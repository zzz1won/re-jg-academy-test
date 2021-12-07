package kr.disable.jugd.academy.controller;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.disable.jugd.academy.domain.AdminVO;
import kr.disable.jugd.academy.domain.CertVO;
import kr.disable.jugd.academy.service.CertService;

@Controller
@RequestMapping("/file/")
public class FileController {

	private Logger logger = LoggerFactory.getLogger(FileController.class);
	
	private final String CERT_FILE_PATH = "/usr/local/tomcat/webapps/image/cert/";
	private final String STAMP_FILE_PATH = "/usr/local/tomcat/webapps/image/stamp/";
	//private final String CERT_FILE_PATH = "D://Source//file//";
	//private final String STAMP_FILE_PATH = "D://Source//file//";
	
	@Autowired
	private CertService certService;
	
	/**
	 * 수료증 업로드
	 * @param model
     * @return
	 * @throws Exception 
	 */
	@RequestMapping("upload/cert")
	@ResponseBody
	public Map<String, Object> uploadCert(HttpServletRequest request
										, @RequestParam("uploadFile") MultipartFile uploadFile
										, @RequestParam("acEduCertInfoNo") Integer acEduCertInfoNo) throws Exception {
		
		HttpSession session = request.getSession();
		AdminVO admin = (AdminVO) session.getAttribute("ADMIN");
		
		Map<String, Object> resultMap = new HashMap<>();
		BufferedOutputStream stream = null;
		CertVO cert = new CertVO();
		int result = 0;
		
		try {
			String filePath = CERT_FILE_PATH.replaceAll("/", Matcher.quoteReplacement(File.separator)); // os에 맞게 파일 구분자 처리
			String fileName = uploadFile.getOriginalFilename();
			filePath = Paths.get(filePath, fileName).toString();
			
			if(!uploadFile.isEmpty()) {
				stream = new BufferedOutputStream(new FileOutputStream(new File(filePath)));
				stream.write(uploadFile.getBytes());
				
				cert.setAcEduCertInfoNo(acEduCertInfoNo);
				cert.setAcEduCertFilePath(fileName);
				cert.setModId(admin.getAdminId());
				cert.setFileId(admin.getAdminId());
				
				// filePath 저장
				result = certService.updateCertPath(cert);
				resultMap.put("result", result);
			}
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		} finally {
			stream.close();
		}
		
		return resultMap;
	}
	
	/**
	 * 등록한 수료증(pdf) 미리보기
	 * @param request
	 * @param model
     * @return 
     * @throws Exception
	 */
	@RequestMapping("view/cert")
	public String viewCert(HttpServletRequest request, Model model) throws Exception {
		Integer certNo = Integer.parseInt(request.getParameter("certNo").toString());
		CertVO certInfo = new CertVO();
		String filePath = "";
		
		try {
			certInfo = certService.selectCertPath(certNo);
			filePath = CERT_FILE_PATH + certInfo.getAcEduCertFilePath();
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		}
		
		model.addAttribute("certInfo", certInfo);
		model.addAttribute("filePath", filePath);
		
		return "admin/cert/certificate";
	}
	
	/**
	 * 직인 이미지 보여주기
	 * @param request
	 * @param response
     * @return 
     * @throws Exception
	 */
	@RequestMapping("view/stamp")
	@ResponseBody
	public void viewStamp(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String fileName = "stamp.jpg";
		ServletOutputStream sos = null;
		FileInputStream fis = null;
		
		try {
			response.setContentType("image/jpg");
			
			sos = response.getOutputStream();
			fis = new FileInputStream(STAMP_FILE_PATH + fileName);
			int length;
			byte[] buffer = new byte[10];
			while( (length = fis.read(buffer)) != -1 ) {
				sos.write(buffer, 0, length);
			}
			
		} catch(Exception e) {
			logger.debug(e.getMessage());
		} finally {
			sos.close();
			fis.close();
		}
		
		
	}
	
}

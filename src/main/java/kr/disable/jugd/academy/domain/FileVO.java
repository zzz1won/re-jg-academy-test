package kr.disable.jugd.academy.domain;

import org.springframework.web.multipart.MultipartFile;

public class FileVO {

	private MultipartFile uploadFile;

	public MultipartFile getFile() {
		return uploadFile;
	}

	public void setFile(MultipartFile uploadFile) {
		this.uploadFile = uploadFile;
	}
}
package kr.disable.jugd.academy.service;

import kr.disable.jugd.academy.domain.CodeVO;
import kr.disable.jugd.academy.mapper.CodeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class CodeService {

    @Autowired
    private CodeMapper codeMapper;

    public Integer deleteCode(CodeVO code) {
        return codeMapper.deleteCode(code);
    }

    /** code_no 값으로 common_code 값 가져오기 */
    public List<CodeVO> selectCodeNo(CodeVO code) {
        return codeMapper.selectCodeNo(code);
    }

    /** code 등록*/
    public Integer insertCode(CodeVO codeVO) {
        return codeMapper.insertCode(codeVO);
    }

    /** code 상세보기 */
    public CodeVO selectDetailCode(CodeVO codeVO) {
        return codeMapper.selectDetailCode(codeVO);
    }

    /** code 수정처리 ㅠ */
    public Integer updateCode(CodeVO codeVO) {
        return codeMapper.updateCode(codeVO);
    }

    /** codeList 출력용 */
    public List<CodeVO> selectCode(Map<String, Object> paramMap) {
        return codeMapper.selectCode(paramMap);
    }

    /** code useState n으로 변경 */
    /*public List<CodeVO> insertUseState(CodeVO codeVO) {
        return codeMapper.updateCodeState(codeVo);
    }*/

    /** code useState N으로 변경 */
    public Integer updateCodeUseState(CodeVO codeVO) {
        return codeMapper.updateCodeUseState(codeVO);
    }

    /** code useState Y로 변경*/
    public Integer updateCodeUseStateY(CodeVO codeVO) {
        return codeMapper.updateCodeUseStateY(codeVO);
    }

    public Integer selectCodeCnt(Map<String, Object> paramMap) { return codeMapper.selectCodeCnt(paramMap); }


    /*public Integer selectCodeListCnt(Map<String, Object> paramMap) {
        return codeMapper.selectCodeListCnt(paramMap);
    }*/
}

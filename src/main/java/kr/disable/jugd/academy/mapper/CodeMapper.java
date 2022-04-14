package kr.disable.jugd.academy.mapper;

import kr.disable.jugd.academy.domain.CodeVO;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Mapper
@Repository
public interface CodeMapper {

    /** 코드관리 목록 */
    public List<CodeVO> selectCommonCode(Map<String, Object> paramMap);

    /** 코드 삭제 */
    public Integer deleteCode(CodeVO code);

    /** 코드No 값 찾기 */
    public List<CodeVO> selectCodeNo(CodeVO code);

    /** 신규 코드 추가 */
    public Integer insertCode(CodeVO codeVO);

    /** 코드 상세확인 */
    public CodeVO selectDetailCode(CodeVO codeVO);

    /** 코드 수정처리 */
    public Integer updateCode(CodeVO codeVO);

    /** 코드 출력*/
    public List<CodeVO> selectCode(Map<String, Object> paramMap);

    /** 0413 codeUseState y -> n*/
    public Integer updateCodeUseState(CodeVO codeVO);

    /** 0414 codeUseState n-> y*/
    public Integer updateCodeUseStateY(CodeVO codeVO);
}

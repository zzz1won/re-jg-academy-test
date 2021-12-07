package kr.disable.jugd.academy.test;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Repository
@Mapper
public interface TestMapper {
	List<TestVo> selectTest();
}

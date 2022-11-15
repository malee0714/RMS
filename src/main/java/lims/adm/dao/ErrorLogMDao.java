package lims.adm.dao;

import lims.adm.vo.ErrorLogMVo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ErrorLogMDao {
	//조회
	public List<ErrorLogMVo> getErrorLog(ErrorLogMVo vo);



}

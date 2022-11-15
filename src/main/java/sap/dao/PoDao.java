package sap.dao;

import org.apache.ibatis.annotations.Mapper;
import sap.vo.SapPo;

import java.util.List;

@Mapper
public interface PoDao {
	List<SapPo> getPoList();
}

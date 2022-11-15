package lims.rsc.dao;

import lims.rsc.vo.CustlabExpriemDto;
import lims.rsc.vo.CustlabDto;
import lims.rsc.vo.CustlabProductDto;
import lims.rsc.vo.CustlabWorkerDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CustlabManageDao {

	List<CustlabDto> getCustlab(CustlabDto custlabDto);

	void insertCustlab(CustlabDto custlabDto);

	void updateCustlab(CustlabDto custlabDto);
	
	void deleteCustlab(CustlabDto custlabDto);

	void insertCustlabWorker(CustlabWorkerDto worker);

	void deleteCustlabWorker(CustlabWorkerDto worker);

	List<CustlabWorkerDto> getCustlabWorkers(CustlabWorkerDto workerDto);

	List<CustlabProductDto> getCustlabProducts(CustlabDto custlabDto);

	String selectchrgDeptCode(CustlabDto custlabDto);

	void insertCustlabProduct(CustlabProductDto product);

	void deleteCustlabProduct(CustlabProductDto product);

	List<CustlabExpriemDto> getCustlabDayExpriems(CustlabDto custlabDto);

	void insertDayExpr(CustlabExpriemDto expr);
	
	void updateDayExpr(CustlabExpriemDto expr);

	void deleteDayExpr(CustlabExpriemDto custlabCheckExpriemDto);

}

package lims.rsc.service.Impl;

import lims.rsc.dao.CustlabManageDao;
import lims.rsc.service.CustlabManageService;
import lims.rsc.vo.CustlabExpriemDto;
import lims.rsc.vo.CustlabDto;
import lims.rsc.vo.CustlabProductDto;
import lims.rsc.vo.CustlabWorkerDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustlabManageServiceImpl implements CustlabManageService {

	private final CustlabManageDao custlabDao;

	@Autowired
	public CustlabManageServiceImpl(CustlabManageDao custlabDao) {
		this.custlabDao = custlabDao;
	}
	
	public List<CustlabDto> getCustlab(CustlabDto custlabDto) {
		return custlabDao.getCustlab(custlabDto);
	}
	
	@Override
	public List<CustlabWorkerDto> getCustlabWorkers(CustlabWorkerDto workerDto) {
		return custlabDao.getCustlabWorkers(workerDto);
	}

	@Override
	public List<CustlabProductDto> getCustlabProducts(CustlabDto custlabDto) {
		return custlabDao.getCustlabProducts(custlabDto);
	}

	@Override
	public List<CustlabExpriemDto> getCustlabDayExpriems(CustlabDto custlabDto) {
		return custlabDao.getCustlabDayExpriems(custlabDto);
	}

	/**
	 * 분석실 데이터 저장.
	 * 분석실 정보, 근무자, 관련제품, 일상점검 관리항목까지 전부 다 저장합니다. 
	 * @param custlabDto 분석실 정보
	 */
	@Override
	public void saveCustlab(CustlabDto custlabDto) {
		
		if (custlabDto.isNew()) {
			custlabDao.insertCustlab(custlabDto);
		} else {
			custlabDao.updateCustlab(custlabDto);
		}

		// 저장된 분석실 seqno
		Integer custlabSeqno = custlabDto.getCustlabSeqno();
		
		custlabDto.getWorkers().forEach(worker -> this.saveWorker(custlabSeqno, worker)); // 근무자 저장
		custlabDto.getRemovedWorkers().forEach(this::deleteWorker); // 삭제된 근무자 db 삭제 처리
		
		custlabDto.getProducts().forEach(product -> this.saveProduct(custlabSeqno, product)); // 제품 저장
		custlabDto.getRemovedProducts().forEach(this::deleteProduct); // 삭제된 제품 db 삭제 처리
		
		custlabDto.getDayExpriems().forEach(expr -> this.saveDayExpr(custlabSeqno, expr)); // 일상점검 시험항목 저장
		custlabDto.getRemovedDayExpriems().forEach(this::deleteDayExpr); // 삭제된 일상정검 시험항목 db 삭제처리
	}

	@Override
	public void deleteCustlab(CustlabDto custlabDto) {
		custlabDto.deleteCustlabValidation();
		custlabDao.deleteCustlab(custlabDto);
	}

	private void saveWorker(Integer custlabSeqno, CustlabWorkerDto worker) {
		worker.setCustlabSeqno(custlabSeqno);
		if (worker.isNew()) {
			custlabDao.insertCustlabWorker(worker);
		}
	}
	private void deleteWorker(CustlabWorkerDto custlabWorkerDto) {
		custlabDao.deleteCustlabWorker(custlabWorkerDto);
	}

	private void saveProduct(Integer custlabSeqno, CustlabProductDto product) {
		product.setCustlabSeqno(custlabSeqno);
		if (product.isNew()) {
			custlabDao.insertCustlabProduct( product);
		}
	}
	private void deleteProduct(CustlabProductDto product) {
		custlabDao.deleteCustlabProduct(product);
	}
	
	private void saveDayExpr(Integer custlabSeqno, CustlabExpriemDto expr) {
		expr.setCustlabSeqno(custlabSeqno);
		if (expr.isNew()) {
			custlabDao.insertDayExpr(expr);
		} else {
			custlabDao.updateDayExpr(expr);
		} 
	}
	private void deleteDayExpr(CustlabExpriemDto custlabCheckExpriemDto) {
		custlabDao.deleteDayExpr(custlabCheckExpriemDto);
	}

	@Override
	public String selectchrgDeptCode(CustlabDto custlabDto){
		return custlabDao.selectchrgDeptCode(custlabDto);
	}
}

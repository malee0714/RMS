package lims.rsc.service.Impl;

import lims.com.vo.ComboVo;
import lims.rsc.dao.CustlabEdayChckDao;
import lims.rsc.service.CustlabEdayChckService;
import lims.rsc.vo.CustlabEdayChckRegistDto;
import lims.rsc.vo.CustlabEdayChckResultDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CustlabEdayChckServiceImpl implements CustlabEdayChckService {

	private final CustlabEdayChckDao custlabEdayChckDao;

	@Autowired
	public CustlabEdayChckServiceImpl(CustlabEdayChckDao custlabEdayChckDao) {
		this.custlabEdayChckDao = custlabEdayChckDao;
	}

	@Override
	public List<ComboVo> getCustlabCombo() {
		return custlabEdayChckDao.getCustlabCombo();
	}

	@Override
	public List<CustlabEdayChckRegistDto> getCustlabEday(CustlabEdayChckRegistDto custlabEdayChckRegistDto) {
		return custlabEdayChckDao.getCustlabEday(custlabEdayChckRegistDto);
	}

	@Override
	public List<CustlabEdayChckResultDto> getCustlabEdayCheckResultList(CustlabEdayChckRegistDto custlabEdayChckRegistDto) {
		return custlabEdayChckDao.getCustlabEdayCheckResultList(custlabEdayChckRegistDto);
	}

	@Override
	public void saveEveryDayCheckRegist(CustlabEdayChckRegistDto custlabEdayChckRegistDto) {

		if (custlabEdayChckRegistDto.isNew()) {
			custlabEdayChckDao.insertEveryDayCheckRegist(custlabEdayChckRegistDto);
		} else {
			custlabEdayChckDao.updateEveryDayCheckRegist(custlabEdayChckRegistDto);
		}

		// 저장된 seqno
		final Integer custlabEdayChckRegistSeqno = custlabEdayChckRegistDto.getCustlabEdayChckRegistSeqno();

		// 일상점검 시험항목 결과 저장
		custlabEdayChckRegistDto.getEveryDayExprResultList().forEach(expr -> saveEveryDayExprResult(custlabEdayChckRegistSeqno, expr));
	}

	@Override
	public void deleteEveryDayCheckRegist(CustlabEdayChckRegistDto custlabEdayChckRegistDto) {
		custlabEdayChckRegistDto.deleteValidation();
		custlabEdayChckDao.deleteEveryDayExprResult(custlabEdayChckRegistDto);
	}

	@Override
	public List<CustlabEdayChckResultDto> getCustlabEdayCheckResultSearchList(CustlabEdayChckRegistDto custlabEdayChckRegistDto) {
		return custlabEdayChckDao.getCustlabEdayCheckResultSearchList(custlabEdayChckRegistDto);
	}

	public void saveEveryDayExprResult(Integer custlabEdayChckRegistSeqno, CustlabEdayChckResultDto custlabEdayChckResultDto) {
		custlabEdayChckResultDto.setCustlabEdayChckRegistSeqno(custlabEdayChckRegistSeqno);
		if (custlabEdayChckResultDto.valid()) {
			custlabEdayChckDao.saveEveryDayCheckExprResult(custlabEdayChckResultDto);
		}
	}
}

package lims.req.service.Impl;

import lims.req.dao.ReceiptManageDao;
import lims.req.service.ReceiptManageService;
import lims.req.vo.ReceiptManageDto;
import lims.util.CommonFunc;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReceiptManageServiceImpl implements ReceiptManageService {

	private final ReceiptManageDao receiptManageDao;
	private final CommonFunc commonFunc;

	@Autowired
	public ReceiptManageServiceImpl(ReceiptManageDao receiptManageDao, CommonFunc commonFunc) {
		this.receiptManageDao = receiptManageDao;
		this.commonFunc = commonFunc;
	}

	@Override
	public List<ReceiptManageDto> getRequestRceptList(ReceiptManageDto receiptManageDto) {
		return receiptManageDao.getRequestRceptList(receiptManageDto);
	}
	
	@Override
	public int multipleReceipt(List<ReceiptManageDto> list) {
		int result = 0;

		for (ReceiptManageDto lot : list) {
			receiptManageDao.insReceiptReq(lot); // 접수
			receiptManageDao.updProgSittnCodeFromEx(lot); // 시험항목 - 진행상황코드 '분석중'으로 업데이트
			receiptManageDao.updProgSittnCodeFromReq(lot); // 의뢰 - 시험항목 중 진행상황코드 최솟값으로 업데이트

			result++;
		}

		return (result == list.size()) ? 1 : result;
	}

	@Override
	public int cancelReceipt(List<ReceiptManageDto> list) {
		int result = 0;

		for (ReceiptManageDto lot : list) {
			receiptManageDao.updReceiptCancel(lot); // 접수취소
			receiptManageDao.updReceiptExprCancel(lot); // 시험항목 접수취소

			result++;
		}

		return (result == list.size()) ? 1 : result;
	}

	@Override
	public int reqestReturn(List<ReceiptManageDto> list) {
		int result = 0;

		for (ReceiptManageDto lot : list) {
			result += receiptManageDao.reqestReturn(lot);
		}

		return (result == list.size()) ? 1 : result;
	}

	@Override
	public ReceiptManageDto getReqRtnInfo(ReceiptManageDto receiptManageDto) {
		return receiptManageDao.getReqRtnInfo(receiptManageDto);
	}

}

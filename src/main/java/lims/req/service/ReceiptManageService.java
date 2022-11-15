package lims.req.service;

import lims.req.vo.ReceiptManageDto;

import java.util.List;

public interface ReceiptManageService {

	List<ReceiptManageDto> getRequestRceptList(ReceiptManageDto receiptManageDto);
	int multipleReceipt(List<ReceiptManageDto> list);
	int cancelReceipt(List<ReceiptManageDto> list);
	int reqestReturn(List<ReceiptManageDto> list);
	ReceiptManageDto getReqRtnInfo(ReceiptManageDto receiptManageDto);

}

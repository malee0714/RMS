package lims.req.dao;

import lims.req.vo.ReceiptManageDto;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface ReceiptManageDao {
	
	List<ReceiptManageDto> getRequestRceptList(ReceiptManageDto receiptManageDto);
	int insReceiptReqHist(ReceiptManageDto receiptManageDto);
	int reqRceptCheck(ReceiptManageDto receiptManageDto);
	int chkNotAccepted(ReceiptManageDto receiptManageDto);
	String getReqSanctnProgSittnCode(ReceiptManageDto receiptManageDto);
	int insReceiptReq(ReceiptManageDto receiptManageDto);
	int updAnalCompPrerngDt(ReceiptManageDto receiptManageDto);
	float getMtrilAnalTimeByReq(ReceiptManageDto receiptManageDto);
	List<ReceiptManageDto> getExprSeqByMinPro(ReceiptManageDto receiptManageDto);
	int updProgSittnCodeFromReq(ReceiptManageDto receiptManageDto);
	int updProgSittnCodeFromEx(ReceiptManageDto receiptManageDto);
	int updReceiptCancel(ReceiptManageDto receiptManageDto);
	int updReceiptExprCancel(ReceiptManageDto receiptManageDto);
	int reqestReturn(ReceiptManageDto receiptManageDto);
	ReceiptManageDto getReqRtnInfo(ReceiptManageDto receiptManageDto);
	
}

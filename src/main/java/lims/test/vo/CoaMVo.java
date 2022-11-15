package lims.test.vo;

import lombok.*;

import java.util.List;

@Getter @Setter @ToString
@Builder @NoArgsConstructor @AllArgsConstructor
public class CoaMVo {

	private String reqestSeqno;
	private String processTyNm;
	private String mnfcturDte;
	private String atchmnflSeqno;
	private String avrgResultValue;
	private String mtrilCode;
	private String reqestDte;
	private String progrsSittnCode;
	private String roaCreatAt;
	private String lwprtReqestSeqno;
	private String sploreNm;
	private String extension;
	private String avrgApplcAt;
	private String expriemSeqno;
	private String expriemNm;
	private String expriemClCode;
	private String expriemClNm;
	private String resultValue;
	private String lastExprOdr;
	private String coaSeqno;
	private String printngSeqno;
	private String printngCours;
	private String printngOrginlFileNm;
	private String ctmmnyMtrilCode;
	private String pblshrId;
	private String shipmntQy;
	private String shipmntDte;
	private String po;
	private String entrpsNm;
	private String userNm;
	private String lastChangeDt;
	private String ordr;
	private String sortOrdr;
	private String ceckAt;
	private String upperReqestSeqno;
	private String coaType;
	private String jdgmntWordCode;
	private String upperCnt;
	private String valveMtrqltValue;
	private String valveMnfcturprofsNm;
	private String qcResultValue;
	private Integer upperSortOrdr;
	private Integer lwprtSortOrdr;
	private String excelRowIndex;
	private String excelCellMarkIndex;
	private String extAt;
	private String dwldFileSeCode;
	private String reqestNoSch;
	private String reqNoSch;
	private String lotNoSch;
	private String shipmntBeginDte;
	private String shipmntEndDte;
	private String entrpsSch;
	private String detectLimitApplcAt;
	private String unitSeqno;
	private String bplcCode;
	private String entrpsSeqno;
	private String coaPblicteAtchmnflSeqno;
	private String lotNo;
	private String inspctTyNm;
	private String mtrilNm;
	private String mtrilSeqno;
	private String reqestNo;
	private String inspctTyCode;
	private List<CoaMVo> list;
	private List<CoaMVo> lotList;
	private List<CoaMVo> upperLotGrid;
	private List<CoaMVo> reqLotGrid;

}

package lims.qa.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter 
@Setter
public class VocMVo {
	//VOC 조회 VO
	private String ctmmnyNmSch;
	private String mtrilNmSch;
	private String sjSch;
	private String vocProgrsSittnCode;
	private String vocBeginDteSch;
	private String vocEndDteSch;
	private String bplcCodeSch;
	
	//조회그리드
	private String ctmmnyNm;
	private String sj;
	private String vocRceptNo;
	private String mtrilNm;
	private String vocBadnSeNm;
	private String bplcNm;
	private String writngDeptNm;
	private String wrterNm;
	private String writngDte;
	private String cntrplnApplcDte;
	private String validVrifyDte;
	private String vocProgrsSittnNm;
	private int ctmmnySeqno;
	private String bplcCode;
	private String writngDeptCode;
	private int wrterId;
	private int vocSeqno;
	private int vocRegistSeqno;
	private String temporaryYn;
	
	//RS_VOC_REGIST 데이터입력
	private String vocSeCode;
	private String rceptDeptNm;
	private String rcepterNm;
	private String rceptDte;
	private String ctmmnyLineNm;
	private int mtrilSeqno;
	private String occrrncLotId;
	private String vocBadnSeCode;
	private String vocBadnCn;
	private String occrrncFairNm;
	private String cntnrSeCode;
	private int badnCo;
	private String badnOccrrncDte;
	private String recrAt;
	private String cntrplnFoundngAt;
	private String cntrplnFoundngDeptNm;
	private String badnPhnomenDc;
	private int atchmnflSeqno;
	private String cntrplnFoundngOprtnAt;
	private String imprtyResn;
	private String dedtDte;
	private String dedtAppnResn;
	private String wdtbSeqno;
	private String cntrplnFoundngWdtbSeqno;
	private String validVrifyWdtbSeqno;
	private String deleteAt;
	
	//Voc 대책수립
	private String occrrncCause;
	private String basis;
	private String diagnoseTemporaryYn;
	private int diagnoseAtchmnflSeqno;
	private int vocCntrplnFoundngSeqno;
	
	//VOC 유효 검증
	private String validVrifyMth;
	private String validVrifyResultAt;
	private String validVrifyResn;
	private int validVrifyAtchmnflSeqno;
	private int vocValidVrifySeqno;
	private String validVrifyTemporaryYn;
	
	
	
	
}

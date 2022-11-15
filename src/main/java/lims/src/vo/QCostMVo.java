package lims.src.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter 
@Setter
@ToString
public class QCostMVo {

	private String reqestDeptCode; /*의뢰부서 코드*/
	private String reqestDeptNm; /*의뢰부서 명*/
	private String reqestCnt; /*의뢰건수*/
	private String reqestDte; /*의뢰일*/
	
	private String bplcCode;
	//검색
	private String shrDeptCode;   /*부서*/
	private String shrReqestBeginDte; /*의뢰일자 시작*/
	private String shrReqestEndDte;   /*의뢰일자 종료*/
	private String shrProcessTyCode;
	private String shrProcessTyElseCode;
	private String type;
	private List<QCostMVo> list;
	private List<QCostMVo> listDate;
	private String authorSeCode;
	
	
	//SY_INSPCT_INSTT_QLITY_CT 테이블 
	private String analsctAm;
	private String cmpdsAnalsctAm;
	private String mntncMendngCntrctAm;
	private String rpairsMntncMendngAm;
	private String lbcstRate;
	private String dailAnalsPosblTime;
	private String eqpmnClCode;
	private String eqpmnClCodeNm;
	
	// SY_INSPCT_INSTT_LBCST 테이블 
	
	private String lbcstAm;
	private String inspctInsttCode;
	private String yy;
	// RS_EQPMN 테이블
	private String eqpmnNm;
	private Integer acqsAmount;
	private String wrhousngDte;
	private Integer depreciation;
	private Integer costTotal;
	
	private long lbcstTotal; // 분류별 인건비 COST 비용
	
	
	private Integer analsReqreTime;
	private Integer dayMaxAnalysis;
	private Integer yearMaxAnalysis;
	private Integer eqpmnNumber;
	private Integer capaTotal;
	private Integer capa;
	private String bplcCodeSch;
	private String eqpmnClCodeSch;
	private String count;


}

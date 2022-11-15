package lims.sys.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PlnatMVo {

	/* 사업장관리(SY_검사기관) */
	private String bestInspctInsttCode; //최상위검사기관코드
	private String upperInspctInsttCode; //상위검사기관코드
	private String inspctInsttNm; //검사기관명
	private String dc; //설명
	private String useAt; //사용여부
	/* 사업장관리(SY_검사기관_인건비)*/
	private String inspctInsttLbcstSeqno;//검사기관인건비일련번호
	/* 사업장관리(SY_검사기관_품질_비) */
	private String inspctInsttQlityCtSeqno; //검사기관품질비일련번호
	private String yy; //년(4자리)
	private String lbcstAm; //인건비 액
	private String analsctAm; //분석비 액
	private String cmpdsAnalsctAm; //소모품분석비 액
	private String mntncMendngCntrctAm; //유지보수계약 액
	private String rpairsMntncMendngAm; //수선유지보수 액
	private String eqpmnClCode;		//장비 분류
	private String eqpmnClCodeNm;		//장비 분류 이름
	private String lbcstRate;		
	private String dailAnalsPosblTime;
	private String analsReqreTime;
	private String rdmsServerIp;  // RDMS 서버 IP
	private String engAdres;
	private String koreanAdres;
	private String outnatnTelNo;
	private String dmstcTelno;
	/* 사업장관리(공통) */
	private String inspctInsttCode; //검사기관코드
	private String deleteAt; //삭제여부
	private String lastChangerId; //최종변경자ID
	private String lastChangeDt; //최종변경일시

	/* 서비스로직 변수 */
	private int count;

	/* 그리드 */
	private List<PlnatMVo> addedRowItems;
	private List<PlnatMVo> editedRowItems;
	private List<PlnatMVo> removedItems;
	private List<PlnatMVo> formData;

}

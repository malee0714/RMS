package lims.spc.vo;

import lims.util.CustomException;
import lombok.*;

/**
 * SPC Rule test를 하기위한 의뢰 시험항목 정보를 가지고 있는 객체 입니다.
 * 
 * @see lims.spc.enm.SpcRule 
 * @author shs
 */
@Getter
@Builder @NoArgsConstructor @AllArgsConstructor
public class SpcResultExpriem {
	private String reqestSeqno;         // 의뢰 일련번호
	private Double resultValue;         // 결과 값
	private Double qcResultValue;       // qc 결과 값
	private String mtrilSdspcSeqno;     // 자재 기준규격 seqno
	private Double uclValue;            // ucl
	private Double lclValue;            // lcl
	private Double uslValue;            // usl
	private Double lslValue;            // lsl
	private String lotNo;               // LOT NO
	private String sploreNm;            // LOT NO
	private String mtrilSeano;          // 자재 seqno
	private String venderResultValue;   // 협력사 result value
	private String qcVenderResultValue; // 협력사 qc result value
	private String expriemNm;           // 시험항목 명
	private String lclValueSeCode;      // IM08 LCL 값 구분 코드
	private String uclValueSeCode;      // IM07 UCL 값 구분 코드
	
	public String getSploreNm() {
		return this.sploreNm == null ? "" : this.sploreNm;
	}
	@Override
	public String toString() {
		return "SpcRuleExprVO{" +
				"reqestSeqno=" + reqestSeqno  +
				", resultValue=" + resultValue +
				", qcResultValue=" + qcResultValue +
				", lotNo=" + lotNo +
				", mtrilSeano=" + mtrilSeano +
				", mtrilSdspcSeqno=" + mtrilSdspcSeqno +
				'}';
	}
}

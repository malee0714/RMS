package lims.wrk.vo;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

/**
 * SY_SPC_MANAGE Table은 SY_SPC_RULE 과 SY_SPS_MANAGE_EXPRIEM 테이블을 묶는 Table임. <br>
 * 
 * Spc 기준관리에 대한 VO임.
 * 
 * @author shs
 * @table 	SY_SPC_MANAGE 	-	spc 기준관리 <br>
 */
@Getter
@Setter
@ToString
public class TrendStdrMVO {
	
	//SY_SPC_MANAGE
	private String spcManageSeqno; 	// SPC 관리 일련번호
	private String bplcCode; 		// 사업장 코드
	private String stdrNm; 			// 기준 명
	private String inspctTyCode; 	// ZSY07 검사 유형 코드
	private String mtrilSeqno; 		// 자재 일련번호
	private String mtrilNm;			// 자재 명
	private String entrpsSeqno; 	// 업체 일련번호
	private String entrpsNm;		// 업체 명
	
	private List<TrendSpcRuleVO> spcRules; //SPC rules
	private List<TrendSpcExprVO> addSpcExprIems; // 추가된 spc 기준관리별 시험항목 목록
	private List<TrendSpcExprVO> deleteSpcExprIems; // 삭제된 spc 기준관리별 시험항목 목록

	private String mtrilSdspcSeqno;
	private String expriemNm;
}

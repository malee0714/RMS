package lims.spc.vo;

import lims.spc.enm.SpcRule;
import lombok.*;

import java.util.List;

/**
 * spc 8대 rule을 Test 하기위해 사용되는 DTO
 * spc 테스트 파라미터 전달, 테스트 결과 retrun용으로 사용합니다.
 * 
 * @author shs
 */
@Getter @Setter @ToString
@Builder @AllArgsConstructor @NoArgsConstructor
public class SpcRuleTestDto {
	// 공통 or chart 메뉴 spc rule 조회 param
	private String reqestSeqno;                         // 의뢰 seqno
	
	private String mtrilSeqno;                          // 자재 seqno
	
	private String mnfcturStartDte;                     // 제조일자 시작일
	private String mnfcturEndDte;                       // 제조일자 종료일
	@Builder.Default
	private boolean chartData = false;                  // 차트메뉴에서 호출한건지 ? (기본값은 결과입력, roa 기준입니다.)
	@Builder.Default
	private boolean findFirst = true;                   // bad list를 첫번째로 발견할시 바로 return할지 계속 찾을지 여부. (기본값은 결과입력, roa 기준입니다.)
	@Builder.Default
	private boolean qc = false;                         // qc 여부. (기본값은 결과입력 기준입니다. roa는 qc true로 이용함.)
	private String inspctTyCode;                        // 검사 유형 코드
	private String coaAt;                               // coa 협력사 결과값 조회 여부
	
	// 결과입력
	private String lotNo;                               // LOT NO
	private String entrpsSeqno;                         // 업체 seqno
	
	// return
	private String expriemNm;                           // 시험항목 명
	private String vendorCoaReqestSeqno;                // vender coa 일련번호
	private List<String> badSploreNames;                 // lotNo만 골라서 담은 집합
	private SpcRule ruleName;                           // 테스트 rule name
	private String spcRuleCode;                         // spc rule 공통코드
}

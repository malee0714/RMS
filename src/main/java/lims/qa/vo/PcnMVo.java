package lims.qa.vo;

import lims.com.vo.CmSanctn;
import lombok.Getter;
import lombok.Setter;
import lombok.Builder.Default;

@Getter @Setter
public class PcnMVo extends CmSanctn {
	
	private Integer pcnSeqno;             		// PCN 일련번호
	private String pcnNm;						// PCN 명
	private String pcnNo;						// PCN 번호
	private String changePointApplcCn; 			// 변경점 적용 적용
	private Integer ctmmnySeqno;				// 고객사 일련번호
	private String changePointSeCn;				// 변경점 구분 내용
	private Integer mtrilSeqno;					// 자재 일련번호
	private String changePointSttusCode;		// 변경점 상태 코드
	private String prearngeDte = "";			// 예정 일자
	private String pcnGradCode;					// PCN 등급 코드
	private String m5e1Code;					// M5E1 코드
	private String chrgDeptCode;				// 담당 부서 코드
	private Integer chargerId;					// 담당자 ID
	private String pcnCn = "";					// PCN 내용
	private String pcnBfeCn = "";				// PCN 전 내용
	private String pcnAfterCn = "";				// PCN 후 내용
	private String pcnResultCode;				// PCN 결과 코드
	private String pblicteDte;					// 발행 일자
	private String comptDte = "";				// 완료 일자
	private Integer atchmnflSeqno;				// 첨부파일 일련번호
	private Integer wdtbSeqno;					// 배포 일련번호
	private Integer exmntSeqno;					// 검토 일련번호
	
	// 외래키 관련 테이블 이름
	private String ctmmnySeqnoNm;				// 고객사 이름
	private String mtrilSeqnoNm;				// 자재 이름
	private String chrgDeptNm = "";				// 담당부서 이름
	private String chargerNm = "";				// 담당자 이름

	// 공토 코드 관련 이름
	private String changePointApplcNm;			// 변경점 적용 이름
	private String changePointSttusNm;			// 변경점 상태 이름
	private String pcnGradNm = "";				// 변경점 등급 이름
	private String m5e1Nm;						// M5E1 이름
	private String pcnResultNm;					// pcn결과 이름
	

	// 일정 검색 관련.
	private String prearngeBeginDte;			// 예정일자 시작.
	private String prearngeEndDte;				// 예정일자 끝.
	private String comptBeginDte;				// 완료일자 시작.
	private String comptEndDte;					// 완료일자 시작.
		
	

	/* 결제 중복 데이터
	 *
	private Integer sanctnSeqno;				// 결재 일련번호
	private String deleteAt;					// 삭제 여부
	private String lastChangerId;				// 최종 변경자
	private String lastChangeDt;				// 최종 변경 일시
	
	*/
}

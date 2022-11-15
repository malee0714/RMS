package lims.qa.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lims.com.vo.CmSanctn;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class AuditCarManageDto extends CmSanctn {
	private Integer auditCarSeqno;       // '감사 CAR 일련번호'
	private Integer auditSeqno;          // '감사 일련번호'
	private String carNo;               // 'CAR NO'
	private String carSj;               // 'CAR 제목'
	private String chrgDeptNm;          // '담당 부서 명'
	private String carSttuCode;         // 'RS25 CAR 현황 코드'
	private String carIpcrCode;         // 'RS26 CAR 중요도 코드'
	private String m5e1Code;            // 'RS27 M5E1 코드'
	private String carEffectfmnmCode;   // 'RS28 CAR 효과성 코드'
	private String carSttuCodeNm;         // 'RS25 CAR 현황 코드 명'
	private String carIpcrCodeNm;         // 'RS26 CAR 중요도 코드 명'
	private String m5e1CodeNm;            // 'RS27 M5E1 코드 명'
	private String carEffectfmnmCodeNm;   // 'RS28 CAR 효과성 코드 명'
	private String chargerNm;           // '담당자'
	private String comptDte;            // '완료 일자'
	private String effectExmntDte;      // '효과 검토 일자'
	private String effectExmntCn;       // '효과 검토 내용'
	private Integer atchmnflSeqno;       // '첨부파일 일련번호'
	private Integer exmntSeqno;          // '검토 일련번호'
	
	private String auditSeCode; // ZRS13 감사 구분 코드
	private String auditDetailSeCode; // ZRS14 감사 상세 구분 코드
	private String auditSeCodeNm; // ZRS13 감사 구분 코드 명
	private String auditDetailSeCodeNm; // ZRS14 감사 상세 구분 코드 명
	private String auditSj; // 감사 제목
	private String auditTrgetDeptNm; // 감사 대상 부서 명
	private String auditBeginDte; // 감사 시작 일자
	private String auditEndDte; // 감사 종료 일자
	private Integer auditYear; // 감사년도
	private Integer auditAtchmnflSeqno; // 감사 첨부파일
	private String rm; // 감사 비고
	
	@JsonIgnore
	public boolean isNew() {
		this.auditValidation();
		return this.auditCarSeqno == null;
	}
	
	public void auditValidation() {
		if (this.auditSeqno == null) {
			throw new IllegalStateException("감사 정보 없이 감사 CAR 정보를 저장할 수 없습니다.");
		}
	}
}

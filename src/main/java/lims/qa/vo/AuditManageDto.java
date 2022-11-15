package lims.qa.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lims.com.vo.CmSanctn;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class AuditManageDto extends CmSanctn {
	private Integer auditSeqno; // 감사 일련번호
	private String auditSeCode; // ZRS13 감사 구분 코드
	private String auditSeCodeNm; // ZRS13 감사 구분 코드 명
	private String auditDetailSeCode; // ZRS14 감사 상세 구분 코드
	private String auditDetailSeCodeNm; // ZRS14 감사 상세 구분 코드 명
	private String auditNo; // 감사 번호
	private String auditDte; // 감사 일자
	private String auditSj; // 감사 제목
	private String auditTrgetDeptNm; // 감사 대상 부서 명
	private String auditTrgterNm; // 감사 대상자 명
	private Integer entrpsSeqno; // 업체 일련번호
	private String entrpsNm; // 업체 명
	private String auditmanNm; // 감사자 명
	private String auditBeginDte; // 감사 시작 일자
	private String auditEndDte; // 감사 종료 일자
	private Integer atchmnflSeqno; // 첨부파일 일련번호
	private Integer wdtbSeqno; // 배포 일련번호
	private Integer exmntSeqno; // 검토 일련번호
	private Integer auditYear; // 감사년도
	private Integer carCount; // car 건수
	private String rm; // 비고
	
	@JsonIgnore
	public boolean isNew() {
		return this.auditSeqno == null;
	}
}

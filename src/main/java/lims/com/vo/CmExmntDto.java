package lims.com.vo;

import lombok.*;

@Getter @Setter
@Builder @AllArgsConstructor @NoArgsConstructor
public class CmExmntDto extends BaseDto{
	private Integer exmntSeqno; // 검토 일련번호
	private Integer ordr;       // 순번 (이력 테이블)
	private Integer chckerId;   // 검토자 ID
	private String exmntDte;    // 검토 일자
	private String exmntCn;     // 검토 내용
	private Integer otherKey;   // 문서, 감사, 고객불만, 부적합품, PCN관리 등 other primarykey
	
	public boolean isNew() {
		return this.exmntSeqno == null;
	}
}

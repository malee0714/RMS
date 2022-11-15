package lims.com.vo;

import lombok.*;

@Getter @Setter
@Builder @AllArgsConstructor @NoArgsConstructor
public class CmCn extends BaseDto {
	private Integer cnSeqno; // 내용 일련번호
	private String cn;      // 제목
	private String sj;      // 내용

}

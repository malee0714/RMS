package lims.wrk.vo;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ExprMthMVo {

	/* SY 시험 방법 */
	private String exprMthSeqno; //시험 방법 일련번호
	private String exprMthNm; //시험 방법 명
	private String rm; //비고
	private String atchmnflSeqno; //첨부파일 일련번호
	private String useAt; //사용 여부
	private String deleteAt; //삭제 여부
	private String lastChangerId; //최종 변경자 ID
	private String lastChangeDt; //최종 변경 일시

	/* 조회조건 */
	private String useAtSearch;
	private String exprMthNmSearch;
	private String key;
	private String value;
}

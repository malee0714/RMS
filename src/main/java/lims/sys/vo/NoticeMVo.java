package lims.sys.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class NoticeMVo {
	private String bbsCode;            /* 게시판 코드 */
	private String bbsNm;            /* 게시판 명 */
	private String popupAt;            /* 팝업 여부 */
	private String answerAt;            /* 답변 여부 */
	private String userSntncwriteAt;            /* 이용자 글쓰기 여부 */
	private String atchmnflAt;            /* 첨부파일 여부 */
	private String rm;            /* 비고 */
	private String useAt;            /* 사용 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	
	/* 변수 */
	private String gridCrud; // CRUD 구분값
	
}

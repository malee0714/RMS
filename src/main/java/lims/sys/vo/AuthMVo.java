package lims.sys.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class AuthMVo {
	
	//전체 메뉴
	private String menuSeqno;				
	private String upperMenuSeqno;
	private String menuNm;
	private String topMenu;
	
	private String authorCode;            /* 권한 코드 */
	private String authorNm;            /* 권한 명 */
	private String authorRm;            /* 권한 비고 */
	private String sortOrdr;            /* 정렬 순서 */
	private String useAt;            /* 사용 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	
	private String userId;					//권한관리 검색 조건(사용자명)

	private String authorNmSch;
	
}

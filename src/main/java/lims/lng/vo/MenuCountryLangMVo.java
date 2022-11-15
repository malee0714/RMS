package lims.lng.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MenuCountryLangMVo {
	private String langMenuSeqno;            /* 언어 메뉴 일련번호 */
	private String menuSeqno;            /* 메뉴 일련번호 */
	private String nationLangCode;            /* ZSY06 국가 언어 코드 */
	private String langNm;            /* 언어 명 */
	private String useAt;            /* 사용 여부 */
	private String deleteAt;            /* 삭제 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */


}

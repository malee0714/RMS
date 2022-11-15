package lims.lng.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class DefaultLangMVo {
	private String langMastrSeqno;            /* 언어 마스터 일련번호 */
	private String langNm;            /* 언어 명 */
	private String useAt;            /* 사용 여부 */
	private String deleteAt;            /* 삭제 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	private String langCode; /*lang 코드*/
	
	//검색조건
	private String langNmSch;
	private String useAtSch;
	private String langCodeSch;
	
	//중복값
	private String langNmChk;
	
}

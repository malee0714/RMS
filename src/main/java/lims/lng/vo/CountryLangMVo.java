package lims.lng.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CountryLangMVo {
	private String langDetailSeqno;            /* 언어 상세 일련번호 */
	private String langMastrSeqno;            /* 언어 마스터 일련번호 */
	private String nationLangCode;            /* ZSY06 국가 언어 코드 */
	private String useAt;            /* 사용 여부 */
	private String deleteAt;            /* 삭제 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	private String langNm;            /* 언어 명 */
	private String langCode;
	
	//중복값 
	private String conlangChk;
	
	//검색조건
	private String langNmCodeSch;
	private String langNmSch;
	private String useAtSch;
	private String detailNm;
	private String detailNmSch;
	
}

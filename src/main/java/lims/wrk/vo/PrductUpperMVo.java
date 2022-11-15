package lims.wrk.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class PrductUpperMVo {
	private String prductUpperSeqno;            /* 제품 상위 일련번호 */
	private String mmnySeCode;            /* ZSY01 자사 구분 코드 */
	private String mmnySeNm;           /*자사구분 코드 명*/
	private String prductNm;            /* 제품 명 */
	private String prductDetailNm;            /* 제품 상세 명 */
	private String prductNo;            /* 제품 번호 */
	private String useAt;            /* 사용 여부 */
	private String deleteAt;            /* 삭제 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */

	//저장 중복 리턴값
	private String canNoChk;
	
	//검색
	private String mmnySeCodeSch;
	private String prductNmSch;
	private String prductNoSch;
	private String useAtSch;
	String popProductNmSearch; //팝업검색
	String mmnySe; //제품 구분 한글
	
}

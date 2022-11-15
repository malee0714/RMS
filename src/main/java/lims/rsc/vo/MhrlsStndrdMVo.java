package lims.rsc.vo;

import lombok.Data;

@Data
public class MhrlsStndrdMVo {

	private String prductStndrdSeqno;            /* 제품 규격 일련번호 */
	private String prductStndrdSeCode;            /* ZRS20 제품 규격 구분 코드 */
	private String prductStndrdSeCodeNm;
	private String stdMttrSeCode;            /* ZRS21 표준 물질 구분 코드 */
	private String stdMttrSeCodeNm;
	private String prductStndrdNm;            /* 제품 규격 명 */
	private String wrhousngDte;            /* 입고 일자 */
	private String validDte;            /* 유효 일자 */
	private String useAt;            /* 사용 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	private String rm;            /* 비고 */
	private String deleteAt;

	private String schPrductStndrdSeCode;
	private String schStdMttrSeCode;
	private String schPrductStndrdNm;
	private String useAtSch;
}

package lims.com.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class WdtbVo {
	private String wdtbSeqno;			/* 배포 일련번호 */
	private String wdtbPrearngeDte;			/* 배포 예정 일자 */
	private String wdtbDt;			/* 배포 일시 */
	private String cn;			/* 내용 */
	private String sj;			/* 제목 */
	private String useAt;			/* 사용 여부 */
	private String lastChangerId;			/* 최종 변경자 ID */
	private String lastChangeDt;			/* 최종 변경 일시 */

	private String userId;			/* 이용자 ID */
	private String userNm;
	private String ordr;
	private String emailTrnsmisAt;			/* 이메일 전송 여부 */
	private String chrctrTrnsmisAt;			/* 문자 전송 여부 */
	private String emailTrnsmisComptAt;			/* 이메일 전송 완료 여부 */
	private String chrctrTrnsmisComptAt;			/* 문자 전송 완료 여부 */

	private String seqNo;
	private String view;
	private String type;
	private String reqestSeqno;


	private List<WdtbVo> customerList;
	private List<WdtbVo> chkTrgterData;
}

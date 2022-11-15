package lims.qa.vo;

import lims.test.vo.ResultInputMVo;
import lombok.Data;

import java.util.List;

@Data
public class NCRReportMVo {
	private String ncrSeqno;            /* NCR 일련번호 */
	private String wrterId;            /* 작성자 ID */
	private String ncrNo;            /* NCR NO */
	private String pblicteDte;            /* 발행 일자 */
	private String sj;            /* 제목 */
	private String processTyCode;            /* ZSY02 프로세스 타입 코드 */
	private String processTyCodeNm;            /* ZSY02 프로세스 타입 코드 명 */
	private String lotNo;            /* LOT NO */
	private String entrpsNm;            /* 업체 명 */
	private String improptTyCode;            /* ZRS19 부적합 유형 코드 */
	private String improptTyCodeNm;            /* ZRS19 부적합 유형 코드 명 */
	private String expriemSumry;            /* 시험항목 요약 */
	private String improptCn;            /* 부적합 내용 */
	private String improptOccrrncCause;            /* 부적합 발생 원인 */
	private String causeClCode;            /* ZRS09 원인 분류 코드 */
	private String causeClCodeNm;            /* ZRS09 원인 분류 코드 명 */
	private String causeDetailCn;            /* 원인 상세 내용 */
	private String cntrpln;            /* 대책 */
	private String processMethodCode;            /* ZRS10 처리 방안 코드 */
	private String processMethodCodeNm;            /* ZRS10 처리 방안 코드  명*/
	private String ctmmnyOthbcAt;            /* 고객사 공개 여부 */
	private String basis;            /* 근거 */
	private String atchmnflSeqno;            /* 첨부파일 일련번호 */
	private String deleteAt;            /* 삭제 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	private String processType;			//상태
	private String bplcCode;	//사업장
	private String mtrilSeqno;	//자재일련번호
	private String pblicteBeginDte;
	private String mtrilNm; /* 자재 명 */
	private String pblicteEndDte;
	
	
	private String reqestExpriemSeqno;
	private String reqestSeqno;
	private String exprOdr;
	private String exprNumot;
	private String stdr;
	private String lclUcl;
	private String resultValue;
	private String resultRegistDte;
	private String expriemNm;

	private List<NCRReportMVo> expriemList;
}

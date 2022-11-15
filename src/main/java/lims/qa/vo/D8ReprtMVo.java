package lims.qa.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lims.com.vo.CmSanctn;
import lombok.Data;

@Data
public class D8ReprtMVo extends CmSanctn {
    private String d8ReprtSeqno;			/* D8 보고서 일련번호 */
    private String writngDeptCode;			/* 작성 부서 코드 */
    private String writngDeptCodeNm;			/* 작성 부서 코드 */
    private String wrterId;			/* 작성자 ID */
    private String wrterIdNm;			/* 작성자 ID */
    private String causeAnalsCn;			/* 원인 분석 내용 */
    private String corecManagtCn;			/* 시정 조치 내용 */
    private String corecManagtComptCn;			/* 시정 조치 완료 내용 */
    private String effectfmnmUndstnCn;			/* 효과성 파악 내용 */
    private String recrPrvnCntrplnCn;			/* 재발 방지 대책 내용 */
    private String exmntSeqno;			/* 검토 일련번호 */
    private String writngDte;
    private String deleteAt;

    //고객불만관리
    private String cstmrDscnttSeqno;			/* 고객 불만 일련번호 */
    private String cstmrDscnttNo;			/* 고객 불만 번호 */
    private String entrpsSeqno;			/* 업체 일련번호 */
    private String entrpsNm;        //업체 명
    private String cstmrDscnttSj;			/* 고객 불만 제목 */
    private String mtrilSeqno;			/* 제품 일련번호 */
    private String mtrilNm;         //제품 명
    private String lotNo;			/* LOT NO */

   //조회조건
    private String writngDteSt;
    private String writngDteEn;

    @JsonIgnore
    public boolean isNew(){
        return this.d8ReprtSeqno == null || "".equals(this.d8ReprtSeqno);
    }
}

package lims.qa.vo;

import lims.com.vo.CmSanctn;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class NcrMVo extends CmSanctn {
    private Integer ncrSeqno;			/* NCR 일련번호 */
    private String crrspndDeptCode;			/* 해당 부서 코드 */
    private String reqestSeqno;			/* 의뢰 일련번호 */
    private String prductNm;			/* 제품 명 */
    private String occrrncDte;			/* 발생 일자 */
    private String chrgDeptCode;			/* 담당 부서 코드 */
    private String chargerId;			/* 담당자 ID */
    private String exmntDeptCode;			/* 검토 부서 코드 */
    private String ocapSttusCode;			/* ZRS20 OCAP 상태 코드 */
    private String improptCn;			/* 부적합 내용 */
    private String causeAnalsCn;			/* 원인 분석 내용 */
    private String imprvmCntrplnCn;			/* 개선 대책 내용 */
    private String improptDgreeCode;			/* ZRS19 부적합 정도 코드 */
    private String improptProcessStleCode;			/* ZRS31 부적합 처리 형태 코드 */
    private String comptDte;			/* 완료 일자 */
    private String improptValidfmnmEvlCode;			/* ZRS32 부적합 유효성 평가 코드 */
    private String validfmnmEvlDte;			/* 유효성 평가 일자 */
    private String dmgeScaleCn;			/* 피해 규모 내용 */
    private String processResultCn;			/* 처리 결과 내용 */
    private String recrPrvnCntrplnCn;			/* 재발 방지 대책 내용 */
    private String atchmnflSeqno;			/* 첨부파일 일련번호 */
    private String deleteAt;			/* 삭제 여부 */
    private String lastChangerId;			/* 최종 변경자 ID */
    private String lastChangeDt;			/* 최종 변경 일시 */
    private String exmntSeqno;			/* 검토 일련번호 */
    private String improptProcessResultCode; /* ZRS34 부적합 처리 결과 코드 */
    private String exprOdr;
    private String bplcCode;
    private String qcResultValue;



    private String sanctnProgrsSittnCodeNm;
    private String chrgDeptCodeNm;
    private String chargerIdNm;
    private String exmntDeptCodeNm;
    private String ocapSttusCodeNm;
    private String improptDgreeCodeNm;
    private String improptProcessStleCodeNm;
    private String improptValidfmnmEvlCodeNm;
    private String improptProcessResultCodeNm;
    private String seqCount;

    private List<NcrMVo> gridData;
    private List<NcrMVo> addedRow = new ArrayList<>();
    private List<NcrMVo> editedRow = new ArrayList<>();
    private List<NcrMVo> removedRow = new ArrayList<>();

    private String expriemNm;

    //팝업
    private String mtrilNm;
    private String prductTyNm;

    private String ordr;
    private String reqestExpriemSeqno;

    //조회조건
    private String mtrilNmSch;
    private String prductTyNmSch;
    private String prductSeCode;
    private String ocapSttusCodeSch;
    private String chrgDeptCodeSch;
    private String chargerIdSch;
    private String exmntDeptCodeSch;
    private String comptBeginDte;
    private String comptEndDte;



    @Override
    public String toString() {
        return "NcrMVo{" +
                "ncrSeqno=" + ncrSeqno +
                ", crrspndDeptCode='" + crrspndDeptCode + '\'' +
                ", reqestSeqno='" + reqestSeqno + '\'' +
                ", prductNm='" + prductNm + '\'' +
                ", occrrncDte='" + occrrncDte + '\'' +
                ", chrgDeptCode='" + chrgDeptCode + '\'' +
                ", chargerId='" + chargerId + '\'' +
                ", exmntDeptCode='" + exmntDeptCode + '\'' +
                ", ocapSttusCode='" + ocapSttusCode + '\'' +
                ", improptCn='" + improptCn + '\'' +
                ", causeAnalsCn='" + causeAnalsCn + '\'' +
                ", imprvmCntrplnCn='" + imprvmCntrplnCn + '\'' +
                ", improptDgreeCode='" + improptDgreeCode + '\'' +
                ", improptProcessStleCode='" + improptProcessStleCode + '\'' +
                ", comptDte='" + comptDte + '\'' +
                ", improptValidfmnmEvlCode='" + improptValidfmnmEvlCode + '\'' +
                ", validfmnmEvlDte='" + validfmnmEvlDte + '\'' +
                ", dmgeScaleCn='" + dmgeScaleCn + '\'' +
                ", processResultCn='" + processResultCn + '\'' +
                ", recrPrvnCntrplnCn='" + recrPrvnCntrplnCn + '\'' +
                ", atchmnflSeqno='" + atchmnflSeqno + '\'' +
                ", deleteAt='" + deleteAt + '\'' +
                ", lastChangerId='" + lastChangerId + '\'' +
                ", lastChangeDt='" + lastChangeDt + '\'' +
                ", exmntSeqno='" + exmntSeqno + '\'' +
                ", improptProcessResultCode='" + improptProcessResultCode + '\'' +
                ", exprOdr='" + exprOdr + '\'' +
                ", bplcCode='" + bplcCode + '\'' +
                ", qcResultValue='" + qcResultValue + '\'' +
                ", sanctnProgrsSittnCodeNm='" + sanctnProgrsSittnCodeNm + '\'' +
                ", chrgDeptCodeNm='" + chrgDeptCodeNm + '\'' +
                ", chargerIdNm='" + chargerIdNm + '\'' +
                ", exmntDeptCodeNm='" + exmntDeptCodeNm + '\'' +
                ", ocapSttusCodeNm='" + ocapSttusCodeNm + '\'' +
                ", improptDgreeCodeNm='" + improptDgreeCodeNm + '\'' +
                ", improptProcessStleCodeNm='" + improptProcessStleCodeNm + '\'' +
                ", improptValidfmnmEvlCodeNm='" + improptValidfmnmEvlCodeNm + '\'' +
                ", gridData=" + gridData +
                ", addedRow=" + addedRow +
                ", editedRow=" + editedRow +
                ", removedRow=" + removedRow +
                ", expriemNm='" + expriemNm + '\'' +
                ", mtrilNm='" + mtrilNm + '\'' +
                ", prductTyNm='" + prductTyNm + '\'' +
                ", ordr='" + ordr + '\'' +
                ", reqestExpriemSeqno='" + reqestExpriemSeqno + '\'' +
                '}';
    }

    public boolean isNew() {
        return this.ncrSeqno == null;
    }

    public boolean isAdded() {
        return this.addedRow.size() > 0;
    }

    public boolean isEdited() {
        return this.editedRow.size() > 0;
    }

    public boolean isRemoved() {
        return this.removedRow.size() > 0;
    }

}

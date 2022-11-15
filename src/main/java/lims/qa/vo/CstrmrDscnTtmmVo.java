package lims.qa.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lims.com.vo.CmSanctn;
import lims.sys.vo.UserMVo;
import lombok.Builder;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Data
public class CstrmrDscnTtmmVo extends CmSanctn {
    private String cstmrDscnttSeqno;			/* 고객 불만 일련번호 */
    private String cstmrDscnttNo;			/* 고객 불만 번호 */
    private String entrpsSeqno;			/* 업체 일련번호 */
    private String entrpsNm;        //업체 명
    private String cstmrDscnttSj;			/* 고객 불만 제목 */
    private String mtrilSeqno;			/* 제품 일련번호 */
    private String mtrilNm;         //제품 명
    private String lotNo;			/* LOT NO */
    private String occrrncDte;			/* 발생 일자 */
    private String occrrncQtt;			/* 발생 수량 */
    private String reprtAt;			/* 보고서 여부 */
    private String requstDte;			/* 요청 일자 */
    private String chrgDeptCode;			/* 담당 부서 코드 */
    private String chrgDeptCodeNm;			/* 담당 부서 명 */
    private String chargerId;			/* 담당자 ID */
    private String chargerIdNm;			/* 담당자 ID */
    private String cstmrDscnttIpcrCode;			/* ZRS11 고객 불만 중요도 코드 */
    private String cstmrDscnttIpcrCodeNm;			/* ZRS11 고객 불만 중요도 명 */
    private String ocapSttusCode;			/* ZRS20 OCAP 상태 코드 */
    private String ocapSttusCodeNm;			/* ZRS20 OCAP 상태 명 */
    private String m5e1Code;			/* ZRS27 M5E1Code */
    private String m5e1CodeNm;			/* ZRS27 M5E1Code */
    private String dmgeScaleCn;			/* 피해 규모 내용 */
    private String comptDte;			/* 완료 일자 */
    private String causeAnalsCn;			/* 원인 분석 내용 */
    private String imprvmCntrplnCn;			/* 개선 대책 내용 */
    private String dscnttCn;			/* 불만 내용 */
    private String atchmnflSeqno;			/* 첨부파일 일련번호 */
    private String sanctnerId;
    private String sanctnerNm;
    private String wdtbSeqno;			/* 배포 일련번호 */
    private String deleteAt;			/* 삭제 여부 */
    private String lastChangerId;			/* 최종 변경자 ID */
    private String lastChangeDt;			/* 최종 변경 일시 */
    private String exmntSeqno;			/* 검토 일련번호 */
    private String sanctnProgrsSittnCode;   //결재 진행상황

    private String cstmrDscnttUserSeqno;			/* 고객 불만 이용자 일련번호 */
    private String userId;			/* 이용자 ID */
    private String userNm;			/* 이용자 NM */
    private String deptNm;			/* 부서 명 */
    private String ofcpsNm;			/* 직위 명 */
    private String moblphon;			/* 이동전화 */

    //조회조건 모음
    private String requstDteSt;
    private String requstDteEn;
    private String comptDteSt;
    private String comptDteEn;

    //리스트
    private List<CstrmrDscnTtmmVo> addUserList;
    private List<CstrmrDscnTtmmVo> removeUserList;

    @JsonIgnore
    public boolean isNew(){
        return this.cstmrDscnttSeqno == null || "".equals(this.cstmrDscnttSeqno);
    }

    @JsonIgnore
    public boolean isExitsAddUserList(){
        return this.addUserList != null && addUserList.size() > 0;
    }

    @JsonIgnore
    public boolean isExitsRemoveUserList(){
        return this.removeUserList != null && removeUserList.size() > 0;
    }
}

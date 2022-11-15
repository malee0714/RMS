package lims.test.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class LotTraceMVo {
    private String lotNoSeqno; //LOT NO 일련번호
    private String reqestSeqno; //의뢰 일련번호
    private String bplcCode; //사업장 코드
    private String reqestNo; //의뢰 번호
    private String lotNo; // lot No
    private String avrgApplcAt; // 평균 적용 여부
    private String sploreNm; // 시료 명
    private String reqestDeptCode; // 의뢰 부서 코드
    private String reqestDeptNm; //의뢰 부서 명
    private String clientId; //의뢰자 ID
    private String clientNm; //의뢰자 명
    private String reqestDte; //의뢰 일자
    private String inspctTyCode; //ZSY07 검사 유형 코드
    private String inspctTyCodeNm; //ZSY07 검사 유형 코드 명
    private String custlabSeqno; //분석실 일련번호
    private String prductSeCode; // 제품구분
    private String prductSeCodeNm; // 제품구분명
    private String mtrilNm; //제품명
    private String mnfcturDte; //제조 일자
    private String rm; //비고(특이사항)
    private String custlabNm; //분석실명
    private String mtrilSeqno; //분석실명
    private String deleteAt;


    private String mainReqestSeqno;
    private String ordr;
    private String lwprtReqestSeqno;
    private String sortOrdr;

    private String reqestNoSch;
    private String reqestDeptCodeSch;
    private String inspctTyCodeSch;
    private String reqBeginDte;
    private String reqEndDte;
    private String inspctTyNm;
    private String prductTyNm;

}

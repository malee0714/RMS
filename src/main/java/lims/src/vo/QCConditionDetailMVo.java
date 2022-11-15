package lims.src.vo;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class QCConditionDetailMVo {

    private String inspctTyCodeSch;
    private String custlabSeqnoSch;
    private String mtrilNmSch;
    private String prductSeCodeSch;
    private String mnfcturBeginDte;
    private String mnfcturEndDte;


    private String sploreNm;
    private String resultValue;
    private String spec;
    private String avgValue;
    private String unitSeqno;
    private String unitNm;
    private String expriemSeqno;
    private String expriemNm;
    private String lclValue;
    private String uclValue;
    private String mnfcturDte;

    private String analytical;
    private String stdDev;
}

package lims.src.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter

public class QCConditionMVo {

    private String cnt;
    private String uncnt;
    private String jdgmntWordCode;
    private String resultRegistDte;
    private String inspctTyCode;
    private String cmmnCodeNm;
    private String prductSeCode;
    private String mtrilNm;

    private String mnfcturDteSch;
    private String shrReqestBeginDte;
    private String shrReqestEndDte;
    private String shrReqestBetweenDte;
    private String rereqestNum;
}

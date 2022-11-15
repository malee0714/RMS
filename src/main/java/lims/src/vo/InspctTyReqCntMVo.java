package lims.src.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class InspctTyReqCntMVo {

    private String bplcNm;
    private String inspctTyCode;
    private String inspctTyNm;
    private String reqestDte;
    private String yearMnth;
    private int reqestCnt;

    private String yearSch;
    private String bplcCodeSch;

    private List<InspctTyReqCntMVo> list;
    private List<InspctTyReqCntMVo> listDate;

}

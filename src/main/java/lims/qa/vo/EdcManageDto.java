package lims.qa.vo;


import lims.com.vo.BaseDto;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
public class EdcManageDto extends BaseDto {

    // 교육 관리
    private Integer edcSeqno;
    private String edcSeCode;
    private String edcSeNm;
    private String edcSeDetailCode;
    private String edcSeDetailNm;
    private String edcSj;
    private String edcEvlStdrCode;
    private String evlStdrNm;
    private String edcInsttNm;
    private String edcBeginDte;
    private String edcEndDte;
    private String edcUser;
    private String nxttrmEdcTrgetAt;
    private String nxtEdcTrget;
    private String nxttrmEdcDte;
    private String innerEvlerAt;
    private String innerEvler;
    private String evlerNm;
    private String evlCn;
    private String rm;
    private Integer atchmnflSeqno;

    // 교육 이용자
    private Integer edcUserSeqno;
    private String userId;
    private String userNm;
    private String inspctInsttNm;
    private String evlResultValue;
    private String edcQualfAlwncCode;
    private String edcQualfAlwncCodeNm;
    private List<EdcManageDto> gridData;
    private List<EdcManageDto> addedRow = new ArrayList<>();
    private List<EdcManageDto> editedRow = new ArrayList<>();
    private List<EdcManageDto> removedRow = new ArrayList<>();

    // 조회 조건
    private String schedcSeCode;
    private String schEdcSeDetailCode;
    private String schEdcSj;
    private String schEdcBeginDte;
    private String schEdcEndDte;
    private String schDeptCode;
    private String schUserNm;
    
    
    public boolean isNew() {
        return this.edcSeqno == null;
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

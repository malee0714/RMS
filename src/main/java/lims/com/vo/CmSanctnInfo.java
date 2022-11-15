package lims.com.vo;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class CmSanctnInfo extends BaseDto {
    private Integer ordr; // 순서
    private Integer sanctnSeqno; // 결재 일련번호
    private Integer totSanctnerCo; // 총 결재자 수
    private Integer sanctnOrdr; // 결재 순서
    private String sanctnSeCode; // ZCM02 결재 구분 코드
    private String sanctnProgrsSittnCode; // ZCM01 결재 진행 상황 코드
    private Integer sanctnerId; // 결재자 ID
    private String sanctnDte; // 결재 일자
    private String sanctnOpinion; // 결재 의견
    
    public boolean isNew() {
        return this.ordr == null;
    }
    
    public void sanctnValid() {
        if (this.sanctnSeqno == null) {
            throw new IllegalStateException("결재정보 없이 결재자를 저장할 수 없습니다.");
        }
    }
}

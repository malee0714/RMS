package lims.rsc.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class QualfStdrMVo {
	
	private String qualfStdrSeqno;
	private String qualfStdrSeSeqno;
	private String bplcCode; 
	private String qualfElgblSeCode;
	private String stdrNm;
	private String atchmnflSeqno;
	private String rm;
	private String lastChangerId;
	private String lastChangeDt;
    private String stdrSeCode;
    private String stdrSeNm;
    private String sortOrdr;
    private String useAt;
    private String deleteAt;
    private String bplcCodeNm;
    
	
	
	//기타 / 조회 조건
	
	private String stdrNmSch;
	private String qualfElgblSeCodeSch;
	private String qualfElgblSeCodeNm;
	private String useAtSch;
	private String bplcCodeSch;
	
	
	//배점기준리스트 기준결과목록 리스트
	
	private String scoreAddList;
	private String scoreEditList;
	private String scoreRemoveList;
	private String baseLineAddList;
	private String baseLineEditList;
	private String baseLineRemoveList;
	
	
	List<QualfStdrMVo>addedRowList;
	List<QualfStdrMVo>editedRowList;
	List<QualfStdrMVo>removedRowList;

}

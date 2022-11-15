package lims.qa.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter 
@Setter
public class CstmrDDataVo {

	private String docSeqno;
	private String sj;
	private String docNm;
	private String docSeDetailSeqno;
	private String docManageNo;
	private String writngDte;
	private String wrterId;
	private String ctmmnySeqno;
	private String mtrilSeqno;
	private String reformNo;
	private String estbshDte;
	private String reformDte;
	private String revnResn;
	private String dsuseDte;
	private String dsuseResn;
	private String duspsnId;
	private String sanctnSeqno;
	private String atchmnflSeqno;
	private String rm;
	private String useAt;
	private String deleteAt;
	private String lastChangerId;
	private String lastChangeDt;
	private String bplcCode;
	private String mtrilNm;
	private String lastVerAt;
	private String cycle;
    private String cycleCode;
    private String ctmmnyNm;
	
	private String sanctnProgrsSittnCode;
	
	
	private String useAtSch;
	private String crud;
	private String docSeSeqnoSch;
	private String sjSch;
	private String docNmSch;
	private String docSeDetailSeqnoSch;
	private String ctmmnySeqnoSch;
	private String docSeSeqno;
	
	private String key;
	private String value;
	private String docSeDetailNm;
	private String docSeNm;
	private String wrterNm;
	private String duspsnNm;
	private String lastDocAt;
	private String wdtbAt;
	
	
	//배포
	
	private String wdtbSeqno;
	private String wdtbPrearngeDt;
	private String wdtbDt;
	private String userId;
    private String cn;
    private String emailTrnsmisAt;
    private String chrctrTrnsmisAt; 
    private String emailTrnsmisComptAt; 
    private String chrctrTrnsmisComptAt;
    
      

    //상세 Yn
    private String wdtbEstbsAt;
    private String entrpsChoiseEssntlAt;
    private String mtrilChoiseEssntlAt;
    
    
	List<CstmrDDataVo> wdtbInfoList2;
	
}

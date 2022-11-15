package lims.rsc.vo;


import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class QualfResultMVo {
	// USER VO
	private String bplcCode;
	private String bplcCodeNm;
	private String deptNm;
	private String userId;
	private String userNm;
	private String encpn;
	private String reformDte;
	private String qualfTotScore;
	private String elgblTotScore;
	private String qualfJdgmntSeqno;
	private String elgblJdgmntSeqno;
	private String lastQualfStdrAt;
	private String lastChangerId;
	private String lastChangeDt;
	private String deleteAt;
	private String diffYear;
	private String qualfStdrSeqno;
	private String qualfElgblSeNm;
	private String stdrNm;
	private String stdrSeCodeNm;
	private String stdrSeNm;
	private String score;
	private String stdrSeDetailNm;
	private String qualfElgblSeCode;
	private String key;
	private String value;
	private String qualfStdrSeSeqno;
	private String qualfStdrRegistSeqno;
	private String qualfStdrSeResultSeqno;
	private String updRegistSeqno; /* 업데이트할 등록 일련번호 */
	private String elgblJdgmntNm;
	private String qualfJdgmntNm;
	
	
	
	
	
	List<QualfResultMVo> resultGridList;
	List<QualfResultMVo> removedRowList;
	List<QualfResultMVo> editedRowList;
	
	private String deptCodeSch;
	private String userNmSch;
	private String bplcCodeSch;
}

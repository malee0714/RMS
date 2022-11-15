package lims.qa.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lims.com.vo.CmSanctn;
import lombok.Getter;
import lombok.Setter;

@Getter 
@Setter
public class DocDto extends CmSanctn {

	private Integer docSeqno;
	private String sj;
	private String docNo;
	private String writngDte;
	private String wrterId;
	private String reformNo;
	private String estbshDte;
	private String reformDte;
	private String revnResn;
	private String dsuseDte;
	private String dsuseResn;
	private String duspsnId;
	private String atchmnflSeqno;
	private String rm;
	private String lastVerAt;
	private String deptCode; //콤보박스 받는 파라미터
	private String chrgDeptCode;
	private String chrgDeptCodeNm;
	private String chargerId;
	private String chargerNm;
	private String inspctInsttNm;
	private Integer exmntSeqno;
	
	private String useAtSch;
	private String docNoSch;
	private String crud;
	private String docSeCodeSch;
	private String sjSch;
	private String ctmmnySeqnoSch;
	private String docSeCode;
	private String docSeCodeNm;
	private String sanctnProgrsSittnCodeSch;

	private String key;
	private String value;
	private String docSeDetailNm;
	private String docSeNm;
	private String wrterNm;
	private String mtrilNm;
	private String duspsnNm;
	private String userNm;
	private String ctmmnyNm;

	@JsonIgnore
	public boolean isNew() {
		return this.docSeqno == null;
	}

	@JsonIgnore
	public void setSuperSj(String sj) {
		super.setSj(sj);
	}

	// 재.개정 번호에 따른 날짜 return
	public String getReformAndEstbshDte() {
		return ("0".equals(this.getReformNo())) ? this.getEstbshDte() : this.getReformDte();
	}
}

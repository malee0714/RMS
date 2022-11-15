package lims.rsc.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class CustlabWorkerDto extends BaseCustlabDto {
	private Integer custlabWrkrSeqno;
	private Integer userId;
	private String userNm;
	private String inspctInsttNm;
	
	@JsonIgnore
	public boolean isNew() {
		super.custlabValidation();
		return this.custlabWrkrSeqno == null; 
	}
}

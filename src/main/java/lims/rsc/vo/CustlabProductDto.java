package lims.rsc.vo;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class CustlabProductDto extends BaseCustlabDto {
	private Integer custlabPrductSeqno;
	private Integer mtrilSeqno;
	private String prductSeCodeNm;
	private String mtrilNm;

	@JsonIgnore
	public boolean isNew() {
		super.custlabValidation();
		return this.custlabPrductSeqno == null;
	}
}

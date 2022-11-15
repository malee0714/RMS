package lims.com.vo;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class CmRtn extends BaseDto{
	private Integer ordr;
	private Integer sanctnSeqno;
	private Integer returnerId;
	private String returnerNm;
	private String rtnResn;
	private Integer[] sanctnSeqnoList;
}

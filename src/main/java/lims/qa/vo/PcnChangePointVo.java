package lims.qa.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class PcnChangePointVo {

	private int pcnChangePointSeqno; 				// PCN 변경점 일련번호.
	private int pcnSeqno;							// PCN 일련번호.
	private String changePointApplcCode;			// PCN 변경점 코드번호.
	private String lastChangerId;					// 최종변경자.
	private Date lastChangeDt;						// 최종 변경 일시.
	
}

package lims.sys.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
//@ToString(exclude : {"login_id", "menu_seqno", "gridName", "saveColumns", "chng_date"})
public class ColumnMVo {
	
	private String login_id;
	private String menu_seqno;
	private String gridName;
	private String saveColumns;
//	private List<String> saveColumns;
	private String chng_date;
	
	private String dataField, headerText, applyRestPercentWidth, width, visible, editable, style, columnIndex, isBranch, depth, leaf;
//	private List<String> headerTooltip, editRenderer, validHandler;

	
	
	@Override
	public String toString() {
		return "{dataField:" + dataField + ", headerText:" + headerText + ", applyRestPercentWidth:"
				+ applyRestPercentWidth + ", width:" + width + ", visible:" + visible + ", editable:" + editable
				+ ", style:" + style + ", columnIndex:" + columnIndex + ", isBranch:" + isBranch + ", depth:" + depth
				+ ", leaf:" + leaf + "}";
	}
}

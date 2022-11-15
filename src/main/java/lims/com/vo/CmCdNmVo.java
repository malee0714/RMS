package lims.com.vo;

import java.util.List;
import java.util.Map;

public class CmCdNmVo {
	
    private String cmCode;/*공통코드*/
    private String valueColumn;/*공휴일명*/
    private String nameColumn;/*파일명*/
    private String tableName;/*테이블명*/
    private String tableId;
    private List<Map<String, String>> where;
    
	public String getCmCode() {
		return cmCode;
	}
	public void setCmCode(String cmCode) {
		this.cmCode = cmCode;
	}
	public String getValueColumn() {
		return valueColumn;
	}
	public void setValueColumn(String valueColumn) {
		this.valueColumn = valueColumn;
	}
	public String getNameColumn() {
		return nameColumn;
	}
	public void setNameColumn(String nameColumn) {
		this.nameColumn = nameColumn;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getTableId() {
		return tableId;
	}
	public void setTableId(String tableId) {
		this.tableId = tableId;
	}
	public List<Map<String, String>> getWhere() {
		return where;
	}
	public void setWhere(List<Map<String, String>> where) {
		this.where = where;
	}
	
}
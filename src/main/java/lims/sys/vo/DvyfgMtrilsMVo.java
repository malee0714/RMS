package lims.sys.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class DvyfgMtrilsMVo {
	private String dlivyDvyfgMtrilSeqno;
	private String deptCode;
	private String deptNm;
	private String dvyfgEntrpsSeNm;
	private String ctmmnyMtrilCode;
	private String dvyfgEntrpsSeCode;
	private String col1;
	private String col2;
	private String col3;
	private String col4;
	private String col5;
	private String col6;
	private String col7;
	private String col8;
	private String col9;
	private String col10;
	private String deleteAt;
	private String orginlDlivyQy;
	
	//검색
	private String shrDeptCode;
	private String shrDvyfgEntrpsSeCode;
	private String shrDeleteAt;
	
	
	private List<DvyfgMtrilsMVo> insMtrilsGrid;
	private List<DvyfgMtrilsMVo> updMtrilsGrid;
	private List<DvyfgMtrilsMVo> delMtrilsGrid;
	
	
}

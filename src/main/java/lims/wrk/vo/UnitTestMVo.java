package lims.wrk.vo;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class UnitTestMVo {

	// SY_UNIT_TEST 관련.
	private Integer unitTestSeqno;
	private String testerNm;
	private String testCn;
	private String testDte;
	private String processAt;
	private String processCn;
	private String processDte;
	private String accessIp;
	private String deleteAt;
	private String lastChangerId;
	private Date lastChangeDt;
	private String rm;
	
	// SY_MENU_ACCTO_CHARGER 관련.
	private String chargerNm;
	
	// SY_MENU 관련.
	private String menuNm;
	
	// 테이블 공통 컬럼
	private Integer menuSeqno;
	
	// 서치 관련.
	private Integer srcMenuSeqno;
	private String srcMenuNm;
	private String srcChargetNm;
	private String srcProcessAt;
	
	// Gird 관련
	private List<UnitTestMVo> gridData;
	
	// 셀렉트 관련
	private String key;
	private String value;
	
	// 처리 여부 매핑.
	private String processAtNm;
	
}

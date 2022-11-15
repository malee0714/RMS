package lims.com.vo;

import java.util.List;

import lombok.Data;
import lombok.ToString;


@Data
@ToString
public class RdmsMVo {
	private String binderItemValueA;	// 원본
	private String binderItemValueB;	// 복사본
	private String binderitemvalueId;
	private String binderItemValue;//삭제 바인더 체크 vo
	private String reqestExpriemSeqno;
	private String rdmsGbn;
	private List<String> gridData;
	private List<String> gridData2;
	private List<String> exprOdrArr;
	private List<RdmsMVo> key3Arr;
	private List<RdmsMVo> binderArr;
	private String uuid;
	private String userId;
	private String loginIp;//로그인 IP
	private String reason; // 삭제 사유
	private String docIDs;
	private String exprOdr;
	private String showGbn;
	private String installStatus;
	private String reqestSeqno;
	private String authorSeCode;
	private String page;
	private String itemName;
	private String itemLabelname;
	private String changeVal;
	private String bplcCode;

	
	
	/* RDMS Mapping */

	private List<RdmsMVo> columnInfoList; //바인더아이디에 해당하는 컬럼세팅 정보

	private String B01;
	private String B02;
	private String B03;
	private String B04;
	private String B05;
	private String B06;

	private String R01;
	private String R02;
	private String R03;

	private String U01;
	private String U02;
	private String U03;
	private String U04;
	private String U05;
	private String U06;
	private String U07;
	private String U08;
	private String U09;
	private String U10;
	private String U11;
	private String U12;
	private String U13;
	private String U14;
	private String U15;
	private String U16;
	private String U17;
	private String U18;
	private String U19;
	private String U20;
	private String U21;
	private String U22;
	private String U23;
	private String U24;
	private String U25;
	private String U26;
	private String U27;
	private String U28;
	private String U29;
	private String U30;

}
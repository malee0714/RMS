package lims.sys.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class OrgMVo {

	private String inspctInsttCode; //조직코드
	private String bestInspctInsttCode; //최상위조직 코드
	private String upperInspctInsttCode; //상위조직 코드
	private String inspctInsttNm; //조직명
	private String dc; //설명
	private String useAt; //사용여부
	private String deleteAt; //삭제여부
	private String lastChangerId; //최종변경자ID
	private String lastChangeDt; //최종변경일시
	private String insttmLv; //조회레벨
	private String sapPlantCode;  // SAP PLANT 코드
	private String elgblEvlAt;
	private String authorCode;
	private String authorNm;

	/* 콤보박스 */
	private String key;
	private String value;

	/* 검색조건 */
	private String bplcCodeSch;             //사업장 코드
	private String bestInspctInsttCodeSch;  //최상위조직코드
	private String upperInspctInsttCodeSch; //상위조직코드
	private String inspctInsttNmSch;        //조직명
	private String useAtSch;                //사용여부

}

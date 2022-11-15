package lims.lng.vo;

import lombok.Getter;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
public class CmmnCodeLangMVo {
	
	private String langCmmnCodeSeqno;
	private String cmmnCode;            /* 공통 코드 */
	private String nationLangCode;            /* ZSY06 국가 언어 코드 */
	private String langNm;            /* 언어 명 */
	private String useAt;            /* 사용 여부 */
	private String deleteAt;            /* 삭제 여부 */
	private String lastChangerId;            /* 최종 변경자 ID */
	private String lastChangeDt;            /* 최종 변경 일시 */
	
	private String cmmnLangCode;
	private String cmmnSearch;
	
	/***/
	private String upperCmmnCode;            /* 상위 공통 코드 */
	private String cmmnCodeNm;            /* 공통 코드 명 */
	private String cmmnCodeRm;            /* 공통 코드 비고 */
	private String tmprField1Nm;            /* 임시 필드1 명 */
	private String tmprField1Value;            /* 임시 필드1 값 */
	private String tmprField2Nm;            /* 임시 필드2 명 */
	private String tmprField2Value;            /* 임시 필드2 값 */
	private String tmprField3Nm;            /* 임시 필드3 명 */
	private String tmprField3Value;            /* 임시 필드3 값 */
	private String tmprField4Nm;            /* 임시 필드4 명 */
	private String tmprField4Value;            /* 임시 필드4 값 */
	private String tmprField5Nm;            /* 임시 필드5 명 */
	private String tmprField5Value;            /* 임시 필드5 값 */
	private List<CmmnCodeLangMVo> children;
	private String scrinUseAt;            /* 화면 사용 여부 */

	private String updtPosblAt;  /* 수정가능 여부  */
	
	private String searchCode;
	private String searchNm;
	private String searchUpCode;
	private String searchUpNm;
	private String gbnCrud;
	private String notInCode;
	private String inCode;
	private String deptCode;
	
	/***/
	
}

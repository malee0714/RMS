package lims.wrk.vo;

import java.util.Date;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class EntrpsMDto {
	
	// SY_ENTRPS 테이블 관련
	private Integer entrpsSeqno;		// 업체 일련번호
	private String bplcCode;			// 사업장 코드
	private String entrpsNm;			// 업체 명
	private String entUseAt;			// 사용 여부
	private String lastChangerId;		// 최종 변경자 id
	private Date lastChangeDt;			// 최종 변경 일시
	
	
	// SY_ENTRPS_SE 테이블 관련
	private String entrpsSeCode;		// 업체 구분 코드
	private String entSeUseAt;			// 업체 구분 사용 여부
	
	// SY_ENTRPS_SE 
	private String entrpsSeCodeCus;		// 고객사
	private String entrpsSeCodeCoop;	// 협력사
	
	
	// Grid 관련
	private List<EntrpsMDto> insgridData;
	private List<EntrpsMDto> updGridData;
	private List<EntrpsMDto> delGridData;
	
}

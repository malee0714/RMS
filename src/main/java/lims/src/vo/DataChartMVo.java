package lims.src.vo;

import lims.spc.enm.ResultValueType;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class DataChartMVo {
	private String deptCodeSch;
	private String processTySch;
	private String prductSeqnoSch;
	private String expriemNm;
	private String resultValue;
	private String firstValue;
	private String mhrlsNm;
	private String year;
	private String chartFlag;
	private String bplcCodeSch;
	private String inspctTyCodeSch;
	private String mtrilNmSch;
	private String mnfcturBeginDte;
	private String mnfcturEndDte;
	private String mtrilSeqnoSch;
	private String entrpsSeqnoSch;
	private String lotNo;
	private String sploreName;
    private String reqestExpriemSeqno;
    private String lclValue;
    private String uclValue;
    private String lslValue;
    private String uslValue;
    private String venderResultValue;
    private String coaAtSch;
    
    
    //spc 필ㅇ
    private boolean qcAtSch; //qc true false
    private String qcResultValue;
}
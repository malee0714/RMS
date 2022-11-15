package lims.spc.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class SpcSampleStats {
	
	private String mtrilSeqno;      //자재 seqno
	private String mtrilSdspcSeqno; //자재 기준규격 seqno
	
	// 일반 결과값
	private double cl;      // UCL 값
	private double stdev;   // CL 값
	private double ucl;     // LCL 값
	private double lcl;     // 표준편차
	
	// qc결과값 
	private double qcCl;
	private double qcStdev;
	private double qcUcl;
	private double qcLcl;
	
}

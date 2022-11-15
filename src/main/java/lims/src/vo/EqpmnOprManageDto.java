package lims.src.vo;

import lims.com.vo.BaseDto;
import lombok.Data;

@Data
public class EqpmnOprManageDto extends BaseDto {

	private Integer eqpmnSeqno;
	private String eqpmnNm;
	private String eqpmnClcode;
	private String eqpmnClNm;
	private String eqpmnManageNo;
	private String chrgDeptCode;
	
	// 월별 가동률 변수
	private String monOp1;
	private String monOp2;
	private String monOp3;
	private String monOp4;
	private String monOp5;
	private String monOp6;
	private String monOp7;
	private String monOp8;
	private String monOp9;
	private String monOp10;
	private String monOp11;
	private String monOp12;
	
	// 월별 가용률 변수
	private String monUs1;
	private String monUs2;
	private String monUs3;
	private String monUs4;
	private String monUs5;
	private String monUs6;
	private String monUs7;
	private String monUs8;
	private String monUs9;
	private String monUs10;
	private String monUs11;
	private String monUs12;
	
	// 건수 
	private String monCnt1;
	private String monCnt2;
	private String monCnt3;
	private String monCnt4;
	private String monCnt5;
	private String monCnt6;
	private String monCnt7;
	private String monCnt8;
	private String monCnt9;
	private String monCnt10;
	private String monCnt11;
	private String monCnt12;
	
	// 조회조건
	private String chrgDeptCodeSch;
	private String yearSch;
	private String eqpmnClCodeSch;
	private String eqpmnNmSch;
	
}

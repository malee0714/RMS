package lims.test.vo;

import java.util.Comparator;
import java.util.List;
import java.util.Set;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonInclude.Include;

import lombok.Data;

@Data
@JsonInclude(Include.NON_NULL)
public class RoaMSubVo implements Comparator<Object>{
	String
	reqestSeqno,
	reqestExpriemSeqno,
	exprOdr,
    firRdmsAt,
    firCalcRaw,
    firRvsopCn,
    firVriablId,
    firVriablValue,
    firNumot,
    scdRdmsAt,
    scdCalcRaw,
    scdRvsopCn,
    scdVriablId,
    scdVriablValue,
    scdNumot,
    thdRdmsAt,
    thdCalcRaw,
    thdRvsopCn,
    thdVriablId,
    thdVriablValue,
    thdNumot,
    fourRdmsAt,
    fourCalcRaw,
    fourRvsopCn,
    fourVriablId,
    fourVriablValue,
    fourNumot,
    fifRdmsAt,
    fifCalcRaw,
    fifRvsopCn,
    fifVriablId,
    fifVriablValue,
	fifNumot;
	
	String firNomfrmUuid;		//시험후 계산식 바꼇을때 rdms uuid 1~5까지
	String scdNomfrmUuid;
	String thdNomfrmUuid;
	String fourNomfrmUuid;
	String fifNomfrmUuid;
	
	String firNomfrmRdmsDocNo;	//시험후 계산식 바꼇을대 rdms binderitemvalue_id 1~5까지
	String scdNomfrmRdmsDocNo;
	String thdNomfrmRdmsDocNo;
	String fourNomfrmRdmsDocNo;
	String fifNomfrmRdmsDocNo;
	
	String firMarkCphr; // 소수점자리수겨산 자리수
	String scdMarkCphr;
	String thdMarkCphr;
	String fourMarkCphr;
	String fifMarkCphr;
	
	// RDMS 데이터 생성용-------------------------------------
	
	String binderitemvalue_id;
	String uuid;
	String change_val;
	
	List<RoaMSubVo> valueinfo;
	Set<RoaMSubVo> valueinfoSet;
	
	String rdmsUuid;		// rdms uuid 키
	String updtRdmsDocNo;	// rdms 수정 키;
	
	
	@Override
	public int compare(Object o1, Object o2) {
		
		int result = 0;
		
		String binderItemvalue_id1 = ((RoaMSubVo)o1).getBinderitemvalue_id();
		String binderItemvalue_id2 = ((RoaMSubVo)o2).getBinderitemvalue_id();
		
		if(binderItemvalue_id1 != null && binderItemvalue_id2 != null)
			result = binderItemvalue_id1.compareTo(binderItemvalue_id2);
		
		return result;
	}
	
	
}

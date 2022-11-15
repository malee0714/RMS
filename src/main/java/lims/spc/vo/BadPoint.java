package lims.spc.vo;

import lims.spc.enm.ResultValueType;
import lims.spc.enm.SpcRule;
import lombok.*;

import java.util.List;

/**
 * 
 * Spc 8대 Rule에 위배되는 객체의 정보를 갖는 VO입니다.
 * 
 * 넘겨받은 표본중 어떠한 구간이 위배된 구간인지 전부 찾아내서 retrun하기 위해 사용됩니다.
 * 
 * @author shs
 */
@Getter @ToString
@Builder @AllArgsConstructor @NoArgsConstructor
public class BadPoint {
	private List< ? extends SpcResultExpriem> badSploreNames;	// rule에 위배된 lot들 (point)
	private int fromIndex;						                // rule에 위배된 List의 시작index
	private int toIndex;						                // rule에 위배된 List의 끝 index
	private int n;								                // 미지수 n
	private double sigma;						                // sigma. ucl로 사용될 수 있음.
	private double sigmaLv1;					                // +1 sigma
	private double minaSigmaLv1;				                // -1 sigma
	private double cl;							                // cl
	private double ucl;							                // ucl
	private double lcl;							                // lcl
	private double standardDeviation;			                // 표준편차
	private SpcRule rule;				                        // rule
	private ResultValueType resultValueType;                    // 결과값 구분
	private boolean qc;                                         // qc 여부
	private boolean chartData;                                  // 차트메뉴에서 호출한건지
	
	/**
	 * n 타점 상향, 하향에 대해 상향에 대한 List인지 하향에 대한 List인지 표시.
	 * true 	: 상향
	 * false 	: 하향
	 */
	private boolean up;
	
	/**
	 * ture 	: 첫번째 badPointList를 찾으면 return.
	 * false 	: badPointList를 계속 탐색.
	 */
	@Builder.Default
	private boolean findFirst = true;
}

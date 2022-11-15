package lims.spc.enm;

import java.util.Arrays;
import java.util.function.BiFunction;

/**
 * UCL
 * IM07000001	IM07	이하
 * IM07000002	IM07	미만
 * 
 * LCL
 * IM08000001	IM08	이상
 * IM08000002	IM08	초과
 * 
 * @author shs
 */
public enum UclLclSeCode {

	OR_LESS("IM07000001", (uclLclValue, resultValue) -> resultValue <= uclLclValue), // 이하이면 true
	UNDER("IM07000002", (uclLclValue, resultValue) -> resultValue < uclLclValue), // 미만이면 true
	MORE_THAN("IM08000001", (uclLclValue, resultValue) -> resultValue >= uclLclValue), // 이상이면 true
	OVER("IM08000002", (uclLclValue, resultValue) -> resultValue > uclLclValue); // 초과이면 true

	private final String code;
	private final BiFunction<Double, Double, Boolean> compare;
	
	UclLclSeCode(String code, BiFunction<Double, Double, Boolean> compare) {
		this.code = code;
		this.compare = compare;
	}
	
	public String getCode() {
		return this.code;
	}
	
	/**
	 * 공통코드로 ucl, lcl 값 구분 코드 찾아서 반환
	 * @param uclLclSeCode spc rule 공통코드
	 * @return UclLclSeCode
	 */
	public static UclLclSeCode findUclLclSeCode(String uclLclSeCode) {
		return Arrays.stream(UclLclSeCode.values())
				.filter(code -> uclLclSeCode.equals(code.getCode()))
				.findFirst()
				.orElseThrow(() -> new RuntimeException( uclLclSeCode + "-> Not definition UclLclSeCode."));
	}
	
	public boolean isBad(Double uclLclValue, Double resultValue) {
		// null이면 값 비교 안함
		if (uclLclValue == null) {
			return false;
		} else {
			return !this.compare.apply(uclLclValue, resultValue);
		}
	}
}

package lims.spc.enm;

import lims.spc.vo.SpcChart;
import lims.spc.vo.SpcResultExpriem;
import lims.spc.vo.SpcSampleStats;

import java.util.function.BiFunction;
import java.util.function.Consumer;
import java.util.function.Function;

/**
 * 
 * SPC Rule 위배 검사시에 어떤 ResultValueType으로 검사할건지에 대한 열거이다.
 * Qc 여부에 따라서 qc값을 return할지, 일반 result value를 return할지 정해진다.
 * 
 * 향후 새로운 Value Type이 추가되면 여기에 추가.
 * @author shs
 */
public enum ResultValueType {
	RESULT_VALUE(
			SpcResultExpriem::getUclValue, // 일반 ucl value return (qc여부 상관없이 시험항목평균 테이블의 ucl, lcl값만을 선택)
			SpcResultExpriem::getLclValue, // 일반 lcl value return (qc여부 상관없이 시험항목평균 테이블의 ucl, lcl값만을 선택)
			(spcResultExpriem, isQc) -> isQc ? spcResultExpriem.getQcResultValue() : spcResultExpriem.getResultValue(), // is qc true ? qc result value. or not -> result value.
			(stats, isQc) -> isQc ? stats.getQcCl() : stats.getCl(), // is qc true ? qc cl value. or not -> cl value.
			(stats, isQc) -> isQc ? stats.getQcStdev() : stats.getStdev(), // is qc true ? qc stdev value. or not -> stdev value.
			SpcChart::setupResultValueData // RESULT_VALUE 관련 chart data set 
	);
	public final Function<SpcResultExpriem, Double> getUclValue;
	public final Function<SpcResultExpriem, Double> getLclValue;
	public final BiFunction<SpcResultExpriem, Boolean, Double> getValue;
	public final BiFunction<SpcSampleStats, Boolean, Double> getCl;
	public final BiFunction<SpcSampleStats, Boolean, Double> getStdev;
	public final Consumer<SpcChart> setChartData;
	
	ResultValueType( Function<SpcResultExpriem, Double> getUclValue,
	                 Function<SpcResultExpriem, Double> getLclValue,
					 BiFunction<SpcResultExpriem, Boolean, Double> getValue,
	                 BiFunction<SpcSampleStats, Boolean, Double> getCl,
	                 BiFunction<SpcSampleStats, Boolean, Double> getStdev,
	                 Consumer<SpcChart> setChartData ) {

		this.getUclValue = getUclValue;
		this.getLclValue = getLclValue;
		this.getValue = getValue;
		this.getCl = getCl;
		this.getStdev = getStdev;
		this.setChartData = setChartData;
	}
	
	// ucl value는 통계쿼리를 통해서 뽑은 데이터가 아닌 시험항목 결과 table에 저장되어있는 ucl이다.
	public Double getUclValue(SpcResultExpriem spcResultExpriem) {
		return getUclValue.apply(spcResultExpriem);
	}
	public Double getLclValue(SpcResultExpriem spcResultExpriem) {
		return getLclValue.apply(spcResultExpriem);
	}
	public Double getValue(SpcResultExpriem spcResultExpriem, boolean isQc) {
		return getValue.apply(spcResultExpriem, isQc);
	}
	
	public double getCl(SpcSampleStats stats, boolean isQc) {
		return getCl.apply(stats, isQc);
	}
	
	public double getStdev(SpcSampleStats stats, boolean isQc) {
		return getStdev.apply(stats, isQc);
	}
	
	public void setChartData(SpcChart spcChart) {
		setChartData.accept(spcChart);
	}
}

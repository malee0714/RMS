package lims.spc.vo;

import lims.spc.enm.SpcRule;

import java.util.List;
import java.util.stream.Collectors;

/**
 * 
 * Spc Rule Test를 하기위한 Samples List의 일급 Collection 입니다.
 * 
 * @author shs
 */
public class SpcSamples {
	
	private final List<? extends SpcResultExpriem> spcSamples;

	public SpcSamples(List<? extends SpcResultExpriem> spcSamles) {
		this.spcSamples = spcSamles;
	}

	public List<? extends SpcResultExpriem> getSpcSamles() {
		return this.spcSamples;
	}
	
	// Samples가 유효한가 ?
	public boolean isPresent() {
		return (this.spcSamples.size() > 0);
	}
	
	// Samples가 유효하지 않은가 ?
	public boolean isNotPresent() {
		return (this.spcSamples.size() == 0);
	}
	
	// Samples가 Spc rule Test하기에 유효성을 따져 데이터를 가공한다.
	// 유효하다면, chart메뉴인지, roa, 결과입력메뉴인지 판단하여 List를 재가공하여 return한다.
	public List<? extends SpcResultExpriem> getProcessedSpcSamples(BadPoint badPointVO){
		
		SpcRule spcRule = badPointVO.getRule();
		
		// 5,6번 rule은 n + 1 개의 point를 검사하기 때문에 n + 1 시켜준다.
		int n = (spcRule.equals(SpcRule.RULE_5) || spcRule.equals(SpcRule.RULE_6)) ? badPointVO.getN() + 1 : badPointVO.getN();
		
		if(badPointVO.isChartData()){ // chart menu일 경우 List size는 변함 없다.
			return this.spcSamples;
			
		}else if ( !badPointVO.isChartData() && this.spcSamples.size() < n ){ // chart menu가 아니지만 samples의 size가 n value보다 작은 경우
			return this.spcSamples;
			
		}else {
			// samples의 size가 n value보다 크며, chart menu가 아닌 (roa, 결과입력) menu 이면 N value의 크기만큼만 사용해야한다.
			// 결과입력, roa에서는 가장 최근 Lot가 0번째 index부터 들어오게 된다. 그래서 0번째부터 n번째까지 잘라서 사용한다.
			return this.spcSamples.subList(0, n);
		}
	}
	
	// 결과입력, ROA에서 검사시 시험항목명 return해줌.
	// return해주는 시험항목 명은 spc rule test 검사시 모든 index똑같기 때문에 0번째 index의 시험항목 명 return
	public String getExpriemNm (){
		return this.isPresent() ? this.spcSamples.get(0).getExpriemNm() : "";
	}
	
	public List<String> getPureSploreNames() {
		return this.spcSamples.stream()
				.map(SpcResultExpriem::getSploreNm)
				.collect(Collectors.toList())
				;
	}
	
	public List<Double> getPureUclValues() {
		return this.spcSamples.stream()
				.map(SpcResultExpriem::getUclValue)
				.collect(Collectors.toList())
				;
	}

	public List<Double> getPureLclValues() {
		return this.spcSamples.stream()
				.map(SpcResultExpriem::getLclValue)
				.collect(Collectors.toList())
				;
	}
	public List<Double> getPureResultValues() {
		return this.spcSamples.stream()
				.map(SpcResultExpriem::getResultValue)
				.collect(Collectors.toList())
				;
	}
	
	public List<Double> getPureQcResultValues() {
		return this.spcSamples.stream()
				.map(SpcResultExpriem::getQcResultValue)
				.collect(Collectors.toList())
				;
	}

	public List<String> getPureVenderResultValues() {
		return this.spcSamples.stream()
				.map(SpcResultExpriem::getVenderResultValue)
				.collect(Collectors.toList())
				;
	}

}

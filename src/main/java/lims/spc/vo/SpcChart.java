package lims.spc.vo;

import lims.spc.enm.ResultValueType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Builder @AllArgsConstructor @NoArgsConstructor
public class SpcChart {
	private String expriemNm;                                       // 시험항목 명
	private List<SpcRuleTestDto> violateRules = new ArrayList<>();   // 위반된 Rule 들
	private ResultValueType resultValueType;
	private SpcSamples spcSamples;                                  // spc test 표본 List

	// ResultValueType 상관없이 chart에서 표현 되어야 하는 member. null이면 곤란하기때문에 초기화.
	private List<String> sploreNames = new ArrayList<>();
	
	/* ResultValueType RESULT_VALUE 일 경우 표현되는 member들 */
	private List<Double> uclValues;
	private List<Double> lclValues;
	private List<String> venderResultValues;
	private List<Double> resultValues;
	private List<Double> qcResultValues;
	public SpcChart(String expriemNm, ResultValueType resultValueType, SpcSamples spcSamples) {
		this.expriemNm = expriemNm;
		this.resultValueType = resultValueType;
		this.spcSamples = spcSamples;
	}
	
	/*
		RESULT_VALUE chart 관련 정보들 setup
		아래 List들은 차트에서 그려질 '선 (Line)' 입니다.
	 */
	public void setupResultValueData() {
		this.sploreNames = this.spcSamples.getPureSploreNames();
		this.uclValues = this.spcSamples.getPureUclValues();
		this.lclValues = this.spcSamples.getPureLclValues();
		this.venderResultValues = this.spcSamples.getPureVenderResultValues();
		this.resultValues = this.spcSamples.getPureResultValues();
		this.qcResultValues = this.spcSamples.getPureQcResultValues();
	}
	public String getExpriemNm() {
		return expriemNm;
	}

	public List<SpcRuleTestDto> getViolateRules() {
		return violateRules;
	}

	public ResultValueType getResultValueType() {
		return resultValueType;
	}

	public List<String> getSploreNames() {
		return sploreNames;
	}

	public List<Double> getUclValues() {
		return uclValues;
	}

	public List<Double> getLclValues() {
		return lclValues;
	}

	public List<String> getVenderResultValues() {
		return venderResultValues;
	}

	public List<Double> getResultValues() {
		return resultValues;
	}

	public List<Double> getQcResultValues() {
		return qcResultValues;
	}
}

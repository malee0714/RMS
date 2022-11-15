import lims.spc.enm.ResultValueType;
import lims.spc.enm.SpcRule;
import lims.spc.vo.BadPoint;
import lims.spc.vo.SpcResultExpriem;
import lims.spc.vo.SpcSamples;
import org.junit.Assert;
import org.junit.Test;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Enf IIT DOC
 * /99. 기타/02. 받은자료/20210601_SPC_8대룰_예시/8. SPC Trend 8대 Rule 예시.xlsx
 * 위 경로의 파일 [SPC 8대 Rule 예시] sheet와 비교하여 분홍색으로 칠해진 셀과 같은 index 나오면 테스트 성공 입니다.
 * 
 * @author shs
 */
public class SpcTest {

	//Spc 1번rule ~ 8번 rule까지 테스트합니다.
	//from index와 to index로 테스트하는게 가장 간단하다고 생각해서 from index, to index로 테스트함.
	@Test
	public void SpcRule검증코드Test(){
		
		SpcTest testUtil = new SpcTest();

		// ENF Excel sample리스트 예시데이터 그대로 넣어서 테스트.
		List<Number> excelNumbers1 = Arrays.asList(99.11, 95.68, 102.79, 92.57, 103.20, 101.13, 102.41, 96.82, 90.41, 99.73, 102.19, 101.35, 98.04, 102.99, 100.09, 103.69, 101.32, 98.67, 95.04, 105.97, 105.05, 100.10, 135.00, 100.60, 98.48, 140.00, 92.69, 98.95, 94.82, 103.40);
		List<Number> excelNumbers2 = Arrays.asList(99.1, 95.7, 102.8, 92.6, 103.2, 101.1, 102.4, 96.8, 90.4, 99.7, 102.2, 101.4, 98.0, 103.0, 100.1, 103.7, 101.3, 98.7, 106.40, 102.00, 106.22, 104.70, 110.00, 109.13, 104.36, 103.29, 106.40, 89.00, 91.00, 90.00);
		List<Number> excelNumbers3 = Arrays.asList(99.1, 90.4, 92.6, 95.7, 96.8, 99.7, 101.1, 91.0, 100.0, 92.0, 89.0, 101.4, 98.0, 103.0, 100.1, 103.7, 101.3, 98.7, 95.0, 110.0, 108.0, 105.0, 101.0, 100.1, 98.9, 100.0, 102.0, 89.0, 81.0, 103.4);
		List<Number> excelNumbers4 = Arrays.asList(99.11, 95.68, 102.79, 92.57, 103.20, 101.13, 102.41, 96.82, 90.41, 99.73, 102.19, 99.00, 102.00, 100.00, 104.00, 100.00, 101.32, 98.67, 103.00, 98.00, 103.00, 100.10, 101.07, 100.60, 100.00, 97.30, 92.69, 98.95, 94.82, 103.40);
		List<Number> excelNumbers5 = Arrays.asList(99.11, 95.68, 102.79, 92.57, 103.20, 101.13, 102.41, 96.82, 90.41, 99.73, 102.19, 101.35, 98.04, 102.99, 100.09, 103.69, 101.32, 98.67, 95.04, 105.97, 110.00, 105.00, 111.00, 100.60, 98.48, 92.00, 93.00, 94.00, 94.82, 103.40);
		List<Number> excelNumbers6 = Arrays.asList(99.11, 95.68, 102.79, 92.57, 103.20, 101.13, 102.41, 96.82, 90.41, 99.73, 102.19, 101.35, 98.04, 102.99, 100.09, 103.69, 101.32, 98.67, 95.04, 105.97, 109.00, 110.00, 108.00, 100.60, 98.48, 90.00, 89.00, 91.50, 94.82, 103.40);
		List<Number> excelNumbers7 = Arrays.asList(99.11, 95.68, 102.79, 92.57, 103.20, 101.13, 102.41, 96.82, 90.41, 99.73, 102.19, 101.35, 99.47, 96.70, 95.88, 100.40, 98.06, 100.16, 97.03, 100.00, 97.69, 100.80, 99.38, 95.85, 97.55, 100.66, 96.16, 105.00, 106.00, 103.40);
		List<Number> excelNumbers8 = Arrays.asList(99.11, 95.68, 102.79, 92.57, 89.00, 85.00, 91.00, 96.82, 90.41, 99.73, 91.00, 107.00, 109.12, 108.00, 107.00, 108.00, 109.00, 107.93, 109.00, 100.00, 91.00, 90.27, 91.22, 105.40, 105.22, 93.22, 91.44, 104.16, 104.44, 103.40);

		// spc 1번 rule ~ 8번 rule test. 엑셀 예시 데이터 그대로 테스트. 결과값, 표준편차,cl,ucl,lcl 모두 Excel데이터와 같은 상황에서 테스트
		List<BadPoint> badPoints1 = SpcRule.RULE_1.test(testUtil.getSpcRuleExprList(excelNumbers1), BadPoint.builder().cl(102.077).standardDeviation(10.365).n(3).rule(SpcRule.RULE_1).findFirst(false).resultValueType(ResultValueType.RESULT_VALUE).chartData(true).build());
		List<BadPoint> badPoints2 = SpcRule.RULE_2.test(testUtil.getSpcRuleExprList(excelNumbers2), BadPoint.builder().cl(100.490).n(9).standardDeviation(5.549).rule(SpcRule.RULE_2).findFirst(false).resultValueType(ResultValueType.RESULT_VALUE).chartData(true).build());
		List<BadPoint> badPoints3 = SpcRule.RULE_3.test(testUtil.getSpcRuleExprList(excelNumbers3), BadPoint.builder().n(6).rule(SpcRule.RULE_3).findFirst(false).resultValueType(ResultValueType.RESULT_VALUE).chartData(true).build());
		List<BadPoint> badPoints4 = SpcRule.RULE_4.test(testUtil.getSpcRuleExprList(excelNumbers4), BadPoint.builder().n(14).rule(SpcRule.RULE_4).findFirst(false).resultValueType(ResultValueType.RESULT_VALUE).chartData(true).build());
		List<BadPoint> badPoints5 = SpcRule.RULE_5.test(testUtil.getSpcRuleExprList(excelNumbers5), BadPoint.builder().cl(99.850).standardDeviation(5.031).n(2).rule(SpcRule.RULE_5).findFirst(false).resultValueType(ResultValueType.RESULT_VALUE).chartData(true).build());
		List<BadPoint> badPoints6 = SpcRule.RULE_6.test(testUtil.getSpcRuleExprList(excelNumbers6), BadPoint.builder().cl(99.600).standardDeviation(5.487).n(4).rule(SpcRule.RULE_6).findFirst(false).resultValueType(ResultValueType.RESULT_VALUE).chartData(true).build());
		List<BadPoint> badPoints7 = SpcRule.RULE_7.test(testUtil.getSpcRuleExprList(excelNumbers7), BadPoint.builder().cl(99.253).standardDeviation(3.474).n(15).rule(SpcRule.RULE_7).findFirst(false).resultValueType(ResultValueType.RESULT_VALUE).chartData(true).build());
		List<BadPoint> badPoints8 = SpcRule.RULE_8.test(testUtil.getSpcRuleExprList(excelNumbers8), BadPoint.builder().cl(99.264).standardDeviation(7.628).n(8).rule(SpcRule.RULE_8).findFirst(false).resultValueType(ResultValueType.RESULT_VALUE).chartData(true).build());

		/* ############################ Chart menu test code ############################ */
		//1번룰 테스트 bad poin from index, to index
		Assert.assertEquals("25,25 | 22,22", 
				badPoints1.stream()
						.map(badPoint -> badPoint.getFromIndex() + "," + badPoint.getToIndex())
						.collect(Collectors.joining(" | "))
		);

		// 2번 룰 테스트 bad poin from index, to index
		Assert.assertEquals("18,26", 
				badPoints2.stream()
						.map(badPoint -> badPoint.getFromIndex() + "," + badPoint.getToIndex())
						.collect(Collectors.joining(" | "))
		);
		// 3번 룰 테스트 bad poin from index, to index
		Assert.assertEquals("19,24 | 1,6", 
				badPoints3.stream()
						.map(badPoint -> badPoint.getFromIndex() + "," + badPoint.getToIndex())
						.collect(Collectors.joining(" | "))
		);
		// 4번 룰 테스트 bad poin from index, to index
		Assert.assertEquals("10,23 | 9,22", 
				badPoints4.stream()
						.map(badPoint -> badPoint.getFromIndex() + "," + badPoint.getToIndex())
						.collect(Collectors.joining(" | "))
		);
		// 5번 룰 테스트 bad poin from index, to index
		Assert.assertEquals("20,22",
				badPoints5.stream()
						.map(badPoint -> badPoint.getFromIndex() + "," + badPoint.getToIndex())
						.collect(Collectors.joining(" | "))
		);
		// 6번 룰 테스트 bad poin from index, to index
		Assert.assertEquals("19,23 | 18,22", 
				badPoints6.stream()
						.map(badPoint -> badPoint.getFromIndex() + "," + badPoint.getToIndex())
						.collect(Collectors.joining(" | "))
		);
		// 7번 룰 테스트 bad poin from index, to index
		Assert.assertEquals("12,26 | 11,25 | 10,24 | 9,23", 
				badPoints7.stream()
						.map(badPoint -> badPoint.getFromIndex() + "," + badPoint.getToIndex())
						.collect(Collectors.joining(" | "))
		);
		// 8번 룰 테스트 bad poin from index, to index
		Assert.assertEquals("11,18", 
				badPoints8.stream()
						.map(badPoint -> badPoint.getFromIndex() + "," + badPoint.getToIndex())
						.collect(Collectors.joining(" | "))
		);

		/*
		############################ 결과입력, ROA menu test code ############################
		결과입력, ROA 메뉴에서의 Spc Rule Test는 List전체 size를 모두 순회하며 test하는것이 아니라. BadPointVO의 n값에 따라 List size를 줄여놓고 테스트한다.
		spc 1번 rule ~ 8번 rule test. 엑셀 예시 데이터에서 일부 index만 임의로 가져와 테스트함.
		여기서 1번 rule의 테스트는 제외한다. 1번 rule은 앞으로 ENF에서 배제될 예정이므로. 1번 rule을 고려하지 않은 코드들이 많아졌다. 
		 */
		List<BadPoint> miniBadPoints2 = SpcRule.RULE_2.test(
				testUtil.getSpcRuleExprList(Arrays.asList(106.40, 102.00, 106.22, 104.70, 110.00, 109.13, 104.36, 103.29, 106.40,98.0, 103.0, 100.1, 103.7, 101.3, 98.7)),
				BadPoint.builder().cl(100.490).n(9).standardDeviation(5.549).rule(SpcRule.RULE_2).findFirst(true).resultValueType(ResultValueType.RESULT_VALUE).chartData(false).build()
		);
		List<BadPoint> miniBadPoints3 = SpcRule.RULE_3.test(
				testUtil.getSpcRuleExprList(Arrays.asList(110.0, 108.0, 105.0, 101.0, 100.1, 98.9, 101.3, 98.7, 95.0)), 
				BadPoint.builder().n(6).rule(SpcRule.RULE_3).findFirst(true).resultValueType(ResultValueType.RESULT_VALUE).chartData(false).build()
		);
		List<BadPoint> miniBadPoints4 = SpcRule.RULE_4.test(
				testUtil.getSpcRuleExprList(Arrays.asList(99.73, 102.19, 99.00, 102.00, 100.00, 104.00, 100.00, 101.32, 98.67, 103.00, 98.00, 103.00, 100.10, 101.07, 96.82, 90.41)), 
				BadPoint.builder().n(14).rule(SpcRule.RULE_4).findFirst(true).resultValueType(ResultValueType.RESULT_VALUE).chartData(false).build()
		);

		List<BadPoint> miniBadPoints5 = SpcRule.RULE_5.test(
				testUtil.getSpcRuleExprList(Arrays.asList(110.00, 105.00, 111.00, 98.67, 95.04, 105.97)),
				BadPoint.builder().cl(99.850).standardDeviation(5.031).n(2).rule(SpcRule.RULE_5).findFirst(true).resultValueType(ResultValueType.RESULT_VALUE).chartData(false).build()
		);
		List<BadPoint> miniBadPoints6 = SpcRule.RULE_6.test(
				testUtil.getSpcRuleExprList(Arrays.asList(95.04, 105.97, 109.00, 110.00, 108.00, 102.99, 100.09, 103.69, 101.32, 98.67)),
				BadPoint.builder().cl(99.600).standardDeviation(5.487).n(4).rule(SpcRule.RULE_6).findFirst(true).resultValueType(ResultValueType.RESULT_VALUE).chartData(false).build()
		);
		List<BadPoint> miniBadPoints7 = SpcRule.RULE_7.test(
				testUtil.getSpcRuleExprList(Arrays.asList(99.47, 96.70, 95.88, 100.40, 98.06, 100.16, 97.03, 100.00, 97.69, 100.80, 99.38, 95.85, 97.55, 100.66, 96.16, 102.19, 101.35)), 
				BadPoint.builder().cl(99.253).standardDeviation(3.474).n(15).rule(SpcRule.RULE_7).findFirst(true).resultValueType(ResultValueType.RESULT_VALUE).chartData(false).build()
		);
		List<BadPoint> miniBadPoints8 = SpcRule.RULE_8.test(
				testUtil.getSpcRuleExprList(Arrays.asList(107.00, 109.12, 108.00, 107.00, 108.00, 109.00, 107.93, 109.00, 90.41, 99.73, 91.00)), 
				BadPoint.builder().cl(99.264).standardDeviation(7.628).n(8).rule(SpcRule.RULE_8).findFirst(true).resultValueType(ResultValueType.RESULT_VALUE).chartData(false).build()
		);

		// rule 2
		Assert.assertEquals("106.4,106.4",
				miniBadPoints2.stream()
						.map(badPoint -> badPoint.getBadSploreNames().get(badPoint.getFromIndex()).getResultValue() + "," + badPoint.getBadSploreNames().get(badPoint.getToIndex()).getResultValue())
						.findFirst().orElse("test fail")
		);
		// rule 3
		Assert.assertEquals("110.0,98.9",
				miniBadPoints3.stream()
						.map(badPoint -> badPoint.getBadSploreNames().get(badPoint.getFromIndex()).getResultValue() + "," + badPoint.getBadSploreNames().get(badPoint.getToIndex()).getResultValue())
						.findFirst().orElse("test fail")
		);
		// rule 4
		Assert.assertEquals("99.73,101.07",
				miniBadPoints4.stream()
						.map(badPoint -> badPoint.getBadSploreNames().get(badPoint.getFromIndex()).getResultValue() + "," + badPoint.getBadSploreNames().get(badPoint.getToIndex()).getResultValue())
						.findFirst().orElse("test fail")
		);
		// rule 5
		Assert.assertEquals("110.0,111.0",
				miniBadPoints5.stream()
						.map(badPoint -> badPoint.getBadSploreNames().get(badPoint.getFromIndex()).getResultValue() + "," + badPoint.getBadSploreNames().get(badPoint.getToIndex()).getResultValue())
						.findFirst().orElse("test fail")
		);
		// rule 6
		Assert.assertEquals("95.04,108.0",
				miniBadPoints6.stream()
						.map(badPoint -> badPoint.getBadSploreNames().get(badPoint.getFromIndex()).getResultValue() + "," + badPoint.getBadSploreNames().get(badPoint.getToIndex()).getResultValue())
						.findFirst().orElse("test fail")
		);
		// rule 7
		Assert.assertEquals("99.47,96.16",
				miniBadPoints7.stream()
						.map(badPoint -> badPoint.getBadSploreNames().get(badPoint.getFromIndex()).getResultValue() + "," + badPoint.getBadSploreNames().get(badPoint.getToIndex()).getResultValue())
						.findFirst().orElse("test fail")
		);
		// rule 8
		Assert.assertEquals("107.0,109.0",
				miniBadPoints8.stream()
						.map(badPoint -> badPoint.getBadSploreNames().get(badPoint.getFromIndex()).getResultValue() + "," + badPoint.getBadSploreNames().get(badPoint.getToIndex()).getResultValue())
						.findFirst().orElse("test fail")
		);
	}
	
	// Integer List를 SpcSamples 일급 collection 객체로 변환하여 Spc rule Test를 원활히 할 수 있도록.
	// parameter type을 맞추기 위함임
	public SpcSamples getSpcRuleExprList(List<Number> numbers) {
		return new SpcSamples(
				numbers.stream()
						.map(number -> {
							return SpcResultExpriem
									.builder()
									.resultValue(number.doubleValue())
									.qcResultValue(number.doubleValue() + 14)
									.uclValue(133.170)
									.build();
							}
						)
						.collect(Collectors.toList())
				);
	}
}

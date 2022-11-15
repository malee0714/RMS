package lims.spc.vo;

import lims.spc.enm.SpcRule;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

/**
 * BadPointVO의 일급 Collection Class 입니다.
 * 
 * @author shs
 */
public class BadPointCollection {
	
	private final List<BadPoint> badPoints;

	public BadPointCollection(List<BadPoint> badPoints) {
		this.badPoints = badPoints;
	}

	public List<BadPoint> getBadPoints() {
		return  this.badPoints;
	}

	/**
	 * Chart에서 point를 표시하기 편하도록 data를 만들어 준다. <br>
	 * badList에서 각 index마다 badPoints를 배열로 갖고있는데 해당 배열들의 <br> 
	 * String lotNo값만을 가지는 배열로 얻고싶은 경우 사용.
	 * 
	 * @return List<String>
	 * @see BadPoint getBadFOOSUNG 확인바람.
	 */
	public List<String> getPureBadSploreNames() {
		return this.badPoints.stream()
				.map(BadPoint::getBadSploreNames)
				.flatMap(Collection::stream)
				.map(SpcResultExpriem::getSploreNm)
				.distinct()
				.collect(Collectors.toList());
	}

	/**
	 * BadPoints. SpcRule에 위배된 Lot들이 다구간 발견 되었더라도
	 * Test한 Rule은 같기때문에 0번째의 RuleName을 return합니다.
	 */
	public SpcRule getRule() {
		return this.badPoints.get(0).getRule();
	}
	
	public String getSpcCode() {
		return getRule().getCode();
	}
	
	public boolean isPresent () {
		return (this.badPoints.size() > 0);
	}
}

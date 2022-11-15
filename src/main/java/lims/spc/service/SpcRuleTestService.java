package lims.spc.service;

import lims.spc.vo.SpcChart;
import lims.spc.vo.SpcParam;
import lims.spc.vo.SpcRuleTestDto;

import java.util.List;
import java.util.Optional;

public interface SpcRuleTestService {
	
	// Test or data supplier methods
	List<SpcChart> chartDataSupply(SpcRuleTestDto spcRuleTestDto);
	Optional<SpcRuleTestDto> resultValueSpcTest(SpcParam spcParam);
}

package lims.spc.vo;

import lims.spc.enm.ResultValueType;
import lombok.*;

@Getter @Setter
@Builder @AllArgsConstructor @NoArgsConstructor
public class SpcParam {
	private SpcRuleTestDto spcRuleTestDto;
	private SpcMtrilExpriem spcMtrilExpriem;
	private ResultValueType resultValueType;
}

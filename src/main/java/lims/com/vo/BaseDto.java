package lims.com.vo;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class BaseDto {
	private String bplcCode;        // 사업장 코드
	private String useAt;
	private String deleteAt;
	private String lastChangerId;
	private String lastChangeDt;

	@Override
	public String toString() {
		return "BaseDto{" +
				"bplcCode='" + bplcCode + '\'' +
				", useAt='" + useAt + '\'' +
				", deleteAt='" + deleteAt + '\'' +
				", lastChangerId='" + lastChangerId + '\'' +
				", lastChangeDt='" + lastChangeDt + '\'' +
				'}';
	}
}

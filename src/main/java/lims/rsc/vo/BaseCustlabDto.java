package lims.rsc.vo;

import lims.com.vo.BaseDto;
import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class BaseCustlabDto extends BaseDto {
	private Integer custlabSeqno; // 분석실 일련번호
	
	public void custlabValidation() {
		if (this.custlabSeqno == null) {
			throw new IllegalStateException("분석실 정보없이 하위 데이터를 저장할 수 없습니다.");
		}
	}
	
	public void deleteCustlabValidation() {
		if (this.custlabSeqno == null) {
			throw new IllegalStateException("분석실 정보없이 삭제할 수 없습니다.");
		}
	}
	
	@Override
	public String toString() {
		return super.toString() + 
				"\nBaseCustlabDto{" +
				"custlabSeqno=" + custlabSeqno +
				'}';
	}
}

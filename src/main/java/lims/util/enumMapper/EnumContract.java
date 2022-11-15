package lims.util.enumMapper;

import lombok.AllArgsConstructor;

/**
 * 
 * @author hancheol
 * @see .이놈 콘트랙트 안에는 넣고싶은거 매칭해서 넣어주면됨
 */
public class EnumContract{
	
	@AllArgsConstructor
	public enum ReqestType implements EnumModel{
		reqestDte("의뢰 일자"),
		mnfcturDte("제조 일자"),
		batchCo("배치 수"),
		reqestSeCode("의뢰 구분"),
		prductTnkSeqno("Tank No."),
		lotId("Lot ID"),
		upperLotId("상위 Lot Id"),
		virtlLotSeCode("가상 Lot 구분"),
		expriemNm("시험 항목 명"),
		canNo("Can. No");
		
		String value;

		@Override
		public String getKey(){
			return name();
		}

		@Override
		public String getValue(){
			return value;
		}
	}
	
}

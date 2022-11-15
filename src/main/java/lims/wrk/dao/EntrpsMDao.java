package lims.wrk.dao;

import java.util.List;

import lims.wrk.vo.EntrpsMDto;
import lims.wrk.vo.EntrpsMVo;

public interface EntrpsMDao {
	
	// 조회
	List<EntrpsMDto> getEntrpsMList(EntrpsMVo EntrpsMVo);
	
	// 생성
	public Integer insEntrpsM(EntrpsMDto vo);

	// 수정
	public Integer updEntrpsM(EntrpsMDto vo);
	
	// 삭제
	public Integer deleteEntrpsM(EntrpsMDto vo);
	
	// 업체 정보 생성 및 수정
	public void saveEntrpsSe(EntrpsMDto vo);
	
	// 업체 코드 정보 초기화
	public void resetEntrpsSeCode(EntrpsMDto vo);

	
	
	// 데이터 입력 시 업체명 확인.
	public int insEntrpsNmValidation(EntrpsMDto vo);
	
	// 데이터 업데이트 시 업체명 확인.
	public int updEntrpsNmValidation(EntrpsMDto vo);
	
	
}

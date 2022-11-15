package lims.rsc.dao;

import java.util.HashMap;
import java.util.List;

import lims.rsc.vo.MhrlsUnInspctMVo;

public interface MhrlsUnInspctMDao {
	
	/**
	 * 미등록 설비 검교정 목록 조회
	 * @param vo
	 * @return
	 */
	public List<MhrlsUnInspctMVo> getMhrlsUnInspctM(MhrlsUnInspctMVo vo);
	
	/**
	 * 미등록 설비 검교정 목록 조회(월별)
	 * @param vo
	 * @return
	 */
	public List<MhrlsUnInspctMVo> getMonthMhrlsUnInspctM(MhrlsUnInspctMVo vo);
	/**
	 * 미등록 설비 검교정 목록 조회(부서별)
	 * @param vo
	 * @return
	 */
	public List<MhrlsUnInspctMVo> getdeptMhrlsUnInspctM(MhrlsUnInspctMVo vo);
	
	/**
	 * 미등록 설비 정보 그리드 추가 데이터 저장
	 * @param vo
	 * @return
	 */
	public int insertMhrlsUnInspctM(MhrlsUnInspctMVo vo);
	
	/**
	 * 미등록 설비 정보 그리드 수정 데이터 저장
	 * @param vo
	 * @return
	 */
	public int updateMhrlsUnInspctM(MhrlsUnInspctMVo vo);
	
	/**
	 * 미등록 설비 정보 그리드 삭제 데이터 저장
	 * @param vo
	 * @return
	 */
	public int deleteMhrlsUnInspctM(MhrlsUnInspctMVo vo);
	
	/**
	 * 실제하는 부서인지 조회
	 * @param vo
	 * @return
	 */
	public MhrlsUnInspctMVo getDeptCodeCnt(HashMap<String, Object> params);

	
}

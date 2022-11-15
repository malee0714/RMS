package lims.wrk.dao;

import lims.wrk.vo.ExpriemMVo;

import java.util.List;

public interface ExpriemMDao {

	//조회
	List<ExpriemMVo> getExpriemMList(ExpriemMVo vo);

	//저장
	int insExpriem(ExpriemMVo vo);

	//업데이트
	int updExpriem(ExpriemMVo vo);

	//시헝항목명 중복 체크
	int getExpriemNmCnt(ExpriemMVo vo);

	//시험항목 삭제
	int deleteExpriem(ExpriemMVo vo);

	//시험항목 순서 변경
	int updExpriemSortOrdr(ExpriemMVo list);
}

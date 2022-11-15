package lims.wrk.service;

import lims.wrk.vo.ExpriemMVo;

import java.util.List;

public interface ExpriemMService {

	//조회
	List<ExpriemMVo> getExpriemMList(ExpriemMVo vo);

	//저장
	int insExpriemM(ExpriemMVo vo);

	//수정
	int updExpriemM(ExpriemMVo vo);

	//시험항목 중복체크
	int getExpriemNmCnt(ExpriemMVo vo);

	//시험항목 삭제
	int deleteExpriem(ExpriemMVo vo);

	//시험항목 순서 변경
	int updExpriemSortOrdr(List<ExpriemMVo> list);

}
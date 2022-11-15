package lims.wrk.dao;

import java.util.HashMap;
import java.util.List;

import lims.wrk.vo.PrintngMVO;


public interface PrintngMDao {

	//출력물 정보 조회
	public List<PrintngMVO> getPrintngMList(PrintngMVO vo);
	
	//출력물 파일명 중복체크
	public int chkPrintngFileNm(HashMap<String, Object> map);
	
	//출력물 정보 저장
	public int insPrintngM(PrintngMVO vo);

	//출력물 정보 수정
	public int updPrintngM(PrintngMVO vo);

	//출력물 이력 저장
	public void insPrintngHistM(PrintngMVO vo);

	//출력물 삭제
	public int deletePrintngM(PrintngMVO vo);

	//최신 이력버전 조회
	public int getMaxHistVer(PrintngMVO vo);

	//시퀀스에 해당하는 출력물 정보
	public PrintngMVO getPrintngSeqnoInfo(String printngSeqno);
}
package lims.qa.service.Impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.qa.dao.VocMDao;
import lims.qa.service.VocMService;
import lims.qa.vo.VocMVo;

@Service
public class VocMServiceImpl implements VocMService{

	@Autowired
	private VocMDao vocMDao;


	/**
	 * VOC목록 조회
	 */
	@Override
	public List<VocMVo> searchVocList(VocMVo vo) {
		return vocMDao.searchVocList(vo);
	}
	
	/**
	 * VOCRegist목록 조회
	 */
	@Override
	public List<VocMVo> getVocRegist(VocMVo vo) {
		return vocMDao.getVocRegist(vo);
	}
	
	/**
	 * VOC 등록
	 */
	@Override
	public int putVoc(VocMVo vo) {
		int result = 0;
		 if(vo.getVocSeqno() == 0 ){
			 int vocSeqno = vocMDao.getVocSeqno(vo);
			 vo.setVocSeqno(vocSeqno);
		 }
		 if(vo.getVocRegistSeqno() == 0 ){
			 int vocRegistSeqno = vocMDao.getVocRegistSeqno(vo);
			 vo.setVocRegistSeqno(vocRegistSeqno);
		 }
		 if(vo.getVocRceptNo() == null || "".equals(vo.getVocRceptNo())){
			 String vocRceptNo = vocMDao.getVocRceptNo(vo);
			 vo.setVocRceptNo(vocRceptNo);
		 }
		 vocMDao.putVoc(vo);
		 vocMDao.putVocRegist(vo);
		return result;
	}
	
	/**
	 * VOC 삭제
	 */
	@Override
	public int updateVocDel(VocMVo vo) {
		int result = 0;
		vocMDao.updateVocDel(vo);
		return result;
	}
	
	
	/**
	 * VOC 대책수립 등록
	 */
	@Override
	public int putDiagnose(VocMVo vo) {
		int result = 0;
		if(vo.getVocCntrplnFoundngSeqno() == 0 ){
			int vocCntrplnFoundngSeqno = vocMDao.getVocCntrplnFoundngSeqno(vo);
			vo.setVocCntrplnFoundngSeqno(vocCntrplnFoundngSeqno);
		}
		vocMDao.putVocCntrplnFoundng(vo);
		if("Y".equals(vo.getDiagnoseTemporaryYn())){
			vo.setVocProgrsSittnCode("RS06000003");
			vocMDao.updateVoc(vo);
		}
		return result;
	}
	
	/**
	 * VOC대책수립조회
	 */
	@Override
	public List<VocMVo> getVocCntrplnFoundng(VocMVo vo) {
		return vocMDao.getVocCntrplnFoundng(vo);
	}
	
	
	
	/**
	 * VOC 유효성 검증 등록
	 */
	@Override
	public int putValidVrify(VocMVo vo) {
		int result = 0;
		if(vo.getVocValidVrifySeqno() == 0 ){
			int vocValidVrifySeqno = vocMDao.getVocValidVrifySeqno(vo);
			vo.setVocValidVrifySeqno(vocValidVrifySeqno);
		}
		vocMDao.putVocValidVrify(vo);
		if("Y".equals(vo.getValidVrifyTemporaryYn())){
			vo.setVocProgrsSittnCode("RS06000004");
			vocMDao.updateVoc(vo);
		}
		return result;
	}
	
	/**
	 * VOC유효 검증
	 */
	@Override
	public List<VocMVo> getVocValidVrify(VocMVo vo) {
		return vocMDao.getVocValidVrify(vo);
	}
	
	
	/**
	 * VOC 대책등록 삭제
	 */
	@Override
	public int updateVocCntrplnFoundngDel(VocMVo vo) {
		int result = 0;
		vo.setVocProgrsSittnCode("RS06000002");
		vocMDao.updateVoc(vo);
		vocMDao.updateVocCntrplnFoundngDel(vo);
		return result;
	}
	
	
	/**
	 * VOC 유효검증 삭제
	 */
	@Override
	public int updateVocValidVrifyDel(VocMVo vo) {
		int result = 0;
		vocMDao.updateVocValidVrifyDel(vo);
		vo.setVocProgrsSittnCode("RS06000003");
		vocMDao.updateVoc(vo);
		return result;
	}
	
}

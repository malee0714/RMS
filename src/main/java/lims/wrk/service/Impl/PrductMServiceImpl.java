package lims.wrk.service.Impl;

import lims.util.CommonFunc;
import lims.wrk.dao.PrductMDao;
import lims.wrk.service.PrductMService;
import lims.wrk.vo.PrductMVo;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class PrductMServiceImpl implements PrductMService {
	
	@Autowired
    private PrductMDao prductMDao;
	
	@Autowired
	private CommonFunc commonFunc;
	
	@Override
	public List<PrductMVo> getMtrilList(PrductMVo vo) {
		return prductMDao.getMtrilList(vo);
	}

	@Override
	public int insMtrilNewSave(PrductMVo vo) {
		prductMDao.insMtrilNewSave(vo);
		return Integer.parseInt(vo.getMtrilSeqno());
	}

	@Override
	public List<PrductMVo> getDeptList(PrductMVo vo) {
		return prductMDao.getDeptList(vo);
	}
	
	@Override
	public int putMtrilSave(PrductMVo vo) {
		int cnt = 0;
		String mtrilCode = vo.getMtrilCode().replaceAll("\\s", "").replaceAll(" ", "");
		vo.setMtrilCode(mtrilCode);
		
		if (vo.getFlag() != null)
			vo.setMtrilNm(vo.getMtrilNm() + " - 복사본");

		if (vo.getMtrilSeqno() == null || vo.getMtrilSeqno().equals("")) {
			//사업장별 자재코드 중복방지
			int chkCnt = prductMDao.chkMtrilCodeByPlantIns(vo);
			if (chkCnt > 0) {
				return cnt;
			} else {
				prductMDao.insMtrilNewSave(vo);
				
				var addedExpriemList = vo.getAddedExpriemGrid();
				var addedCylinderList = vo.getAddedCylinderList();
				var addedItemNoList = vo.getAddedItemNoList();

				//제품 시험항목 등록
				if(addedExpriemList != null){
					for(int i=0; i<addedExpriemList.size(); i++){
						addedExpriemList.get(i).setMtrilSeqno(vo.getMtrilSeqno());
						addedExpriemList.get(i).setSortOrdr(Integer.toString(i));
						prductMDao.insExpriem(addedExpriemList.get(i));
					}
				}
				
				//제품 실린더 정보 등록
				if(addedCylinderList != null) {
					for(int i=0; i<addedCylinderList.size(); i++) {
						addedCylinderList.get(i).setMtrilSeqno(vo.getMtrilSeqno());
						prductMDao.addCylinder(addedCylinderList.get(i));
					}
				}
				
				//제품 아이템 정보 등록
				if(addedItemNoList != null) {
					for(int i=0; i<addedItemNoList.size(); i++) {
						addedItemNoList.get(i).setMtrilSeqno(vo.getMtrilSeqno());
						prductMDao.addItemNo(addedItemNoList.get(i));
					}
				}

				cnt = Integer.parseInt(vo.getMtrilSeqno());
			}
		} else {
			//사업장별 자재코드 중복방지
			int chkCnt = prductMDao.chkMtrilCodeByPlantUpd(vo);
			if (chkCnt > 0) {
				return cnt;
			} else {
				prductMDao.updPrductSave(vo);
				
				var addedExpriemList= vo.getAddedExpriemGrid();
				var editedExpriemList= vo.getEditedExpriemGrid();
				var addedCylinderList= vo.getAddedCylinderList();
				var	editedCylinderList= vo.getEditedCylinderList();
				var	addedItemNoList= vo.getAddedItemNoList();
				var editedItemNoList= vo.getEditedItemNoList();

				ArrayList<String> ordr = new ArrayList<String>();;
				
				if(editedExpriemList != null) {
					for(int i=0; i<editedExpriemList.size(); i++){
						editedExpriemList.get(i).setSortOrdr(Integer.toString(i));
						prductMDao.updExpriem(editedExpriemList.get(i));
						
						if(addedExpriemList != null) {
							for(PrductMVo avo : addedExpriemList){
								if(editedExpriemList.get(i).getMtrilSeqno().equals(avo.getMtrilSeqno()) && editedExpriemList.get(i).getExpriemSeqno().equals(avo.getExpriemSeqno())) {
									ordr.add(Integer.toString(i));
								}
							}
						}
					}
				}
				
				if(addedExpriemList != null) {
					for(int i=0; i<addedExpriemList.size(); i++){
						addedExpriemList.get(i).setSortOrdr(ordr.get(i));
						prductMDao.insExpriem(addedExpriemList.get(i));
					}
				}

				if(addedCylinderList != null) {
					for(int i=0; i<addedCylinderList.size(); i++) {
						addedCylinderList.get(i).setMtrilSeqno(vo.getMtrilSeqno());
						prductMDao.addCylinder(addedCylinderList.get(i));
					}
				}
				if(editedCylinderList != null) {
					for(int i=0; i<editedCylinderList.size(); i++) {
						prductMDao.addCylinder(editedCylinderList.get(i));
					}

				}
				if(addedItemNoList != null) {
					for(int i=0; i<addedItemNoList.size(); i++) {
						addedItemNoList.get(i).setMtrilSeqno(vo.getMtrilSeqno());
						prductMDao.addItemNo(addedItemNoList.get(i));
					}
				}
				if(editedItemNoList != null) {
					for(int i=0; i<editedItemNoList.size(); i++) {
						prductMDao.addItemNo(editedItemNoList.get(i));
					}

				}

				cnt = Integer.parseInt(vo.getMtrilSeqno());
			}
				
		}
		return cnt;
	}

	@Override
	public int delMtril(PrductMVo vo) {
		int result = 0;
		
		String sapData = prductMDao.getMtrilSapData(vo);
		if(commonFunc.isEmpty(sapData)) {
			result += prductMDao.delMtril(vo);
		}
			
		return result;
	}

	@Override
	public List<PrductMVo> getMtrilExpriemList(PrductMVo vo) {
		return prductMDao.getMtrilExpriemList(vo);
	}

	@Override
	public List<PrductMVo> getMasterUnitList(PrductMVo vo) {
		return prductMDao.getMasterUnitList(vo);
	}


	@Override
	public int insMtrilExpriemAll(PrductMVo vo) { 
		// TODO Auto-generated method stub  
		int cnt =0;
		
		List<PrductMVo> mtrilList = vo.getMtrilList();
		
		List<PrductMVo> sdspcList = vo.getSdspcList();
		
		if(mtrilList != null && sdspcList != null) {
			for(PrductMVo avo : mtrilList) {
				for(PrductMVo bvo : sdspcList) {
					bvo.setMtrilSeqno(avo.getMtrilSeqno());
					cnt += prductMDao.insExpriemAll(bvo);
				}
			}
		}
		
		 
		
		return cnt;
	}

	@Override
	public int deletCylinder(PrductMVo vo){
		int check = 0;
		List<PrductMVo> removedGridData = vo.getRemovedCylinderList();

		for (int i = 0; i <removedGridData.size(); i++) {
			vo.setMtrilEqpSeSeqno(removedGridData.get(i).getMtrilEqpSeSeqno());
			vo.setMtrilSeqno(removedGridData.get(i).getMtrilSeqno());
			vo.setSanctnSeqno(removedGridData.get(i).getSanctnSeqno());
			vo.setMtrilCylndrSeqno(removedGridData.get(i).getMtrilCylndrSeqno());
			check =prductMDao.deletCylinder(vo);
		}

		return check;
	}

	@Override
	public int deletItemNo(PrductMVo vo) {
		int check = 0;
		List<PrductMVo> removedGridData = vo.getRemovedItemNoList();
		for (PrductMVo item : removedGridData) {
			if (!commonFunc.isEmpty(item.getMtrilItmSeqno())) {
				check += prductMDao.deletItemNo(item);
			}
		}

		return check;
	}

	@Override
	public int deletExpriem(PrductMVo vo){
		int check = 0;
		List<PrductMVo> removedGridData = vo.getRemovedExpriemGrid();

		for (int i = 0; i <removedGridData.size(); i++) {

			vo.setMtrilSdspcSeqno(removedGridData.get(i).getMtrilSdspcSeqno());
			check =prductMDao.delExpriem(vo);
		}

		return  check;
	};

	@Override
	public List<PrductMVo> getcylndrList(PrductMVo vo){
		return prductMDao.getcylndrList(vo);
	}
	@Override
	public List<PrductMVo> getitemNoList(PrductMVo vo){
		return prductMDao.getitemNoList(vo);
	}

}

package lims.sys.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.sys.dao.PlnatMDao;
import lims.sys.service.PlnatMService;
import lims.sys.vo.PlnatMVo;
import lims.util.CommonFunc;
import lims.util.GetUserSession;

@Service
public class PlnatMServiceImpl implements PlnatMService {

	@Autowired
	private PlnatMDao plnatMDao;

	@Autowired
	private CommonFunc commonFunc;

	@Override
	public List<PlnatMVo> getPlnatMList(PlnatMVo vo) {
		return plnatMDao.getPlnatMList(vo);
	}

	@Override
	public int insPlnat(List<PlnatMVo> list) {

		// 행추가, 행삭제 사용안하기로하여 주석처리

		/*
		 * 사업장 등록을 진행하기 전에 DB 데이터를 다시 가져와서 카운팅 하는 이유는
		 * 사용자가 사업장 화면에서 조회버튼을 클릭하지 않고 행추가를 진행하여 등록 시
		 * 정확한 사업장 수를 체크하기 어렵기 때문에 그리드 및 DB를 다시 체크 후 진행


		//이미 등록되어있는 사업장 수, 사업장 수 + 추가 사업장 수의 합 컬럼 을 사용하기위한 생성자
		PlnatMVo gubunVo = new PlnatMVo();
		gubunVo.setUseAt("Y");
		//등록되어있는 모든 사업장
		List<PlnatMVo> gubunList = plnatMDao.getPlnatMList(gubunVo);
		if(gubunList.size() > 0) {
			gubunList.stream().forEach(v -> {
				gubunVo.setCount(gubunVo.getCount() + 1);
			});
		}

		//그리드의 사업장 데이터
		list.stream().forEach(v -> {
			//로컬변수를 조작할 수 없어서 int 타입 변수를 생성하지않고 gubunVo에 count컬럼 사용
			if((v.getInspctInsttCode() == null || "".equals(v.getInspctInsttCode())) && "N".equals(v.getDeleteAt()) && "N".equals(v.getUseAt()))
				gubunVo.setCount(gubunVo.getCount() + 1);
		});

		//gubun 1: 등록, 99 : 사업장 수 초과
		int gubun = plnatMDao.bplcCoCheck(gubunVo.getCount());

		if(gubun == 1) {
			new GetUserSession();
			list.stream().forEach(v -> {
				v.setLastChangerId(GetUserSession.getUserId());
				plnatMDao.insPlnat(v);
			});
		}

		 */

		for(int i = 0; i < list.size(); i++)
			plnatMDao.insPlnat(list.get(i));

		return 1;
	}

	@Override
	public List<PlnatMVo> getPlnatQlityCtAmMList(PlnatMVo vo) {
		return plnatMDao.getPlnatQlityCtAmMList(vo);
	}
	@Override
	public List<PlnatMVo> getlbcstList(PlnatMVo vo) {
		return plnatMDao.getlbcstList(vo);
	}
	

	@Override
	public int putPlnatQlityCtAm(PlnatMVo vo) {

		int result = 0;


		if(!commonFunc.isEmpty(vo)) {
			//품질비 등록
			if(vo.getFormData().size() > 0) {
				if(vo.getFormData().get(0).getInspctInsttLbcstSeqno() != "")
					result = plnatMDao.upLbcst(vo.getFormData().get(0));
				else 
					result = plnatMDao.insLbcst(vo.getFormData().get(0));
					
			}
			if(vo.getAddedRowItems().size() > 0) {
				for(int i = 0; i < vo.getAddedRowItems().size(); i++) {
					vo.getAddedRowItems().get(i).setInspctInsttLbcstSeqno(vo.getFormData().get(0).getInspctInsttLbcstSeqno()); 
					result = plnatMDao.insPlnatQlityCtAm(vo.getAddedRowItems().get(i));
				}
			}
			//품질비 수정
			if(vo.getEditedRowItems().size() > 0) {
				for(int i = 0; i < vo.getEditedRowItems().size(); i++) {
					result = plnatMDao.updPlnatQlityCtAm(vo.getEditedRowItems().get(i));
				}
			}
			//품질비 삭제
			if(vo.getRemovedItems().size() > 0) {
				for(int i = 0; i < vo.getRemovedItems().size(); i++) {
					result = plnatMDao.delPlnatQlityCtAm(vo.getRemovedItems().get(i));
				}
			}
		}

		return result;
	}
}

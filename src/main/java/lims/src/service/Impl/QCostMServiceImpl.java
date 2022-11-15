package lims.src.service.Impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lims.src.dao.QCostMDao;
import lims.src.service.QCostMService;
import lims.src.vo.QCostMVo;
import lims.util.CommonFunc;

@Service
public class QCostMServiceImpl implements QCostMService{

	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;
	@Autowired 
	private QCostMDao  qCostMDao;
	
	/**
	 * 부서별 의뢰건수 조회
	 */
	@Override
	public List<QCostMVo> getQCostList(QCostMVo vo) {
		return qCostMDao.getQCostList(vo);
	}
	
	@Override
	public List<QCostMVo> getCost(List<QCostMVo> list) {
		List <QCostMVo> list1 =new ArrayList<QCostMVo>();
		List <QCostMVo> listadd =new ArrayList<QCostMVo>();
		
		for (int i =0; i<list.size();i++){
		QCostMVo costadd =new QCostMVo();
		int CostTotal=0;
		listadd=qCostMDao.getCost(list.get(i));
		if(listadd.size() == 0){
			return list1;
		}
		for (int j =0; j<listadd.size();j++){
			CostTotal +=listadd.get(j).getCostTotal();
		}
		list1.addAll(listadd);
		costadd.setEqpmnClCode(listadd.get(0).getEqpmnClCode());
		costadd.setEqpmnClCodeNm(listadd.get(0).getEqpmnClCodeNm());
		costadd.setCount("1");
		costadd.setCostTotal(CostTotal);
		list1.add(costadd);
		}
		return list1;
	}
	
	@Override
	public List<QCostMVo> getCostYear(QCostMVo vo) {
		List <QCostMVo> list1 =new ArrayList<QCostMVo>();
		List <QCostMVo> listadd =new ArrayList<QCostMVo>();
		
		return qCostMDao.getCostYear(vo);
			
//		for (int i =0; i<list.size();i++){
//		listadd.addAll(qCostMDao.getCostYear(list.get(i)));
//		}
		//return listadd;
	}
	@Override
	public List<QCostMVo> getCapa(List<QCostMVo> list) {
		List <QCostMVo> list1 =new ArrayList<QCostMVo>();
		List <QCostMVo> listadd =new ArrayList<QCostMVo>();
		for (int i =0; i<list.size();i++){
			list1.addAll(qCostMDao.getCapa(list.get(i)));
		}
		 return list1;
//		for (int i =0; i<list.size();i++){
//		listadd.addAll(qCostMDao.getCostYear(list.get(i)));
//		}
		//return listadd;
	}
	
}

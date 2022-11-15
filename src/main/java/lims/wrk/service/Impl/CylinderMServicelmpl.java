package lims.wrk.service.Impl;


import lims.util.CommonFunc;
import lims.wrk.dao.CylinderMDao;
import lims.wrk.vo.CylinderMVo;
import lims.wrk.service.CylinderMService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class CylinderMServicelmpl implements CylinderMService {

    @Resource(name = "commonFunc")
    private CommonFunc commonFunc;

    @Autowired
    private CylinderMDao cylinderMDao;

    @Override
    public List<CylinderMVo> getcylinderList(CylinderMVo vo) {
        return cylinderMDao.getcylinderList(vo);
    }

    @Override
    public int savecylinder(CylinderMVo vo) {
        return cylinderMDao.savecylinder(vo);
    }

    @Override
    public int deletecylinder(CylinderMVo vo) {
        return cylinderMDao.deletecylinder(vo);
    }

    @Override
    public int batchUpdValvMaker(List<CylinderMVo> list) {
        int result = 0;

        // list parameter 맨마지막에 붙어있는 일괄수정값 뽑아냄
        String editValveMnfcturprofsNm = list.get(list.size()-1).getValveMnfcturprofsNm();
        for (int i = 0; i < list.size()-1; i++) {
            // 기존 밸브제조사를 이전 밸브제조사 값으로 등록하고, 일괄수정값을 밸브제조사값으로 세팅하여 업데이트
            list.get(i).setBeforeValveMnfcturprofsNm(list.get(i).getValveMnfcturprofsNm());
            list.get(i).setValveMnfcturprofsNm(editValveMnfcturprofsNm);
            result += cylinderMDao.savecylinder(list.get(i));
        }

        return (result == list.size()-1) ? 1 : 0;
    }

}

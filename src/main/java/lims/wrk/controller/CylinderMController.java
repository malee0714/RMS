package lims.wrk.controller;


import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lims.wrk.service.CylinderMService;
import lims.wrk.vo.CylinderMVo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/wrk")
public class CylinderMController {

    @Resource(name = "cylinderMServicelmpl")
    private CylinderMService cylinderMService;

    @SetLocale
    @RequestMapping(value = "CylinderM.lims")
    public String cylinderM(HttpServletRequest request, Model model) {
        return "wrk/CylinderM";
    }

    @RequestMapping(value = "getcylinderList.lims")
    public @ResponseBody List<CylinderMVo> getcylinderList(@RequestBody CylinderMVo vo) {
        return cylinderMService.getcylinderList(vo);
    }

    @RequestMapping(value = "savecylinder.lims")
    public @ResponseBody int savecylinder(@RequestBody CylinderMVo vo){
        try {
            return cylinderMService.savecylinder(vo);
        } catch (CustomException e) {
            throw e;
        } catch (Exception e) {
            throw new CustomException(e, "실린더 정보가 저장이 정상적으로 완료되지 않았습니다.");
        }

    }

    @RequestMapping(value = "deletecylinder.lims")
    public @ResponseBody int deletecylinder(@RequestBody CylinderMVo vo){
        try {
            return cylinderMService.deletecylinder(vo);
        } catch (CustomException e) {
            throw e;
        } catch (Exception e) {
            throw new CustomException(e, "실린더 정보가 저장이 정상적으로 완료되지 않았습니다.");
        }

    }

    @RequestMapping(value = "batchUpdValvMaker.lims")
    public @ResponseBody int batchUpdValvMaker(@RequestBody List<CylinderMVo> list) {
        try {
            return cylinderMService.batchUpdValvMaker(list);
        } catch (Exception e) {
            throw new CustomException(e, list, "VAVLE_MAKER 일괄수정이 정상적으로 완료되지 않았습니다.");
        }
    }

}

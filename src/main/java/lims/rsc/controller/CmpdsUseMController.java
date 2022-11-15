package lims.rsc.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.rsc.service.CmpdsUseMService;
import lims.rsc.vo.CmpdsUseMVo;
import lims.sys.vo.UserMVo;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import lombok.extern.slf4j.Slf4j;
import net.sf.json.JSONObject;

@Slf4j
@Controller
@RequestMapping("/rsc")
public class CmpdsUseMController {

    @Resource(name = "cmpdsUseMServiceImpl")
    public CmpdsUseMService cmpdsUseMService;

    @SetLocale()
    @RequestMapping(value = "CmpdsUseM.lims")
    public String CmpdsUseM(HttpServletRequest request, Model model) {
        return "rsc/CmpdsUseM";
    }

    
    @RequestMapping(value = "getCmpdsUseList.lims")
    public @ResponseBody List<CmpdsUseMVo> getCmpdsUseList(@RequestBody CmpdsUseMVo vo) {
        return cmpdsUseMService.getCmpdsUseList(vo);
    }
    
    
    
    @RequestMapping(value = "saveCmpdsUseM.lims")
    public @ResponseBody int saveCmpdsUseM(@RequestBody CmpdsUseMVo list) {
        try {
            return cmpdsUseMService.saveCmpdsUseM(list);
        } catch (Exception e) {
            throw new CustomException(e, list, "저장이 정상적으로 처리되지 않았습니다");
        }
    }

    @RequestMapping(value = "getbrcdData.lims")
    public @ResponseBody List<CmpdsUseMVo> getbrcdData(@RequestBody CmpdsUseMVo vo) {
        return cmpdsUseMService.getbrcdData(vo);
    }
    @RequestMapping(value = "delMhrlsCmpdsM.lims")
    public @ResponseBody int delMhrlsCmpdsM(@RequestBody CmpdsUseMVo vo) {
        try {
        return cmpdsUseMService.delMhrlsCmpdsM(vo);
       } catch (Exception e) {
            throw new CustomException(e, vo, "저장이 정상적으로 처리되지 않았습니다");
        }
    }
    

}

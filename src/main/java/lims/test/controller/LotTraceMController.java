package lims.test.controller;

import lims.test.service.LotTraceMService;
import lims.test.vo.LotTraceMVo;
import lims.util.Locale.SetLocale;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.annotation.Resource;
import java.util.List;

@Controller
@RequestMapping("/test")
public class LotTraceMController {

    @Resource(name = "lotTraceMServiceImpl")
    private LotTraceMService lotTraceMServiceImpl;

    @SetLocale
    @RequestMapping("/LotTraceM.lims")
    public String LotTraceM(Model model) {
        return "test/LotTraceM";
    }

    // 조회
    @RequestMapping(value = "getLotTraceList.lims" )
    public @ResponseBody List<LotTraceMVo> getLotTraceList(@RequestBody LotTraceMVo vo) {
        return lotTraceMServiceImpl.getLotTraceList(vo);
    }

    // 저장
    @RequestMapping(value = "/saveReqTrace.lims")
    public @ResponseBody int saveReqTrace(@RequestBody List<LotTraceMVo> list){
        return lotTraceMServiceImpl.saveReqTrace(list);
    }
    // 저장
    @RequestMapping(value = "/saveTrace.lims")
    public @ResponseBody int saveTrace(@RequestBody List<LotTraceMVo> list){
        return lotTraceMServiceImpl.saveTrace(list);
    }

    //lotTrace 조회
    @RequestMapping("/getTraceDetail.lims")
    public @ResponseBody List<LotTraceMVo> getTraceDetail(@RequestBody LotTraceMVo vo){
        return this.lotTraceMServiceImpl.getTraceDetail(vo);
    }

    // lotTrace 삭제
    @RequestMapping(value = "/delLotTrace.lims")
    public @ResponseBody int delLotTrace(@RequestBody List<LotTraceMVo> list) {
        return lotTraceMServiceImpl.delLotTrace(list);
    }

}

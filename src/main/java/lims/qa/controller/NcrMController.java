package lims.qa.controller;

import lims.com.vo.CmExmntDto;
import lims.qa.service.NcrMService;
import lims.qa.vo.AuditManageDto;
import lims.qa.vo.NcrMVo;
import lims.util.CustomException;
import lims.util.Locale.SetLocale;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping(value="/qa")
public class NcrMController {
    private final NcrMService ncrMServiceImpl;

    @Autowired
    public NcrMController(NcrMService ncrMServiceImpl) {
        this.ncrMServiceImpl = ncrMServiceImpl;
    }

    @SetLocale()
    @RequestMapping(value = "NcrM.lims")
    public String NcrM (Model model, HttpServletRequest request) {
        return "qa/NcrM";
    }

    //조회
    @RequestMapping("/getNcrList.lims")
    public @ResponseBody List<NcrMVo> getNcrList(@RequestBody NcrMVo vo){
        return this.ncrMServiceImpl.getNcrList(vo);
    }

    //저장
    @RequestMapping(value ="/saveNcr")
    public @ResponseBody ResponseEntity<NcrMVo> saveNcr(@RequestBody NcrMVo ncrMVo) {
        ncrMServiceImpl.saveNcr(ncrMVo);
        return ResponseEntity.ok(ncrMVo);
    }

    //삭제
    @RequestMapping(value = "deleteNcr.lims" )
    public @ResponseBody int deleteNcr(@RequestBody NcrMVo ncrMVo) {
        return ncrMServiceImpl.deleteNcr(ncrMVo);
    }


    //시험항목 조회
    @RequestMapping("/getExprGrid.lims")
    public @ResponseBody List<NcrMVo> getExprGrid(@RequestBody NcrMVo vo){
        return this.ncrMServiceImpl.getExprGrid(vo);
    }

    //부적합 시험항목 조회
    @RequestMapping("/ncrExpriemGrid.lims")
    public @ResponseBody List<NcrMVo> ncrExpriemGrid(@RequestBody NcrMVo vo){
        return this.ncrMServiceImpl.ncrExpriemGrid(vo);
    }

    /**
     * 검토 정보 저장.
     * @param cmExmntDto 검토 dto
     */
    @RequestMapping("/ncrSaveExmnt.lims")
    public ResponseEntity<Void> ncrSaveExmnt(@RequestBody CmExmntDto cmExmntDto) {
        try {
            ncrMServiceImpl.saveExmnt(cmExmntDto); // 공통 검토 정보 저장.
            return ResponseEntity.ok().build();
        } catch (CustomException e) {
            throw e;
        }
    }

    @RequestMapping("/approvalRequestNcr.lims")
    public ResponseEntity<NcrMVo> approvalRequestNcr(@RequestBody NcrMVo ncrMVo) {
        try {
            ncrMServiceImpl.approvalRequestNcr(ncrMVo);
            return ResponseEntity.ok(ncrMVo);
        } catch (CustomException e) {
            throw e;
        } catch (Exception e) {
            throw new CustomException(e, ncrMVo, "부적합품관리 저장/수정을 정상적으로 완료하지 못했습니다.");
        }
    }

    @RequestMapping("/revertNcr.lims")
    public ResponseEntity<NcrMVo> revertNcr(@RequestBody NcrMVo ncrMVo) {
        try {
            ncrMServiceImpl.revertNcr(ncrMVo);
            return ResponseEntity.ok(ncrMVo);
        } catch (CustomException e) {
            throw e;
        } catch (Exception e) {
            throw new CustomException(e, ncrMVo, "회수를 정상적으로 완료하지 못했습니다.");
        }
    }
}

package lims.qa.service.Impl;

import lims.com.dao.CmExmntDao;
import lims.com.service.CmExmntTemplate;
import lims.com.service.CmSanctnService;
import lims.com.vo.CmExmntDto;
import lims.qa.dao.D8RerptMDao;
import lims.qa.service.D8ReprtMService;
import lims.qa.vo.D8ReprtMVo;
import lims.util.CommonFunc;
import lims.util.CustomException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class D8ReprtMServiceImpl implements D8ReprtMService {

    private final D8RerptMDao d8ReprtMMDao;
    private final CmSanctnService cmSanctnServiceImpl;
    private final CommonFunc commonFunc;
    private final CmExmntTemplate cmExmntTemplate;


    @Value("${style.table}")
    String tableStyle;

    @Value("${style.th}")
    String thStyle;

    @Value("${style.td}")
    String tdStyle;

    @Autowired
    public D8ReprtMServiceImpl(D8RerptMDao d8ReprtMMDao, CmSanctnService cmSanctnServiceImpl, CmExmntDao cmExmntDao, CommonFunc commonFunc, CmExmntTemplate cmExmntTemplate){
        this.d8ReprtMMDao = d8ReprtMMDao;
        this.cmSanctnServiceImpl = cmSanctnServiceImpl;
        this.commonFunc = commonFunc;
        this.cmExmntTemplate = cmExmntTemplate;
    }

    @Override
    public List<D8ReprtMVo> d8ReprtMList(D8ReprtMVo vo) {
        return d8ReprtMMDao.d8ReprtMList(vo);
    }

    @Override
    public HashMap<String, Object> insD8ReprtInfo(D8ReprtMVo vo) {
        try{
            HashMap<String,Object> resultMap = new HashMap<>();
            if(vo.isNew()){
                this.d8ReprtMMDao.insD8ReprtInfo(vo);
            }else{
                this.d8ReprtMMDao.updD8ReprtInfo(vo);
            }

            this.setD8ReprtMCn(vo);

            this.saveSanctn(vo);

            return resultMap ;
        }catch(Exception e){
            throw new CustomException(e, vo, "고객 불만 저장중 에러가 발생하였습니다.");
        }
    }

    public void setD8ReprtMCn(D8ReprtMVo vo){
        vo.setSj("8D보고서("+ vo.getCstmrDscnttNo() + ")");
        vo.setCn(this.getD8ReprtMFormHtml(vo));
    }

    public String getD8ReprtMFormHtml(D8ReprtMVo vo){

        StringBuffer sb = new StringBuffer();
        sb.append("<h2>8D 보고서</h2> ");
        sb.append("        <table "+ tableStyle +"> ");
        sb.append("            <colgroup> ");
        sb.append("                <col style=width:10%/> ");
        sb.append("                <col style=width:15%/> ");
        sb.append("                <col style=width:10%/> ");
        sb.append("                <col style=width:15%/> ");
        sb.append("                <col style=width:10%/> ");
        sb.append("                <col style=width:15%/> ");
        sb.append("                <col style=width:10%/> ");
        sb.append("                <col style=width:15%/> ");
        sb.append("            </colgroup> ");
        sb.append("            <tr> ");
        sb.append("                <th "+ thStyle +">고객불만번호</th>  ");
        sb.append("                <td "+ tdStyle +"> "+ vo.getCstmrDscnttNo() +" </td> ");
        sb.append("                <th "+ thStyle +">고객사</th>  ");
        sb.append("                <td "+ tdStyle +">"+ vo.getEntrpsNm() +"</td> ");
        sb.append("                <th "+ thStyle +">고객불만 제목</th> ");
        sb.append("                <td "+ tdStyle +" colspan=\"3\">"+ vo.getCstmrDscnttSj()+"</td> ");
        sb.append("            </tr> ");
        sb.append("            <tr> ");
        sb.append("                <th "+ thStyle +">제품</th> ");
        sb.append("                <td "+ tdStyle +">"+ vo.getMtrilNm()+"</td> ");
        sb.append("                <th "+ thStyle +">Lot No.</th> ");
        sb.append("                <td "+ tdStyle +">"+ vo.getLotNo()+"</td> ");
        sb.append("                <th "+ thStyle +"></th> ");
        sb.append("                <td "+ tdStyle +"></td> ");
        sb.append("                <th "+ thStyle +"></th> ");
        sb.append("                <td "+ tdStyle +"></td> ");
        sb.append("            </tr> ");
        sb.append("            <tr> ");
        sb.append("                <th "+ thStyle +">작성 부서</th> ");
        sb.append("                <td "+ tdStyle +">"+ vo.getWritngDeptCodeNm()+"</td> ");
        sb.append("                <th "+ thStyle +">작성자</th> ");
        sb.append("                <td "+ tdStyle +">"+ vo.getWrterIdNm()+"</td> ");
        sb.append("                <th "+ thStyle +">작성 일자</th> ");
        sb.append("                <td "+ tdStyle +">"+ vo.getWritngDte()+"</td> ");
        sb.append("                <th "+ thStyle +"></th> ");
        sb.append("                <td "+ tdStyle +"></td> ");
        sb.append("            </tr> ");
        sb.append("            <tr> ");
        sb.append("                <th "+ thStyle +">원인 분석</th> ");
        sb.append("                <td "+ tdStyle +" colspan=\"7\">" + vo.getCauseAnalsCn() + "</td> ");
        sb.append("            </tr> ");
        sb.append("            <tr> ");
        sb.append("                <th "+ thStyle +">시정 조치</th> ");
        sb.append("                <td "+ tdStyle +" colspan=\"7\">" + vo.getCorecManagtCn() + "</td> ");
        sb.append("            </tr> ");
        sb.append("            <tr> ");
        sb.append("                <th "+ thStyle +">효과성 파악</th> ");
        sb.append("                <td "+ tdStyle +" colspan=\"7\">" + vo.getEffectfmnmUndstnCn() + "</td> ");
        sb.append("            </tr> ");
        sb.append("            <tr> ");
        sb.append("                <th "+ thStyle +">재발 방지 대책</th> ");
        sb.append("                <td "+ tdStyle +" colspan=\"7\">" + vo.getRecrPrvnCntrplnCn() + "</td> ");
        sb.append("            </tr> ");
        sb.append("            <tr> ");
        sb.append("                <th "+ thStyle +">시정조치 완료</th> ");
        sb.append("                <td "+ tdStyle +" colspan=\"7\">" + vo.getCorecManagtComptCn() + "</td> ");
        sb.append("            </tr> ");
        sb.append("        </table>");
        System.out.println(">>> : " + sb.toString());
        return sb.toString();
    }

    @Override
    public void saveExmnt(CmExmntDto cmExmntDto) {
        cmExmntTemplate.saveExmnt(cmExmntDto, this.d8ReprtMMDao::updateExmntSeqno);
    }

    @Override
    public void revertD8Reprt(D8ReprtMVo d8ReprtMVo) {
        this.cmSanctnServiceImpl.revert(d8ReprtMVo);
    }

    private void saveSanctn(D8ReprtMVo vo) {
        this.cmSanctnServiceImpl.saveSanctn(vo); // 공통 결재정보 저장 및 결재자 목록 저장
        this.d8ReprtMMDao.updateD8ReprtSanctn(vo); // CM_AUDIT 테이블에 결재 Seqno update
    }
}

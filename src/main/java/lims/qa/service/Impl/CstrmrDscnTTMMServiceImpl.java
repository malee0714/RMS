package lims.qa.service.Impl;

import lims.com.dao.CmExmntDao;
import lims.com.service.CmExmntTemplate;
import lims.com.service.CmSanctnService;
import lims.com.vo.CmExmntDto;
import lims.qa.dao.CstrmrDscnTTMMDao;
import lims.qa.service.CstrmrDscnTTMMService;
import lims.qa.vo.CstrmrDscnTtmmVo;
import lims.qa.vo.D8ReprtMVo;
import lims.util.CommonFunc;
import lims.util.CustomException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;

@Service
public class CstrmrDscnTTMMServiceImpl implements CstrmrDscnTTMMService {

    private final CstrmrDscnTTMMDao cstrmrDscnTTMMDao;
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
    public CstrmrDscnTTMMServiceImpl(CstrmrDscnTTMMDao cstrmrDscnTTMMDao, CmSanctnService cmSanctnServiceImpl, CmExmntDao cmExmntDao, CommonFunc commonFunc, CmExmntTemplate cmExmntTemplate){
        this.cstrmrDscnTTMMDao = cstrmrDscnTTMMDao;
        this.cmSanctnServiceImpl = cmSanctnServiceImpl;
        this.commonFunc = commonFunc;
        this.cmExmntTemplate = cmExmntTemplate;
    }

    @Override
    public List<CstrmrDscnTtmmVo> CstrmrDscnTTMList(CstrmrDscnTtmmVo vo) {
        return cstrmrDscnTTMMDao.CstrmrDscnTTMList(vo);
    }

    @Override
    public HashMap<String, Object> insCstrmrInfo(CstrmrDscnTtmmVo vo) {
        try{
            HashMap<String,Object> resultMap = new HashMap<>();
            if(vo.isNew()){
                this.cstrmrDscnTTMMDao.insCstrmrInfo(vo);
            }else{
                this.cstrmrDscnTTMMDao.updCstrmrInfo(vo);
            }

            if(vo.isExitsAddUserList()){
                List<CstrmrDscnTtmmVo> addUserList = vo.getAddUserList();

                addUserList.forEach(user -> {

                    user.setCstmrDscnttSeqno(vo.getCstmrDscnttSeqno());
                    this.cstrmrDscnTTMMDao.insCstrmrUserInfo(user);
                });
            }

            this.setCstrmrCn(vo);

            this.saveSanctn(vo);

            return resultMap ;
        }catch(Exception e){
            throw new CustomException(e, vo, "고객 불만 저장중 에러가 발생하였습니다.");
        }
    }

    public void setCstrmrCn(CstrmrDscnTtmmVo vo){
        vo.setSj("불만관리("+ vo.getCstmrDscnttNo() + ")");
        vo.setCn(this.getCstrmrFormHtml(vo));
    }

    @Override
    public List<CstrmrDscnTtmmVo> getCstmrUserList(CstrmrDscnTtmmVo vo) {
        return this.cstrmrDscnTTMMDao.getCstmrUserList(vo);
    }

    public String getCstrmrFormHtml(CstrmrDscnTtmmVo vo){
        String tableStyle = " style=border:1px solid rgb(149 149 149); margin-top:15px; width: 100%;";
        String thStyle = " style=background:#dcdcdc; border:1px solid rgb(149 149 149); color:#444; font-size:12px; font-weight: bold; min-width: 100px;";
        String tdStyle = " style=padding:1px; font-size: 13px; font-weight: bold; height: 26px; text-align: center; border: 0.3px solid rgb(149 149 149);";

        StringBuffer sb = new StringBuffer();
        sb.append("<h2>고객 불만 정보</h2> ");
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
        sb.append("                <th "+ thStyle +">발생 일자</th> ");
        sb.append("                <td "+ tdStyle +">"+ vo.getOccrrncDte()+"</td> ");
        sb.append("                <th "+ thStyle +">발생 수량</th> ");
        sb.append("                <td "+ tdStyle +">"+ vo.getOccrrncQtt()+"</td> ");
        sb.append("            </tr> ");
        sb.append("            <tr> ");
        sb.append("                <th  "+ thStyle +">8D보고서 유무</th> ");
        sb.append("                <td  "+ tdStyle +">"+ vo.getReprtAt()+"</td> ");
        sb.append("                <th  "+ thStyle +">요청 일자</th> ");
        sb.append("                <td  "+ tdStyle +">"+ vo.getRequstDte()+"</td> ");
        sb.append("                <th  "+ thStyle +">담당 부서</th> ");
        sb.append("                <td  "+ tdStyle +">"+ vo.getChrgDeptCodeNm()+"</td> ");
        sb.append("                <th  "+ thStyle +">담당자</th> ");
        sb.append("                <td  "+ tdStyle +">"+ vo.getChargerIdNm()+"</td> ");
        sb.append("            </tr> ");
        sb.append("            <tr> ");
        sb.append("                <th  "+ thStyle +">중요도</th> ");
        sb.append("                <td  "+ tdStyle +">"+ vo.getCstmrDscnttIpcrCodeNm()+"</td> ");
        sb.append("                <th  "+ thStyle +">OCAP상태</th> ");
        sb.append("                <td  "+ tdStyle +">"+ vo.getOcapSttusCodeNm()+"</td> ");
        sb.append("                <th  "+ thStyle +">M51E</th> ");
        sb.append("                <td  "+ tdStyle +">"+ vo.getM5e1CodeNm()+"</td> ");
        sb.append("                <th  "+ thStyle +">피해규모</th> ");
        sb.append("                <td  "+ tdStyle +">"+ vo.getDmgeScaleCn()+"</td> ");
        sb.append("            </tr> ");
        sb.append("            <tr> ");
        sb.append("                <th  "+ thStyle +">완료일자</th> ");
        sb.append("                <td  "+ tdStyle +">" + vo.getComptDte() + "</td> ");
        sb.append("                <th  "+ thStyle +"></th> ");
        sb.append("                <td  "+ tdStyle +"></td> ");
        sb.append("                <th  "+ thStyle +"></th> ");
        sb.append("                <td  "+ tdStyle +"></td> ");
        sb.append("                <th  "+ thStyle +"></th> ");
        sb.append("                <td  "+ tdStyle +"></td> ");
        sb.append("            </tr> ");
        sb.append("            <tr> ");
        sb.append("                <th "+ thStyle +">원인분석</th> ");
        sb.append("                <td "+ tdStyle +" colspan=\"3\">" + vo.getCauseAnalsCn() + "</td> ");
        sb.append("                <th "+ thStyle +">개선대책</th> ");
        sb.append("                <td "+ tdStyle +" colspan=\"3\">" + vo.getImprvmCntrplnCn() + "</td> ");
        sb.append("            </tr> ");
        sb.append("            <tr> ");
        sb.append("                <th "+ thStyle +">불만내용</th> ");
        sb.append("                <td "+ tdStyle +" colspan=\"7\">" + vo.getDscnttCn() + "</td> ");
        sb.append("            </tr> ");
        sb.append("        </table>");
        return sb.toString();
    }

    @Override
    public void saveExmnt(CmExmntDto cmExmntDto) {
        cmExmntTemplate.saveExmnt(cmExmntDto, this.cstrmrDscnTTMMDao::updateExmntSeqno);
    }

    @Override
    public void revertCstrmrDscntt(CstrmrDscnTtmmVo vo) {
        this.cmSanctnServiceImpl.revert(vo);
    }

    @Override
    public void removeCstmrUser(CstrmrDscnTtmmVo vo) {
        List<CstrmrDscnTtmmVo> removeUserList = vo.getRemoveUserList();
        removeUserList.forEach(user -> {
            user.setCstmrDscnttSeqno(vo.getCstmrDscnttSeqno());
            this.cstrmrDscnTTMMDao.updCstrmrUserInfo(user);
        });
    }

    private void saveSanctn(CstrmrDscnTtmmVo vo) {
        this.cmSanctnServiceImpl.saveSanctn(vo); // 공통 결재정보 저장 및 결재자 목록 저장
        this.cstrmrDscnTTMMDao.updateCstrmrSanctn(vo); // CM_AUDIT 테이블에 결재 Seqno update
    }
}

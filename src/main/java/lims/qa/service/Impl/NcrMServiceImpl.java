package lims.qa.service.Impl;

import lims.com.dao.CmExmntDao;
import lims.com.service.CmExmntTemplate;
import lims.com.service.CmSanctnService;
import lims.com.vo.CmExmntDto;
import lims.qa.dao.NcrMDao;
import lims.qa.service.NcrMService;
import lims.qa.vo.AuditManageDto;
import lims.qa.vo.EdcManageDto;
import lims.qa.vo.NcrMVo;
import lims.wrk.vo.ExpriemMVo;
import lims.wrk.vo.PrductMVo;
import lombok.var;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class NcrMServiceImpl implements NcrMService {
    private final CmSanctnService cmSanctnServiceImpl;
    private final CmExmntTemplate cmExmntTemplate;
    private final NcrMDao ncrMDao;

    @Value("${style.table}")
    String tableStyle;

    @Value("${style.th}")
    String thStyle;

    @Value("${style.td}")
    String tdStyle;

    @Autowired
    public NcrMServiceImpl(NcrMDao ncrMDao, CmSanctnService cmSanctnServiceImpl, CmExmntDao cmExmntDao, CmExmntTemplate cmExmntTemplate) {
        this.cmSanctnServiceImpl = cmSanctnServiceImpl;
        this.ncrMDao = ncrMDao;
        this.cmExmntTemplate = cmExmntTemplate;
    }

    @Override
    public void saveNcr(NcrMVo ncrMVo) {
        List<NcrMVo> gridData = ncrMVo.getGridData();
        List<NcrMVo> addedRow = ncrMVo.getAddedRow();
        List<NcrMVo> editedRow = ncrMVo.getEditedRow();
        List<NcrMVo> removedRow = ncrMVo.getRemovedRow();

        // 1. 부적합 저장
        if(ncrMVo.isNew()) {
            ncrMDao.insertNcr(ncrMVo);
        }else{
            ncrMDao.updateNcr(ncrMVo);
        }

        // 신규등록
        if (ncrMVo.isNew()) {

            if(ncrMVo.isAdded()) {
                for(int i=0; i<addedRow.size(); i++){
                    addedRow.get(i).setNcrSeqno(ncrMVo.getNcrSeqno());
                    addedRow.get(i).setReqestExpriemSeqno(ncrMVo.getAddedRow().get(i).getReqestExpriemSeqno());
                    addedRow.get(i).setExprOdr(ncrMVo.getExprOdr());
                    ncrMDao.insNcrExpriem(addedRow.get(i));
                }
            }
            // 수정
        } else {

            // 추가된 row insert
            if(ncrMVo.isAdded()) {
                for(int i=0; i<addedRow.size(); i++){
                    addedRow.get(i).setNcrSeqno(ncrMVo.getNcrSeqno());
                    addedRow.get(i).setReqestExpriemSeqno(ncrMVo.getAddedRow().get(i).getReqestExpriemSeqno());
                    ncrMDao.insNcrExpriem(addedRow.get(i));
                }
            }

            // 수정된 row update
            if(ncrMVo.isEdited()) {
                for(int i=0; i<editedRow.size(); i++){
                    editedRow.get(i).setNcrSeqno(ncrMVo.getNcrSeqno());
                    editedRow.get(i).setReqestExpriemSeqno(ncrMVo.getEditedRow().get(i).getReqestExpriemSeqno());
                    ncrMDao.insNcrExpriem(editedRow.get(i));
                }
            }

            // 삭제된 row delete
            if(ncrMVo.isRemoved()) {
                for(int i=0; i<removedRow.size(); i++){
                    removedRow.get(i).setNcrSeqno(ncrMVo.getNcrSeqno());
                    removedRow.get(i).setReqestExpriemSeqno(ncrMVo.getRemovedRow().get(i).getReqestExpriemSeqno());
                    ncrMDao.delNcrExpriem(removedRow.get(i));
                }
            }

        }

        // 2. email, 결재 메뉴에서의 상세페이지 동적 rendering을 위한 sj, cn data 생성
        this.setNcrCn(ncrMVo);

        // 3. 결재 정보 저장.
        this.saveSanctn(ncrMVo);
    }


    @Override
    public int deleteNcr(NcrMVo NcrMVo) {
        return ncrMDao.deleteNcr(NcrMVo);
    }

    private void saveSanctn(NcrMVo ncrMVo) {
        this.cmSanctnServiceImpl.saveSanctn(ncrMVo);
        this.ncrMDao.updateNcrSanctn(ncrMVo);
    }


    private void setNcrCn(NcrMVo ncrMVo) {
        ncrMVo.setSj("부적합품관리("+ ncrMVo.getMtrilNm() + ")");
        ncrMVo.setCn(this.getNcrFormHtml(ncrMVo));
    }

    @Override
    public void approvalRequestNcr(NcrMVo ncrMVo) {
        this.saveNcr(ncrMVo);
        this.cmSanctnServiceImpl.approvalRequest(ncrMVo);
    }

    //조회
    @Override
    public List<NcrMVo> getNcrList(NcrMVo vo) {
        return this.ncrMDao.getNcrList(vo);
    }


    private String getNcrFormHtml(NcrMVo ncrMVo) {
        String form =
                "<h2>부적합품정보<h2>" +
                        "<table "+ tableStyle +">" +
                        "    <colgroup>" +
                        "        <col style=\"width:10%\"/>" +
                        "        <col style=\"width:15%\"/>" +
                        "        <col style=\"width:10%\"/>" +
                        "        <col style=\"width:15%\"/>" +
                        "        <col style=\"width:10%\"/>" +
                        "        <col style=\"width:15%\"/>" +
                        "        <col style=\"width:10%\"/>" +
                        "        <col style=\"width:15%\"/>" +
                        "    </colgroup>" +
                        "    <tr>" +
                        "        <th "+ thStyle +">부적합 제품</th> " +
                        "        <td "+ tdStyle +" colspan=\"3\">"+ ncrMVo.getMtrilNm ()+" </td>" +
                        "        <th "+ thStyle +">부적합 제품</th> " +
                        "        <td "+ tdStyle +">"+ ncrMVo.getPrductTyNm()+" </td>" +
                        "        <th "+ thStyle +">발생일자</th>" +
                        "        <td "+ tdStyle +">"+ ncrMVo.getOccrrncDte()+"</td>" +
                        "    </tr>" +
                        "    <tr>" +
                        "        <th "+ thStyle +">담당부서</th> " +
                        "        <td "+ tdStyle +"> "+ ncrMVo.getChrgDeptCodeNm() +" </td>" +
                        "        <th "+ thStyle +">담당자</th> " +
                        "        <td "+ tdStyle +">"+ ncrMVo.getChargerIdNm() +"</td>" +
                        "        <th "+ thStyle +">검토부서</th>" +
                        "        <td "+ tdStyle +">"+ ncrMVo.getExmntDeptCodeNm()+"</td>" +
                        "        <th "+ thStyle +">OCAP상태</th>" +
                        "        <td "+ tdStyle +">"+ ncrMVo.getOcapSttusCodeNm()+"</td>" +
                        "    </tr>" +
                        "    <tr>" +
                        "        <th "+ thStyle +">부적합내용</th>" +
                        "        <td "+ tdStyle +" colspan=\"7\">" + ncrMVo.getImproptCn() + "</td>" +
                        "    </tr>" +
                        "    <tr>" +
                        "        <th "+ thStyle +">원인분석</th>" +
                        "        <td "+ tdStyle +" colspan=\"3\">" + ncrMVo.getCauseAnalsCn() + "</td>" +
                        "        <th "+ thStyle +">개선대책</th>" +
                        "        <td "+ tdStyle +" colspan=\"3\">" + ncrMVo.getImprvmCntrplnCn() + "</td>" +
                        "    </tr>" +
                        "    <tr>" +
                        "        <th "+ thStyle +">부적합정도</th>" +
                        "        <td "+ tdStyle +">"+ ncrMVo.getImproptDgreeCodeNm()+"</td>" +
                        "        <th "+ thStyle +">처리형태</th>" +
                        "        <td "+ tdStyle +">"+ ncrMVo.getImproptProcessStleCodeNm()+"</td>" +
                        "        <th "+ thStyle +">완료일자</th>" +
                        "        <td "+ tdStyle +">"+ ncrMVo.getComptDte()+"</td>" +
                        "        <th "+ thStyle +">유효성평가</th>" +
                        "        <td "+ tdStyle +">"+ ncrMVo.getImproptValidfmnmEvlCodeNm()+"</td>" +
                        "    </tr>" +
                        "    <tr>" +
                        "        <th "+ thStyle +">유효성평가일자</th>" +
                        "        <td "+ tdStyle +">"+ ncrMVo.getValidfmnmEvlDte()+"</td>" +
                        "        <th "+ thStyle +">처리결과</th>" +
                        "        <td "+ tdStyle +">" + ncrMVo.getImproptProcessResultCodeNm() + "</td>" +
                        "        <td></td>" +
                        "        <td></td>" +
                        "    </tr>" +
                        "    <tr>" +
                        "        <th "+ thStyle +">재발방지대책</th>" +
                        "        <td "+ tdStyle +" colspan=\"7\">" + ncrMVo.getRecrPrvnCntrplnCn() + "</td>" +
                        "    </tr>" +
                        "    <tr>" +
                        "        <th "+ thStyle +">첨부파일</th>" +
                        "        <td "+ tdStyle +" colspan=\"7\">" +
                        "            <div id=\"auditDropZoneArea\" class='dropzoneSelector'></div>" +
                        "            <input type=\"text\" name=\"atchmnflSeqno\" style=\"display: none;\" value=\""+ncrMVo.getAtchmnflSeqno()+"\">" +
                        "        </td>" +
                        "    </tr>" +
                        "</table>";
        return form;
    }
    //시험항목 조회
    @Override
    public List<NcrMVo> getExprGrid(NcrMVo vo) {
        return this.ncrMDao.getExprGrid(vo);
    }
    //부적합 시험항목 조회
    @Override
    public List<NcrMVo> ncrExpriemGrid(NcrMVo vo) {
        return this.ncrMDao.ncrExpriemGrid(vo);
    }

    @Override
    public void saveExmnt(CmExmntDto cmExmntDto) {
        cmExmntTemplate.saveExmnt(cmExmntDto, this.ncrMDao::updateExmntSeqno);
    }

    @Override
    public void revertNcr(NcrMVo ncrMVo) {
        this.cmSanctnServiceImpl.revert(ncrMVo);
    }
}

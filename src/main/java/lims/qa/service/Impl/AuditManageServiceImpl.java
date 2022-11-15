package lims.qa.service.Impl;

import lims.com.dao.CmExmntDao;
import lims.com.service.CmExmntTemplate;
import lims.com.service.CmSanctnService;
import lims.com.vo.CmExmntDto;
import lims.qa.dao.AuditManageDao;
import lims.qa.service.AuditManageService;
import lims.qa.vo.AuditManageDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AuditManageServiceImpl implements AuditManageService {

	private final AuditManageDao auditManageDao;
	private final CmSanctnService cmSanctnServiceImpl;
	private final CmExmntTemplate cmExmntTemplate;
	
	@Value("${style.table}")
	String tableStyle;

	@Value("${style.th}")
	String thStyle;
	
	@Value("${style.td}")
	String tdStyle;

	@Autowired
	public AuditManageServiceImpl(AuditManageDao auditManageDao, CmSanctnService cmSanctnServiceImpl, CmExmntTemplate cmExmntTemplate) {
		this.auditManageDao = auditManageDao;
		this.cmSanctnServiceImpl = cmSanctnServiceImpl;
		this.cmExmntTemplate = cmExmntTemplate;
	}

	@Override
	public List<AuditManageDto> getAudit(AuditManageDto auditManageDto) {
		return this.auditManageDao.getAudit(auditManageDto);
	}
	
	@Override
	public void saveAuditManage(AuditManageDto auditManageDto) {

		if (auditManageDto.isNew()) {
			auditManageDao.insertAuditManage(auditManageDto);
		} else {
			auditManageDao.updateAuditManage(auditManageDto);
		}
		
		this.setAuditCn(auditManageDto);

		// 결재 정보 저장.
		this.saveSanctn(auditManageDto);
	}
	
	@Override
	public void approvalRequestAuditManage(AuditManageDto auditManageDto) {
		this.saveAuditManage(auditManageDto);
		this.cmSanctnServiceImpl.approvalRequest(auditManageDto);
	}

	@Override
	public void deleteAuditManage(AuditManageDto auditManageDto) {
		this.auditManageDao.deleteAuditManage(auditManageDto);
	}

	@Override
	public void saveExmnt(CmExmntDto cmExmntDto) {
		cmExmntTemplate.saveExmnt(cmExmntDto, this.auditManageDao::updateExmntSeqno);
	}

	@Override
	public void revertAuditManage(AuditManageDto auditManageDto) {
		this.cmSanctnServiceImpl.revert(auditManageDto);
	}

	private void saveSanctn(AuditManageDto auditManageDto) {
		this.cmSanctnServiceImpl.saveSanctn(auditManageDto);
		this.auditManageDao.updateAuditManageSanctn(auditManageDto);
	}
	
	private void setAuditCn(AuditManageDto auditManageDto) {
		auditManageDto.setSj("감사("+ auditManageDto.getAuditNo() + ")");
		auditManageDto.setCn(this.getAuditFormHtml(auditManageDto));
	}
	
	private String getAuditFormHtml(AuditManageDto auditManageDto) {
		String form = 
				"<h2>감사정보<h2>" +
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
				"        <th "+ thStyle +">감사구분</th> " +
				"        <td "+ tdStyle +"> "+ auditManageDto.getAuditSeCodeNm() +" </td>" +
				"        <th "+ thStyle +">감사구분상세</th> " +
				"        <td "+ tdStyle +">"+ auditManageDto.getAuditDetailSeCodeNm() +"</td>" +
				"        <th "+ thStyle +">감사일자</th>" +
				"        <td "+ tdStyle +">"+ auditManageDto.getAuditDte()+"</td>" +
				"        <th "+ thStyle +">감사번호</th>" +
				"        <td "+ tdStyle +">"+ auditManageDto.getAuditNo()+"</td>" +
				"    </tr>" +
				"    <tr>" +
				"        <th "+ thStyle +">감사제목</th>" +
				"        <td "+ tdStyle +" colspan=\"7\">"+ auditManageDto.getAuditSj()+"</td>" +
				"    </tr>" +
				"    <tr>" +
				"        <th "+ thStyle +">감사대상부서</th>" +
				"        <td "+ tdStyle +">"+ auditManageDto.getAuditTrgetDeptNm()+"</td>" +
				"        <th "+ thStyle +">감사대상자</th>" +
				"        <td "+ tdStyle +">"+ auditManageDto.getAuditTrgterNm()+"</td>" +
				"        <th "+ thStyle +">업체명</th>" +
				"        <td "+ tdStyle +">"+ auditManageDto.getEntrpsNm()+"</td>" +
				"        <th "+ thStyle +">감사자</th>" +
				"        <td "+ tdStyle +">"+ auditManageDto.getAuditmanNm()+"</td>" +
				"    </tr>" +
				"    <tr>" +
				"        <th "+ thStyle +">감사시작일자</th>" +
				"        <td "+ tdStyle +">"+ auditManageDto.getAuditBeginDte()+"</td>" +
				"        <th "+ thStyle +">감사종료일자</th>" +
				"        <td "+ tdStyle +">"+ auditManageDto.getAuditEndDte()+"</td>" +
				"        <td></td>" +
				"        <td></td>" +
				"        <td></td>" +
				"        <td></td>" +
				"    </tr>" +
				"    <tr>" +
				"        <th "+ thStyle +">비고</th>" +
				"        <td "+ tdStyle +" colspan=\"7\">" + auditManageDto.getRm() + "</td>" +
				"    </tr>" +
				"    <tr>" +
				"        <th "+ thStyle +">첨부파일</th>" +
				"        <td "+ tdStyle +" colspan=\"7\">" +
				"            <div id=\"auditDropZoneArea\" class='dropzoneSelector'></div>" +
				"            <input type=\"text\" name=\"atchmnflSeqno\" style=\"display: none;\" value=\""+auditManageDto.getAtchmnflSeqno()+"\">" +
				"        </td>" +
				"    </tr>" +
				"</table>";
		return form;
	}
}

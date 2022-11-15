package lims.qa.service.Impl;

import lims.com.dao.CmExmntDao;
import lims.com.service.CmExmntTemplate;
import lims.com.service.CmSanctnService;
import lims.com.vo.CmExmntDto;
import lims.qa.dao.AuditCarManageDao;
import lims.qa.service.AuditCarManageService;
import lims.qa.vo.AuditCarManageDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AuditCarManageServiceImpl implements AuditCarManageService {

	private final AuditCarManageDao auditCarManageDao;
	private final CmSanctnService cmSanctnServiceImpl;
	private final CmExmntTemplate cmExmntTemplate;

	@Value("${style.table}")
	String tableStyle;

	@Value("${style.th}")
	String thStyle;
	
	@Value("${style.td}")
	String tdStyle;
	
	@Autowired
	public AuditCarManageServiceImpl(AuditCarManageDao auditCarManageDao, CmExmntDao cmExmntDao, CmSanctnService cmSanctnServiceImpl, CmExmntTemplate cmExmntTemplate) {
		this.auditCarManageDao = auditCarManageDao;
		this.cmSanctnServiceImpl = cmSanctnServiceImpl;
		this.cmExmntTemplate = cmExmntTemplate;
	}

	@Override
	public List<AuditCarManageDto> getAuditCar(AuditCarManageDto auditCarManageDto) {
		return auditCarManageDao.getAuditCar(auditCarManageDto);
	}

	@Override
	public void saveAuditCar(AuditCarManageDto auditCarManageDto) {

		if (auditCarManageDto.isNew()) {
			auditCarManageDao.insertAuditCar(auditCarManageDto);
		} else {
			auditCarManageDao.updateAuditCar(auditCarManageDto);
		}
		
		// cm cn data 생성 및 set
		this.setCn(auditCarManageDto);

		// 결재 정보 저장.
		this.saveSanctn(auditCarManageDto);
	}

	@Override
	public void auditCarApprovalRequest(AuditCarManageDto auditCarManageDto) {
		this.saveAuditCar(auditCarManageDto);
		this.cmSanctnServiceImpl.approvalRequest(auditCarManageDto);
	}

	@Override
	public void deleteAuditCar(AuditCarManageDto auditCarManageDto) {
		this.auditCarManageDao.deleteAuditCar(auditCarManageDto);
	}

	@Override
	public void saveExmnt(CmExmntDto cmExmntDto) {
		cmExmntTemplate.saveExmnt(cmExmntDto, this.auditCarManageDao::updateExmntSeqno);
	}

	@Override
	public void revertAuditCarManage(AuditCarManageDto auditCarManageDto) {
		this.cmSanctnServiceImpl.revert(auditCarManageDto);
	}

	private void saveSanctn(AuditCarManageDto auditCarManageDto) {
		this.cmSanctnServiceImpl.saveSanctn(auditCarManageDto);
		this.auditCarManageDao.updateAuditCarSanctn(auditCarManageDto);
	}
	
	private void setCn(AuditCarManageDto auditCarManageDto) {
		auditCarManageDto.setSj("감사 CAR ("+ auditCarManageDto.getCarNo() + ")");
		auditCarManageDto.setCn(this.getAuditFormHtml(auditCarManageDto));
	}
	
	private String getAuditFormHtml(AuditCarManageDto dto) {

		String form = 
				"<h2>CAR 정보<h2>" +
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
				"        <th "+ thStyle +">CAR NO.</th> " +
				"        <td "+ tdStyle +"> "+ dto.getCarNo() +" </td>" +
				"        <th "+ thStyle +">CAR 제목</th> " +
				"        <td "+ tdStyle +">"+ dto.getCarSj() +"</td>" +
				"        <th "+ thStyle +">CAR 부서</th>" +
				"        <td "+ tdStyle +">"+ dto.getChrgDeptNm()+"</td>" +
				"        <th "+ thStyle +">CAR 현황</th>" +
				"        <td "+ tdStyle +">"+ dto.getCarSttuCodeNm() +"</td>" +
				"    </tr>" +
				"    <tr>" +
				"        <th "+ thStyle +">중요도</th> " +
				"        <td "+ tdStyle +"> "+ dto.getCarIpcrCodeNm() +" </td>" +
				"        <th "+ thStyle +">5M1E</th> " +
				"        <td "+ tdStyle +">"+ dto.getM5e1CodeNm() +"</td>" +
				"        <th "+ thStyle +">담당자</th>" +
				"        <td "+ tdStyle +">"+ dto.getChargerNm()+"</td>" +
				"        <th "+ thStyle +">완료일자</th>" +
				"        <td "+ tdStyle +">"+ dto.getComptDte() +"</td>" +
				"    </tr>" +
				"    <tr>" +
				"        <th "+ thStyle +">효과검토일자</th> " +
				"        <td "+ tdStyle +"> "+ dto.getEffectExmntDte() +" </td>" +
				"        <td></td>" +
				"        <td></td>" +
				"        <td></td>" +
				"        <td></td>" +
				"        <td></td>" +
				"        <td></td>" +
				"    </tr>" +
				"    <tr>" +
				"        <th "+ thStyle +">효과검토내용</th>" +
				"        <td "+ tdStyle +" colspan=\"7\">"+ dto.getEffectExmntCn()+"</td>" +
				"    </tr>" +
				"    <tr>" +
				"        <th "+ thStyle +">첨부파일</th>" +
				"        <td "+ tdStyle +" colspan=\"7\">" +
				"            <div id=\"dropZoneArea\" class='dropzoneSelector'></div>" +
				"            <input type=\"text\" name=\"atchmnflSeqno\" style=\"display: none;\" value=\""+dto.getAtchmnflSeqno()+"\">" +
				"        </td>" +
				"    </tr>" +
				"</table>";
		return form;
	}
}

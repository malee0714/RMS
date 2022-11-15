package lims.com.service;

import lims.com.dao.CmExmntDao;
import lims.com.vo.CmExmntDto;
import lims.util.CustomException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 검토 공통 Template method를 제공하는 Class입니다.
 * 
 * @author shs
 */
@Service
public class CmExmntTemplate {

	private final CmExmntDao cmExmntDao;

	@Autowired
	public CmExmntTemplate(CmExmntDao cmExmntDao) {
 		this.cmExmntDao = cmExmntDao;
	}

	/**
	 * 검토 정보, 검토 이력 정보를 저장.
	 */
	public void saveExmnt(CmExmntDto cmExmntDto, CmExmntOperator callback) {
		try {
			if (cmExmntDto.isNew()) {
				cmExmntDao.insertExmnt(cmExmntDto);
				cmExmntDao.insertExmntHistory(cmExmntDto);
				callback.updateExmntSeqno(cmExmntDto);
			} else {
				cmExmntDao.updateExmnt(cmExmntDto);
				cmExmntDao.insertExmntHistory(cmExmntDto);
			}
			
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, cmExmntDto, "검토, 검토이력 저장이 정상적으로 완료되지 않았습니다.");
		}
	}
}

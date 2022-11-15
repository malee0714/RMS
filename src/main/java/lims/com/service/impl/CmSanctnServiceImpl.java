package lims.com.service.impl;

import lims.com.dao.CmSanctnDao;
import lims.com.vo.CmCn;
import lims.com.vo.CmSanctn;
import lims.com.service.CmSanctnService;
import lims.com.vo.CmSanctnInfo;
import lims.util.CustomException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Optional;

/**
 * CM 결재에 대한 기능을 구현한다.
 * 
 * @author shs
 */
@Service
public class CmSanctnServiceImpl implements CmSanctnService {

	private final CmSanctnDao cmSanctnDao;

	@Autowired
	public CmSanctnServiceImpl(CmSanctnDao cmSanctnDao) {
		this.cmSanctnDao = cmSanctnDao;
	}

	/**
	 * 결재 상신처리
	 * @param cmSanctn 결재 dto
	 */
	@Override
	public <T extends CmSanctn> void approvalRequest(T cmSanctn) {
		try {
			
			CmSanctn presentSanctn = Optional.ofNullable(cmSanctnDao.getSanctn(cmSanctn))
					.orElseThrow(() -> new CustomException("결재 정보가 존재하지 않아 결재상신을 진행할 수 없습니다."));
			
			presentSanctn.sanctnApprovalValidation(); // 결재상신 진행상황, cn 데이터가 있는지 validation.
			
			cmSanctnDao.approvalRequestSanctnInfo(cmSanctn);
			cmSanctnDao.approvalRequest(cmSanctn);
			
		} catch (CustomException e) {
			throw e;
		} catch (Exception e) {
			throw new CustomException(e, cmSanctn, "결재상신이 정상적으로 완료되지 않았습니다.");
		}
	}

	/**
	 * 내용, 제목 저장
	 * 결재 저장 및 결재자 저장
	 * @param cmSanctn 결재 dto
	 */
	@Override
	public <T extends CmSanctn> void saveSanctn(T cmSanctn) {
		try {

			// cm 내용
			if (cmSanctn.cnInsertAble()) {
				final CmCn cmCn = CmCn.builder()
						.sj(cmSanctn.getSj())
						.cn(cmSanctn.getCn())
						.build();
				cmSanctnDao.insertCmCn(cmCn);
				cmSanctn.setCnSeqno(cmCn.getCnSeqno());
			}

			// cm 결재 정보, 결재자 정보
			if (cmSanctn.isSanctnNew()) {
				cmSanctnDao.insertSanctn(cmSanctn);
				this.sanctnInfoInsertProcess(cmSanctn);
			} else {
				cmSanctnDao.updateSanctn(cmSanctn);
				this.sanctnInfoUpdateProcess(cmSanctn);
			}

		} catch (IllegalStateException e) {
			throw new CustomException(e, cmSanctn, e.getMessage());
		} catch (Exception e) {
			throw new CustomException(e, cmSanctn, "결재 정보 저장이 정상적으로 완료되지 않았습니다.");
		}
	}

	/**
	 * 회수
	 * @param cmSanctn 결재 dto
	 */
	@Override
	public <T extends CmSanctn> void revert(T cmSanctn) {
		CmSanctn presentSanctn = Optional.ofNullable(cmSanctnDao.getSanctn(cmSanctn))
				.orElseThrow(() -> new CustomException("결재 정보가 존재하지 않아 회수를 진행할 수 없습니다."));

		presentSanctn.sanctnRevertValidation(); // 회수 진행상황 validation.
		
		try {
			cmSanctnDao.approvalRequestSanctnInfo(cmSanctn); // 회수시 진행 상황을 결재상신과 동일하게 변경
			cmSanctnDao.revert(cmSanctn);
		} catch (Exception e) {
			throw new CustomException(e, cmSanctn, "회수가 정상적으로 완료되지 않았습니다.");
		}
	}

	/**
	 * 결재자 저장
	 * @param sanctn 결재 dto
	 */
	private <T extends CmSanctn> void sanctnInfoInsertProcess(T sanctn) {
		sanctn.getSanctnInfoList().forEach(cmSanctnInfo -> this.insertSanctnInfo(sanctn.getSanctnSeqno(), cmSanctnInfo));
		this.updateTotalSanctnUserCount(sanctn);
	}

	/**
	 * 결재자 삭제 & 저장
	 * @param sanctn 결재 dto
	 */
	private <T extends CmSanctn> void sanctnInfoUpdateProcess(T sanctn) {
		if (sanctn.getSanctnInfoList().size() > 0) {
			// 결재자 정보 삭제 후 isnert
			this.cmSanctnDao.deleteSanctnInfo(sanctn);
			sanctn.getSanctnInfoList().forEach(cmSanctnInfo -> this.insertSanctnInfo(sanctn.getSanctnSeqno(), cmSanctnInfo));
			this.updateTotalSanctnUserCount(sanctn);
		}
	}

	/**
	 * 결재자 저장
	 * @param sanctnSeqno  결재 seqno
	 * @param cmSanctnInfo 결재자 dto
	 */
	private void insertSanctnInfo(Integer sanctnSeqno, CmSanctnInfo cmSanctnInfo) {
		cmSanctnInfo.setSanctnSeqno(sanctnSeqno);
		cmSanctnInfo.sanctnValid();
		this.cmSanctnDao.insertSanctnInfo(cmSanctnInfo);
	}

	/**
	 * total count update
	 * @param sanctn 결재 dto
	 */
	private <T extends CmSanctn> void updateTotalSanctnUserCount(T sanctn) {
		this.cmSanctnDao.updateTotalSanctnUserCount(sanctn);
	}
}

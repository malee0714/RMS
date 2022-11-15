package lims.sys.service.impl;

import lims.sys.dao.UserMDao;
import lims.sys.service.UserMService;
import lims.sys.vo.InsttMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import lims.util.enumMapper.EnumRDMS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import sun.misc.BASE64Encoder;

import javax.annotation.Resource;
import java.util.List;

@Service
public class UserMServiceImpl implements UserMService {

	@Resource(name = "commonFunc")
	private CommonFunc commonFunc;

	@Autowired
	private UserMDao userMDao;

	@Override
	public List<UserMVo> getDeptComboList(UserMVo vo) {
		return userMDao.getDeptComboList(vo);
	}

	@Override
	public List<UserMVo> getUserMList(UserMVo vo){
		return userMDao.getUserMList(vo);
	}
	
	@Override
	public int updNotUse(List<UserMVo> list) {
		UserMVo countingVo = new UserMVo();
		countingVo.setResultCount(list.size());
		
		list.stream().forEach(v -> {
			userMDao.updNotUse(v);
			
			countingVo.setResultCount(countingVo.getResultCount() - 1);
		});
		
		return countingVo.getResultCount() == 0 ? 1 : 99;
	}
	
	@Override
	public List<UserMVo> getNotLoginSixMonth(){
		return userMDao.getNotLoginSixMonth();
	}
	
	@Override
	public List<UserMVo> getSbscrbConfmUserList(UserMVo vo) {
		vo.setSbscrbConfmAt("N");
		return userMDao.getUserMList(vo);
	}

	@Override
	public int updSbscrbConfm(List<UserMVo> list) {
		UserMVo countingVo = new UserMVo();
		countingVo.setResultCount(list.size());

		list.stream().forEach(v -> {
			userMDao.updSbscrbConfm(v);
			
			// 사업장별 RDMS DB서버 연결
//			Optional<EnumRDMS> rdms = EnumRDMS.findRdmsPL(v.getBplcCode());
//			if(rdms.isPresent() && rdms.get().chkExistRdmsUser(v) == 0) {
//				rdms.get().insertRdmsUserInfo(v); // RDMS 유저정보 등록
//			}
			
			// 사업장별 DB서버 구분없이 RDMS 유저정보 등록
			EnumRDMS.OS.insertRdmsUserInfo(v);
			
			countingVo.setResultCount(countingVo.getResultCount() - 1);
		});

		return countingVo.getResultCount() == 0 ? 1 : 99;
	}

	@Override
	public int updResetPassword(List<UserMVo> list) {
		UserMVo countingVo = new UserMVo();
		countingVo.setResultCount(list.size());
		
		list.stream().forEach(v -> {
			userMDao.updResetPassword(v);
			
			// 사업장별 RDMS DB서버 연결
//			Optional<EnumRDMS> rdms = EnumRDMS.findRdmsPL(v.getBplcCode());
//			if(rdms.isPresent() && rdms.get().chkExistRdmsUser(v) > 0) {

				// 초기 비밀번호 베이스64 인코딩
//				BASE64Encoder encoder = new BASE64Encoder();
//				countingVo.setBasePassword(userMDao.getIntlPw());
//				String encodingPassword = encoder.encode(countingVo.getBasePassword().getBytes());
//				v.setBasePassword(encodingPassword);
//				
				// RDMS 사용자 비밀번호 초기화
//				rdms.get().resetRdmsPassword(v); 
//			}

			// 사업장별 DB서버 구분없이 RDMS 사용자 비밀번호 초기화
			EnumRDMS.OS.resetRdmsPassword(v);

			countingVo.setResultCount(countingVo.getResultCount() - 1);
		});

		return countingVo.getResultCount() == 0 ? 1 : 99;
	}

	@Override
	public List<UserMVo> getAuthorSeCode(UserMVo vo){
		return userMDao.getAuthorSeCode(vo);
	}

	@Override
	public List<InsttMVo> getInspctCode(InsttMVo vo){
		return userMDao.getInspctCode(vo);
	}

	@Override
	public List<UserMVo> getSignAtchmnflSeqno(UserMVo vo){
		return userMDao.getSignAtchmnflSeqno(vo);
	}

	@Override
	public int getLoginIdChk(UserMVo vo){
		return userMDao.getLoginIdChk(vo);
	}

	@Override
	public int putUserM(UserMVo vo) {
		int result = 0;
		
		// RDMS 패스워드 베이스64 인코딩
		BASE64Encoder encoder = new BASE64Encoder();
		String encodingPassword = encoder.encode(vo.getPassword().getBytes());
		vo.setBasePassword(encodingPassword);
		
		// 수정
		if (!commonFunc.isEmpty(vo.getUserId())) {
//			String prevBplcCode = userMDao.getUserBplcCode(vo);
//			Optional<EnumRDMS> prevRdms = EnumRDMS.findRdmsPL(prevBplcCode); // 기존 RDMS DB서버
//			Optional<EnumRDMS> newRdms = EnumRDMS.findRdmsPL(vo.getBplcCode()); // 바뀔 RDMS DB서버
//			if (newRdms.isPresent() && prevRdms.isPresent()) {
//
//				// 사업장을 변경하는 경우
//				if (!prevBplcCode.equals(vo.getBplcCode())) {
//
//					// 바뀔 RDMS DB에 해당 사용자정보가 이미 있는 경우
//					if (newRdms.get().chkExistRdmsUser(vo) > 0) {
//						// 기존 RDMS DB에서 삭제 후, 바뀔 RDMS DB에서 삭제 복구
//						prevRdms.get().deleteRdmsUserInfo(vo);
//						newRdms.get().updateDelRdmsUserInfo(vo);
//
//					} else {
//						// 기존 RDMS DB에서 삭제 후, 바뀔 RDMS DB에 새로 등록
//						prevRdms.get().deleteRdmsUserInfo(vo);
//						newRdms.get().insertRdmsUserInfo(vo);
//					}
//
//				} else {
//					result = prevRdms.get().updateRdmsUserInfo(vo);
//				}
//			}

			result = userMDao.updUserM(vo);

			// 사업장별 DB서버 구분없이 RDMS 유저정보 수정
			EnumRDMS.OS.updateRdmsUserInfo(vo);

			
			// DB : AuthorCode, AuthorSeCode : html 선택값
			if (vo.getAuthorSeCode() != vo.getAuthorCode()) {

				// 권한 : 시스템, 사업장, 일반으로 권한이 변경되었을 경우
				if (Integer.parseInt(vo.getAuthorSeCode().substring(vo.getAuthorSeCode().length() - 1)) <= 3) {
					// SY 부서 별 권한 대상자에 있는 로우들 사용여부 'N' 처리
					userMDao.upd04LowerAuthorTrgter(vo);
					
				// 권한 : 고객사
				} else {
					// 동일한 사용자 ID로 새로운 고객사권한이 생길수 있으니 먼저 사용자ID와 동일한 권한 모두 사용여부 'N'
					userMDao.upd04LowerAuthorTrgter(vo);
					
					// SY 부서 별 권한 대상자에 사업장코드, 사용자ID, 권한구분코드가 동일한게 있는지 있으면 수정 없으면 등록
					userMDao.updAuthorTrgter(vo);
				}
			}
		
		// 신규 등록
		} else {
			result = userMDao.insUserM(vo);
			
			// 사업장별 RDMS DB서버 연결1
//			Optional<EnumRDMS> rdms = EnumRDMS.findRdmsPL(vo.getBplcCode());
//			if (rdms.isPresent() && rdms.get().chkExistRdmsUser(vo) == 0) {
//				result = rdms.get().insertRdmsUserInfo(vo); // RDMS 유저정보 등록
//			}

			// 사업장별 DB서버 구분없이 RDMS 유저정보 등록
			EnumRDMS.OS.insertRdmsUserInfo(vo);

			// 권한 = 고객사일 경우 부서별 권한 대상자에 INSERT
			// 권한값 마지막숫자가 3이하는 일반권한 그 이상은 고객사 권한으로 추가 될 수 있음.
			if (Integer.parseInt(vo.getAuthorSeCode().substring(vo.getAuthorSeCode().length()-1)) > 3) {
				userMDao.insAuthorTrgter(vo);
			}
		}

		return result;
	}

	@Override
	public List<UserMVo> getUserAuthList(UserMVo vo) {
		return userMDao.getUserAuthList(vo);
	}

	@Override
	public String deleteUserInfo(UserMVo vo){
		String result = "";
		result = userMDao.deleteUserInfo(vo) != 0 ? "Y" : "N";
		
		if (result.equals("Y")) {
//			Optional<EnumRDMS> rdms = EnumRDMS.findRdmsPL(vo.getBplcCode());
//			if (rdms.isPresent() && rdms.get().chkExistRdmsUser(vo) > 0) {
//				rdms.get().deleteRdmsUserInfo(vo); // RDMS 유저정보 삭제
//			}
			
			// 사업장별 DB서버 구분없이 RDMS 유저정보 삭제
			EnumRDMS.OS.deleteRdmsUserInfo(vo);
		}
		
		return result;
	}

	@Override
	public int updCustomerResult(UserMVo vo) {
		int result = 0;
		try {
			// 고객사 권한 삭제
			if(!commonFunc.isEmpty(vo.getRemoveListGridData())) {
				for(int i = 0; i < vo.getRemoveListGridData().size(); i++){
					UserMVo removeGridDlivyMVo = new UserMVo();
					removeGridDlivyMVo = vo.getRemoveListGridData().get(i);
					
					// 유저 테이블 권한 : 고객사 -> 일반사용자 변경
					result = userMDao.delCustomerResult(removeGridDlivyMVo);
					
					// 부서별 권한 테이블에서 권한 삭제
					result += userMDao.delAuthTrg(removeGridDlivyMVo);
				}
			}

			// 고객사 권한 등록
			if(!commonFunc.isEmpty(vo.getAddListGridData())){
				for(int i = 0; i < vo.getAddListGridData().size(); i++){
					UserMVo gridDlivyMVo = new UserMVo();
					gridDlivyMVo = vo.getAddListGridData().get(i);
					gridDlivyMVo.setDeptCode(vo.getDeptCode());
					gridDlivyMVo.setAuthorSeCode("SY09000004");
					
					// insert
					if(commonFunc.isEmpty(vo.getAddListGridData().get(i).getAuthorTrgterSeqno())) {
						// 유저테이블의 권한을 고객사권한으로 변경
						result += userMDao.upCustomerResult(gridDlivyMVo);
						
						// 유저ID와 동일한 고객사 권한 을 사용여부 'N' 처리
						result += userMDao.useAuthTrg(gridDlivyMVo);
						
						// 고객사 T 에 동일한 권한이 있으면 삭제
						result += userMDao.delAuthTrg(gridDlivyMVo);
						
						// 고객사 T 에 권한 신규등록
						result += userMDao.insAuthTrg(gridDlivyMVo);
						
					// update
					}else {
						// 유저테이블의 권한을 고객사권한으로 변경
						result += userMDao.upCustomerResult(gridDlivyMVo);
						
						// 유저ID와 동일한 고객사 권한 을 사용여부 'N' 처리
						result += userMDao.useAuthTrg(gridDlivyMVo);
						
						// 키값이 있을때 업데이트
						// result += commonDao.upAuthTrg(gridDlivyMVo);
						result += userMDao.insAuthTrg(gridDlivyMVo);
					}
				}
			}else if(!commonFunc.isEmpty(vo.getListGridData())) {
				
				for(int i=0; i<vo.getListGridData().size(); i++) {
					UserMVo gridDlivyMVo = new UserMVo();
					gridDlivyMVo = vo.getListGridData().get(i);
					
					// 고객사 권한 사용여부를 사용안함으로 체크한 경우
					if(vo.getListGridData().get(i).getUseAt().equals("N")) {
						// 유저ID와 동일한 고객사 권한 을 사용여부 'N' 처리
						result += userMDao.upAuthTrg(gridDlivyMVo);
						gridDlivyMVo.setAuthorSeCode("SY09000003");
						
						// 유저테이블의 권한을 일반사용자권한으로 변경
						result += userMDao.upCustomerResult(gridDlivyMVo);
						
					// 고객사 권한 사용여부를 사용으로 체크한 경우
					}else {
						// 유저ID와 동일한 고객사 권한 을 사용여부 'N' 처리
						result += userMDao.useAuthTrg(gridDlivyMVo);
						
						// 유저테이블의 권한을 고객사권한으로 변경
						gridDlivyMVo.setAuthorSeCode("SY09000004");
						result += userMDao.upCustomerResult(gridDlivyMVo);
						
						// 유저ID와 동일한 고객사 권한 을 사용여부 'N' 처리
						result += userMDao.upAuthTrg(gridDlivyMVo);
					}
				}
			}
		} catch(Exception e) {
			e.getStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			throw e;
		}

		return result;
	}
}

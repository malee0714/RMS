package lims.com.service.impl;

import lims.com.dao.IgnoreServletUrlDao;
import lims.com.service.IgnoreServletUrlService;
import lims.com.vo.ComboVo;
import lims.sys.vo.CmmnCodeMVo;
import lims.sys.vo.InsttMVo;
import lims.sys.vo.UserMVo;
import lims.util.CommonFunc;
import lims.util.enumMapper.EnumRDMS;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import sun.misc.BASE64Encoder;

import java.util.List;
import java.util.regex.Pattern;

@Service
public class IgnoreServletUrlServiceImpl implements IgnoreServletUrlService{

	@Autowired
    private IgnoreServletUrlDao ignoreServletUrlDao;

	@Autowired
	private CommonFunc commonFunc;

	@Override
	public List<ComboVo> getBplcCode(InsttMVo param) {
		return ignoreServletUrlDao.getBplcCode(param);
	}

	@Override
	public List<ComboVo> getDeptCode(InsttMVo param) {
		return ignoreServletUrlDao.getDeptCode(param);
	}
	
	@Override
	public List<ComboVo> getOfcpsAndClsfCode(CmmnCodeMVo vo) {
		return ignoreServletUrlDao.getOfcpsAndClsfCode(vo);
	}

	@Override
	public int insUserJoin(UserMVo vo) {
		int result = 0;
		boolean policyChkBool = false;
		int failedCnt = 0;

		UserMVo pwPolicyVo = ignoreServletUrlDao.getPasswordPolicy();
		if ("Y".equals(pwPolicyVo.getPasswordPolicyExecutAt())) {
			String password = vo.getPassword();

			if (pwPolicyVo.getPasswordMxmmCphr() != null) {
				// 비밀번호 최대자리수
				if (!(password.length() <= Integer.parseInt(pwPolicyVo.getPasswordMxmmCphr())))
					failedCnt++;
			}

			if ("Y".equals(pwPolicyVo.getPasswordSpclChrctrInclsAt())) {
				//비밀번호 특수문자 포함 여부
				Pattern pattern = Pattern.compile("[ !@#$%^&*(),.?\":{}|<>]");
		        if (!pattern.matcher(password).find())
		        	failedCnt++;
			}

			if ("Y".equals(pwPolicyVo.getPasswordNumberInclsAt())) {
				//비밀번호 숫자 포함 여부
				Pattern pattern = Pattern.compile("[0-9]");
		        if (!pattern.matcher(password).find())
		        	failedCnt++;
			}

			if ("Y".equals(pwPolicyVo.getPasswordUpprsInclsAt())) {
				//비밀번호 대문자 포함 여부
				Pattern pattern = Pattern.compile("[A-Z]");
		        if (!pattern.matcher(password).find())
		        	failedCnt++;
			}
		}

		if (failedCnt == 0) {
			policyChkBool = true;
		} else {
			result = 100; // 비밀번호 정책에 부적합
		}

		if (policyChkBool) {
			List<String> loginIdList = ignoreServletUrlDao.getLoginIdList();
			boolean overlapVal = loginIdList.stream().anyMatch(v -> v.startsWith(vo.getLoginId()));
			if (overlapVal){
				return 99;  // 로그인 ID 중복
			} else {
				result = ignoreServletUrlDao.insUserJoin(vo);

				// RDMS 패스워드 베이스64 인코딩
				BASE64Encoder encoder = new BASE64Encoder();
				String encodingPassword = encoder.encode(vo.getPassword().getBytes());
				vo.setBasePassword(encodingPassword);

				// RMDS 유저정보 등록
				EnumRDMS.OS.insertRdmsUserInfo(vo);
				
				vo.setAuthorCode(ignoreServletUrlDao.findAuthorCode(vo));
				return vo.getAuthorCode() == null ? result : ignoreServletUrlDao.insAthUser(vo);
			}
		} else {
			return result;
		}
	}

	@Override
	public UserMVo getPasswordPolicyString() {
		UserMVo vo = ignoreServletUrlDao.getPasswordPolicy();
		String passwordPolicyString = "";
		/**
		 * PASSWORD_POLICY_EXECUT_AT		비밀번호 정책 실행 여부
		 * PASSWORD_MXMM_CPHR				비밀번호 최대 자리수
		 * PASSWORD_SPCL_CHRCTR_INCLS_AT	비밀번호 특수 문자 포함 여부
		 * PASSWORD_NUMBER_INCLS_AT			비밀번호 숫자 포함 여부
		 * PASSWORD_UPPRS_INCLS_AT			비밀번호 대문자 포함 여부
		 */
		//비밀번호정책을 사용할 경우
		if("Y".equals(vo.getPasswordPolicyExecutAt())) {
			passwordPolicyString = "Y".equals(vo.getPasswordNumberInclsAt()) ? passwordPolicyString += "숫자 " : passwordPolicyString;
			passwordPolicyString = "Y".equals(vo.getPasswordUpprsInclsAt()) ? passwordPolicyString += "대문자 " : passwordPolicyString;
			passwordPolicyString = "Y".equals(vo.getPasswordSpclChrctrInclsAt()) ? passwordPolicyString += "특수문자 " : passwordPolicyString;
			passwordPolicyString += "포함 ";

			//숫자, 대문자, 특수문하 하나도 해당되지 않을 때
			if("N".equals(vo.getPasswordNumberInclsAt()) && "N".equals(vo.getPasswordUpprsInclsAt()) && "N".equals(vo.getPasswordSpclChrctrInclsAt()))
				passwordPolicyString = "";

			if(!commonFunc.isEmpty(vo.getPasswordMxmmCphr())) {
				passwordPolicyString += vo.getPasswordMxmmCphr() + "자리";
			}
		} else {
			passwordPolicyString = "N";
		}
		vo.setTxt(passwordPolicyString);
		return vo;
	}

}

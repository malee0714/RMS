package lims.sys.vo;

import java.util.List;

import org.springframework.security.core.userdetails.UserDetails;

import lims.util.security.Role;

public class UserMVo implements UserDetails {

    private static final long serialVersionUID = 1L;

    private String userId; //이용자ID
    private String bplcCode; //사업장코드
    private String bplcCodeNm; //사업장코드명
    private String loginId; //로그인ID
    private String userNm; //사용자명
    private String deptCode; //부서코드
    private String password; //비밀번호
    private String moblphon; //핸드폰
    private String email; //이메일
    private String ofcpsCode; //ZSY18 직위 코드
    private String clsfCode; //ZSY19 직급 코드
    private String authorSeCode; //권한
    private String encpn; //입사일자
    private String resigndte; //퇴사일자
    private String signAtchmnflSeqno; //첨부파일번호
    private String lockAt; //잠금여부
    private String lockResn; //잠금사유
    private int passwordFailrCo; //비밀번호실패회수
    private String timhderAt; //팀장여부
    private String sbscrbConfmAt; //가입승인여부
    private String useAt; //사용여부
    private String deleteAt; //삭제여부
    private String lastChangerId; //최종변경자
    private String lastChangeDt; //최종변경일
    private String beforeAuth; //변경 전 권한

    private String bplcCodeSch; //사업장코드 검색
    private String deptCodeSch; //부서 검색

    private String encryptRdmsLoginID;
    private String ifEmpnum;            /* IF EMPNUM */
    private String inspctInsttCode;		//부서
    private String bestInspctInsttCode;		//최상위 부서
    private String bestInspctInsttCodeSch; //최상위부서 검색
    private String authorSeNm;
    private String nationLangCode;
    private String loginIp; //사용자IP
    private String rdmsGroupId;

    /* 자격증 정보 테이블 vo */
    private String crqfcSeqno; /* 자격증 일련번호 */
    private String crqfcKndCode; /* ZSY12_자격증 종류 코드 */
    private String crqfcNm; /* 자격증 명 */
    private String rm; /* 비고 */
    private String crqfcNo; // 자격증 번호

    /* 변수 */
    private List<Role> authorities;
    private boolean accountNonExpired = true;
    private boolean accountNonLocked = true;
    private boolean credentialsNonExpired = true;
    private boolean enabled = true;
    private String gbnCrud;
    private String crqfcCrud;
    private String upperInspctInsttNm; /* 검사기관 명 */
    private String inspctInsttNm; /* 사용자관리 부서 명 */
    private String authorSeCodeNm; /* 권한 명 */
    private String cntrctKndCodeNm; /* 계약 명 */
    private String sexdstnSeCodeNm; /* 성별 */
    private String acdmcrKndCodeNm; /* 학력 */
    private String upperInspctInsttNmSch;
    private String inspctInsttNmSch;
    private String loginIdSch; /* 로그인ID 검색어 */
    private String userNmSch; /* 사용자명 검색어 */
    private String useAtSch; /* 사용유무 검색어 */
    private String key;
    private String value;
    private String upperKey;
    private String upperValue;
    private String userIdCode;
    private String userIdPw;
    private String prePassword;
    private String gbnFailure;
    private String menuAuth;
    private String pUserNm;					//전체 사용자 조회 조건
    private String streAuthorAt;
    private String inqireAuthorAt;
    private String deleteAuthorAt;
    private String outptAuthorAt;
    private String reqUrlParam;
    private String authorCode;
    private String deptNm;
    private String mmnySeCode;
    private String limsUseAt;
    private String lockAtSch;
    private String ifValue;
    private String eblgblEvlAt;     // 적격성 평가 여부 

    /* RDMS 변수 */
    private String groupId;
    private String groupName;
    private String basePassword;
    private String userCategory;
    private String userLevel;
    private String listOption;
    private String description;

    /* ? */
    private String schdulSeCode;
    private String timhderNtcnAt;
    private String indvdlNtcnAt;
    private String chrctrNtcnAt;
    private String prductSeqno;
    private String issuSeqno;
    private String[] userIdList;
    private String userDeptCode; /*부서조회*/
    private String authorTrgterSeqno; /*권한테이블 일련번호*/
	private String notInSeqno;

    private List<UserMVo> listGridData;
    private List<UserMVo> addListGridData;
    private List<UserMVo> removeListGridData;

    private String upperInspctInsttCode;

	private String passwordPolicyExecutAt; //비밀번호 정책 실행 여부
	private String passwordMxmmCphr; //비밀번호 최대 자리수
	private String passwordSpclChrctrInclsAt; //비밀번호 특수 문자 포함 여부
	private String passwordNumberInclsAt; //비밀번호 숫자 포함 여부
	private String passwordUpprsInclsAt; //비밀번호 대문자 포함 여부
	private String txt; //비밀번호정책 문자열
	
	private String auditAt; //고객사 여부

	public String getPasswordPolicyExecutAt() {
		return passwordPolicyExecutAt;
	}

	public void setPasswordPolicyExecutAt(String passwordPolicyExecutAt) {
		this.passwordPolicyExecutAt = passwordPolicyExecutAt;
	}

	public String getPasswordMxmmCphr() {
		return passwordMxmmCphr;
	}

	public void setPasswordMxmmCphr(String passwordMxmmCphr) {
		this.passwordMxmmCphr = passwordMxmmCphr;
	}

	public String getPasswordSpclChrctrInclsAt() {
		return passwordSpclChrctrInclsAt;
	}

	public void setPasswordSpclChrctrInclsAt(String passwordSpclChrctrInclsAt) {
		this.passwordSpclChrctrInclsAt = passwordSpclChrctrInclsAt;
	}

	public String getPasswordNumberInclsAt() {
		return passwordNumberInclsAt;
	}

	public void setPasswordNumberInclsAt(String passwordNumberInclsAt) {
		this.passwordNumberInclsAt = passwordNumberInclsAt;
	}

	public String getPasswordUpprsInclsAt() {
		return passwordUpprsInclsAt;
	}

	public void setPasswordUpprsInclsAt(String passwordUpprsInclsAt) {
		this.passwordUpprsInclsAt = passwordUpprsInclsAt;
	}

	public String getTxt() {
		return txt;
	}

	public void setTxt(String txt) {
		this.txt = txt;
	}

	public String getUpperInspctInsttCode() {
		return upperInspctInsttCode;
	}

	public void setUpperInspctInsttCode(String upperInspctInsttCode) {
		this.upperInspctInsttCode = upperInspctInsttCode;
	}

	public List<UserMVo> getListGridData() {
		return listGridData;
	}

	public void setListGridData(List<UserMVo> listGridData) {
		this.listGridData = listGridData;
	}

	public List<UserMVo> getAddListGridData() {
		return addListGridData;
	}

	public void setAddListGridData(List<UserMVo> addListGridData) {
		this.addListGridData = addListGridData;
	}

	public List<UserMVo> getRemoveListGridData() {
		return removeListGridData;
	}

	public void setRemoveListGridData(List<UserMVo> removeListGridData) {
		this.removeListGridData = removeListGridData;
	}

	private int resultCount;

    public String getBeforeAuth() {
		return beforeAuth;
	}

	public void setBeforeAuth(String beforeAuth) {
		this.beforeAuth = beforeAuth;
	}

	public int getResultCount() {
		return resultCount;
	}

	public void setResultCount(int resultCount) {
		this.resultCount = resultCount;
	}

	public String getDeptCodeSch() {
		return deptCodeSch;
	}

	public void setDeptCodeSch(String deptCodeSch) {
		this.deptCodeSch = deptCodeSch;
	}

	public String getBplcCodeSch() {
		return bplcCodeSch;
	}

	public void setBplcCodeSch(String bplcCodeSch) {
		this.bplcCodeSch = bplcCodeSch;
	}

	public String getBplcCodeNm() {
		return bplcCodeNm;
	}

	public void setBplcCodeNm(String bplcCodeNm) {
		this.bplcCodeNm = bplcCodeNm;
	}

	public String getBestInspctInsttCodeSch() {
		return bestInspctInsttCodeSch;
	}

	public void setBestInspctInsttCodeSch(String bestInspctInsttCodeSch) {
		this.bestInspctInsttCodeSch = bestInspctInsttCodeSch;
	}

	public String getBplcCode() {
		return bplcCode;
	}

	public void setBplcCode(String bplcCode) {
		this.bplcCode = bplcCode;
	}

    public String getAuthorTrgterSeqno() {
        return authorTrgterSeqno;
    }

    public void setAuthorTrgterSeqno(String authorTrgterSeqno) {
        this.authorTrgterSeqno = authorTrgterSeqno;
    }

    public String getUserDeptCode() {
        return userDeptCode;
    }

    public void setUserDeptCode(String userDeptCode) {
        this.userDeptCode = userDeptCode;
    }

    public String[] getUserIdList() {
        return userIdList;
    }

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getLoginId() {
		return loginId;
	}

	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}

	public String getUserNm() {
		return userNm;
	}

	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}

	public String getDeptCode() {
		return deptCode;
	}

	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMoblphon() {
		return moblphon;
	}

	public void setMoblphon(String moblphon) {
		this.moblphon = moblphon;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getOfcpsCode() {
		return ofcpsCode;
	}

	public void setOfcpsCode(String ofcpsCode) {
		this.ofcpsCode = ofcpsCode;
	}

	public String getClsfCode() {
		return clsfCode;
	}

	public void setClsfCode(String clsfCode) {
		this.clsfCode = clsfCode;
	}

	public String getAuthorSeCode() {
		return authorSeCode;
	}

	public void setAuthorSeCode(String authorSeCode) {
		this.authorSeCode = authorSeCode;
	}

	public String getEncpn() {
		return encpn;
	}

	public void setEncpn(String encpn) {
		this.encpn = encpn;
	}

	public String getResigndte() {
		return resigndte;
	}

	public void setResigndte(String resigndte) {
		this.resigndte = resigndte;
	}

	public String getSignAtchmnflSeqno() {
		return signAtchmnflSeqno;
	}

	public void setSignAtchmnflSeqno(String signAtchmnflSeqno) {
		this.signAtchmnflSeqno = signAtchmnflSeqno;
	}

	public String getLockAt() {
		return lockAt;
	}

	public void setLockAt(String lockAt) {
		this.lockAt = lockAt;
	}

	public String getLockResn() {
		return lockResn;
	}

	public void setLockResn(String lockResn) {
		this.lockResn = lockResn;
	}

	public int getPasswordFailrCo() {
		return passwordFailrCo;
	}

	public void setPasswordFailrCo(int passwordFailrCo) {
		this.passwordFailrCo = passwordFailrCo;
	}

	public String getTimhderAt() {
		return timhderAt;
	}

	public void setTimhderAt(String timhderAt) {
		this.timhderAt = timhderAt;
	}

	public String getSbscrbConfmAt() {
		return sbscrbConfmAt;
	}

	public void setSbscrbConfmAt(String sbscrbConfmAt) {
		this.sbscrbConfmAt = sbscrbConfmAt;
	}

	public String getUseAt() {
		return useAt;
	}

	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	public String getDeleteAt() {
		return deleteAt;
	}

	public void setDeleteAt(String deleteAt) {
		this.deleteAt = deleteAt;
	}

	public String getLastChangerId() {
		return lastChangerId;
	}

	public void setLastChangerId(String lastChangerId) {
		this.lastChangerId = lastChangerId;
	}

	public String getLastChangeDt() {
		return lastChangeDt;
	}

	public void setLastChangeDt(String lastChangeDt) {
		this.lastChangeDt = lastChangeDt;
	}

	public String getEncryptRdmsLoginID() {
		return encryptRdmsLoginID;
	}

	public void setEncryptRdmsLoginID(String encryptRdmsLoginID) {
		this.encryptRdmsLoginID = encryptRdmsLoginID;
	}

	public String getIfEmpnum() {
		return ifEmpnum;
	}

	public void setIfEmpnum(String ifEmpnum) {
		this.ifEmpnum = ifEmpnum;
	}

	public String getInspctInsttCode() {
		return inspctInsttCode;
	}

	public void setInspctInsttCode(String inspctInsttCode) {
		this.inspctInsttCode = inspctInsttCode;
	}

	public String getBestInspctInsttCode() {
		return bestInspctInsttCode;
	}

	public void setBestInspctInsttCode(String bestInspctInsttCode) {
		this.bestInspctInsttCode = bestInspctInsttCode;
	}

	public String getAuthorSeNm() {
		return authorSeNm;
	}

	public void setAuthorSeNm(String authorSeNm) {
		this.authorSeNm = authorSeNm;
	}

	public String getNationLangCode() {
		return nationLangCode;
	}

	public void setNationLangCode(String nationLangCode) {
		this.nationLangCode = nationLangCode;
	}

	public String getLoginIp() {
		return loginIp;
	}

	public void setLoginIp(String loginIp) {
		this.loginIp = loginIp;
	}

	public String getRdmsGroupId() {
		return rdmsGroupId;
	}

	public void setRdmsGroupId(String rdmsGroupId) {
		this.rdmsGroupId = rdmsGroupId;
	}

	public String getCrqfcSeqno() {
		return crqfcSeqno;
	}

	public void setCrqfcSeqno(String crqfcSeqno) {
		this.crqfcSeqno = crqfcSeqno;
	}

	public String getCrqfcKndCode() {
		return crqfcKndCode;
	}

	public void setCrqfcKndCode(String crqfcKndCode) {
		this.crqfcKndCode = crqfcKndCode;
	}

	public String getCrqfcNm() {
		return crqfcNm;
	}

	public void setCrqfcNm(String crqfcNm) {
		this.crqfcNm = crqfcNm;
	}

	public String getRm() {
		return rm;
	}

	public void setRm(String rm) {
		this.rm = rm;
	}

	public String getCrqfcNo() {
		return crqfcNo;
	}

	public void setCrqfcNo(String crqfcNo) {
		this.crqfcNo = crqfcNo;
	}

	public List<Role> getAuthorities() {
		return authorities;
	}

	public void setAuthorities(List<Role> authorities) {
		this.authorities = authorities;
	}

	public boolean isAccountNonExpired() {
		return accountNonExpired;
	}

	public void setAccountNonExpired(boolean accountNonExpired) {
		this.accountNonExpired = accountNonExpired;
	}

	public boolean isAccountNonLocked() {
		return accountNonLocked;
	}

	public void setAccountNonLocked(boolean accountNonLocked) {
		this.accountNonLocked = accountNonLocked;
	}

	public boolean isCredentialsNonExpired() {
		return credentialsNonExpired;
	}

	public void setCredentialsNonExpired(boolean credentialsNonExpired) {
		this.credentialsNonExpired = credentialsNonExpired;
	}

	public boolean isEnabled() {
		return enabled;
	}

	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}

	public String getGbnCrud() {
		return gbnCrud;
	}

	public void setGbnCrud(String gbnCrud) {
		this.gbnCrud = gbnCrud;
	}

	public String getCrqfcCrud() {
		return crqfcCrud;
	}

	public void setCrqfcCrud(String crqfcCrud) {
		this.crqfcCrud = crqfcCrud;
	}

	public String getUpperInspctInsttNm() {
		return upperInspctInsttNm;
	}

	public void setUpperInspctInsttNm(String upperInspctInsttNm) {
		this.upperInspctInsttNm = upperInspctInsttNm;
	}

	public String getInspctInsttNm() {
		return inspctInsttNm;
	}

	public void setInspctInsttNm(String inspctInsttNm) {
		this.inspctInsttNm = inspctInsttNm;
	}

	public String getAuthorSeCodeNm() {
		return authorSeCodeNm;
	}

	public void setAuthorSeCodeNm(String authorSeCodeNm) {
		this.authorSeCodeNm = authorSeCodeNm;
	}

	public String getCntrctKndCodeNm() {
		return cntrctKndCodeNm;
	}

	public void setCntrctKndCodeNm(String cntrctKndCodeNm) {
		this.cntrctKndCodeNm = cntrctKndCodeNm;
	}

	public String getSexdstnSeCodeNm() {
		return sexdstnSeCodeNm;
	}

	public void setSexdstnSeCodeNm(String sexdstnSeCodeNm) {
		this.sexdstnSeCodeNm = sexdstnSeCodeNm;
	}

	public String getAcdmcrKndCodeNm() {
		return acdmcrKndCodeNm;
	}

	public void setAcdmcrKndCodeNm(String acdmcrKndCodeNm) {
		this.acdmcrKndCodeNm = acdmcrKndCodeNm;
	}

	public String getUpperInspctInsttNmSch() {
		return upperInspctInsttNmSch;
	}

	public void setUpperInspctInsttNmSch(String upperInspctInsttNmSch) {
		this.upperInspctInsttNmSch = upperInspctInsttNmSch;
	}

	public String getInspctInsttNmSch() {
		return inspctInsttNmSch;
	}

	public void setInspctInsttNmSch(String inspctInsttNmSch) {
		this.inspctInsttNmSch = inspctInsttNmSch;
	}

	public String getLoginIdSch() {
		return loginIdSch;
	}

	public void setLoginIdSch(String loginIdSch) {
		this.loginIdSch = loginIdSch;
	}

	public String getUserNmSch() {
		return userNmSch;
	}

	public void setUserNmSch(String userNmSch) {
		this.userNmSch = userNmSch;
	}

	public String getUseAtSch() {
		return useAtSch;
	}

	public void setUseAtSch(String useAtSch) {
		this.useAtSch = useAtSch;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getUpperKey() {
		return upperKey;
	}

	public void setUpperKey(String upperKey) {
		this.upperKey = upperKey;
	}

	public String getUpperValue() {
		return upperValue;
	}

	public void setUpperValue(String upperValue) {
		this.upperValue = upperValue;
	}

	public String getUserIdCode() {
		return userIdCode;
	}

	public void setUserIdCode(String userIdCode) {
		this.userIdCode = userIdCode;
	}

	public String getUserIdPw() {
		return userIdPw;
	}

	public void setUserIdPw(String userIdPw) {
		this.userIdPw = userIdPw;
	}

	public String getPrePassword() {
		return prePassword;
	}

	public void setPrePassword(String prePassword) {
		this.prePassword = prePassword;
	}

	public String getGbnFailure() {
		return gbnFailure;
	}

	public void setGbnFailure(String gbnFailure) {
		this.gbnFailure = gbnFailure;
	}

	public String getMenuAuth() {
		return menuAuth;
	}

	public void setMenuAuth(String menuAuth) {
		this.menuAuth = menuAuth;
	}

	public String getpUserNm() {
		return pUserNm;
	}

	public void setpUserNm(String pUserNm) {
		this.pUserNm = pUserNm;
	}

	public String getStreAuthorAt() {
		return streAuthorAt;
	}

	public void setStreAuthorAt(String streAuthorAt) {
		this.streAuthorAt = streAuthorAt;
	}

	public String getInqireAuthorAt() {
		return inqireAuthorAt;
	}

	public void setInqireAuthorAt(String inqireAuthorAt) {
		this.inqireAuthorAt = inqireAuthorAt;
	}

	public String getDeleteAuthorAt() {
		return deleteAuthorAt;
	}

	public void setDeleteAuthorAt(String deleteAuthorAt) {
		this.deleteAuthorAt = deleteAuthorAt;
	}

	public String getOutptAuthorAt() {
		return outptAuthorAt;
	}

	public void setOutptAuthorAt(String outptAuthorAt) {
		this.outptAuthorAt = outptAuthorAt;
	}

	public String getReqUrlParam() {
		return reqUrlParam;
	}

	public void setReqUrlParam(String reqUrlParam) {
		this.reqUrlParam = reqUrlParam;
	}

	public String getAuthorCode() {
		return authorCode;
	}

	public void setAuthorCode(String authorCode) {
		this.authorCode = authorCode;
	}

	public String getDeptNm() {
		return deptNm;
	}

	public void setDeptNm(String deptNm) {
		this.deptNm = deptNm;
	}

	public String getMmnySeCode() {
		return mmnySeCode;
	}

	public void setMmnySeCode(String mmnySeCode) {
		this.mmnySeCode = mmnySeCode;
	}

	public String getLimsUseAt() {
		return limsUseAt;
	}

	public void setLimsUseAt(String limsUseAt) {
		this.limsUseAt = limsUseAt;
	}

	public String getLockAtSch() {
		return lockAtSch;
	}

	public void setLockAtSch(String lockAtSch) {
		this.lockAtSch = lockAtSch;
	}

	public String getIfValue() {
		return ifValue;
	}

	public void setIfValue(String ifValue) {
		this.ifValue = ifValue;
	}

	public String getGroupId() {
		return groupId;
	}

	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}

	public String getGroupName() {
		return groupName;
	}

	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}

	public String getSchdulSeCode() {
		return schdulSeCode;
	}

	public void setSchdulSeCode(String schdulSeCode) {
		this.schdulSeCode = schdulSeCode;
	}

	public String getTimhderNtcnAt() {
		return timhderNtcnAt;
	}

	public void setTimhderNtcnAt(String timhderNtcnAt) {
		this.timhderNtcnAt = timhderNtcnAt;
	}

	public String getIndvdlNtcnAt() {
		return indvdlNtcnAt;
	}

	public void setIndvdlNtcnAt(String indvdlNtcnAt) {
		this.indvdlNtcnAt = indvdlNtcnAt;
	}

	public String getChrctrNtcnAt() {
		return chrctrNtcnAt;
	}

	public void setChrctrNtcnAt(String chrctrNtcnAt) {
		this.chrctrNtcnAt = chrctrNtcnAt;
	}

	public String getPrductSeqno() {
		return prductSeqno;
	}

	public void setPrductSeqno(String prductSeqno) {
		this.prductSeqno = prductSeqno;
	}

	public String getIssuSeqno() {
		return issuSeqno;
	}

	public void setIssuSeqno(String issuSeqno) {
		this.issuSeqno = issuSeqno;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public void setUserIdList(String[] userIdList) {
		this.userIdList = userIdList;
	}

	@Override
	public String getUsername() {
		// TODO Auto-generated method stub
		return null;
	}

	public String getUserCategory() {
		return userCategory;
	}

	public void setUserCategory(String userCategory) {
		this.userCategory = userCategory;
	}

	public String getUserLevel() {
		return userLevel;
	}

	public void setUserLevel(String userLevel) {
		this.userLevel = userLevel;
	}

	public String getListOption() {
		return listOption;
	}

	public void setListOption(String listOption) {
		this.listOption = listOption;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getBasePassword() {
		return basePassword;
	}

	public void setBasePassword(String basePassword) {
		this.basePassword = basePassword;
	}

	public String getAuditAt() {
		return auditAt;
	}

	public void setAuditAt(String auditAt) {
		this.auditAt = auditAt;
	}

	public String getEblgblEvlAt() {
		return eblgblEvlAt;
	}

	public void setEblgblEvlAt(String eblgblEvlAt) {
		this.eblgblEvlAt = eblgblEvlAt;
	}

	public String getNotInSeqno() {
		return notInSeqno;
	}

	public void setNotInSeqno(String notInSeqno) {
		this.notInSeqno = notInSeqno;
	}
}

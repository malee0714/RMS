package lims.util;

import java.util.Map;



import org.springframework.context.ApplicationContext;

import lims.config.ApplicationContextProvider;

/***
 * 
 * @author Hancheol
 * @see .끄어억헉헉
 * 
 */

public class Util {	
	
	public static Util getInstance() {
		return LazyHolder.INSTANCE;
	}

	private static class LazyHolder {
		private static final Util INSTANCE = new Util();
	}
	
	
	
	String DATA_SERVER;
	String REPORTING_SERVER;
	String SERVER_IP;
	String smtpHost;
	String smtpPort;
	String adminID;
	String adminPW;
	String reportID;
	String reportPW;
	String emailToUserId;
	String rdServiceNm;
	String rdContype;
	String rdmsUrl;
	Map<String, Object> getAllCmmnCodeMap;
	
	//빈 불러오지 못할때 사용하시면 됩니다.
	public static Object getBean(String beanName) {
        ApplicationContext applicationContext = ApplicationContextProvider.getApplicationContext();
        return applicationContext.getBean(beanName);
    }

	public Map<String, Object> getGetAllCmmnCodeMap() {
		return getAllCmmnCodeMap;
	}


	public void setGetAllCmmnCodeMap(Map<String, Object> getAllCmmnCodeMap) {
		this.getAllCmmnCodeMap = getAllCmmnCodeMap;
	}


	public String getRdServiceNm() {
		return rdServiceNm;
	}

	public void setRdServiceNm(String rdServiceNm) {
		this.rdServiceNm = rdServiceNm;
	}
	
	public String getEmailToUserId() {
		return emailToUserId;
	}

	public void setEmailToUserId(String emailToUserId) {
		this.emailToUserId = emailToUserId;
	}

	public String getReportID() {
		return reportID;
	}

	public void setReportID(String reportID) {
		this.reportID = reportID;
	}

	public String getReportPW() {
		return reportPW;
	}

	public void setReportPW(String reportPW) {
		this.reportPW = reportPW;
	}

	public String getSERVER_IP() {
		return SERVER_IP;
	}

	public String getAdminID() {
		return adminID;
	}

	public void setAdminID(String adminID) {
		this.adminID = adminID;
	}

	public String getAdminPW() {
		return adminPW;
	}

	public void setAdminPW(String adminPW) {
		this.adminPW = adminPW;
	}

	public void setSERVER_IP(String sERVER_IP) {
		SERVER_IP = sERVER_IP;
	}

	public String getSmtpHost() {
		return smtpHost;
	}

	public void setSmtpHost(String smtpHost) {
		this.smtpHost = smtpHost;
	}

	public String getSmtpPort() {
		return smtpPort;
	}

	public void setSmtpPort(String smtpPort) {
		this.smtpPort = smtpPort;
	}

	public String getDATA_SERVER() {
		return DATA_SERVER;
	}

	public void setDATA_SERVER(String dATA_SERVER) {
		DATA_SERVER = dATA_SERVER;
	}

	public String getREPORTING_SERVER() {
		return REPORTING_SERVER;
	}

	public void setREPORTING_SERVER(String rEPORTING_SERVER) {
		REPORTING_SERVER = rEPORTING_SERVER;
	}
	
	public String getRdContype() {
		return rdContype;
	}

	public void setRdContype(String rdContype) {
		this.rdContype = rdContype;
	}

	public String getRdmsUrl() {
		return rdmsUrl;
	}

	public void setRdmsUrl(String rdmsUrl) {
		this.rdmsUrl = rdmsUrl;
	}
	
}

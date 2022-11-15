package lims.util.enumMapper;

import lims.com.vo.FileDetailMVo;
import lims.com.vo.RdmsMVo;
import lims.sys.vo.UserMVo;
import lims.util.Util;
import rdms.os.dao.RdmsOSMDao;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;
import java.util.function.Function;

public enum EnumRDMS {
	//울산
	OS("1000", (binderitemvalueArr) -> {
		Util util = Util.getInstance();
		RdmsOSMDao rdms = (RdmsOSMDao)util.getBean("rdmsOSMDao");
		return rdms.getBinderColumnInfo(binderitemvalueArr);
	}, (hashmap) -> {
		Util util = Util.getInstance();
		RdmsOSMDao rdms = (RdmsOSMDao)util.getBean("rdmsOSMDao");		
		return rdms.getPdfViewerGridData(hashmap);
	}, (vo) -> {
		Util util = Util.getInstance();
		RdmsOSMDao rdms = (RdmsOSMDao)util.getBean("rdmsOSMDao");
		return rdms.getblobPdfViewer(vo);
	}, (str) -> {
		Util util = Util.getInstance();
		RdmsOSMDao rdms = (RdmsOSMDao)util.getBean("rdmsOSMDao");
		return rdms.getCheckBlobPdfViewer(str);
	}, (vo) -> {
		Util util = Util.getInstance();
		RdmsOSMDao rdms = (RdmsOSMDao)util.getBean("rdmsOSMDao");
		return rdms.getRdmsResultData(vo);
	}, (vo) -> {
		Util util = Util.getInstance();
		RdmsOSMDao rdms = (RdmsOSMDao)util.getBean("rdmsOSMDao");
		return rdms.delRdmsResultData(vo);
	}, (vo) -> {
		Util util = Util.getInstance();
		RdmsOSMDao rdms = (RdmsOSMDao)util.getBean("rdmsOSMDao");
		return rdms.insertRdmsUserInfo(vo);
	}, (vo) -> {
		Util util = Util.getInstance();
		RdmsOSMDao rdms = (RdmsOSMDao)util.getBean("rdmsOSMDao");
		return rdms.updateRdmsUserInfo(vo);
	}, (vo) -> {
		Util util = Util.getInstance();
		RdmsOSMDao rdms = (RdmsOSMDao)util.getBean("rdmsOSMDao");
		return rdms.deleteRdmsUserInfo(vo);
	}, (vo) -> {
		Util util = Util.getInstance();
		RdmsOSMDao rdms = (RdmsOSMDao)util.getBean("rdmsOSMDao");
		return rdms.resetRdmsPassword(vo);
	}, (vo) -> {
		Util util = Util.getInstance();
		RdmsOSMDao rdms = (RdmsOSMDao)util.getBean("rdmsOSMDao");
		return rdms.chkExistRdmsUser(vo);
	}, (vo) -> {
		Util util = Util.getInstance();
		RdmsOSMDao rdms = (RdmsOSMDao)util.getBean("rdmsOSMDao");
		return rdms.updateDelRdmsUserInfo(vo);
	});
//	//천안
//	CA("2000", (binderitemvalueArr) -> {
//		Util util = Util.getInstance();
//		RdmsCAMDao rdms = (RdmsCAMDao)util.getBean("rdmsCAMDao");
//		return rdms.getBinderColumnInfo(binderitemvalueArr);
//	}, (hashmap) -> {
//		Util util = Util.getInstance();
//		RdmsCAMDao rdms = (RdmsCAMDao)util.getBean("rdmsCAMDao");
//		return rdms.getPdfViewerGridData(hashmap);
//	}, (vo) -> {
//		Util util = Util.getInstance();
//		RdmsCAMDao rdms = (RdmsCAMDao)util.getBean("rdmsCAMDao");
//		return rdms.getblobPdfViewer(vo);
//	}, (str) -> {
//		Util util = Util.getInstance();
//		RdmsCAMDao rdms = (RdmsCAMDao)util.getBean("rdmsCAMDao");
//		return rdms.getCheckBlobPdfViewer(str);
//	}, (vo) -> {
//		Util util = Util.getInstance();
//		RdmsCAMDao rdms = (RdmsCAMDao)util.getBean("rdmsCAMDao");
//		return rdms.getRdmsResultData(vo);
//	}, (vo) -> {
//		Util util = Util.getInstance();
//		RdmsCAMDao rdms = (RdmsCAMDao)util.getBean("rdmsCAMDao");
//		return rdms.delRdmsResultData(vo);
//	}, (vo) -> {
//		Util util = Util.getInstance();
//		RdmsCAMDao rdms = (RdmsCAMDao)util.getBean("rdmsCAMDao");
//		return rdms.insertRdmsUserInfo(vo);
//	}, (vo) -> {
//		Util util = Util.getInstance();
//		RdmsCAMDao rdms = (RdmsCAMDao)util.getBean("rdmsCAMDao");
//		return rdms.updateRdmsUserInfo(vo);
//	}, (vo) -> {
//		Util util = Util.getInstance();
//		RdmsCAMDao rdms = (RdmsCAMDao)util.getBean("rdmsCAMDao");
//		return rdms.deleteRdmsUserInfo(vo);
//	}, (vo) -> {
//		Util util = Util.getInstance();
//		RdmsCAMDao rdms = (RdmsCAMDao)util.getBean("rdmsCAMDao");
//		return rdms.resetRdmsPassword(vo);
//	}, (vo) -> {
//		Util util = Util.getInstance();
//		RdmsCAMDao rdms = (RdmsCAMDao) util.getBean("rdmsCAMDao");
//		return rdms.chkExistRdmsUser(vo);
//	}, (vo) -> {
//		Util util = Util.getInstance();
//		RdmsCAMDao rdms = (RdmsCAMDao) util.getBean("rdmsCAMDao");
//		return rdms.updateDelRdmsUserInfo(vo);
//	});
	
	public final String code;
	public final Function<String, List<RdmsMVo>> getBinderColumnInfo;
	public final Function<HashMap<String,String[]>, List<RdmsMVo>> getPdfViewerGridData;
	public final Function<RdmsMVo, FileDetailMVo> getblobPdfViewer;
	public final Function<String[], List<FileDetailMVo>> getCheckBlobPdfViewer;
	public final Function<RdmsMVo, List<HashMap<String,Object>>> getRdmsResultData;
	public final Function<RdmsMVo, Integer> delRdmsResultData;
	public final Function<UserMVo, Integer> insertRdmsUserInfo;
	public final Function<UserMVo, Integer> updateRdmsUserInfo;
	public final Function<UserMVo, Integer> deleteRdmsUserInfo;
	public final Function<UserMVo, Integer> resetRdmsPassword;
	public final Function<UserMVo, Integer> chkExistRdmsUser;
	public final Function<UserMVo, Integer> updateDelRdmsUserInfo;
	
	EnumRDMS(String code,
			Function<String, List<RdmsMVo>> getBinderColumnInfo,
			Function<HashMap<String,String[]>, List<RdmsMVo>> getPdfViewerGridData,
			Function<RdmsMVo, FileDetailMVo> getblobPdfViewer,
			Function<String[], List<FileDetailMVo>> getCheckBlobPdfViewer,
			Function<RdmsMVo, List<HashMap<String,Object>>> getRdmsResultData,
			Function<RdmsMVo, Integer> delRdmsResultData,
			Function<UserMVo, Integer> insertRdmsUserInfo,
			Function<UserMVo, Integer> updateRdmsUserInfo,
			Function<UserMVo, Integer> deleteRdmsUserInfo,
			Function<UserMVo, Integer> resetRdmsPassword,
			Function<UserMVo, Integer> chkExistRdmsUser,
		 	Function<UserMVo, Integer> updateDelRdmsUserInfo){
		this.code = code;
		this.getBinderColumnInfo = getBinderColumnInfo;
		this.getPdfViewerGridData = getPdfViewerGridData;
		this.getblobPdfViewer = getblobPdfViewer;
		this.getCheckBlobPdfViewer = getCheckBlobPdfViewer;
		this.getRdmsResultData = getRdmsResultData;
		this.delRdmsResultData = delRdmsResultData;
		this.insertRdmsUserInfo = insertRdmsUserInfo;
		this.updateRdmsUserInfo = updateRdmsUserInfo;
		this.deleteRdmsUserInfo = deleteRdmsUserInfo;
		this.resetRdmsPassword = resetRdmsPassword;
		this.chkExistRdmsUser = chkExistRdmsUser;
		this.updateDelRdmsUserInfo = updateDelRdmsUserInfo;
	}
	
	public List<RdmsMVo> getBinderColumnInfo(String binderitemvalueArr){
		return this.getBinderColumnInfo.apply(binderitemvalueArr);
	};
	
	public List<RdmsMVo> getPdfViewerGridData(HashMap<String,String[]> hashmap){
		return this.getPdfViewerGridData.apply(hashmap);
	};

	public FileDetailMVo getblobPdfViewer(RdmsMVo vo){
		return this.getblobPdfViewer.apply(vo);
	};
	
	public List<FileDetailMVo> getCheckBlobPdfViewer(String[] str){
		return this.getCheckBlobPdfViewer.apply(str);
	};
	
	public List<HashMap<String,Object>> getRdmsResultData(RdmsMVo vo){
		return this.getRdmsResultData.apply(vo);
	};
	
	public Integer delRdmsResultData(RdmsMVo vo){
		return this.delRdmsResultData.apply(vo);
	};
	
	public Integer insertRdmsUserInfo(UserMVo vo){
		return this.insertRdmsUserInfo.apply(vo);
	};
	
	public Integer updateRdmsUserInfo(UserMVo vo){
		return this.updateRdmsUserInfo.apply(vo);
	};
	
	public Integer deleteRdmsUserInfo(UserMVo vo){
		return this.deleteRdmsUserInfo.apply(vo);
	};
	
	public Integer resetRdmsPassword(UserMVo vo){
		return this.resetRdmsPassword.apply(vo);
	};
	
	public Integer chkExistRdmsUser(UserMVo vo){
		return this.chkExistRdmsUser.apply(vo);
	};

	public Integer updateDelRdmsUserInfo(UserMVo vo){
		return this.updateDelRdmsUserInfo.apply(vo);
	};
	
	public String getCode() {
		return this.code;
	};
	
	public static Optional<EnumRDMS> findRdmsPL(String code) {
		return Arrays.stream(EnumRDMS.values())
				.filter(cmmn -> code.equals(cmmn.getCode()))
				.findFirst();
	};
}

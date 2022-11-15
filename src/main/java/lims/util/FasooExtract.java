package lims.util;


import java.io.IOException;
import java.io.Reader;
import java.util.Properties;

import org.apache.ibatis.io.Resources;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;

import com.fasoo.fcwpkg.packager.WorkPackager;


public class FasooExtract {
	Logger logger =  LoggerFactory.getLogger(FasooExtract.class);
	
	@Value("${fasoo.drm.homedir}")
	private String homedir;
	
	@Value("${fasoo.drm.fsdinit}")
	private String fsdinit;
	
	
	
	public void DoExtract(String filePath){
		String resource = "property/fileUploadPath.properties"; 
		Properties properties = new Properties();
			
		try {
			Reader reader = Resources.getResourceAsReader(resource);
			properties.load(reader);
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
        int nRet = 0;
        boolean bRet = false;

		String HOMEDIR = properties.getProperty("fasoo.drm.homedir");  //fsdinit 디렉토리 경로
		String FSDINIT = properties.getProperty("fasoo.drm.fsdinit");  //고객사 DSDCODE
 		String srcFile = filePath; //암호화 파일
		String tarFile = filePath; //복호화 파일

        WorkPackager oWorkPackager = new WorkPackager();
        oWorkPackager.setOverWriteFlag(true);

		nRet = oWorkPackager.GetFileType(srcFile);
		
		if (nRet == 103) //FSN 문서일 경우
		{
			bRet = oWorkPackager.DoExtract(HOMEDIR,	FSDINIT, srcFile, tarFile);	
									 
	        if (!bRet){
				System.out.println("복호화 실패!! ["+ oWorkPackager.getLastErrorNum()+"] "+oWorkPackager.getLastErrorStr());
			}else{
				System.out.println("복호화 성공!!" + oWorkPackager.getContainerFilePathName());
			}
		}
	}

}

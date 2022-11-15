package lims.test.service.Impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import lims.test.dao.ResultInputPfileMDao;
import lims.test.service.ResultInputPfileMService;
import lims.test.vo.ResultInputPfileMVo;


@Service("ResultInputPfileMService")
public class ResultInputPfileMServiceImpl implements ResultInputPfileMService{

	@Autowired
	private ResultInputPfileMDao resultInputPfileMDao;

	@Override
	public HashMap<String, Object> fileTxtUpload(MultipartHttpServletRequest request) throws Exception {

        int result = 0;
        MultipartFile file = request.getFile("formFile"); // request로 전달받은 파일
        BufferedReader br = new BufferedReader(new InputStreamReader(file.getInputStream(), "UTF-8")); // 텍스트 파일 읽기
        HashMap<String, Object> resultMap = new HashMap<String, Object>(); //리턴해줄 hashmap

        //얘는 텍스트파일 읽어 줄 변수
        String line = "";

        List<HashMap<String, Object>> readList = new ArrayList<>();
        List<HashMap<String, Object>> resultList = new ArrayList<>();



        List<String> array = new ArrayList<String>();

        List array2 = new ArrayList();
        List array3 = new ArrayList();


        while((line = br.readLine()) != null){
        	// 내용이 끝날떄 까지 while로 돌리고 그값을 array에 담는다
        	array.add(line);

        }
      int num=0;
        for(int i=0; i<array.size(); i++) {
        	if(array.get(i).indexOf("Sample ID") != -1 ){
        		num ++;
        		array2.add(i);
        		array3.add(num);
        	}
        }

        array2.add(array.size()+1);

        int cnt=0;

        for(int i=0; i<array.size(); i++) {


        	// array에서 Sample ID가 있으면 실행
        	if(array.get(i).indexOf("Sample ID") != -1 ){

        		for(int j=i+3; j<(int)array2.get(cnt+1)-1; j++) {
        			//System.out.println("::::::"+array.get(j));

        			//데이터를 담을 해시맵을 만든다
        			HashMap<String, Object> readMap = new HashMap<String, Object>();
        			//필요한 데이터를 put으로 담는다
        			readMap.put("lotId", array.get(i).split(",")[1]);
        			readMap.put("testNm", array.get(j).split(",")[1]);
    				readMap.put("resultValue", array.get(j).split(",")[3]);
    				readMap.put("idChk", array3.get(cnt));
    				readMap.put("msg", "성공");
    				//필요한 데이터를 담아논것을 또 한번  담는다 여기엔 가공된 전체 데이터가 들어감
            		readList.add(readMap);

        		}

        		cnt ++;
        	}

        }

//        System.out.println("가공시킨데이터 담김 >>"+readList);
		ResultInputPfileMVo pfileVo = new ResultInputPfileMVo();

		// 가공된 데이터를 기준으로 for문을 돌림
        for(int i=0; i<readList.size(); i++) {
        	// 각각 vo에 값을 넣어준다
        	pfileVo.setLotId(readList.get(i).get("lotId").toString());
        	pfileVo.setResultValue(readList.get(i).get("resultValue").toString());
        	pfileVo.setTestNm(readList.get(i).get("testNm").toString());
        	pfileVo.setIdChk(readList.get(i).get("idChk").toString());



           	//lot id로 진행사항 코드 조회
        	String sittnCode = resultInputPfileMDao.getSittnCode(pfileVo);
        	pfileVo.setProgrsSittnCode(sittnCode);

        	// lot id로 의뢰일련번호 조회
        	String reqestSeqno = resultInputPfileMDao.getReqSeqno(pfileVo);
        	pfileVo.setReqestSeqno(reqestSeqno);

        	// 의뢰 일련번호로 시험항목 조회
        	String reqExpriemSeqno = resultInputPfileMDao.getReqestExpriemSeqno(pfileVo);
        	pfileVo.setReqestExpriemSeqno(reqExpriemSeqno);



			HashMap<String, Object> resultChkMap = new HashMap<String, Object>();

			if(sittnCode == null || sittnCode.equals("")) {
				resultChkMap.put("lotId", readList.get(i).get("lotId").toString());
				resultChkMap.put("testNm",readList.get(i).get("testNm").toString());
				resultChkMap.put("resultValue",readList.get(i).get("resultValue").toString());
				resultChkMap.put("idChk",readList.get(i).get("idChk").toString());
				resultChkMap.put("msg", "유효하지 않은 LOT ID 입니다.");

				resultList.add(resultChkMap);

				continue;
			}

			if(sittnCode.equals("IM03000003")){
				resultChkMap.put("lotId", readList.get(i).get("lotId").toString());
				resultChkMap.put("testNm",readList.get(i).get("testNm").toString());
				resultChkMap.put("resultValue",readList.get(i).get("resultValue").toString());
				resultChkMap.put("idChk",readList.get(i).get("idChk").toString());
				resultChkMap.put("msg", "성공");

				resultList.add(resultChkMap);
				//결과 저장
				result = resultInputPfileMDao.saveGo(pfileVo);

			} else {
				resultChkMap.put("lotId", readList.get(i).get("lotId").toString());
				resultChkMap.put("testNm",readList.get(i).get("testNm").toString());
				resultChkMap.put("resultValue",readList.get(i).get("resultValue").toString());
				resultChkMap.put("idChk",readList.get(i).get("idChk").toString());
				resultChkMap.put("msg", "유효하지 않은 LOT ID 입니다.");
				resultList.add(resultChkMap);
				continue;
			}





        }

        resultMap.put("readList", readList);	//얘는 저장에 성공할떄 쓸거고
        resultMap.put("resultList", resultList); // 얘는 실패할때 씀


        //맵을 리턴하여 jsp에서 사용
		return resultMap;
	}


}

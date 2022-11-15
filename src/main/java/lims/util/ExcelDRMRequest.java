package lims.util;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

@Service
public class ExcelDRMRequest {

    //DRM을 해제하기위한 SOAP 호출
    public String callSoapService(MultipartHttpServletRequest request) throws IOException {

        MultipartFile multipartFile = request.getFile("formFile");
        String fName = multipartFile.getOriginalFilename();
        DataOutputStream wr = null;
        BufferedReader in = null;

        try {
            String xml = ""
                    +"<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
                    +"<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\">\n"
                    +"  <soap:Body>\n"
                    +"      <ReadExcelWithHeaerOption_NoCompress xmlns=\"http://tempuri.org/\">\n"
                    +"         <fileName>temp" + fName.substring(fName.indexOf(".")) + "</fileName>\n"
                    +"         <file>" + Base64.getEncoder().encodeToString(multipartFile.getBytes()) + "</file>\n"
                    +"         <headerOption>N</headerOption>\n"
                    +"     </ReadExcelWithHeaerOption_NoCompress>\n"
                    +"  </soap:Body>\n"
                    +"</soap:Envelope>";

            URL obj = new URL("http://61.81.242.11/IRIS/Service.asmx"); //WWW의 리소스에 대한 포인터
            HttpURLConnection con = (HttpURLConnection) obj.openConnection(); //단일요청 커넥션 생성
            con.setRequestMethod("POST"); //HTTP Method
            con.setRequestProperty("Content-Type","text/xml; charset=utf-8"); //HTTP Header type
            con.setDoOutput(true); //URL 연결 입/출력에 사용(입력 = false, 출력 = true)

            //기본 자바 데이터 유형을 스트림에 이식하기 위한 Stream 사용
            wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(xml); //String to Byte Stream
            wr.flush(); //버퍼에 쌓여있는 데이터를 내보낸다

            in = new BufferedReader(new InputStreamReader(con.getInputStream(), StandardCharsets.UTF_8));
            String inputLine;
            StringBuilder stringBuilder = new StringBuilder();
            while ((inputLine = in.readLine()) != null)
                stringBuilder.append(inputLine);

            //HTTP 요청으로 응답 받은 데이터에서 필요한 부분만 subString 으로 제거하여 요청 메소드에 돌려준다
            String tempString = stringBuilder.substring(stringBuilder.indexOf("</xs:schema>") + 12, stringBuilder.indexOf("</ReadExcelWithHeaerOption_NoCompressResult>"));
            //</ReadExcelWithHeaerOption_NoCompressResult> 태그 밖에서도 <Table1> 값이 있어서 두번에 걸쳐서 substring 진행
            return tempString.substring(tempString.indexOf("<Table1"), tempString.lastIndexOf("</Table1>") + 9);

        } catch (Exception e) {
            return e.getMessage();
        } finally {
            if(wr != null)
                wr.close();
            if(in != null)
                in.close();
        }
    }
}
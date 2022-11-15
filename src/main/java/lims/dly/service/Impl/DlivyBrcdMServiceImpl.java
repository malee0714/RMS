/**
 * 1.바코드 검증 중복여부 체크
 *   제조1팀 - 전부 중복체크 1(두번찍히면 불합격)
 *   제조2팀 - SEC 만 중복체크 1
 *   제조3팀 - SEC 만 중복체크 1, 동부는 바코드 이어서 생성안함 무조건 1번부터 시작
 *   제조4팀 - 전부 중복체크 1(두번찍히면 불합격)
 *   훽    트 - SEC 만 중복체크
 */
package lims.dly.service.Impl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.BeanUtils;
//import org.eclipse.jdt.internal.compiler.util.Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import lims.dly.dao.DlivyBrcdMDao;
import lims.dly.service.DlivyBrcdMService;
import lims.dly.vo.DlivyMVo;
import lims.sys.dao.DvyfgMtrilsMDao;
import lims.sys.vo.DvyfgMtrilsMVo;
import lims.util.GetUserSession;

@Service("DlivyBrcdMService")
public class DlivyBrcdMServiceImpl implements DlivyBrcdMService{

	@Autowired
	private DlivyBrcdMDao dlivyBrcdMDao;
	
	@Autowired
	private DvyfgMtrilsMDao dvyfgMtrilsMDao;
	
	/**
	 * 바코드 조회
	 */
	@Override
	public List<DlivyMVo> getBarcodeList(DlivyMVo vo) {
		GetUserSession sessionD = new GetUserSession();
		vo.setAuthorSeCode(sessionD.getAuthorSeCode());
		return dlivyBrcdMDao.getBarcodeList(vo);
	}
	
	/**
	 * 바코드 상세 조회
	 */
	@Override
	public List<DlivyMVo> getBarcodeDetailList(DlivyMVo vo) {
		// TODO Auto-generated method stub
		return dlivyBrcdMDao.getBarcodeDetailList(vo);
	}
	
	
	/**
	 * 바코드 엑셀 출력 조회
	 */
	@Override
	public List<DlivyMVo> getBarcodePrintList(DlivyMVo vo) {
		GetUserSession sessionD = new GetUserSession();
		vo.setAuthorSeCode(sessionD.getAuthorSeCode());
	List<DlivyMVo> list = dlivyBrcdMDao.getBarcodePrintList(vo);

		return list;
	}
	
	/**
	 * 물류양식 엑셀 출력 조회
	 */
	@Override
	public List<DlivyMVo> getBarcodePrintList3(DlivyMVo vo) {
		GetUserSession sessionD = new GetUserSession();
		vo.setAuthorSeCode(sessionD.getAuthorSeCode());
	List<DlivyMVo> list = dlivyBrcdMDao.getBarcodePrintList3(vo);

		return list;
	}
	
	/**
	 * 품질양식 엑셀 출력 조회
	 */
	@Override
	public List<DlivyMVo> getBarcodePrintList4(DlivyMVo vo) {
		GetUserSession sessionD = new GetUserSession();
		vo.setAuthorSeCode(sessionD.getAuthorSeCode());
		
	List<DlivyMVo> list = dlivyBrcdMDao.getBarcodePrintList4(vo);

		return list;
	}
	
	/**
	 * 바코드 정보 삭제
	 */
	@Override	
	public int insDeleteBarcd(DlivyMVo vo) {
		
		int result = 0;
		//1 바코드 정보
		if(vo.getGubun().equals("1")){
			result = dlivyBrcdMDao.insDeleteBarcodeInfo(vo);
		}
		//2 바코드 정보의 하위 바코드
		else{
			for(int i=0; i<vo.getListGridData().size(); i++){
				result = dlivyBrcdMDao.insDeleteBarcodeList(vo.getListGridData().get(i));
			}
		}
		return result;		
	}
	
	/**
	 * 출고바코드 저장
	 */
	@Override
	public int insBrcdFormDlivy(DlivyMVo vo) {
		if(vo.getPoNo().toUpperCase().indexOf("HIR") != -1){
			vo.setSkAt("Y");
		}
		else{
			vo.setSkAt("N");
		}

		int result = 0;
		String dvyfgEntrpsCode = dlivyBrcdMDao.getDvyfgEntrpsCode(vo);
		String barcode1 = "";
		String barcode2 = "";
		String barcode3 = "";
		String barcode4 = "";
		String barcode5 = "";
		try{
			if(!vo.getInspctInsttCode().equals("3977")) {
				if(dvyfgEntrpsCode == null){
					throw new Exception();
				}				
			}
		}catch(Exception e){
			e.printStackTrace();
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			
			throw new RuntimeException("납품 업체 목록에 등록되지 않은 자재 코드입니다.") {
				private static final long serialVersionUID = 17646577L;
			};
		}

		//담당팀의 납품업체 바코드 규칙조회
		DvyfgMtrilsMVo dvyfgMtrilsMVo = new DvyfgMtrilsMVo();
		dvyfgMtrilsMVo.setShrDeptCode(vo.getInspctInsttCode());
		dvyfgMtrilsMVo.setShrDvyfgEntrpsSeCode(dvyfgEntrpsCode);
		dvyfgMtrilsMVo.setShrDeleteAt("N");
		
		//납품 업체 목록 조회
		List<DvyfgMtrilsMVo> DvyfgMtrilsList = dvyfgMtrilsMDao.getDvyfgMtrils(dvyfgMtrilsMVo);
		//이미 생성된 바코드 갯수
		vo.setShrDvyfgEntrpsSeCode(dvyfgEntrpsCode);

		String chkDlivyQy = dlivyBrcdMDao.getDlivyQy(vo);

		int intDlivyQy = Integer.parseInt(String.valueOf(Math.round(Double.valueOf(vo.getDlivyQy()))));
		int preDlivyQy = 0;
		
		if(chkDlivyQy == null || chkDlivyQy.equals("null") || chkDlivyQy.equals("")){
			preDlivyQy = 0;
		}
		else{
			preDlivyQy = Integer.valueOf(chkDlivyQy);
		}
		
		//수량 저장
		Integer qy = 0;
		
		//첫번째 바코드 객체
		DlivyMVo barcode1Vo = new DlivyMVo();
		
		//두번째 바코드 객체
		DlivyMVo barcode2Vo = new DlivyMVo();
		
		//세번째 바코드 객체
		DlivyMVo barcode3Vo = new DlivyMVo();
				
		//네번째 바코드 객체
		DlivyMVo barcode4Vo = new DlivyMVo();
		
		//다섯번째 바코드 객체
		DlivyMVo barcode5Vo = new DlivyMVo();
		
		//출고 바코드 테이블 저장
		vo.setDeptCode(vo.getInspctInsttCode());

		result = dlivyBrcdMDao.insBrcdDlivy(vo);
		
		//고객사 제조번호					
		String ctmmnyMtrilCode = "";
		
		//1팀
		if(vo.getInspctInsttCode().equals("3974")){
			switch(dvyfgEntrpsCode){
				case "SY17000001": //1팀 삼성 전자
					
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						//"Item", "유효기간", "CAN 제작사", "CAN Size", "Plant", "제품정보"
						if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode)){

							//총개수 저장
							vo.setTopRepr(2);
							dlivyBrcdMDao.updBrcdDlivy(vo);
							qy = intDlivyQy;
							
							//첫번째 바코드 객체
							barcode1Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode1Vo);
							
							//두번째 바코드 객체
							barcode2Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode2Vo);
							
							
							//바코드1 조합
							barcode1 = "SH79" + vo.getCtmmnyMtrilCode() + getMafdate(vo.getBatchNo(), "");
							
							//두번째 바코드 조합
							
							barcode2 = DvyfgMtrilsList.get(i).getCol2() //유효기간
									+ vo.getBatchNo() //Lot 번호
									+ "$$$$" //공란
									+ DvyfgMtrilsList.get(i).getCol3() //CAN 제작사
									+ DvyfgMtrilsList.get(i).getCol4() //CAN 사이즈
									+ vo.getRm() //Can No. 비고에 작성한다고함
									+ DvyfgMtrilsList.get(i).getCol5() //공장구분
							 		;
							//order 저장
							barcode1Vo.setOrdr(String.valueOf(1));
							barcode2Vo.setOrdr(String.valueOf(1));
							//첫번째 바코드 저장
							barcode1Vo.setBrcd(barcode1);
							barcode1Vo.setRepr("1");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy()));
							}
							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
							
							//두번째 바코드 저장
							barcode2Vo.setBrcd(barcode2);
							barcode2Vo.setRepr("2");
							barcode2Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy()));
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode2Vo);
							
							//수량 업데이트, 갯수검증여부
							vo.setDlivyQy(String.valueOf(qy));
							vo.setVrifyAt("Y");// 일련번호로 증가되지 않기때문에 중복체크 안함
							dlivyBrcdMDao.updBrcdDlivyQy(vo);
						}
					}
					break;
				case "SY17000002": //1팀 SK하이닉스
					
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						//"고객 자재코드", "Item", "Site"
						if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode)){
							
							//총개수 저장
							vo.setTopRepr(2);
							dlivyBrcdMDao.updBrcdDlivy(vo);
							
							qy = intDlivyQy;
							
							//첫번째 바코드 객체
							barcode1Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode1Vo);								

							//두번째 바코드 객체
							barcode2Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode2Vo);
							
							//상위 바코드 SAP 벤더 Code(6자리) + 공란4자리 + 비고에 적혀있는 용기번호
							barcode1 = "300199" + vo.getRm();
							
							//order 저장
							barcode1Vo.setOrdr(String.valueOf(1));
							//첫번째 바코드 저장
							barcode1Vo.setBrcd(barcode1);
							barcode1Vo.setRepr("1");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy()));
							}
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
							
							//SAP Code 6자리 + 공란 4자리 + Lot No 8자리
							barcode2 = DvyfgMtrilsList.get(i).getCol1() + "    " + vo.getBatchNo();
							
							//order 저장
							barcode2Vo.setOrdr(String.valueOf(1));
							//첫번째 바코드 저장
							barcode2Vo.setBrcd(barcode2);
							barcode2Vo.setRepr("2");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode2Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy()));
							}
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode2Vo);
							
							//수량 업데이트, 갯수검증여부
							vo.setDlivyQy(String.valueOf(qy));
							vo.setVrifyAt("N");
							dlivyBrcdMDao.updBrcdDlivyQy(vo);
							
						}
					}
					break;
				case "SY17000003": //1팀 동부하이텍
					
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						//"고객 자재코드", "Item", "SQ"
						if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode)){

							//지시서의 수량
							double dlivyQy = Double.valueOf(vo.getDlivyQy());
							//제품의 수량 
							double dbsq = Double.valueOf(DvyfgMtrilsList.get(i).getCol3());
							
							//지시서 수량 나누기 제품 수량
							double dbqy = dlivyQy / dbsq;
							//소수점이면 올림처리해서 루프돌림
							int ceil = (int) Math.ceil(dbqy);						
							

							//총개수 저장
							vo.setTopRepr(1);
							dlivyBrcdMDao.updBrcdDlivy(vo);
							
							//수량만큼 반복한다.
							for(int j=1; j<=ceil; j++){
								//첫번째 바코드 객체
								barcode1Vo = new DlivyMVo();
								BeanUtils.copyProperties(vo, barcode1Vo);
								
								//SQ
								double resultSq = Double.valueOf(DvyfgMtrilsList.get(i).getCol3());
								
								
								//지시서의 수량이 제품의 수량보다 적으면..
								if(Double.valueOf(vo.getDlivyQy()) < Double.valueOf(DvyfgMtrilsList.get(i).getCol3())){
									resultSq = Double.valueOf(vo.getDlivyQy());
								}
								else{
									//첫번째 수량일때
									if(j == 1){
										resultSq = Double.valueOf(DvyfgMtrilsList.get(i).getCol3());
										//지시서 수량 - SQ
										dlivyQy = dlivyQy  - Double.valueOf(DvyfgMtrilsList.get(i).getCol3());
									}
									//마지막 수량일때
									else if(j == ceil){
										//남은 지시서수량
										resultSq = dlivyQy;
									}
									else{
										//SQ 나누기 지시서 수량
										double tempqy = dbsq % dlivyQy;
										//지시서 수량 - (SQ 나누기 지시서 수량)
										dlivyQy = dlivyQy - tempqy;
										resultSq = tempqy;
									}									
								}
								
								//지시서의 수량 - sq를 해고 남은 지시서의 수량을 다시 sq를 빼서 사용하는 방식임
								double dResultSq = (resultSq*10)/10.0;
								
								//바코드1 조합
								barcode1 = DvyfgMtrilsList.get(i).getCol1() + "-"//자재코드
										 + vo.getRm()  + "-"//비고
										 + String.format("%05d", j+preDlivyQy)  + "-"//SQ
										 + String.format("%06d", Math.round(dResultSq)) //제품 수량 , 두째자리 반올림
										 ; 
								//order 저장
								barcode1Vo.setOrdr(String.valueOf(j));
								//첫번째 바코드 저장
								barcode1Vo.setBrcd(barcode1);
								barcode1Vo.setRepr("1");
								if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
									barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy()));
								}
								
								dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
							}
							
							//수량 업데이트, 갯수 검증여부
							vo.setDlivyQy(String.valueOf(ceil));
							vo.setVrifyAt("N");
							dlivyBrcdMDao.updBrcdDlivyQy(vo);
						}
					}
					
					break;
			}
		}
		//개발 2팀
		else if(vo.getInspctInsttCode().equals("3975")){
			switch(dvyfgEntrpsCode){
				case "SY17000001": //2팀 삼성 전자
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						
						String ctmmnyMtrilCodevo = "";
						
						//고객 자재코드가 없는 제품이면 lims자재 코드로 비교한다.
						if(vo.getCtmmnyMtrilCode() == null || vo.getCtmmnyMtrilCode().equals("")){
							ctmmnyMtrilCodevo = vo.getMtrilCode();
						}
						else{
							ctmmnyMtrilCodevo = vo.getCtmmnyMtrilCode();
						}
						
						//총개수 저장
						vo.setTopRepr(1);
						dlivyBrcdMDao.updBrcdDlivy(vo);					
						
						//"고객 자재코드", "Maker", "Item", "제품명 코드", "Grade", "제조사 위치", "유효기간"
						if(ctmmnyMtrilCodevo.equals(ctmmnyMtrilCode)){
							//첫번째 바코드 객체
							barcode1Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode1Vo);

							if(DvyfgMtrilsList.get(i).getCol9().equals("TL")) {
								// TL제품은 수량에 관계 없이무조건 1개나와야함 
								qy = intDlivyQy / intDlivyQy;
							} else {
								//단위가 KG면 수량 / 드럼무게
								if(vo.getUnitNm().toUpperCase().equals("KG")){
									qy = intDlivyQy / Integer.valueOf(DvyfgMtrilsList.get(i).getCol8());
								}
								else{
									qy = intDlivyQy;
								}
							}
							String getBatchNo = "";
							String fistBatch = "";
							
							//제조일보다 제품이 앞에오는 LOT일때
							if(vo.getBatchNo().substring(0, 2).toUpperCase().equals("C3")){
								getBatchNo = vo.getBatchNo().substring(2, 6);
								String m = getBatchNo.substring(1, 2);
								
								//A~I 까지 batchNo 들어오면 1~9로 변경함 바코드 뒤에 날짜 월 부분임
								if(m.toUpperCase().equals("A")){
									getBatchNo = getBatchNo.replace(getBatchNo.substring(1,2), "1");
								}
								else if(m.toUpperCase().equals("B")){
									getBatchNo = getBatchNo.replace(getBatchNo.substring(1,2), "2");
								}
								else if(m.toUpperCase().equals("C")){
									getBatchNo = getBatchNo.replace(getBatchNo.substring(1,2), "3");
								}
								else if(m.toUpperCase().equals("D")){
									getBatchNo = getBatchNo.replace(getBatchNo.substring(1,2), "4");
								}
								else if(m.toUpperCase().equals("E")){
									getBatchNo = getBatchNo.replace(getBatchNo.substring(1,2), "5");
								}
								else if(m.toUpperCase().equals("F")){
									getBatchNo = getBatchNo.replace(getBatchNo.substring(1,2), "6");
								}
								else if(m.toUpperCase().equals("G")){
									getBatchNo = getBatchNo.replace(getBatchNo.substring(1,2), "7");
								}
								else if(m.toUpperCase().equals("H")){
									getBatchNo = getBatchNo.replace(getBatchNo.substring(1,2), "8");
								}
								else if(m.toUpperCase().equals("I")){
									getBatchNo = getBatchNo.replace(getBatchNo.substring(1,2), "9");
								}
								
								if(getBatchNo.substring(0,1).equals("A")){
									getBatchNo = getBatchNo.replace(getBatchNo.substring(0,1), "0");
								}
								
								fistBatch = vo.getBatchNo() + "$$"; //지시서 배치넘버 염산은 $$ 붙힘
							}
							else{
								//지시서 배치넘버
								fistBatch = vo.getBatchNo();
								//YYYYMMDD							
								String _mDate = getMafdate(vo.getBatchNo(), "full");

								if(vo.getBatchNo().length() == 8){
									
								}
								
								String y = _mDate.substring(3,4);
								String m = "";
								String d = _mDate.substring(6,8);
								
								d = String.format("%02d", Integer.valueOf(d)); 

								if(_mDate.substring(4,6).equals("10")){
									m = "X";
								}
								else if(_mDate.substring(4,6).equals("11")){
									m = "Y";
								}
								else if(_mDate.substring(4,6).equals("12")){
									m = "Z";
								}
								else{
									m = _mDate.substring(5,6);
								}
								
								getBatchNo = y + m + d;
							}

							//수량만큼 반복한다.
							for(int j=1; j<=qy; j++){

								//바코드1 조합							
								barcode1 = DvyfgMtrilsList.get(i).getCol2() //마커
										 + DvyfgMtrilsList.get(i).getCol4() //제품명코드
										 + DvyfgMtrilsList.get(i).getCol5() //Grade
										 + fistBatch //지시서 배치넘버
										 + String.format("%03d", j + preDlivyQy)
										 + getBatchNo //제조일
										 + DvyfgMtrilsList.get(i).getCol6() //제조사위치 
										 + DvyfgMtrilsList.get(i).getCol7() //유효기간
										 ;
								//order 저장
								barcode1Vo.setOrdr(String.valueOf(j));
								//첫번째 바코드 저장
								barcode1Vo.setBrcd(barcode1);
								barcode1Vo.setRepr("1");
								
								if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
									barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
								}
								dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
							}
							if(DvyfgMtrilsList.get(i).getCol9().equals("TL")) {
								vo.setDlivyQy(String.valueOf(intDlivyQy));
							} else {
								vo.setDlivyQy(String.valueOf(qy));
							}
							//수량 업데이트, 갯수 검증여부
							vo.setVrifyAt("Y");
							dlivyBrcdMDao.updBrcdDlivyQy(vo);
						}
						
					}
					
					break;
				case "SY17000002": //2팀 SK하이닉스
					//P/O No. 에 HIR이 앞에 있으면.. 한줄
					if(vo.getPoNo().toUpperCase().indexOf("HIR") != -1){

						//총개수 저장
						vo.setTopRepr(1);
						dlivyBrcdMDao.updBrcdDlivy(vo);
						
						//"고객 자재코드", "Item", "용기", "1차 생성", "2차 생성", "3차 생성", "4차 생성", "갯수"
						for(int i=0; i<DvyfgMtrilsList.size(); i++){
							ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
							
							//첫번째 바코드 객체
							barcode1Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode1Vo);
							
							//고객자재코드 , cnt가 1인것
							if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode) && Integer.valueOf(DvyfgMtrilsList.get(i).getCol8()) == 1){
								int num = 0;
								if(DvyfgMtrilsList.get(i).getCol3().equals("TL")) {
									 num = intDlivyQy / intDlivyQy;
								} else {
									 num = intDlivyQy / Integer.valueOf(DvyfgMtrilsList.get(i).getCol4());																
								}

								//고객자재코드 + 8자리 LOT + 000 + (수량/1차 생성)
								for(int j=1; j<=num; j++){
									if(DvyfgMtrilsList.get(i).getCol3().equals("TL")) {
										barcode1 = DvyfgMtrilsList.get(i).getCol1() + vo.getBatchNo() + " " + "01";
									} else {
										barcode1 = DvyfgMtrilsList.get(i).getCol1() + vo.getBatchNo() + String.format("%02d", j + preDlivyQy) + " ";	
										//21-01-14 3팀하고 똑같이 이제품만 변경
										if(DvyfgMtrilsList.get(i).getCol1().equals("R3165999")) {
											barcode1 = DvyfgMtrilsList.get(i).getCol1() + vo.getBatchNo() + " " +String.format("%02d", j + preDlivyQy);				
										}
									}
									
									//첫번째 바코드 저장(제품자재코드)
									barcode1Vo.setBrcd(barcode1);
									barcode1Vo.setRepr("1");
									barcode1Vo.setOrdr(String.valueOf(j));
									if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
										barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
									}
									
									dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
								}
								
								//수량 업데이트, 갯수 검증여부
								if(DvyfgMtrilsList.get(i).getCol3().equals("TL")) {
									vo.setDlivyQy(String.valueOf(intDlivyQy));									
								} else {
									vo.setDlivyQy(String.valueOf(num));	
								}
								vo.setVrifyAt("N");
								dlivyBrcdMDao.updBrcdDlivyQy(vo);
							}
						}
						
					}
					else{
						//서브로 생성되는 제품이 있으면 저장해놓고 서브 제품이 오면 컨티뉴 함
						String ctmmnyCntCode = "";
						
						//"고객 자재코드", "Item", "용기", "1차 생성", "2차 생성", "3차 생성", "4차 생성", "갯수"
						for(int i=0; i<DvyfgMtrilsList.size(); i++){
							ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
							
							if(ctmmnyCntCode.equals(ctmmnyMtrilCode) && Integer.valueOf(DvyfgMtrilsList.get(i).getCol8()) == 1){
								continue;
							}
							
							//고객자재코드 비교
							if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode)){


								//총개수 저장
								vo.setTopRepr(2);							
								dlivyBrcdMDao.updBrcdDlivy(vo);
								
								int cnt = 4;
								//같은 고객자재코드, 같은 용기이면 서브를 찾아서 생성
	 							if(Integer.valueOf(DvyfgMtrilsList.get(i).getCol8()) > 1){
									cnt = cnt * Integer.valueOf(DvyfgMtrilsList.get(i).getCol8());
									ctmmnyCntCode = ctmmnyMtrilCode;
								}
								
								
								//드럼일때
								if(DvyfgMtrilsList.get(i).getCol3().equals("DRUM")){
									int order = 1;
									for(int j=0; j<cnt/4; j++){
										
										for(int x=1; x<=4; x++){
											
											barcode1Vo = new DlivyMVo();
											BeanUtils.copyProperties(vo, barcode1Vo);
											
											barcode1 = vo.getCtmmnyMtrilCode();
											
											//첫번째 바코드 저장
											barcode1Vo.setBrcd(barcode1);
											barcode1Vo.setRepr("1");
											barcode1Vo.setOrdr(String.valueOf(order));
											if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
												barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
											}
											
											dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
											
											//두번째 바코드 저장
											barcode2Vo = new DlivyMVo();
											BeanUtils.copyProperties(vo, barcode2Vo);
											
											//바코드1 조합
											if(x == 1){
												barcode2 = String.format("%05d", Integer.valueOf(DvyfgMtrilsList.get(i+j).getCol4())) + " " + vo.getBatchNo();
											}
											else if(x == 2){
												barcode2 = String.format("%05d", Integer.valueOf(DvyfgMtrilsList.get(i+j).getCol5())) + " " + vo.getBatchNo();
											}
											else if(x == 3){
												barcode2 = String.format("%05d", Integer.valueOf(DvyfgMtrilsList.get(i+j).getCol6())) + " " + vo.getBatchNo();
											}
											else if(x == 4){
												barcode2 = String.format("%05d", Integer.valueOf(DvyfgMtrilsList.get(i+j).getCol7())) + " " + vo.getBatchNo();
											}
											
											//order 저장
											barcode2Vo.setOrdr(String.valueOf(order));
											//첫번째 바코드 저장
											barcode2Vo.setBrcd(barcode2);
											barcode2Vo.setRepr("2");
											if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
												barcode2Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
											}											
											dlivyBrcdMDao.insDlivyBrcdDetail(barcode2Vo);
											order++;
										}
									}
																		
									//수량 업데이트, 갯수 검증여부
									vo.setDlivyQy(String.valueOf(cnt/4));
									vo.setVrifyAt("N");
									dlivyBrcdMDao.updBrcdDlivyQy(vo);
								}
								//보틀일때
								else{
									int order = 1;
									qy = intDlivyQy;
									
									for(int x=1; x<=4; x++){
										
										barcode1Vo = new DlivyMVo();
										BeanUtils.copyProperties(vo, barcode1Vo);
										
										barcode1 = vo.getCtmmnyMtrilCode();
										
										//첫번째 바코드 저장
										barcode1Vo.setBrcd(barcode1);
										barcode1Vo.setRepr("1");
										barcode1Vo.setOrdr(String.valueOf(order));
										if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
											barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
										}
										
										dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
										
										barcode2Vo = new DlivyMVo();
										BeanUtils.copyProperties(vo, barcode2Vo);
										
										//바코드1 조합
										if(x == 1){
											barcode2 = String.format("%05d", Integer.valueOf(DvyfgMtrilsList.get(i).getCol4())) + " " + vo.getBatchNo();
										}
										else if(x == 2){
											barcode2 = String.format("%05d", intDlivyQy ) + " " + vo.getBatchNo();
										}
										else if(x == 3){
											barcode2 = String.format("%05d", Integer.valueOf(DvyfgMtrilsList.get(i).getCol6())) + " " + vo.getBatchNo();
										}
										else if(x == 4){					
											barcode2 = String.format("%05d", Integer.valueOf(DvyfgMtrilsList.get(i).getCol7())) + " " + vo.getBatchNo();
										}
										
										//order 저장
										barcode2Vo.setOrdr(String.valueOf(order));
										//첫번째 바코드 저장
										barcode2Vo.setBrcd(barcode2);
										barcode2Vo.setRepr("2");
										if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
											barcode2Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
										}
										
										dlivyBrcdMDao.insDlivyBrcdDetail(barcode2Vo);
										order++;
									}
									
									//수량 업데이트, 갯수 검증여부
									vo.setDlivyQy(String.valueOf(qy));
									vo.setVrifyAt("N");
									dlivyBrcdMDao.updBrcdDlivyQy(vo);
									
								}
							}
						}						
					}
					break;
				case "SY17000003": //2팀 동부하이텍
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						
						//"고객 자재코드", "Item", "SQ"
						if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode)){
							
							//지시서의 수량
							double dlivyQy = Double.valueOf(vo.getDlivyQy());
							//제품의 수량 
							double dbsq = Integer.valueOf(DvyfgMtrilsList.get(i).getCol3());
							
							//지시서 수량 나누기 제품 수량
							double dbqy = dlivyQy / dbsq;
							//올림처리해서 루프돌림
							int ceil = (int) Math.ceil(dbqy);	
							
							
							////////////////////////////////////////////
							/////////////CSA-T07 제품일때/////////////////
							///////////////////////////////////////////
							if(ctmmnyMtrilCode.equals("RPC0303")){
								//지시서 비고가 비었을때 CSA-T07 생성
								if(vo.getRm() == null || vo.getRm().equals("")){
									int rpcCnt = intDlivyQy / 20;						

									for(int j=1; j<=rpcCnt; j++){
										//첫번째 바코드 객체
										barcode1Vo = new DlivyMVo();
										BeanUtils.copyProperties(vo, barcode1Vo);
										
										//제품명 + lot번호 + 공백 + - + 1에서32까지 두자리 + 공백(20-04-13 오보람씨 요청으로 공백제거해둠)
										barcode1 = "CSA-T07" + " " + vo.getBatchNo() + "-" + String.format("%02d", j);
										//order 저장
										barcode1Vo.setOrdr(String.valueOf(ceil+j));
										//첫번째 바코드 저장
										barcode1Vo.setBrcd(barcode1);
										barcode1Vo.setRepr("1");
										if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
											barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
										}
										
										dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
									}
																		
									//수량 업데이트, 갯수 검증여부
									vo.setDlivyQy(String.valueOf(rpcCnt));
									vo.setVrifyAt("N");
									dlivyBrcdMDao.updBrcdDlivyQy(vo);
									
									//총개수 저장
									vo.setTopRepr(1);
									dlivyBrcdMDao.updBrcdDlivy(vo);
									
									
								}
								//지시서에 비고가 있으면 바코드 두개 생성
								else{
									//수량만큼 반복한다.
									for(int j=1; j<=ceil; j++){
										//첫번째 바코드 객체
										barcode1Vo = new DlivyMVo();
										BeanUtils.copyProperties(vo, barcode1Vo);
										
										String resultSq = "";
										
										//지시서의 수량이 제품의 수량보다 적으면..
										if(intDlivyQy < Integer.valueOf(DvyfgMtrilsList.get(i).getCol3())){
											resultSq = String.valueOf(intDlivyQy);
										}
										else{
											if(j == 1){
												resultSq = DvyfgMtrilsList.get(i).getCol3();
												dlivyQy = dlivyQy  - Double.valueOf(DvyfgMtrilsList.get(i).getCol3());
											}
											else if(j == ceil){
												resultSq = String.valueOf((int)dlivyQy);
											}
											else{
												double tempqy = dbsq % dlivyQy;										
												dlivyQy = dlivyQy - tempqy;
												resultSq = String.valueOf((int)tempqy);
											}									
										}
										
										//바코드1 조합							
										barcode1 = DvyfgMtrilsList.get(i).getCol1() + "-"//자재코드
												 + vo.getRm()  + "-"//Batch No
												 + String.format("%05d", j)  + "-"//SQ
												 + String.format("%06d", Integer.valueOf(resultSq)) //제품 수량
												 ;
										//order 저장
										barcode1Vo.setOrdr(String.valueOf(j));
										//첫번째 바코드 저장
										barcode1Vo.setBrcd(barcode1);
										barcode1Vo.setRepr("1");
										if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
											barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
										}
										
										dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
									}
									
									//RPC0303 제품은 고정 바코드 하나더 생성//									
//									if(ctmmnyMtrilCode.equals("RPC0303")){							
//										
//										rpcCnt = intDlivyQy / 20;
//										
//										for(int j=1; j<=rpcCnt; j++){
//											//첫번째 바코드 객체
//											barcode1Vo = new DlivyMVo();
//											BeanUtils.copyProperties(vo, barcode1Vo);
//											
//											//제품명 + lot번호 + 공백 + - + 1에서32까지 두자리 + 공백
//											barcode1 = "CSA-T07" + " " + vo.getBatchNo() + "-" + String.format("%02d", j+preDlivyQy) + " ";
//											//order 저장
//											barcode1Vo.setOrdr(String.valueOf(ceil+j));
//											//첫번째 바코드 저장
//											barcode1Vo.setBrcd(barcode1);
//											barcode1Vo.setRepr("1");
//											dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
//										}
//										
//										//총개수 저장
//										vo.setTopRepr(1);
//										dlivyBrcdMDao.updBrcdDlivy(vo);
//									}
									
									//수량 업데이트, 갯수 검증여부
									vo.setDlivyQy(String.valueOf(ceil));
									vo.setVrifyAt("Y");
									dlivyBrcdMDao.updBrcdDlivyQy(vo);
									
									//총개수 저장
									vo.setTopRepr(1);
									dlivyBrcdMDao.updBrcdDlivy(vo);
								}
							}
							////////////////////////////////////////////
							/////////////CSA-T07 아닐때/////////////////
							///////////////////////////////////////////
							else{
								
								//총개수 저장
								vo.setTopRepr(1);
								dlivyBrcdMDao.updBrcdDlivy(vo);
								
								//수량만큼 반복한다.
								for(int j=1; j<=ceil; j++){
									//첫번째 바코드 객체
									barcode1Vo = new DlivyMVo();
									BeanUtils.copyProperties(vo, barcode1Vo);
									
									String resultSq = "";
									
									//지시서의 수량이 제품의 수량보다 적으면..
									if(intDlivyQy < Integer.valueOf(DvyfgMtrilsList.get(i).getCol3())){
										resultSq = String.valueOf(intDlivyQy);
									}
									else{
										if(j == 1){
											resultSq = DvyfgMtrilsList.get(i).getCol3();
											dlivyQy = dlivyQy  - Double.valueOf(DvyfgMtrilsList.get(i).getCol3());
										}
										else if(j == ceil){
											resultSq = String.valueOf((int)dlivyQy);
										}
										else{
											double tempqy = dbsq % dlivyQy;										
											dlivyQy = dlivyQy - tempqy;
											resultSq = String.valueOf((int)tempqy);
										}									
									}
									
									//바코드1 조합							
									barcode1 = DvyfgMtrilsList.get(i).getCol1() + "-"//자재코드
											 + vo.getRm()  + "-"//Batch No
											 + String.format("%05d", j+preDlivyQy)  + "-"//SQ
											 + String.format("%06d", Integer.valueOf(resultSq)) //제품 수량
											 ;
									//order 저장
									barcode1Vo.setOrdr(String.valueOf(j));
									//첫번째 바코드 저장
									barcode1Vo.setBrcd(barcode1);
									barcode1Vo.setRepr("1");
									if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
										barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
									}
									
									dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
								}
								
								//수량 업데이트, 갯수 검증여부
								vo.setDlivyQy(String.valueOf(ceil));
								vo.setVrifyAt("N");
								dlivyBrcdMDao.updBrcdDlivyQy(vo);
							}
						}
					}
					
					break;
				case "SY17000019": //2팀 동부하이텍 동부하이텍 (CSA-T07)
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						
						//총개수 저장
						vo.setTopRepr(1);
						dlivyBrcdMDao.updBrcdDlivy(vo);
						
						if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode)){
							
							qy = intDlivyQy / Integer.valueOf(DvyfgMtrilsList.get(i).getCol3());
							
							for(int j=0; j<qy; j++){
								barcode1 = DvyfgMtrilsList.get(i).getCol2()
										 + " "
										 + vo.getBatchNo()
										 + "-"
										 + String.format("%02d", j+1+preDlivyQy)
										 
										 ; 
								
								//첫번째 바코드 객체
								barcode1Vo = new DlivyMVo();
								BeanUtils.copyProperties(vo, barcode1Vo);
								
								//order 저장
								barcode1Vo.setOrdr(String.valueOf(j+1));
								//첫번째 바코드 저장
								barcode1Vo.setBrcd(barcode1);
								barcode1Vo.setRepr("1");
								if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
									barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
								}
								
								dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
							}
							//수량 업데이트, 갯수 검증여부
							vo.setDlivyQy(String.valueOf(qy));
							vo.setVrifyAt("N");
							dlivyBrcdMDao.updBrcdDlivyQy(vo);
						}
					}
					break;
				case "SY17000006": //2팀 페어차일드
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						

						//총개수 저장
						vo.setTopRepr(1);
						dlivyBrcdMDao.updBrcdDlivy(vo);
						
						//자재코드 비교
						//"고객 자재코드", "Item", "공통문자", "자재코드 규칙", "제품코드 규칙"
						if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode)){
														
							qy = intDlivyQy;
							
							String date = getMafdate(vo.getBatchNo(), "");
							
							barcode1 = DvyfgMtrilsList.get(i).getCol3()
									 + DvyfgMtrilsList.get(i).getCol4()
									 + vo.getBatchNo()
									 + date
									 ; 
							
							//첫번째 바코드 객체
							barcode1Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode1Vo);
							
							//order 저장
							barcode1Vo.setOrdr(String.valueOf(1));
							//첫번째 바코드 저장
							barcode1Vo.setBrcd(barcode1);
							barcode1Vo.setRepr("1");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
							}
							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
							
							//수량 업데이트, 갯수 검증여부
							vo.setDlivyQy(String.valueOf(qy));
							vo.setVrifyAt("N");
							dlivyBrcdMDao.updBrcdDlivyQy(vo);
						}
					}
					break;
				case "SY17000007": //2팀 SK실트론
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						
						//총개수 저장
						vo.setTopRepr(5);
						dlivyBrcdMDao.updBrcdDlivy(vo);
						
						//"고객 자재코드", "Item", "PART", "Q'ty"
						if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode)){
							
							qy = intDlivyQy;
							
							//첫번째 바코드 객체
							barcode1Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode1Vo);
							
							barcode2Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode2Vo);
							
							barcode3Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode3Vo);
							
							barcode4Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode4Vo);
							
							barcode5Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode5Vo);
							
							//바코드1 조합
							barcode1 = vo.getPoNo(); //po
							barcode2 = DvyfgMtrilsList.get(i).getCol3(); //PART
							barcode3 = "004"; //Q'ty
							barcode4 = "ENF"; //VENDOR
							barcode5 = vo.getBatchNo(); //lot id
							//order 저장
							barcode1Vo.setOrdr(String.valueOf(1));
							barcode2Vo.setOrdr(String.valueOf(1));
							barcode3Vo.setOrdr(String.valueOf(1));
 							barcode4Vo.setOrdr(String.valueOf(1));
							barcode5Vo.setOrdr(String.valueOf(1));
							//첫번째 바코드 저장
							barcode1Vo.setBrcd(barcode1);
							barcode1Vo.setRepr("1");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
							}							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
							//두번째 바코드 저장
							barcode2Vo.setBrcd(barcode2);
							barcode2Vo.setRepr("2");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode2Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
							}							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode2Vo);
							//세번째 바코드 저장
							barcode3Vo.setBrcd(barcode3);
							barcode3Vo.setRepr("3");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode3Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
							}							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode3Vo);
							//네번째 바코드 저장
							barcode4Vo.setBrcd(barcode4);
							barcode4Vo.setRepr("4");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode4Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
							}							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode4Vo);
							//다섯번째 바코드 저장
							barcode5Vo.setBrcd(barcode5);
							barcode5Vo.setRepr("5");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode5Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
							}							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode5Vo);
							
							//수량 업데이트, 갯수 검증여부
							vo.setDlivyQy(String.valueOf(qy));
							vo.setVrifyAt("N");
							dlivyBrcdMDao.updBrcdDlivyQy(vo);
						}
					}
					break;
				case "SY17000008": //2팀 LG디스플레이
					
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						//"고객 자재코드", "Item", "자리구분", "Maker", "Chemical"
						if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode)){
							
							//총개수 저장
							vo.setTopRepr(1);
							dlivyBrcdMDao.updBrcdDlivy(vo);
							
							qy = intDlivyQy/200;
							
							//바코드1 조합							
							barcode1 = DvyfgMtrilsList.get(i).getCol3() //자리구분(공통문자)
									 + DvyfgMtrilsList.get(i).getCol4() //Maker
									 + String.format("%02d", Integer.valueOf(DvyfgMtrilsList.get(i).getCol5())) //Chemical
									 + vo.getBatchNo() //Lot ID
									 ;
							
							//첫번째 바코드 객체
							barcode1Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode1Vo);	
							
							//order 저장
							barcode1Vo.setOrdr(String.valueOf(1));
							//첫번째 바코드 저장
							barcode1Vo.setBrcd(barcode1);
							barcode1Vo.setRepr("1");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
							}
							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
							
							//수량 업데이트, 갯수 검증여부
							vo.setDlivyQy(String.valueOf(qy));
							vo.setVrifyAt("N");
							dlivyBrcdMDao.updBrcdDlivyQy(vo);
							
							
						}
					}
					break;
				case "SY17000018": //제조2팀 솔브레인 MI(S-2)
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						String getBatchNo = "";
						//총개수 저장
						vo.setTopRepr(1);
						dlivyBrcdMDao.updBrcdDlivy(vo);
						
						//수량
						qy = intDlivyQy;
						
						for(int j=1; j<=qy; j++){

							//첫번째 바코드 객체
							barcode1Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode1Vo);	
							
							getBatchNo = vo.getBatchNo().substring(0, 4);
							
							if(getBatchNo.substring(0,1).equals("A")){
								getBatchNo = getBatchNo.replace(getBatchNo.substring(0,1), "0");
							}
							
							//바코드1 조합							
							barcode1 = DvyfgMtrilsList.get(i).getCol3() //vendor
									 + DvyfgMtrilsList.get(i).getCol4() //product
									 + DvyfgMtrilsList.get(i).getCol5() //grade
									 + vo.getBatchNo() //Lot Id
									 + String.format("%03d", j+preDlivyQy)
							         + getBatchNo
							         + DvyfgMtrilsList.get(i).getCol6() //Location
							         + DvyfgMtrilsList.get(i).getCol7() //Lifetime
									 ;
							
							
							//order 저장
							barcode1Vo.setOrdr(String.valueOf(j));
							//첫번째 바코드 저장
							barcode1Vo.setBrcd(barcode1);
							barcode1Vo.setRepr("1");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
							}
							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
						}
						
						//수량 업데이트, 갯수 검증여부
						vo.setDlivyQy(String.valueOf(qy));
						vo.setVrifyAt("N");
						dlivyBrcdMDao.updBrcdDlivyQy(vo);
					}
					break;
				case "SY17000005": //제조2팀 삼성디스플레이
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						
						//"고객 자재코드", "Item", "1차 생성", "2차 생성", "3차 생성", "4차 생성"
						if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode)){
							//총개수 저장
							vo.setTopRepr(2);
							dlivyBrcdMDao.updBrcdDlivy(vo);
							//수량
							qy = intDlivyQy ;
							
							// 수량의 길이 체크 4000 -> 4 , 10000 -> 5 수량길이에 따라 바코드가 변경됨
							int qylen = (int)(Math.log10(intDlivyQy)+1);
							// 풀날짜 ex) 20201119
							String _mDate = getMafdate(vo.getBatchNo(), "full");
							
							//수량만큼 반복한다.
							for(int j=1; j<=1; j++){
								//첫번째 바코드 객체
								barcode1Vo = new DlivyMVo();
								BeanUtils.copyProperties(vo, barcode1Vo);
								
								barcode2Vo = new DlivyMVo();
								BeanUtils.copyProperties(vo, barcode2Vo);
								
								
								barcode3Vo = new DlivyMVo();
								BeanUtils.copyProperties(vo, barcode3Vo);
								

								
								if(j == 1){		
									//바코드1 얘는 고정값
									barcode1 = "ETSH79$$$0204-007104";
									if(qylen == 4) {
										//나중에 독같은 형식으로 계속 추가되면  하드 코딩 한거 공통에다가 빼는게 좋을듯
										barcode1 += vo.getBatchNo()+ "$$$0001#S1@" + _mDate.substring(2) + "@" + qy + "$K@";
									} else if(qylen == 5) {
										barcode1 += vo.getBatchNo()+ "$$$0001#S1@" + _mDate.substring(2) + "@" + qy + "K@";	
									// 3이하는 없을거같은데 혹시 몰라 넣어봤음	
									} else if(qylen == 3) {
										barcode1 += vo.getBatchNo()+ "$$$0001#S1@" + _mDate.substring(2) + "@" + qy + "$$K@";
									} else if(qylen == 2) {
										barcode1 += vo.getBatchNo()+ "$$$0001#S1@" + _mDate.substring(2) + "@" + qy + "$$$K@";
									} else {
										barcode1 += vo.getBatchNo()+ "$$$0001#S1@" + _mDate.substring(2) + "@" + qy + "K@";
									}
								}
								
								//첫번째 바코드 저장
								barcode1Vo.setOrdr(String.valueOf(j));
								barcode1Vo.setBrcd(barcode1);
								barcode1Vo.setRepr("1");
								if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
									barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
								}
								
								dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);

							}

							barcode2 = "ETSH79$$$0204-007104";
							//첫번째 바코드 저장
							barcode2Vo.setOrdr(String.valueOf(1));
							barcode2Vo.setBrcd(barcode2);
							barcode2Vo.setRepr("2");
						
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode2Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
							}
							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode2Vo);
							
							//수량 업데이트, 갯수 검증여부
							vo.setDlivyQy(String.valueOf(qy));
							vo.setVrifyAt("N");
							dlivyBrcdMDao.updBrcdDlivyQy(vo);
						}
					}
			}
		}
		//제조3팀
		else if(vo.getInspctInsttCode().equals("3976")){
			switch(dvyfgEntrpsCode){
			case "SY17000001": //3팀 삼성 전자
				for(int i=0; i<DvyfgMtrilsList.size(); i++){
					ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();

					//총개수 저장
					vo.setTopRepr(1);
					dlivyBrcdMDao.updBrcdDlivy(vo);

					//"고객 자재코드", "Maker", "Produt", "제품명 코드", "Grade", "PLANT 정보", "Lifetime"
					if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode)){

						//첫번째 바코드 객체
						barcode1Vo = new DlivyMVo();
						BeanUtils.copyProperties(vo, barcode1Vo);							
						
						//수량
						qy = intDlivyQy;
						
						//YYYYMMDD
						String getBatchNo = "";
						
						//제조일보다 제품이 앞에오는 LOT일때
						if(vo.getBatchNo().indexOf("FH") != -1 || vo.getBatchNo().indexOf("FK") != -1 || vo.getBatchNo().indexOf("FP") != -1 || vo.getBatchNo().indexOf("FQ") != -1
								|| vo.getBatchNo().indexOf("FN") != -1){
							getBatchNo = vo.getBatchNo().substring(2, 6);
							
							if(getBatchNo.substring(0,1).equals("A")){ // 년도가 A면 A=20년도
								Calendar c = Calendar.getInstance(); 
								String ntime = new String();
								ntime = String.valueOf(c.get(Calendar.YEAR));
								// 해당년도 가장끝자리 1자 + 배치번호값 3자리
//								getBatchNo = ntime.substring(3)+getBatchNo.substring(1,4);
//								getBatchNo = getBatchNo.replace(getBatchNo.substring(0), "0"); 
								if(getBatchNo.substring(0,1).equals("A")) { // 년도가 A면 A=20년도
									getBatchNo ="0"+getBatchNo.substring(1,4); // A면 0으로 바꾸고 뒤 3자리
								}
							
								// 12-18일 추가 삼성
//								if(!ctmmnyMtrilCode.equals("0204-007297")) {

									if(getBatchNo.substring(1,2).equals("A")) {
										getBatchNo = "0"+"X"+vo.getBatchNo().substring(4, 6);
									}else if(getBatchNo.substring(1,2).equals("B")) {
										getBatchNo = "0"+"Y"+vo.getBatchNo().substring(4, 6);
									}else if(getBatchNo.substring(1,2).equals("C")){
										getBatchNo = "0"+"Z"+vo.getBatchNo().substring(4, 6);
									}
//								}
							}
							if(getBatchNo.substring(1,2).equals("A")) {
								getBatchNo = getBatchNo.substring(0,1)+"X"+vo.getBatchNo().substring(4, 6);
							}else if(getBatchNo.substring(1,2).equals("B")) {
								getBatchNo = getBatchNo.substring(0,1)+"Y"+vo.getBatchNo().substring(4, 6);
							}else if(getBatchNo.substring(1,2).equals("C")) {
								getBatchNo = getBatchNo.substring(0,1)+"Z"+vo.getBatchNo().substring(4, 6);
							}
						}
						else{
							getBatchNo = vo.getBatchNo();
							String _mDate = getMafdate(getBatchNo, "full");
							String y = _mDate.substring(3,4);
							String m = "";
							String d = _mDate.substring(6,8);
							
							d = String.format("%02d", Integer.valueOf(d));
							if(ctmmnyMtrilCode.equals("0204-005996")) {
								if(_mDate.substring(4,6).equals("10")){
									m = "X";
								}
								else if(_mDate.substring(4,6).equals("11")){
									m = "Y";
								}
								else if(_mDate.substring(4,6).equals("12")){
									m = "Z";
								}
								else{
									m = _mDate.substring(5,6);
								}
								
								getBatchNo = y + m + d;
							}else {
								if(_mDate.substring(4,6).equals("10")){
									m = "X";
								}
								else if(_mDate.substring(4,6).equals("11")){
									m = "Y";
								}
								else if(_mDate.substring(4,6).equals("12")){
									m = "Z";
								}
								else{
									m = _mDate.substring(5,6);
								}
								
								getBatchNo = y + m + d;
							}	
						}
						
						//수량만큼 반복한다.
						for(int j=1; j<=qy; j++){
														
							//바코드1 조합							
							barcode1 = DvyfgMtrilsList.get(i).getCol2() //마커
									 + DvyfgMtrilsList.get(i).getCol4() //제품명코드
									 + DvyfgMtrilsList.get(i).getCol5() //Grade
									 + vo.getBatchNo() + String.format("%03d", j+preDlivyQy)
									 + getBatchNo //제조일
									 + DvyfgMtrilsList.get(i).getCol6() //제조사위치 
									 + DvyfgMtrilsList.get(i).getCol7() //유효기간
									 ;
							//order 저장
							barcode1Vo.setOrdr(String.valueOf(j));
							//첫번째 바코드 저장
							barcode1Vo.setBrcd(barcode1);
							barcode1Vo.setRepr("1");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
							}
							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
						}
						
						//수량 업데이트, 갯수 검증여부
						vo.setDlivyQy(String.valueOf(qy));
						vo.setVrifyAt("Y");
						dlivyBrcdMDao.updBrcdDlivyQy(vo);
					}
				}
				break;
			case "SY17000002": //3팀 SK하이닉스
				
				//P/O No. 에 HIR이 앞에 있으면..
				if(vo.getPoNo().toUpperCase().indexOf("HIR") != -1){

					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();

						//총개수 저장
						vo.setTopRepr(1);
						dlivyBrcdMDao.updBrcdDlivy(vo);
						
						
						//"고객 자재코드", "Item", "용기", "1차 생성", "2차 생성", "3차 생성", "4차 생성", "갯수"
						//고객자재코드 , cnt가 1인것
						if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode) && Integer.valueOf(DvyfgMtrilsList.get(i).getCol8()) == 1){
							
							int num = 0;
						
							if(vo.getUnitNm().toUpperCase().equals("BT")){
								num = intDlivyQy;	
							}
							else{	
								num = intDlivyQy / Integer.valueOf(DvyfgMtrilsList.get(i).getCol4());
							}
													  
							
							//첫번째 바코드 객체
							barcode1Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode1Vo);
							
							//고객자재코드 + 8자리 LOT + 000 + (수량/1차 생성)
							for(int j=1; j<=num; j++){
								// 21-01-14 하이닉스에서 얘만 또 따로 바뀌고 추후에 전체다 바뀐다함 // 2줄바코드는 기존 유지
								if(DvyfgMtrilsList.get(i).getCol1().equals("R3165602")) {
									barcode1 = DvyfgMtrilsList.get(i).getCol1() + vo.getBatchNo() + " " +String.format("%02d", j+preDlivyQy);			
								} else {
									barcode1 = DvyfgMtrilsList.get(i).getCol1() + vo.getBatchNo() + String.format("%02d", j+preDlivyQy) + " ";									
								}


								//첫번째 바코드 저장(제품자재코드)
								barcode1Vo.setBrcd(barcode1);
								barcode1Vo.setRepr("1");
								barcode1Vo.setOrdr(String.valueOf(j));
								if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
									barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
								}
								
								dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
							}
							
							//수량 업데이트, 갯수 검증여부
							vo.setDlivyQy(String.valueOf(num));
							vo.setVrifyAt("Y");

							dlivyBrcdMDao.updBrcdDlivyQy(vo);
							
						}
					}
				}
				else{
					//서브로 생성되는 제품이 있으면 저장해놓고 서브 제품이 오면 컨티뉴 함
					String ctmmnyCntCode = "";
					
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						
						if(ctmmnyCntCode.equals(ctmmnyMtrilCode) && Integer.valueOf(DvyfgMtrilsList.get(i).getCol8()) == 1){
							continue;
						}
						
						//고객자재코드 비교
						if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode)){
							
							int cnt = 4;
							//같은 고객자재코드, 같은 용기이면 서브를 찾아서 생성
 							if(Integer.valueOf(DvyfgMtrilsList.get(i).getCol8()) > 1){
								cnt = cnt * Integer.valueOf(DvyfgMtrilsList.get(i).getCol8());
								ctmmnyCntCode = ctmmnyMtrilCode;
							}
							
							//총개수 저장
							vo.setTopRepr(2);							
							dlivyBrcdMDao.updBrcdDlivy(vo);
							
							//드럼일때
							if(DvyfgMtrilsList.get(i).getCol3().equals("DRUM")){
								int order = 1;
								for(int j=0; j<cnt/4; j++){
									
									for(int x=1; x<=4; x++){
										
										barcode1Vo = new DlivyMVo();
										BeanUtils.copyProperties(vo, barcode1Vo);
										
										barcode1 = vo.getCtmmnyMtrilCode();
										
										//첫번째 바코드 저장
										barcode1Vo.setBrcd(barcode1);
										barcode1Vo.setRepr("1");
										barcode1Vo.setOrdr(String.valueOf(order));
										if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
											barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
										}
										
										dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
										
										//두번째 바코드 저장
										barcode2Vo = new DlivyMVo();
										BeanUtils.copyProperties(vo, barcode2Vo);
										
										//바코드1 조합
										if(x == 1){											// getCol4 = 1차생성
											barcode2 = String.format("%05d", Integer.valueOf(DvyfgMtrilsList.get(i+j).getCol4())) + " " + vo.getBatchNo();
										}
										else if(x == 2){									// getCol5 = 2차생성
											barcode2 = String.format("%05d", Integer.valueOf(DvyfgMtrilsList.get(i+j).getCol5())) + " " +  vo.getBatchNo();
										}
										else if(x == 3){ 									// getCol6 = 3차생성
											barcode2 = String.format("%05d", Integer.valueOf(DvyfgMtrilsList.get(i+j).getCol6())) + " " +  vo.getBatchNo();
										}
										else if(x == 4){
										// 모든 드럼 제품 4차값은 계산 맥스4
											int sub4 = intDlivyQy  / Integer.valueOf(DvyfgMtrilsList.get(i+j).getCol4());
											if(sub4 > 4) {
												barcode2 = String.format("%05d", 4) + " " +  vo.getBatchNo();
											}else {
												barcode2 = String.format("%05d", sub4) + " " +  vo.getBatchNo();												
											}
											
//											barcode2 = String.format("%05d", Integer.valueOf(DvyfgMtrilsList.get(i+j).getCol7())) + " " +  vo.getBatchNo();
										}

										
										//order 저장
										barcode2Vo.setOrdr(String.valueOf(order));
										//첫번째 바코드 저장
										barcode2Vo.setBrcd(barcode2);
										barcode2Vo.setRepr("2");
										if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
											barcode2Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
										}
										
										dlivyBrcdMDao.insDlivyBrcdDetail(barcode2Vo);
										order++;
									}
								}
								
								//수량 업데이트, 갯수 검증여부
								vo.setDlivyQy(String.valueOf(cnt/4));
								vo.setVrifyAt("N");
								dlivyBrcdMDao.updBrcdDlivyQy(vo);
							}
							//보틀일때
							else{
								int order = 1;
								for(int j=0; j<cnt/4; j++){
									for(int x=1; x<=5; x++){
										
										barcode1Vo = new DlivyMVo();
										BeanUtils.copyProperties(vo, barcode1Vo);
										barcode1 = vo.getCtmmnyMtrilCode();
										
										//첫번째 바코드 저장
										barcode1Vo.setBrcd(barcode1);
										barcode1Vo.setRepr("1");
										barcode1Vo.setOrdr(String.valueOf(order));
										if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
											barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
										}
										
										dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
										
										barcode2Vo = new DlivyMVo();
										BeanUtils.copyProperties(vo, barcode2Vo);
										
										//바코드1 조합
										if(x == 1){
											barcode2 = String.format("%05d", Integer.valueOf(DvyfgMtrilsList.get(i+j).getCol4())) + " " +  vo.getBatchNo();
										}
										else if(x == 2){
											barcode2 = String.format("%05d", intDlivyQy ) + " " +  vo.getBatchNo();
										}
										else if(x == 3){
											barcode2 = String.format("%05d", Integer.valueOf(DvyfgMtrilsList.get(i+j).getCol6())) + " " +  vo.getBatchNo();
										}
										else if(x == 4){
											barcode2 = String.format("%05d", Integer.valueOf(DvyfgMtrilsList.get(i+j).getCol7())) + " " +  vo.getBatchNo();
										}
										// 이렇게하면 모든 보틀 제품은 다 수정됨
										else if(x == 5){
											// 5차는 계산 엑셀 수량값 / 1차생성
											int sub5 = intDlivyQy  / Integer.valueOf(DvyfgMtrilsList.get(i+j).getCol4());
												// 4보다 작으면 계산값으로
												barcode2 = String.format("%05d", sub5) + " " +  vo.getBatchNo();												
											
											
										}

										
										//두번째 바코드 저장
										barcode2Vo.setBrcd(barcode2);
										barcode2Vo.setRepr("2");
										barcode2Vo.setOrdr(String.valueOf(order));
										if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
											barcode2Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
										}
										
										dlivyBrcdMDao.insDlivyBrcdDetail(barcode2Vo);
										order++;
									}
								}
								
								//수량 업데이트, 갯수 검증여부
								vo.setDlivyQy(String.valueOf(cnt/4));
								vo.setVrifyAt("N");
								dlivyBrcdMDao.updBrcdDlivyQy(vo);
							}
							
						}
					}
				}
				
				break;
			case "SY17000003": //제조 3팀 동부하이텍
				for(int i=0; i<DvyfgMtrilsList.size(); i++){
					ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
					
					//"고객 자재코드", "Item", "SQ"
					if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode)){
						//지시서의 수량
						double dlivyQy = Integer.valueOf(vo.getDlivyQy());
						//제품의 수량 
						double dbsq = Integer.valueOf(DvyfgMtrilsList.get(i).getCol3());
						
						//지시서 수량 나누기 제품 수량
						double dbqy = dlivyQy / dbsq;
						//올림처리해서 루프돌림
						int ceil = (int) Math.ceil(dbqy);
						

						//총개수 저장
						vo.setTopRepr(1);
						dlivyBrcdMDao.updBrcdDlivy(vo);
						
						//수량만큼 반복한다.
						for(int j=1; j<=ceil; j++){
							//첫번째 바코드 객체
							barcode1Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode1Vo);
							
							int resultSq = Integer.valueOf(DvyfgMtrilsList.get(i).getCol3());
							
							//지시서의 수량이 제품의 수량보다 적으면..
							if(Integer.valueOf(vo.getDlivyQy()) < Integer.valueOf(DvyfgMtrilsList.get(i).getCol3())){
								resultSq = Integer.valueOf(vo.getDlivyQy());
							}
							else{
								if(j == 1){
									resultSq = Integer.valueOf(DvyfgMtrilsList.get(i).getCol3());
									dlivyQy = dlivyQy  - Double.valueOf(DvyfgMtrilsList.get(i).getCol3());
								}
								else if(j == ceil){
									resultSq = (int)dlivyQy;
								}
								else{
									double tempqy = dbsq % dlivyQy;										
									dlivyQy = dlivyQy - tempqy;
									resultSq = (int)tempqy;
								}									
							}
							
							//바코드1 조합							
							barcode1 = DvyfgMtrilsList.get(i).getCol1() + "-"//자재코드
									 + vo.getRm()  + "-"//Batch No
									 + String.format("%05d", j)  + "-"//SQ
									 + String.format("%06d", resultSq) //제품 수량
									 ;
							//order 저장
							barcode1Vo.setOrdr(String.valueOf(j));
							//첫번째 바코드 저장
							barcode1Vo.setBrcd(barcode1);
							barcode1Vo.setRepr("1");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
							}
							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
						}
						
						//수량 업데이트, 갯수 검증여부
						vo.setDlivyQy(String.valueOf(ceil));
						vo.setVrifyAt("N");
						dlivyBrcdMDao.updBrcdDlivyQy(vo);
					}
				}
				
				break;
			}
		}
		else if(vo.getInspctInsttCode().equals("3980")){ //FECT
			switch(dvyfgEntrpsCode){
				case "SY17000001": //훽트 삼성 전자
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						//"고객 자재코드", "Maker", "Item", "제품명 코드", "Grade", "제조사 위치", "유효기간"
						if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode)){

							//첫번째 바코드 객체
							barcode1Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode1Vo);							
							
							//수량
							qy = intDlivyQy;
							
							//YYYYMMDD
							String _mDate = getMafdate(vo.getBatchNo(), "full");
							String y = _mDate.substring(3,4);
							String m = "";
							String d = _mDate.substring(6,8);
							d = String.format("%02d", Integer.valueOf(d));
							
							if(_mDate.substring(4,6).equals("10")){
								m = "X";
							}
							else if(_mDate.substring(4,6).equals("11")){
								m = "Y";
							}
							else if(_mDate.substring(4,6).equals("12")){
								m = "Z";
							}
							else{
								m = _mDate.substring(5,6);
							}
							
							//총개수 저장
							vo.setTopRepr(1);
							dlivyBrcdMDao.updBrcdDlivy(vo);
							
							// DvyfgMtrilsList.get(i).getCol8()에 DRUM인지 TL인지 구분값 넣고 조건걸어서 TL이면 001로 고정 시키면 될거같음
							if(DvyfgMtrilsList.get(i).getCol8().equals("TL")) {
								//수량만큼 반복한다.
								for(int j=1; j<=1; j++){
																
									//바코드1 조합							
									barcode1 = DvyfgMtrilsList.get(i).getCol2() //마커
											 + DvyfgMtrilsList.get(i).getCol4() //제품명코드
											 + DvyfgMtrilsList.get(i).getCol5() //Grade
											 + vo.getBatchNo() + String.format("%03d", 001 )
											 + y + m + d //제조일
											 + DvyfgMtrilsList.get(i).getCol6() //제조사위치 
											 + DvyfgMtrilsList.get(i).getCol7() //유효기간
											 ;
									//order 저장
									barcode1Vo.setOrdr(String.valueOf(j));
									//첫번째 바코드 저장
									barcode1Vo.setBrcd(barcode1);
									barcode1Vo.setRepr("1");
									if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
										barcode1Vo.setVrifyQy(Integer.valueOf(1)); //검증할 횟수
									}
									
									dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
								}
							} else {
								//수량만큼 반복한다.
								for(int j=1; j<=qy; j++){
																
									//바코드1 조합							
									barcode1 = DvyfgMtrilsList.get(i).getCol2() //마커
											 + DvyfgMtrilsList.get(i).getCol4() //제품명코드
											 + DvyfgMtrilsList.get(i).getCol5() //Grade
											 + vo.getBatchNo() + String.format("%03d", j+preDlivyQy )
											 + y + m + d //제조일
											 + DvyfgMtrilsList.get(i).getCol6() //제조사위치 
											 + DvyfgMtrilsList.get(i).getCol7() //유효기간
											 ;
									//order 저장
									barcode1Vo.setOrdr(String.valueOf(j));
									//첫번째 바코드 저장
									barcode1Vo.setBrcd(barcode1);
									barcode1Vo.setRepr("1");
									if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
										barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
									}
									
									dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
								}
							}
							
							//수량 업데이트, 갯수 검증여부
							vo.setDlivyQy(String.valueOf(qy));
							vo.setVrifyAt("Y");
							dlivyBrcdMDao.updBrcdDlivyQy(vo);
						}
					}
					
					break;
				case "SY17000002": //훽트 SK하이닉스
					/**********2팀과 동일하게 함***********/
					//수량 저장
					qy = intDlivyQy;			
					
					
					//첫번째 바코드 객체
					barcode1Vo = new DlivyMVo();
					BeanUtils.copyProperties(vo, barcode1Vo);
					
					barcode2Vo = new DlivyMVo();
					BeanUtils.copyProperties(vo, barcode2Vo);
					
					barcode3Vo = new DlivyMVo();
					BeanUtils.copyProperties(vo, barcode3Vo);
					
					barcode4Vo = new DlivyMVo();
					BeanUtils.copyProperties(vo, barcode4Vo);
					
					barcode5Vo = new DlivyMVo();
					BeanUtils.copyProperties(vo, barcode5Vo);
					
//					//총개수 저장
//					vo.setTopRepr(2);
//					dlivyBrcdMDao.updBrcdDlivy(vo);
					
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						
						//"고객 자재코드", "Item", "1차 생성", "2차 생성", "3차 생성", "4차 생성"
						if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode)){
							//수량
							qy = intDlivyQy ;
							int totCnt=0;
							if(DvyfgMtrilsList.get(i).getCol7().equals("TL")) {
								totCnt = 2;
							} else {
								totCnt = 4;
							}
							
							if(DvyfgMtrilsList.get(i).getCol7().equals("TL")) {
								if(DvyfgMtrilsList.get(i).getCol1().equals("R1238216")) {
									//총개수 저장
									vo.setTopRepr(3);
									dlivyBrcdMDao.updBrcdDlivy(vo);
									//수량만큼 반복한다.
									for(int j=1; j<=totCnt; j++){
										//바코드2
										barcode1 = vo.getCtmmnyMtrilCode();
										
										//첫번째 바코드 저장
										barcode1Vo.setOrdr(String.valueOf(j));
										barcode1Vo.setBrcd(barcode1);
										barcode1Vo.setRepr("1");
										if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
											barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
										}
										
										if(DvyfgMtrilsList.get(i).getCol1().equals("R1238216")) {
											if(j == 1) {
												dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);	
											}
										} else {
											dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);									
										}

										//바코드2 조합
										if(DvyfgMtrilsList.get(i).getCol1().equals("R1238216")) {

											if(j == 1){
												barcode2 = DvyfgMtrilsList.get(i).getCol3() + " " + vo.getBatchNo();
												//order 저장
												barcode2Vo.setOrdr(String.valueOf(j));
												//두번째 바코드 저장
												barcode2Vo.setBrcd(barcode2);
												barcode2Vo.setRepr("2");
											}else if(j == 2){
												barcode2 = "R1238216AY04UA1H000 01 ";
												//order 저장
												barcode2Vo.setOrdr(String.valueOf(1));
												//두번째 바코드 저장
												barcode2Vo.setBrcd(barcode2);
												barcode2Vo.setRepr("3");
											}

											
										}
										
										if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
											barcode2Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
										}
										
										dlivyBrcdMDao.insDlivyBrcdDetail(barcode2Vo);

									}
								 
								
								}	
								
								else {
									//총개수 저장
									vo.setTopRepr(1);
									dlivyBrcdMDao.updBrcdDlivy(vo);
									for(int j=1; j<=1; j++){
										
										//바코드1 조합	
										if(DvyfgMtrilsList.get(i).getCol1().equals("R0000000")) {
											barcode3 = "R1238216" // 고객자재코드
													 + vo.getBatchNo()
													 + "000"
													 + " " 
													 + "01"
													 ;
										} else {
											barcode3 = DvyfgMtrilsList.get(i).getCol1() // 고객자재코드
													 + vo.getBatchNo()
													 + "000"
													 + " " 
													 + "01"
													 ;
										}
										//order 저장
										barcode3Vo.setOrdr(String.valueOf(j));
										//첫번째 바코드 저장
										barcode3Vo.setBrcd(barcode3);
										barcode3Vo.setRepr("1");
										if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
											barcode3Vo.setVrifyQy(Integer.valueOf(qy)); //검증할 횟수
										}
										
										dlivyBrcdMDao.insDlivyBrcdDetail(barcode3Vo);
										
									}
								}
							} 
							
							else {
								//수량만큼 반복한다.
								for(int j=1; j<=totCnt; j++){
									//바코드2
									barcode1 = vo.getCtmmnyMtrilCode();
									
									//첫번째 바코드 저장
									barcode1Vo.setOrdr(String.valueOf(j));
									barcode1Vo.setBrcd(barcode1);
									barcode1Vo.setRepr("1");
									if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
										barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
									}
										dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);	

										//총개수 저장
										vo.setTopRepr(2);
										dlivyBrcdMDao.updBrcdDlivy(vo);	
									
									
									if(j == 1){
										barcode2 = DvyfgMtrilsList.get(i).getCol3() + " " + vo.getBatchNo();
									}
									else if(j == 2){
										barcode2 = DvyfgMtrilsList.get(i).getCol4() + " " + vo.getBatchNo();
									}
									else if(j == 3){
										barcode2 = DvyfgMtrilsList.get(i).getCol5() + " " + vo.getBatchNo();
									}
									else if(j == 4){
										barcode2 = DvyfgMtrilsList.get(i).getCol6() + " " + vo.getBatchNo();
									}
									
									
									
									//order 저장
									barcode2Vo.setOrdr(String.valueOf(j));
									//두번째 바코드 저장
									barcode2Vo.setBrcd(barcode2);
									barcode2Vo.setRepr("2");
									
									
									if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
										barcode2Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
									}
									
									dlivyBrcdMDao.insDlivyBrcdDetail(barcode2Vo);
									
									
									
									
								}
							}
//							//수량만큼 반복한다.
//							for(int j=1; j<=totCnt; j++){
//								//바코드2
//								barcode1 = vo.getCtmmnyMtrilCode();
//								
//								//첫번째 바코드 저장
//								barcode1Vo.setOrdr(String.valueOf(j));
//								barcode1Vo.setBrcd(barcode1);
//								barcode1Vo.setRepr("1");
//								if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
//									barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
//								}
//								if(DvyfgMtrilsList.get(i).getCol1().equals("R1238216")) {
//									if(j == 1) {
//										dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);	
//									}
//								} else {
//									dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);									
//								}
//
//								//바코드2 조합
//								if(DvyfgMtrilsList.get(i).getCol1().equals("R1238216")) {
//									//총개수 저장
//									vo.setTopRepr(3);
//									dlivyBrcdMDao.updBrcdDlivy(vo);
//									if(j == 1){
//										barcode2 = DvyfgMtrilsList.get(i).getCol3() + " " + vo.getBatchNo();
//										//order 저장
//										barcode2Vo.setOrdr(String.valueOf(j));
//										//두번째 바코드 저장
//										barcode2Vo.setBrcd(barcode2);
//										barcode2Vo.setRepr("2");
//									}else if(j == 2){
//										barcode2 = "R1238216AY04UA1H000 01 ";
//										//order 저장
//										barcode2Vo.setOrdr(String.valueOf(1));
//										//두번째 바코드 저장
//										barcode2Vo.setBrcd(barcode2);
//										barcode2Vo.setRepr("3");
//									}
//
//									
//								} else {
//									//총개수 저장
//									vo.setTopRepr(2);
//									dlivyBrcdMDao.updBrcdDlivy(vo);	
//								
//								
//								
//								if(j == 1){
//									barcode2 = DvyfgMtrilsList.get(i).getCol3() + " " + vo.getBatchNo();
//								}
//								else if(j == 2){
//									barcode2 = DvyfgMtrilsList.get(i).getCol4() + " " + vo.getBatchNo();
//								}
//								else if(j == 3){
//									barcode2 = DvyfgMtrilsList.get(i).getCol5() + " " + vo.getBatchNo();
//								}
//								else if(j == 4){
//									barcode2 = DvyfgMtrilsList.get(i).getCol6() + " " + vo.getBatchNo();
//								}
//								
//								
//								
//								//order 저장
//								barcode2Vo.setOrdr(String.valueOf(j));
//								//두번째 바코드 저장
//								barcode2Vo.setBrcd(barcode2);
//								barcode2Vo.setRepr("2");
//								}
//								
//								if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
//									barcode2Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
//								}
//								
//								dlivyBrcdMDao.insDlivyBrcdDetail(barcode2Vo);
//								
//								
//								
//								
//							}
							
							//수량 업데이트, 갯수 검증여부
							vo.setDlivyQy(String.valueOf(qy));
							vo.setVrifyAt("N");
							dlivyBrcdMDao.updBrcdDlivyQy(vo);
						}
					  
					}					
					break;
				case "SY17000003": //훽트 동부하이텍
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						
						//"고객 자재코드", "Item", "SQ"
						if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode)){

							//지시서의 수량
							double dlivyQy = Double.valueOf(vo.getDlivyQy());
							//제품의 수량 
							double dbsq = Double.valueOf(DvyfgMtrilsList.get(i).getCol3());
							
							//지시서 수량 나누기 제품 수량
							double dbqy = dlivyQy / dbsq;
							//올림처리해서 루프돌림
							int ceil = (int) Math.ceil(dbqy);							
							

							//총개수 저장
							vo.setTopRepr(1);
							dlivyBrcdMDao.updBrcdDlivy(vo);
							
							//수량만큼 반복한다.
							for(int j=1; j<=ceil; j++){
								//첫번째 바코드 객체
								barcode1Vo = new DlivyMVo();
								BeanUtils.copyProperties(vo, barcode1Vo);
								
								int resultSq = Integer.valueOf(DvyfgMtrilsList.get(i).getCol3());
								
								//지시서의 수량이 제품의 수량보다 적으면..
								if(Double.valueOf(vo.getDlivyQy()) < Integer.valueOf(DvyfgMtrilsList.get(i).getCol3())){
									resultSq = intDlivyQy;
								}
								else{
									if(j == 1){
										resultSq = Integer.valueOf(DvyfgMtrilsList.get(i).getCol3());
										dlivyQy = dlivyQy  - Double.valueOf(DvyfgMtrilsList.get(i).getCol3());
									}
									else if(j == ceil){
										resultSq = (int)dlivyQy;
									}
									else{
										double tempqy = dbsq % dlivyQy;										
										dlivyQy = dlivyQy - tempqy;
										resultSq = (int)tempqy;
									}									
								}
								
								//바코드1 조합							
								barcode1 = DvyfgMtrilsList.get(i).getCol1() + "-"//자재코드
										 + vo.getRm()  + "-"//Batch No
										 + String.format("%05d", j )  + "-"//SQ
										 + String.format("%06d", resultSq) //제품 수량
										 ;
								//order 저장
								barcode1Vo.setOrdr(String.valueOf(j));
								//첫번째 바코드 저장
								barcode1Vo.setBrcd(barcode1);
								barcode1Vo.setRepr("1");
								if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
									barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
								}
								
								dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
							}
							
							//수량 업데이트, 갯수 검증여부
							vo.setDlivyQy(String.valueOf(ceil));
							vo.setVrifyAt("N");
							dlivyBrcdMDao.updBrcdDlivyQy(vo);
						}
					}
					break;	
				case "SY17000005": //훽트 삼성디스플레이
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						
						//"고객 자재코드", "Item", "1차 생성", "2차 생성", "3차 생성", "4차 생성"
						if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode)){
							if(DvyfgMtrilsList.get(i).getCol1().equals("S020-068301")) {
								//총개수 저장 (기흥이면2)
								vo.setTopRepr(2);
								dlivyBrcdMDao.updBrcdDlivy(vo);
							} else {
								//총개수 저장
								vo.setTopRepr(2);
								dlivyBrcdMDao.updBrcdDlivy(vo);
							}

							//수량
							qy = intDlivyQy ;
	
							// 수량의 길이 체크 4000 -> 4 , 10000 -> 5 수량길이에 따라 바코드가 변경됨
							int qylen = (int)(Math.log10(intDlivyQy)+1);
							
							// 풀날짜 ex) 20201119
							String _mDate = getMafdate(vo.getBatchNo(), "full");
							
							//수량만큼 반복한다.
							for(int j=1; j<=1; j++){
								//첫번째 바코드 객체
								barcode1Vo = new DlivyMVo();
								BeanUtils.copyProperties(vo, barcode1Vo);
								
								barcode2Vo = new DlivyMVo();
								BeanUtils.copyProperties(vo, barcode2Vo);
								
								barcode3Vo = new DlivyMVo();
								BeanUtils.copyProperties(vo, barcode3Vo);
								
								if(DvyfgMtrilsList.get(i).getCol1().equals("S020-068301")) {
									//바코드1 얘는 고정값 기흥
									barcode1 = DvyfgMtrilsList.get(i).getCol2();									
								} else {
									// SDC
									barcode1 = DvyfgMtrilsList.get(i).getCol2()+vo.getBatchNo();
									if(j == 1){					
									if(DvyfgMtrilsList.get(i).getCol1().equals("S020-068301")) {
										// 기흥
										barcode2 = _mDate.substring(2) + vo.getBatchNo() + "***0001";										
									} else {
										// SDC 나중에 독같은 형식으로 계속 추가되면  하드 코딩 한거 공통에다가 빼는게 좋을듯
										if(qylen == 4) {
											barcode1 += "$$$0001#S1@"+ _mDate.substring(2) + "@" + qy + "$K@";		
										} else if(qylen == 5) {
											barcode1 += "$$$0001#S1@"+ _mDate.substring(2) + "@" + qy + "K@";		
										// 3이하는 없을거같은데 혹시 몰라 넣어봤음	
										} else if(qylen == 3) {
											barcode1 += "$$$0001#S1@"+ _mDate.substring(2) + "@" + qy + "$$K@";		
										} else if(qylen == 2) {
											barcode1 += "$$$0001#S1@"+ _mDate.substring(2) + "@" + qy + "$$$K@";		
										} else {
											barcode1 += "$$$0001#S1@"+ _mDate.substring(2) + "@" + qy + "K@";
										}
											
									}
								}
								}
								
								//첫번째 바코드 저장
								barcode1Vo.setOrdr(String.valueOf(j));
								barcode1Vo.setBrcd(barcode1);
								barcode1Vo.setRepr("1");
								if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
									barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
								}
								
								dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
					

								//바코드2 조합
//								if(j == 1){					
//									if(DvyfgMtrilsList.get(i).getCol1().equals("S020-068301")) {
//										// 기흥
//										barcode2 = _mDate.substring(2) + vo.getBatchNo() + "***0001";										
//									} else {
//										// SDC 나중에 독같은 형식으로 계속 추가되면  하드 코딩 한거 공통에다가 빼는게 좋을듯
//										if(qylen == 4) {
//											barcode2 = "$$$0001#S1@"+ _mDate.substring(2) + "@" + qy + "$K@";		
//										} else if(qylen == 5) {
//											barcode2 = "$$$0001#S1@"+ _mDate.substring(2) + "@" + qy + "K@";		
//										// 3이하는 없을거같은데 혹시 몰라 넣어봤음	
//										} else if(qylen == 3) {
//											barcode2 = "$$$0001#S1@"+ _mDate.substring(2) + "@" + qy + "$$K@";		
//										} else if(qylen == 2) {
//											barcode2 = "$$$0001#S1@"+ _mDate.substring(2) + "@" + qy + "$$$K@";		
//										} else {
//											barcode2 = "$$$0001#S1@"+ _mDate.substring(2) + "@" + qy + "K@";
//										}
//											
//									}
//								}
//								
//								//order 저장
//								barcode2Vo.setOrdr(String.valueOf(j));
//								//두번째 바코드 저장
//								barcode2Vo.setBrcd(barcode2);
//								barcode2Vo.setRepr("2");
//								if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
//									barcode2Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
//								}
//								
//								dlivyBrcdMDao.insDlivyBrcdDetail(barcode2Vo);

							}
							
//							 탕정이면 3줄, 기흥이면2줄 탕정이어서 1줄 더 추가
							if(DvyfgMtrilsList.get(i).getCol1().equals("0204-004961")) {
								barcode2 = DvyfgMtrilsList.get(i).getCol2();
								//첫번째 바코드 저장
								barcode2Vo.setOrdr(String.valueOf(1));
								barcode2Vo.setBrcd(barcode2);
								barcode2Vo.setRepr("2");

								if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
									barcode2Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
								}
								
								dlivyBrcdMDao.insDlivyBrcdDetail(barcode2Vo);
							} else {
								barcode2 = _mDate.substring(2) + vo.getBatchNo() + "***0001";	
								barcode2Vo.setOrdr(String.valueOf(1));
								barcode2Vo.setBrcd(barcode2);
								barcode2Vo.setRepr("2");

								if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
									barcode2Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
								}
								
								dlivyBrcdMDao.insDlivyBrcdDetail(barcode2Vo);
							}
							

							
							//수량 업데이트, 갯수 검증여부
							vo.setDlivyQy(String.valueOf(qy));
							vo.setVrifyAt("N");
							dlivyBrcdMDao.updBrcdDlivyQy(vo);
						}
					}
					break;
				case "SY17000007": //훽트 SK실트론
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						
						//총개수 저장
						vo.setTopRepr(5);
						dlivyBrcdMDao.updBrcdDlivy(vo);
						
						//"고객 자재코드", "Item", "PART", "Q'ty"
						if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode)){

							//첫번째 바코드 객체
							barcode1Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode1Vo);
							
							barcode2Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode2Vo);
							
							barcode3Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode3Vo);
							
							barcode4Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode4Vo);
							
							barcode5Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode5Vo);
							
							//바코드1 조합
							barcode1 = vo.getPoNo(); //po
							barcode2 = DvyfgMtrilsList.get(i).getCol3(); //PART
							barcode3 = "004"; //Q'ty
							barcode4 = "ENF"; //VENDOR
							barcode5 = vo.getBatchNo(); //lot id
							//order 저장
							barcode1Vo.setOrdr(String.valueOf(1));
							barcode2Vo.setOrdr(String.valueOf(1));
							barcode3Vo.setOrdr(String.valueOf(1));
 							barcode4Vo.setOrdr(String.valueOf(1));
							barcode5Vo.setOrdr(String.valueOf(1));
							//첫번째 바코드 저장
							barcode1Vo.setBrcd(barcode1);
							barcode1Vo.setRepr("1");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
							}
							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
							//두번째 바코드 저장
							barcode2Vo.setBrcd(barcode2);
							barcode2Vo.setRepr("2");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode2Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
							}
							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode2Vo);
							//세번째 바코드 저장
							barcode3Vo.setBrcd(barcode3);
							barcode3Vo.setRepr("3");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode3Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
							}
							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode3Vo);
							//네번째 바코드 저장
							barcode4Vo.setBrcd(barcode4);
							barcode4Vo.setRepr("4");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode4Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
							}
							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode4Vo);
							//다섯번째 바코드 저장
							barcode5Vo.setBrcd(barcode5);
							barcode5Vo.setRepr("5");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode5Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
							}
							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode5Vo);
						}
						
						//수량 업데이트, 갯수 검증여부
						vo.setDlivyQy(String.valueOf(intDlivyQy));
						vo.setVrifyAt("N");
						dlivyBrcdMDao.updBrcdDlivyQy(vo);
					}
					break;
					//훽트 에이텍솔류션
				case "SY17000014" :
					int cnt14 = 1;
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						
						//"고객 자재코드", "Maker", "Item", "제품명 코드", "Grade", "제조사 위치", "유효기간"
						if(vo.getMtrilCode().equals(ctmmnyMtrilCode)){
							
							//수량
							qy = intDlivyQy;
							
							//YYYYMMDD
							String _mDate = getMafdate(vo.getBatchNo(), "full");
							String y = _mDate.substring(3,4);
							String m = "";
							String d = _mDate.substring(6,8);
							d = String.format("%02d", Integer.valueOf(d));
							
							if(_mDate.substring(4,6).equals("10")){
								m = "X";
							}
							else if(_mDate.substring(4,6).equals("11")){
								m = "Y";
							}
							else if(_mDate.substring(4,6).equals("12")){
								m = "Z";
							}
							else{
								m = _mDate.substring(5,6);
							}
							
							//총개수 저장
							vo.setTopRepr(1);
							dlivyBrcdMDao.updBrcdDlivy(vo);
							
							//수량만큼 반복한다.
							for(int j=1; j<=qy; j++){

								//첫번째 바코드 객체
								barcode1Vo = new DlivyMVo();
								BeanUtils.copyProperties(vo, barcode1Vo);
								
								//바코드1 조합							
								barcode1 = DvyfgMtrilsList.get(i).getCol2() //마커
										 + DvyfgMtrilsList.get(i).getCol4() //제품명코드
										 + DvyfgMtrilsList.get(i).getCol5() //Grade
										 + vo.getBatchNo() + String.format("%03d", j+preDlivyQy)
										 + y + m + d //제조일
										 + DvyfgMtrilsList.get(i).getCol6() //제조사위치 
										 + DvyfgMtrilsList.get(i).getCol7() //유효기간
										 ;
								//order 저장
								barcode1Vo.setOrdr(String.valueOf(cnt14));
								//첫번째 바코드 저장
								barcode1Vo.setBrcd(barcode1);
								barcode1Vo.setRepr(String.valueOf(1));
								if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
									barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
								}
								
								dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
								cnt14++;
							}
							
							//수량 업데이트, 갯수 검증여부
							vo.setDlivyQy(String.valueOf(qy));
							vo.setVrifyAt("Y");
							dlivyBrcdMDao.updBrcdDlivyQy(vo);
						}
					}
					
					break;
				//훽트 원익큐엔씨 
				case "SY17000015" :
					int cnt15 = 1;
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						
						if(vo.getMtrilCode().equals(ctmmnyMtrilCode)){			
							
							//수량
//							qy = intDlivyQy / 880;
							qy = intDlivyQy;
							
							//YYYYMMDD
							String _mDate = getMafdate(vo.getBatchNo(), "full");
							String y = _mDate.substring(3,4);
							String m = "";
							String d = _mDate.substring(6,8);
							d = String.format("%02d", Integer.valueOf(d)); 
							
						
							
							if(_mDate.substring(4,6).equals("10")){
								m = "X";
							}
							else if(_mDate.substring(4,6).equals("11")){
								m = "Y";
							}
							else if(_mDate.substring(4,6).equals("12")){
								m = "Z";
							}
							else{
								m = _mDate.substring(5,6);
							}
							
							//총개수 저장
							vo.setTopRepr(1);
							dlivyBrcdMDao.updBrcdDlivy(vo);
							
							//수량만큼 반복한다.
							for(int j=1; j<=qy; j++){

								//첫번째 바코드 객체
								barcode1Vo = new DlivyMVo();
								BeanUtils.copyProperties(vo, barcode1Vo);		
								
								//바코드1 조합							
								barcode1 = DvyfgMtrilsList.get(i).getCol2() //마커
										 + DvyfgMtrilsList.get(i).getCol4() //제품명코드
										 + DvyfgMtrilsList.get(i).getCol5() //Grade
										 + vo.getBatchNo() + String.format("%03d", j+preDlivyQy)
										 + y + m + d //제조일
										 + DvyfgMtrilsList.get(i).getCol6() //제조사위치 
										 + DvyfgMtrilsList.get(i).getCol7() //유효기간
										 ;
								//order 저장
								barcode1Vo.setOrdr(String.valueOf(cnt15));
								//첫번째 바코드 저장
								barcode1Vo.setBrcd(barcode1);
								barcode1Vo.setRepr(String.valueOf(1));
								if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
									barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
								}
								
								dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
								cnt15 ++;
							}
							
							//수량 업데이트, 갯수 검증여부
							vo.setDlivyQy(String.valueOf(qy));
							vo.setVrifyAt("Y");
							dlivyBrcdMDao.updBrcdDlivyQy(vo);
						}
					}
					break;
				case "SY17000017" : //훽트팀 종합기술원
					for(int i=0; i<DvyfgMtrilsList.size(); i++){
						ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
						
						//"고객 자재코드", "Maker", "Item", "제품명 코드", "Grade", "제조사 위치", "유효기간"
						if(vo.getMtrilCode().equals(ctmmnyMtrilCode)){
							//총개수 저장
							vo.setTopRepr(1);
							dlivyBrcdMDao.updBrcdDlivy(vo);
							
							//첫번째 바코드 객체
							barcode1Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode1Vo);							
							
							//수량
							qy = intDlivyQy;
							
							//YYYYMMDD
							String _mDate = getMafdate(vo.getBatchNo(), "full");
							String y = _mDate.substring(3,4);
							String m = "";
							String d = _mDate.substring(6,8);
							d = String.format("%02d", Integer.valueOf(d)); 
							
						
							
							if(_mDate.substring(4,6).equals("10")){
								m = "X";
							}
							else if(_mDate.substring(4,6).equals("11")){
								m = "Y";
							}
							else if(_mDate.substring(4,6).equals("12")){
								m = "Z";
							}
							else{
								m = _mDate.substring(5,6);
							}
														
							//수량만큼 반복한다.
							for(int j=1; j<=qy; j++){
															
								//바코드1 조합							
								barcode1 = DvyfgMtrilsList.get(i).getCol2() //마커
										 + DvyfgMtrilsList.get(i).getCol4() //제품명코드
										 + DvyfgMtrilsList.get(i).getCol5() //Grade
										 + vo.getBatchNo() + String.format("%03d", j+preDlivyQy)
										 + y + m + d //제조일
										 + DvyfgMtrilsList.get(i).getCol6() //제조사위치 
										 + DvyfgMtrilsList.get(i).getCol7() //유효기간
										 ;
								//order 저장
								barcode1Vo.setOrdr(String.valueOf(j));
								//첫번째 바코드 저장
								barcode1Vo.setBrcd(barcode1);
								barcode1Vo.setRepr(String.valueOf(i));
								if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
									barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
								}
								
								dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
							}
							
							//수량 업데이트, 갯수 검증여부
							vo.setDlivyQy(String.valueOf(qy));
							vo.setVrifyAt("N");
							dlivyBrcdMDao.updBrcdDlivyQy(vo);
						}						
					}
					break;
			}
		}
		
		else if(vo.getInspctInsttCode().equals("3977")){ //제조 4팀 (자재코드 미등록 - 비고에 적힌 값으로 바코드 생성)
				//총개수 저장
				vo.setTopRepr(1);
				dlivyBrcdMDao.updBrcdDlivy(vo);
				
				//첫번째 바코드 객체
				barcode1Vo = new DlivyMVo();
				BeanUtils.copyProperties(vo, barcode1Vo);

				//바코드1 조합							
				barcode1 = vo.getRm();
				//order 저장
				barcode1Vo.setOrdr(String.valueOf(1));
				//첫번째 바코드 저장
				barcode1Vo.setBrcd(barcode1);
				barcode1Vo.setRepr("1");
				
				
				for(int i=0; i<DvyfgMtrilsList.size(); i++){
					ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
					String mtril = DvyfgMtrilsList.get(i).getCol1();
					
					if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode) && vo.getMtrilCode().equals(mtril)){
						if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
							barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
						}
						
					}
				}
				
				dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
				
				
				//수량 업데이트, 갯수 검증여부
				vo.setDlivyQy(String.valueOf(1));
				vo.setVrifyAt("N");				
				dlivyBrcdMDao.updBrcdDlivyQy(vo);

		}
		
		
//		else if(vo.getInspctInsttCode().equals("3977")){ //4팀 (자재코드 등록되있을떄)
//			switch(dvyfgEntrpsCode){
//			case "SY17000012" : // 4팀 삼성SDI
//				//총개수 저장
//				vo.setTopRepr(1);
//				dlivyBrcdMDao.updBrcdDlivy(vo);
//	
//				//첫번째 바코드 객체
//				barcode1Vo = new DlivyMVo();
//				BeanUtils.copyProperties(vo, barcode1Vo);
//				
//				//바코드1 조합							
//				barcode1 = vo.getRm();
//				//order 저장
//				barcode1Vo.setOrdr(String.valueOf(1));
//				//첫번째 바코드 저장
//				barcode1Vo.setBrcd(barcode1);
//				barcode1Vo.setRepr("1");
//				
//				
//				for(int i=0; i<DvyfgMtrilsList.size(); i++){
//					ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
//					String mtril = DvyfgMtrilsList.get(i).getCol1();
//					
//					if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode) && vo.getMtrilCode().equals(mtril)){
//						if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
//							barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
//						}
//						
//					}
//				}
//				
//				dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
//				
//				
//				//수량 업데이트, 갯수 검증여부
//				vo.setDlivyQy(String.valueOf(1));
//				vo.setVrifyAt("Y");				
//				dlivyBrcdMDao.updBrcdDlivyQy(vo);
//				
//				break;
//			case "SY17000013" : // 4팀 SK 이노베이션
//				//총개수 저장
//				vo.setTopRepr(1);
//				dlivyBrcdMDao.updBrcdDlivy(vo);
//				//첫번째 바코드 객체
//				barcode1Vo = new DlivyMVo();
//				BeanUtils.copyProperties(vo, barcode1Vo);		
//				
//				//바코드1 조합							
//				barcode1 = vo.getBatchNo();
//				//order 저장
//				barcode1Vo.setOrdr(String.valueOf(1));
//				//첫번째 바코드 저장
//				barcode1Vo.setBrcd(barcode1);
//				barcode1Vo.setRepr("1");
//				
//				for(int i=0; i<DvyfgMtrilsList.size(); i++){
//					ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
//					String mtril = DvyfgMtrilsList.get(i).getCol1();
//					
//					if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode) && vo.getMtrilCode().equals(mtril)){
//						if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
//							barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
//						}
//						
//					}
//				}
//				
//				dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
//				
//				//수량 업데이트, 갯수 검증여부
//				vo.setDlivyQy(String.valueOf(1));
//				vo.setVrifyAt("N"); //용기번호가 순서대로 안가기때문에 중복체크 안함
//				dlivyBrcdMDao.updBrcdDlivyQy(vo);
//				break;
//			}
//		}
		else if(vo.getInspctInsttCode().equals("3978")){ //파주팀
			switch(dvyfgEntrpsCode){
			case "SY17000001" : // 파주팀 삼성전자
				for(int i=0; i<DvyfgMtrilsList.size(); i++){
					ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode();
					String mtril = DvyfgMtrilsList.get(i).getCol2();

					//"고객 자재코드", "내부 자재코드", "Maker", "Item", "제품명 코드", "Grade", "제조사 위치", "유효기간"
					if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode) && vo.getMtrilCode().equals(mtril)){

						//수량
						qy = intDlivyQy;
						
						//YYYYMMDD
						String _mDate = getMafdate(vo.getBatchNo(), "full");
						String y = _mDate.substring(3,4);
						String m = "";
						String d = _mDate.substring(6,8);
						d = String.format("%02d", Integer.valueOf(d)); 
						
						
						if(_mDate.substring(4,6).equals("10")){
							m = "X";
						}
						else if(_mDate.substring(4,6).equals("11")){
							m = "Y";
						}
						else if(_mDate.substring(4,6).equals("12")){
							m = "Z";
						}
						else{
							m = _mDate.substring(5,6);
						}

						//총개수 저장
						vo.setTopRepr(1);
						dlivyBrcdMDao.updBrcdDlivy(vo);

						//수량만큼 반복한다.
						for(int j=1; j<=qy; j++){

							//첫번째 바코드 객체
							barcode1Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode1Vo);		

							//바코드1 조합							
							barcode1 = DvyfgMtrilsList.get(i).getCol3() //마커
									 + DvyfgMtrilsList.get(i).getCol5() //제품명코드
									 + DvyfgMtrilsList.get(i).getCol6() //Grade
									 + vo.getBatchNo() + String.format("%03d", j+preDlivyQy)
									 + y + m + d //제조일
									 + DvyfgMtrilsList.get(i).getCol7() //제조사위치
									 + DvyfgMtrilsList.get(i).getCol8() //유효기간
									 ;
							//order 저장
							barcode1Vo.setOrdr(String.valueOf(j));
							//첫번째 바코드 저장
							barcode1Vo.setBrcd(barcode1);
							barcode1Vo.setRepr("1");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
							}
							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
						}
						
						//수량 업데이트, 갯수 검증여부
						vo.setDlivyQy(String.valueOf(qy));
						vo.setVrifyAt("Y");
						dlivyBrcdMDao.updBrcdDlivyQy(vo);
					}
				}
				break;
				
			case "SY17000022" : // 파주팀 삼성전기
				for(int i=0; i<DvyfgMtrilsList.size(); i++){
					ctmmnyMtrilCode = DvyfgMtrilsList.get(i).getCtmmnyMtrilCode(); //고객사 자재코드
					String mtril = DvyfgMtrilsList.get(i).getCol2(); // 내부자재코드

					//"고객 자재코드", "내부 자재코드", "Maker", "Item", "제품명 코드", "Grade", "제조사 위치", "유효기간"
					if(vo.getCtmmnyMtrilCode().equals(ctmmnyMtrilCode) && vo.getMtrilCode().equals(mtril)){

						//수량
						qy = intDlivyQy;

						//YYYYMMDD
						String _mDate = getMafdate(vo.getBatchNo(), "full");
						String y = _mDate.substring(3,4);
						String m = "";
						String d = _mDate.substring(6,8);
						d = String.format("%02d", Integer.valueOf(d)); 
						
						
						if(_mDate.substring(4,6).equals("10")){
							m = "X";
						}
						else if(_mDate.substring(4,6).equals("11")){
							m = "Y";
						}
						else if(_mDate.substring(4,6).equals("12")){
							m = "Z";
						}
						else{
							m = _mDate.substring(5,6);
						}
						
						//총개수 저장
						vo.setTopRepr(1);
						dlivyBrcdMDao.updBrcdDlivy(vo);
						for(int j=1; j<=1; j++){
							//첫번째 바코드 객체
							barcode1Vo = new DlivyMVo();
							BeanUtils.copyProperties(vo, barcode1Vo);		
							
							//바코드1 조합							
							barcode1 = ctmmnyMtrilCode+", " //고객자재코드
									 + vo.getBatchNo().substring(0,4) // 의뢰일자
									 + DvyfgMtrilsList.get(i).getCol3() // 고유번호
									 + DvyfgMtrilsList.get(i).getCol4() // 용기번호
									 + DvyfgMtrilsList.get(i).getCol5() // 용기구분
									 + ", 01" // 수량
									 ;
							//order 저장
							barcode1Vo.setOrdr(String.valueOf(1));
							//첫번째 바코드 저장
							barcode1Vo.setBrcd(barcode1);
							barcode1Vo.setRepr("1");
							if(DvyfgMtrilsList.get(i).getOrginlDlivyQy() != null){
								barcode1Vo.setVrifyQy(Integer.valueOf(DvyfgMtrilsList.get(i).getOrginlDlivyQy())); //검증할 횟수
							}
							
							dlivyBrcdMDao.insDlivyBrcdDetail(barcode1Vo);
					}

						//수량 업데이트, 갯수 검증여부
						vo.setDlivyQy(String.valueOf(qy));
						vo.setVrifyAt("Y");
						dlivyBrcdMDao.updBrcdDlivyQy(vo);
					}
				}
				break;
			}
		}
		return result;
	}
	
	/**
	 * lot아이디로 날짜 추출
	 * @param getBatchNo
	 * @return
	 */
	private String getMafdate(String getBatchNo, String type){
		String mafDateYy = getBatchNo.substring(0,1);
		String mafDateMm = getBatchNo.substring(1,2);
	
		//A면 0, 년수 두자리면 0으로
		if(mafDateYy.equals("A")){
			mafDateYy = "0";
		}
		
		//X-10, Y-11, X-12 한자리는 0붙임
		if(mafDateMm.equals("X")){
			mafDateMm = "10";
		}
		else if(mafDateMm.equals("Y")){
			mafDateMm = "11";
		}
		else if(mafDateMm.equals("Z")){
			mafDateMm = "12";
		}
		else {
			mafDateMm = "0" + mafDateMm;
		}
		
		SimpleDateFormat format = new SimpleDateFormat ( "yyyy");					
		Date time = new Date();
		
		String time1 = "";
		
		//9만 있으면 2019인지 2029인지 했갈려서 이렇게함
		if(format.format(time).equals("2020")){
			if(getBatchNo.substring(0,1).equals("9")){
				time1 = "2019";
			} 
			else{
				time1 = format.format(time);
			}
		}
		else{
			time1 = format.format(time);
		}

		String date = "";
		
		if(type.equals("full")){ //YYYY
//			date = time1 + mafDateMm + getBatchNo.substring(2, 4);
			date = time1.substring(0, 3) + mafDateYy + mafDateMm + getBatchNo.substring(2, 4);
		}else{
			date = time1.substring(2, 3) + mafDateYy + mafDateMm + getBatchNo.substring(2, 4);
		}
		
		
		return date;
	}

	
}

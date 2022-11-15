  package lims.req.service.Impl;

  import lims.req.dao.RequestMDao;
  import lims.req.service.RequestMService;
  import lims.req.vo.ProcessDivision;
  import lims.req.vo.RequestAuditVo;
  import lims.req.vo.RequestMVo;
  import lims.test.service.LotTraceMService;
  import lims.test.vo.LotTraceMVo;
  import lims.util.CommonFunc;
  import org.apache.commons.beanutils.BeanUtils;
  import org.springframework.beans.factory.annotation.Autowired;
  import org.springframework.stereotype.Service;
  import org.springframework.web.context.request.RequestContextHolder;
  import org.springframework.web.context.request.ServletRequestAttributes;

  import javax.servlet.http.HttpServletRequest;
  import java.net.UnknownHostException;
  import java.util.ArrayList;
  import java.util.List;
  import java.util.Map;

@Service
public class RequestMServiceImpl implements RequestMService {

	private final RequestMDao requestMDao;
	private final CommonFunc commonFunc;
	private final LotTraceMService lotTraceMService;

	@Autowired
	public RequestMServiceImpl(RequestMDao requestMDao, CommonFunc commonFunc, LotTraceMService lotTraceMServiceImpl) {
		this.requestMDao = requestMDao;
		this.commonFunc = commonFunc;
		this.lotTraceMService = lotTraceMServiceImpl;
	}

	@Override
	public List<RequestMVo> getMtrilEqpSeCombo(RequestMVo vo) {
		return requestMDao.getMtrilEqpSeCombo(vo);
	}

	@Override
	public List<RequestMVo> getMtrilVendorCombo(RequestMVo vo) {
		return requestMDao.getMtrilVendorCombo(vo);
	}

	@Override
	public List<RequestMVo> getRequestList(RequestMVo vo) {
		return requestMDao.getRequestList(vo);
	}

	@Override
	public RequestMVo insReqest(RequestMVo vo) {

		//신규일경우 의뢰번호생성
		//스크립트 - 자재테이블 Lot No 자리수와 비교해서 적거나 클경우 리턴, Lot 생성 규칙에 맞게 입력이 모두 되었는지 확인 후 리턴
		//		 ㄴ 자리수만 비교해도 가능하나 이중으로 막아서 잘못된 데이터 안나오게 확인.
		//서버 - 저장하기전에 동일한 LotNo있는지 확인 후 저장 있을경우 다시 리턴
		String resultCode;
		RequestMVo requestMVo = vo.getFormData();
		requestMVo.setPutExpriemCnt(0); //시험항목 등록 및 수정 개수 체크 초기화
		List<RequestMVo> addedGridData = vo.getAddedRequestDtlList();

		int sameLotNoCnt = requestMDao.insSameLotNoChk(requestMVo);
		if(sameLotNoCnt > 0) {
			resultCode = "99";
		} else {
			//결재 상신
			List<RequestMVo> santcnInfoList = vo.getAddedSanctnList();

			requestMVo.setExpriemCo(addedGridData != null ? String.valueOf(addedGridData.size()) : "0"); //시험항목수
			int result = requestMDao.insReqest(requestMVo); //의뢰 저장

			//화면에서 lotNo가 생성되었으면 lotNo 등록
			if (!commonFunc.isEmpty(requestMVo.getLotNo())) {
				List<LotTraceMVo> list = new ArrayList<>();
				list.add(requestMVo);
				lotTraceMService.saveReqTrace(list);
			}

			//의뢰 폼 Audit
			requestMVo.setReqestNo(requestMDao.getReqestNo(requestMVo)); //의뢰 번호 저장
			insertRequestAudit(getAuditTrailContent(null, requestMVo, "저장", ProcessDivision.REQUEST, requestMVo.getReqestSeqno()));
			if(result == 1) {

				if (addedGridData != null && addedGridData.size() > 0) {
					addedGridData.forEach(v -> {
						v.setReqestSeqno(requestMVo.getReqestSeqno());
						v.setBplcCode(requestMVo.getBplcCode());
						requestMDao.insExpriem(v); //시험항목 저장
						requestMVo.setPutExpriemCnt(requestMVo.getPutExpriemCnt() + 1);
						//1.IM의뢰 시험항목 결과 등록
							//시험항목 1개당 초,중,말에 대한 3개의 로우 insert
							//EXPR_NUMOT = 쌓는순서대로 1,2,3
							//EXPR_ODR = default
							//DELETE_AT 초, 중, 말 체크되어있으면 'N' 반대 'Y'
						requestMDao.insInitIREResults(v);
					});

					//신규등록하기위한 시험항목 개수가 실제로 등록된 개수와 같으면 의뢰번호 리턴, 틀리면 "0" : 등록실패 리턴
					resultCode = addedGridData.size() == requestMVo.getPutExpriemCnt() ? requestMDao.getReqestNo(requestMVo) : "0";

				} else {
					resultCode = requestMDao.getReqestNo(requestMVo); //의뢰번호 조회
				}

				//시험항목 Audit
				List<RequestMVo> expriemList = requestMDao.getExpriemList(requestMVo);
				if(expriemList.size() > 0)
					insertRequestAudit(getAuditTrailContent(expriemList, null, "저장", ProcessDivision.EXPRIEM, requestMVo.getReqestSeqno()));
			} else {
				resultCode = "0";
			}
		}

		//resultCode = 의뢰번호 : '저장완료', 0 : '등록실패', 99 : '이미등록된 Lot No'
		requestMVo.setResultCode(resultCode);
		return requestMVo;
	}

	@Override
	public String updReqest(RequestMVo vo) {

		/* 폼 */
		RequestMVo requestMVo = vo.getFormData();
		//RETURN : 진행상황 COA완료는 수정불가
		if ("IM03000006".equals(requestMDao.getProgrsCode(requestMVo))) return "98";

		/* 시험항목 */
		List<RequestMVo> addedGridData = vo.getAddedRequestDtlList();
		List<RequestMVo> removedGridData = vo.getRemovedRequestDtlList();

		requestMVo.setExpriemCo(requestMVo.getExpriemCoChk()); //시험항목수
		//의뢰 저장
		int result = requestMDao.updReqest(requestMVo);

		//화면에서 lotNo가 생성되었으면 lotNo 등록 또는 수정
		if (!commonFunc.isEmpty(requestMVo.getLotNo())) {
			List<LotTraceMVo> list = new ArrayList<>();
			list.add(requestMVo);
			lotTraceMService.saveReqTrace(list);
		}

		//의뢰 폼 Audit
		requestMVo.setReqestNo(requestMDao.getReqestNo(requestMVo)); //의뢰 번호 저장
		insertRequestAudit(getAuditTrailContent(null, requestMVo, "수정", ProcessDivision.REQUEST, requestMVo.getReqestSeqno()));
		if(result == 1) {
			//시험항목추가
			if(!commonFunc.isEmpty(addedGridData)) {
				addedGridData.forEach(v -> {
					v.setReqestSeqno(requestMVo.getReqestSeqno());
					v.setBplcCode(requestMVo.getBplcCode());
					requestMDao.insExpriem(v);
					requestMDao.insInitIREResults(v);
				});

				//시험 항목 추가 Audit
				insertRequestAudit(getAuditTrailContent(addedGridData, null, "수정(추가)", ProcessDivision.EXPRIEM, requestMVo.getReqestSeqno()));
			}
			//시험항목삭제
			//시험항목 결과 평균 테이블에 대한 데이터 삭제는 필요없다고 하셔서 만들지 않았습니다.
			if(!commonFunc.isEmpty(removedGridData)) {
				removedGridData.forEach(v -> {
					requestMDao.delExpriem(v);
					requestMDao.delExpriemResults(v);
				});

				//시험 항목 삭제 Audit
				insertRequestAudit(getAuditTrailContent(removedGridData, null, "수정(삭제)", ProcessDivision.EXPRIEM, requestMVo.getReqestSeqno()));
			}

			//의뢰정보는 시험항목의 진행상황 MIN값으로 업데이트
			requestMDao.updMinProgrsSittnCode(requestMVo);

		}
		return requestMDao.getReqestNo(requestMVo); //의뢰번호로 리턴
	}

	@Override
	public String delReqest(RequestMVo vo) {
		int resultCnt = 0;
		//시험항목은 없을 수 있으므로 카운트하지않음.
		requestMDao.delReqestAllExpriem(vo);
		resultCnt += requestMDao.delReqest(vo);
		//의뢰 삭제 Audit
		insertRequestAudit(getAuditTrailContent(null, vo, "삭제", ProcessDivision.REQUEST, vo.getReqestSeqno()));
		return resultCnt == 1 ? "1" : "0";
	}

	@Override
	public List<RequestMVo> getExpriemList(RequestMVo vo) {
		return requestMDao.getExpriemList(vo);
	}

	@Override
	public List<RequestMVo> getReMatchingLotNo(List<RequestMVo> list) {
		list.forEach(v -> {
			String matchingReqestSeqno = requestMDao.getReMatchingLotNo(v);
			if(commonFunc.isEmpty(matchingReqestSeqno)) {
				if(commonFunc.isEmpty(v.getLotNo()))
					v.setrMatchingLotNo("X");
				else
					v.setMatchingLotNo("X");
			} else {
				if(commonFunc.isEmpty(v.getLotNo()))
					v.setrMatchingLotNo("O");
				else
					v.setMatchingLotNo("O");
			}
		});
		return list;
	}

	@Override
	public List<RequestMVo> getVendorLotNoList(RequestMVo vo) {
		return requestMDao.getVendorLotNoList(vo);
	}



	@Override
	public List<RequestMVo> getRequestMtrilExpriem(RequestMVo vo) {
		return requestMDao.getRequestMtrilExpriem(vo);
	}


	//PARAM : 이력Vo, (시험 or Lot or Real Lot) Grid List, 의뢰 폼, DML 구분, (의뢰폼 or 시험 or Lot or Real Lot) 프로세스 구분
	public RequestAuditVo getAuditTrailContent(List<RequestMVo> list, RequestMVo requestMVo, String event, ProcessDivision process, String requestSeqno) {

		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

		String ip = ""; //초기화
		try { ip = java.net.InetAddress.getLocalHost().getHostAddress(); } catch(UnknownHostException e) { e.printStackTrace(); }
		RequestAuditVo requestAuditVo = RequestAuditVo.builder()
				.histSeCode("CM03000005") //이력 구분 코드 "의뢰"
				.menuUrl(request.getRequestURI()) //메뉴 URL
				.conectIp(ip) //접속IP
				.reqestSeqno(requestSeqno) //의뢰 일련번호
				.processNm(event) //처리 명
				.build();

		//변경 이후 내용, JSON Parser 같은 URL에서 인식할 수 있도록 설정, 삭제인 경우 아닌 경우로 로직 구분
		if("삭제".equals(event)) {
			requestAuditVo.setChangeAfterCn(process.toString()+ "^^" + requestSeqno);
		} else {
			switch (process) {
				case REQUEST:
					requestAuditVo.setChangeAfterCn(process + "^^");
					Map<String,Object> map = null;
					try { map = BeanUtils.describe(requestMVo); } catch (Exception e) { e.printStackTrace(); }
					if (map != null) {
						map.forEach((k, v) -> {
							if(!commonFunc.isEmpty(v))
								requestAuditVo.setChangeAfterCn(requestAuditVo.getChangeAfterCn() + k + " : " + v + "^^");
						});
					}
					break;
				case EXPRIEM: case LOTTRACE: case REALLOTTRACE:
					if(list.size() > 0) {
						requestAuditVo.setChangeAfterCn(process + "^^");
						for(RequestMVo vo : list) {
							Map<String,Object> tempMap = null;
							try { tempMap = BeanUtils.describe(vo); } catch (Exception e) { e.printStackTrace(); }
							if (tempMap != null) {
								tempMap.forEach((k, v) -> {
									if(!commonFunc.isEmpty(v))
										requestAuditVo.setChangeAfterCn(requestAuditVo.getChangeAfterCn() + k + " : " + v + "^^");
								});
							}
						}
					}
					break;
			}
		}
		return requestAuditVo;
	}

	//Audit 이력 남길 때 이력 문자열이 Varchar 4000을 넘을 경우 분할 등록할 수 있게 추가
	public void insertRequestAudit(RequestAuditVo vo) {
		if(!commonFunc.isEmpty(vo.getChangeAfterCn()) && !"null".equals(vo.getChangeAfterCn())) {
			int string1900cut = vo.getChangeAfterCn().length() / 1900;
			if(string1900cut >= 1) {
				//1900자를 기준으로 문자열 잘라서 vo에서 셋
				String temp = vo.getChangeAfterCn();
				int startPoint = 0;
				int endPoint = 1900;
				for(int i = 1; i <= string1900cut + 1; i++) {
					vo.setChangeAfterCn(temp.substring(startPoint, endPoint));
					requestMDao.insertRequestAudit(vo);
					startPoint = endPoint;
					if(i == string1900cut)
						endPoint = temp.length();
					else
						endPoint = 1900 * (i + 1);
				}
			} else {
				requestMDao.insertRequestAudit(vo);
			}
		}
	}

	public List<RequestMVo> getsploreCylndrList(RequestMVo vo){
		return requestMDao.getsploreCylndrList(vo);
	}
	public List<RequestMVo> getsploreItemList(RequestMVo vo){
	  return requestMDao.getsploreItemList(vo);
	}
	public List<RequestMVo> getmtrilSeqno(RequestMVo vo){
	  return requestMDao.getmtrilSeqno(vo);
	 }
}

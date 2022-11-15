package lims.src.service.Impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itextpdf.text.Document;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfImportedPage;
import com.itextpdf.text.pdf.PdfReader;
import com.itextpdf.text.pdf.PdfWriter;

import lims.com.vo.FileDetailMVo;
import lims.com.vo.RdmsMVo;
import lims.req.vo.RequestMVo;
import lims.src.dao.TestSearchMDao;
import lims.src.service.TestSearchMService;
import lims.test.vo.ResultInputMVo;
import lims.util.GetUserSession;
import rdms.ca.dao.RdmsCAMDao;

@Service
public class TestSearchMServiceImpl implements TestSearchMService {

	@Autowired
	private TestSearchMDao testSearchMDao;

	@Autowired
	private RdmsCAMDao rdmsMDao;


	//의뢰 목록 조회
	@Override
	public List<ResultInputMVo> getReqestListSch(ResultInputMVo vo) {
		return testSearchMDao.getReqestListSch(vo);
	}

	//시험항목 목록 조회
	@Override
	public List<ResultInputMVo> getExpriemListSch(ResultInputMVo vo) {
		GetUserSession sessionD = new GetUserSession();
		vo.setAuthorSeCode(sessionD.getAuthorSeCode());
		return testSearchMDao.getExpriemListSch(vo);
	}

	@Override
	public List<RequestMVo> getReqestUpperLotList(RequestMVo vo) {
		return testSearchMDao.getReqestUpperLotList(vo);
	}

	@Override
	public List<RequestMVo> getReqestChrgTeamList(RequestMVo vo) {
		return testSearchMDao.getReqestChrgTeamList(vo);
	}

	@Override
	public List<RequestMVo> getReqestCanNoList(RequestMVo vo) {
		return testSearchMDao.getReqestCanNoList(vo);
	}

	@Override
	public List<RequestMVo> getUpperLotId(RequestMVo vo) {
		return testSearchMDao.getUpperLotId(vo);
	}

	@Override
	public FileDetailMVo getblobPdfViewer(RdmsMVo vo) {
		return rdmsMDao.getblobPdfViewer(vo);
	}

	@Override
	public FileDetailMVo getCheckBlobPdfViewer(List<RdmsMVo> list) {

		FileDetailMVo mergeFileVo = new FileDetailMVo();

		String[] binderitemvalueIdArr = new String[list.size()];
		int len = list.size();
		for(int i = 0; i < len; i++)
			binderitemvalueIdArr[i] = list.get(i).getBinderitemvalueId();

		List<FileDetailMVo> fileDetailList = rdmsMDao.getCheckBlobPdfViewer(binderitemvalueIdArr);

		try {

			// 동일한 PDF 파일을 같은시간에 사용하는 사용자가 여러명일 경우 파일이 생성되면서 같은파일명으로 문제가 됨
			// 난수로 첨부파일 대체 작업해야함.

			List<InputStream> inputPdfList = new ArrayList<InputStream>();
			OutputStream outputStream = new FileOutputStream("C:\\fileUpload\\pdf\\MergeFile.pdf");

			String[] deletePathArr = new String[fileDetailList.size()];

			for(int i = 0; i < fileDetailList.size(); i++) {
				String filePath = "C:\\fileUpload\\pdf\\" + fileDetailList.get(i).getOrginlFileNm();
				deletePathArr[i] = filePath;
				FileUtils.writeByteArrayToFile(new File(filePath), fileDetailList.get(i).getFileData());
				inputPdfList.add(new FileInputStream(filePath));
			}

			Document document = new Document();
			List<PdfReader> readers = new ArrayList<PdfReader>();

			int totalPages = 0;

			Iterator<InputStream> pdfIterator = inputPdfList.iterator();
			while (pdfIterator.hasNext()) {
				InputStream pdf = pdfIterator.next();
				PdfReader pdfReader = new PdfReader(pdf);
				readers.add(pdfReader);
				totalPages = totalPages + pdfReader.getNumberOfPages();
			}

			PdfWriter writer = PdfWriter.getInstance(document, outputStream);

			document.open();

			PdfContentByte pageContentByte = writer.getDirectContent();

			PdfImportedPage pdfImportedPage;
			int currentPdfReaderPage = 1;
			Iterator<PdfReader> iteratorPDFReader = readers.iterator();

			while (iteratorPDFReader.hasNext()) {
				PdfReader pdfReader = iteratorPDFReader.next();
				//Create page and add content.
				while (currentPdfReaderPage <= pdfReader.getNumberOfPages()) {
					document.newPage();
					pdfImportedPage = writer.getImportedPage(pdfReader,currentPdfReaderPage);
					pageContentByte.addTemplate(pdfImportedPage, 0, 0);
					currentPdfReaderPage++;
				}
				currentPdfReaderPage = 1;
			}

			outputStream.flush();
			document.close();
			outputStream.close();

			String mergeFilePath = "C:\\fileUpload\\pdf\\MergeFile.pdf";
			File mergeFile = new File(mergeFilePath);
			byte[] mergePdfByteArr = FileUtils.readFileToByteArray(mergeFile);

			mergeFileVo.setFileData(mergePdfByteArr);

			for(int i = 0; i < deletePathArr.length; i++) {
				File file = new File(deletePathArr[i]);
				file.delete();
			}

			mergeFile.delete();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mergeFileVo;

	}
}

package com.gn.sungha.irrigation;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gn.sungha.common.CommonNmList;
import com.gn.sungha.common.Pagination;
import com.gn.sungha.local.localVO;
import com.gn.sungha.organizationInfo.organizationInfoVO;
import com.gn.sungha.sensor.SensorVO;

@Service
public class IrrigationService {

	@Autowired
	private IrrigationMapper mapper;
	
	@Autowired
	private final ObjectMapper objectMapper = new ObjectMapper();
	
	@Autowired
	private CommonNmList commonNmList; // 공통 - 기관정보 콤보박스 리스트와 지역 콤보박스 리스트 객체
	
	//@Value("${spring.servlet.multipart.location}")
	private String filePath = "C:\\sensor_file_store\\";
	
	/**
	 * @Method Name : selectIrrigationList
	 * @Description : 기관정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	public List<IrrigationVO> selectIrrigationList(String searchingOrgId, String searchingLocalId,
			String searchingType, String searchingContent, Pagination pagination, String sortColumn, String sortType) throws Exception {
		
		IrrigationVO param = new IrrigationVO();
		param.setSearchingOrgId(searchingOrgId);
		param.setSearchingLocalId(searchingLocalId);
		param.setSearchingType(searchingType);
		param.setSearchingContent(searchingContent);
		param.setPagination(pagination);
		param.setSortColumn(sortColumn);
		param.setSortType(sortType);		
		
		List<IrrigationVO> list = mapper.selectIrrigationList(param);
		return list;
	}
	
	/**
	 * @Method Name : selectIrrigationListTotalCnt
	 * @Description : 기관정보 총개수
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.22  유성우      최초생성
	 * @
	 */
	public int selectIrrigationListTotalCnt(String searchingOrgId, String searchingLocalId, String searchingType, String searchingContent) throws Exception {
		int listCnt = mapper.selectIrrigationListTotalCnt(searchingOrgId, searchingLocalId, searchingType, searchingContent);
		return listCnt;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectIrrigationInfoDetail
	 * @Description : 기관정보 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public IrrigationVO selectIrrigationDetail(String irrigationId) throws Exception {
		IrrigationVO param = new IrrigationVO();
		IrrigationVO detail = new IrrigationVO();
		try {
			
			param.setIrrigationId(irrigationId);
			
			detail = mapper.selectIrrigationDetail(param);
			//File file = new File(filePath + detail.getUuidName());
			//detail.setFile(new FileInputStream(file));
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return detail;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertIrrigationSave
	 * @Description : 관수 정보 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean insertIrrigationSave(String irrigationId, String irrigation, String irrigationState, String organizationId,
			String localId, String irrigationDetail) throws Exception {
		
		try {
			mapper.insertIrrigation(irrigationId, irrigation, organizationId, localId, irrigationDetail);
			mapper.insertIrrigationControl(irrigationId, "macross",  irrigationState, "ON");
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertIrrigationSave
	 * @Description : 관수 정보 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean updateIrrigationStateChange(String irrigationId, String state, String streamTime, String userId, String irrigationDetail) throws Exception {
		try {		
			
			IrrigationVO param = new IrrigationVO();
			param.setIrrigationId(irrigationId);
			param.setIrrigationState(state);
			param.setStreamTime(Integer.parseInt(streamTime));
			param.setUserId(userId);
			param.setIrrigationDetail(irrigationDetail);
			
			mapper.updateIrrigationStateChange(irrigationId, state);
			mapper.insertIrrigationHistoryChange(param);
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectSensorExcel
	 * @Description : 센서정보 엑셀 다운로드
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public Object selectIrrigationExcel(HttpServletResponse response, String searchingOrgId, String searchingLocalId, String personInCharge, Pagination pagination, String sortColumn, String sortType, String searchingType, String searchingContent) throws Exception {
		
		List<IrrigationVO> list = mapper.selectIrrigationListExcel(searchingOrgId, searchingLocalId, searchingType, searchingContent, pagination.getStartList(), pagination.getListSize(), sortColumn, sortType);
        createExcelDownloadResponse(response, list);
        
        List<Map> sensorMap = list.stream()
                .map(userPoint -> objectMapper.convertValue(userPoint, Map.class))
                .collect(Collectors.toList());
        
        return sensorMap;
    }
	
	/**
	 * @throws Exception 
	 * @Method Name : createExcelDownloadResponse
	 * @Description : 센서정보 엑셀 다운로드 바디
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
    public void createExcelDownloadResponse(HttpServletResponse response, List<IrrigationVO> list) {

        try{
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("관수정보_리스트");

            //숫자 포맷은 아래 numberCellStyle을 적용시킬 것이다다
            CellStyle numberCellStyle = workbook.createCellStyle();
            numberCellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
            
            // 테이블 헤더용 스타일
            CellStyle headStyle = workbook.createCellStyle();
            
            // 가는 경계선을 가집니다.
            headStyle.setBorderTop(BorderStyle.THIN);
            headStyle.setBorderBottom(BorderStyle.THIN);
            headStyle.setBorderLeft(BorderStyle.THIN);
            headStyle.setBorderRight(BorderStyle.THIN);
            
            // 데이터는 가운데 정렬합니다.
            headStyle.setAlignment(HorizontalAlignment.CENTER);
            headStyle.setVerticalAlignment(VerticalAlignment.CENTER);
            
            // 데이터용 경계 스타일 테두리만 지정
            headStyle.setBorderTop(BorderStyle.THIN);
            headStyle.setBorderBottom(BorderStyle.THIN);
            headStyle.setBorderLeft(BorderStyle.THIN);
            headStyle.setBorderRight(BorderStyle.THIN);
            
            /* 주석 내용은 숫자 포맷일때 셀 스타일입니다.
            // 가는 경계선을 가집니다.
            numberCellStyle.setBorderTop(BorderStyle.THIN);
            numberCellStyle.setBorderBottom(BorderStyle.THIN);
            numberCellStyle.setBorderLeft(BorderStyle.THIN);
            numberCellStyle.setBorderRight(BorderStyle.THIN);
            
            // 데이터는 가운데 정렬합니다.
            numberCellStyle.setAlignment(HorizontalAlignment.CENTER);
            
            // 데이터용 경계 스타일 테두리만 지정
            numberCellStyle.setBorderTop(BorderStyle.THIN);
            numberCellStyle.setBorderBottom(BorderStyle.THIN);
            numberCellStyle.setBorderLeft(BorderStyle.THIN);
            numberCellStyle.setBorderRight(BorderStyle.THIN);
            */
            //파일명
            final String fileName = "관수정보_리스트";

            //헤더
            final String[] header = {"번호", "관수ID", "관수명", "지역명", "기관명", "관수설정상태", "관수 설명"};
            Row row = sheet.createRow(0);
            for (int i = 0; i < header.length; i++) {
                Cell cell = row.createCell(i);
                cell.setCellValue(header[i]);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                
                sheet.autoSizeColumn(i);                
                sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 3000);
                if(i == 5) {
                	sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 3000);
                }
                sheet.setDefaultRowHeight((short) (sheet.getDefaultRowHeight() + 30) );
            }
            
            //sheet.addMergedRegion(new CellRangeAddress(0, 0, 1, 2)); // CellRangeAddress(첫행, 마지막행, 첫열, 마지막열)
            
           
            
            //바디
            for (int i = 0; i < list.size(); i++) {
                row = sheet.createRow(i + 1);  //헤더 이후로 데이터가 출력되어야하니 +1

                IrrigationVO userPoint = list.get(i);

                Cell cell = null;
                cell = row.createCell(0);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getRownum()); // 번호

                cell = row.createCell(1);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getIrrigationId()); // 관수ID

                cell = row.createCell(2);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getIrrigationName()); // 관수명

                cell = row.createCell(3);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getLocal()); // 지역명

                cell = row.createCell(4);                
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getOrganization()); // 기관명
                
                cell = row.createCell(5);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getState()); // 관수 상태
                
                cell = row.createCell(6);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getIrrigationDetail()); // 관수 설명
                
               
            }

            

            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-Disposition", "attachment;filename="+ URLEncoder.encode(fileName, "UTF-8")+".xlsx");
            //파일명은 URLEncoder로 감싸주는게 좋다!

            workbook.write(response.getOutputStream());
            workbook.close();

        }catch(IOException e){
            e.printStackTrace();
        }

    }
    
    /**
	 * @Method Name : selectDupCheck
	 * @Description : 관수아이디 중복체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.22  유성우      최초생성
	 * @
	 */
	public boolean selectDupCheck(String irrigationId) throws Exception {
		boolean resultFlag = false;
		List<IrrigationVO> irrigationList = mapper.selectIrrigationDupCheck(irrigationId);
		List<IrrigationVO> irrigationControlList = mapper.selectIrrigationControlDupCheck(irrigationId);
		
		if(irrigationList.size() > 0 || irrigationControlList.size() > 0) {
			resultFlag = true; // 중복 true
		} else {
			resultFlag = false; // 중복 false
		}
		return resultFlag;
	}
	
	/**
	 * @Method Name : selectSensorInfoList
	 * @Description : 센서정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	public List<IrrigationVO> selectIrrigationReplyList(String irrigationId) throws Exception {
		List<IrrigationVO> list = mapper.selectIrrigationReplyList(irrigationId);
		return list;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateIrrigationInfoMod
	 * @Description : 관수정보 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean updateIrrigationInfoMod(String irrigationId, String irrigation, String irrigationState, String organizationId, String localId, String irrigationDetail) throws Exception {
		
		try {
			mapper.updateIrrigationMod(irrigationId, irrigation, organizationId, localId, irrigationDetail);
			mapper.updateIrrigationControlMod(irrigationId, "macross", irrigationState, "ON");
		} catch(Exception e) {
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : deleteIrrigationInfoDel
	 * @Description : 관수정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public void deleteIrrigationInfoDel(String irrigationId) throws Exception {
		try {
			mapper.deleteIrrigation(irrigationId); // 해당 관수 삭제
			mapper.deleteIrrigationControl(irrigationId); // 해당 관수 설정 삭제
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : deleteIrrigationInfoDel
	 * @Description : 관수정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean deleteIrrigationReply(int replyId) throws Exception {
		
		String uuidFileName = null;
		String uuidName = "";
		
        try{
        	uuidName = mapper.getUuidName(replyId);
        	
            uuidFileName = URLDecoder.decode(uuidName,"UTF-8");
            //UUID가 포함된 파일이름을 디코딩해줍니다.
            File file = new File(filePath +File.separator + uuidFileName);
            boolean result = file.delete();

            File thumbnail = new File(file.getParent(),"s_"+file.getName());
            //getParent() - 현재 File 객체가 나태내는 파일의 디렉토리의 부모 디렉토리의 이름 을 String으로 리턴해준다.
            result = thumbnail.delete();
            
            mapper.deleteIrrigationReply(replyId); // 댓글 삭제
			mapper.deleteIrrigationReplyFile(replyId); // 댓글 파일 삭제
            
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertIrrigationReplySave
	 * @Description : 관수 댓글 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean insertIrrigationReplySave(String writerId, String title, String locationDetail, String irrigationId) throws Exception {
		try {		
			mapper.insertIrrigationReplyInfo(writerId, title, locationDetail, irrigationId);
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : getIrrigationReplyId
	 * @Description : 관수 댓글 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public int getIrrigationReplyId(String irrigationId) throws Exception {
		int replyId = 0;
		try {		
			replyId =  mapper.getIrrigationReplyId(irrigationId);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return replyId;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertReplyFileSave
	 * @Description : 관수 댓글 파일 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean insertReplyFileSave(int replyId, String uuidNm, String oriFileName, String fileSize) throws Exception {
		
		IrrigationVO irrigationReplyParam = new IrrigationVO();
		
		irrigationReplyParam.setReplyId(replyId);
		irrigationReplyParam.setUuidName(uuidNm);
		irrigationReplyParam.setOriFileName(oriFileName);
		irrigationReplyParam.setFileSize(fileSize);
		
		try {					
			mapper.insertReplyFileSave(irrigationReplyParam);
		} catch(Exception e) {
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateIrrigationReplyMod
	 * @Description : 관수정보 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean updateIrrigationReplyMod(int replyId, String title, String locationDetail) throws Exception {

		try {
			IrrigationVO param = new IrrigationVO();
			param.setReplyId(replyId);
			param.setTitle(title);
			param.setIrrigationDetail(locationDetail);
			
			mapper.updateIrrigationReplyMod(param);
		} catch(Exception e) {
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : deleteLocalViewFile
	 * @Description : 기존 조감도 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean deleteIrrigationReplyFile(int replyId) throws Exception {
		
		String srcFileName = null;
		String uuidName = "";
		
        try{
        	uuidName = mapper.getUuidName(replyId);
        	
    		if(uuidName != null && uuidName != "") {
        		srcFileName = URLDecoder.decode(uuidName,"UTF-8");
                //UUID가 포함된 파일이름을 디코딩해줍니다.
                File file = new File(filePath +File.separator + srcFileName);
                boolean result = file.delete();

                File thumbnail = new File(file.getParent(),"s_"+file.getName());
                //getParent() - 현재 File 객체가 나태내는 파일의 디렉토리의 부모 디렉토리의 이름 을 String으로 리턴해준다.
                result = thumbnail.delete();
        	}
        	
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
        
		
	}
	
	/**
	 * @Method Name : selectIrrigationReplyList
	 * @Description : 관수정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	public List<IrrigationVO> selectReplyFileList(int replyId) throws Exception {
		List<IrrigationVO> list = mapper.selectReplyFileList(replyId);
		return list;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateIrrigationReplyFileMod
	 * @Description : 관수정보 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean updateIrrigationReplyFileMod(int replyId, String finalUuidName, String oriFileName, String fileSize) throws Exception {
		
		try {
			IrrigationVO param = new IrrigationVO();
			param.setReplyId(replyId);
			param.setUuidName(finalUuidName);
			param.setOriFileName(oriFileName);
			param.setFileSize(fileSize);
			
			mapper.updateIrrigationReplyFileMod(param);
		} catch(Exception e) {
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateIrrigationReplyFileMod
	 * @Description : 관수정보 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public List<IrrigationVO> selectIrrigationHistoryList(String irrigationId) throws Exception {
		
		try {
			return mapper.selectIrrigationHistoryList(irrigationId);
		} catch(Exception e) {
			return null;
		}
		
		
	}
	
}

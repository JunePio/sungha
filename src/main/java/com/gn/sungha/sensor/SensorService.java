package com.gn.sungha.sensor;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
import org.springframework.core.io.UrlResource;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gn.sungha.common.Pagination;
import com.gn.sungha.irrigation.IrrigationVO;
import com.gn.sungha.local.localVO;
import com.gn.sungha.organizationInfo.organizationInfoVO;
import com.gn.sungha.userMng.UserMngVO;
import org.apache.commons.text.StringEscapeUtils;


/*
 *  센서정보 서비스
 */

@Service
public class SensorService {

	@Autowired
	private SensorMapper mapper;
	
	@Autowired
	private final ObjectMapper objectMapper = new ObjectMapper();
	
	private String filePath = "C:\\sensor_file_store\\";

	/**
	 * @Method Name : selectSensorInfoList
	 * @Description : 센서정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	public List<SensorVO> selectSensorInfoList(String searchingOrgId, String searchingLocalId, Pagination pagination, String sortColumn, String sortType, String searchingType, String searchingContent) throws Exception {
		
		SensorVO param = new SensorVO();
		param.setSearchingOrgId(searchingOrgId);
		param.setSearchingLocalId(searchingLocalId);
		param.setSearchingType(searchingType);
		param.setSearchingContent(searchingContent);
		param.setPagination(pagination);
		param.setSortColumn(sortColumn);
		param.setSortType(sortType);		
		
		List<SensorVO> list = mapper.selectSensorInfoList(param);
		return list;
	}
	
	/**
	 * @Method Name : selectSensorInfoListTotalCnt
	 * @Description : 센서정보 총개수
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.22  유성우      최초생성
	 * @
	 */
	public int selectSensorInfoListTotalCnt(String searchingOrgId, String searchingLocalId, String searchingType, String searchingContent) throws Exception {
		int listCnt = mapper.selectSensorInfoListTotalCnt(searchingOrgId, searchingLocalId, searchingType, searchingContent);
		return listCnt;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertSensorSave
	 * @Description : 센서 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean insertSensorSave(String sensorId, String usimId, String sensor, String organizationId,
			String localId, String outYn, String sensorDetail, String irrigationId) throws Exception {
		try {		
			mapper.insertSensorInfo(sensorId, usimId, outYn, sensorDetail);
			mapper.insertSensorControl(sensorId, sensor, organizationId, localId);
			mapper.insertSensorIrrigaton(sensorId, irrigationId);
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectSensorInfoDetail
	 * @Description : 기관정보 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public SensorVO selectSensorInfoDetail(String sensorId) throws Exception {
		SensorVO param = new SensorVO();
		SensorVO detail = new SensorVO();
		try {
			
			param.setSensorId(sensorId);
			
			detail = mapper.selectSensorInfoDetail(param);
			//File file = new File(filePath + detail.getUuidName());
			//detail.setFile(new FileInputStream(file));
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return detail;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectSensorModDetail
	 * @Description : 기관정보 수정조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public SensorVO selectSensorModDetail(String sensorId) throws Exception {
		SensorVO param = new SensorVO();
		param.setSensorId(sensorId);
		SensorVO modDetail = mapper.selectSensorInfoDetail(param);
		return modDetail;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateSensorInfoMod
	 * @Description : 센서정보 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean updateSensorInfoMod(String sensorId, String sensor, String usimId, String orgId, String localId, String sensorDetail, String outYn, String irrigationId) throws Exception {

		try {
			mapper.updateSensorMod(sensorId, usimId, sensorDetail, outYn);
			mapper.updateSensorControlMod(sensorId, sensor, orgId, localId);
			
			List<IrrigationVO> irrigatonList = mapper.selectIrrigationList(sensorId);
			if(irrigatonList.size() > 0) {
				mapper.updateSensorIrrigation(sensorId, irrigationId);
			} else {
				mapper.insertSensorIrrigaton(sensorId, irrigationId);
			}
			
		} catch(Exception e) {
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : deleteSensorInfoDel
	 * @Description : 센서정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public void deleteSensorInfoDel(String sensorId) throws Exception {
		try {
			mapper.deleteSensor(sensorId); // 해당 센서 삭제
			mapper.deleteSensorControl(sensorId); // 해당 센서 설정 삭제
		} catch(Exception e) {
			e.printStackTrace();
		}
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
	public Object selectSensorExcel(HttpServletResponse response, String searchingOrgId, String searchingLocalId, String personInCharge, Pagination pagination, String sortColumn, String sortType, String searchingType, String searchingContent) throws Exception {

		List<SensorVO> list = mapper.selectSensorInfoListExcel(searchingOrgId, searchingLocalId, pagination.getStartList(), pagination.getListSize(), sortColumn, sortType, searchingType, searchingContent);

        
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
    public void createExcelDownloadResponse(HttpServletResponse response, List<SensorVO> list) {
    	
        try{
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("센서정보_리스트");

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
            final String fileName = "센서정보_리스트";

            //헤더
            final String[] header = {"번호", "센서ID", "센서명", "지역명", "기관명", "배터리 잔량", "유심코드", "반출여부", "등록일", "센서위치설명", "관수ID", "관수명"};
            Row row = sheet.createRow(0);
            for (int i = 0; i < header.length; i++) {
                Cell cell = row.createCell(i);
                cell.setCellValue(header[i]);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                
                sheet.autoSizeColumn(i);                
                sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 3000);
                sheet.setDefaultRowHeight((short) (sheet.getDefaultRowHeight() + 30) );
            }
            
            //sheet.addMergedRegion(new CellRangeAddress(0, 0, 1, 2)); // CellRangeAddress(첫행, 마지막행, 첫열, 마지막열)
            
           
            
            //바디
            for (int i = 0; i < list.size(); i++) {
                row = sheet.createRow(i + 1);  //헤더 이후로 데이터가 출력되어야하니 +1

                SensorVO userPoint = list.get(i);

                Cell cell = null;
                cell = row.createCell(0);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getRownum()); // 번호

                cell = row.createCell(1);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getSensorId()); // 센서ID

                cell = row.createCell(2);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getSensor()); // 센서명

                cell = row.createCell(3);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getLocal()); // 지역명

                cell = row.createCell(4);                
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getOrganization()); // 기관명
                
                cell = row.createCell(5);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getBatcaprema() + "%"); // 배터리 잔량
                
                cell = row.createCell(6);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getUsimId()); // 유심코드
                
                cell = row.createCell(7);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getOutYn()); // 반출여부
                
                cell = row.createCell(8);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getRegDate()); // 등록일
                
                cell = row.createCell(9);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(StringEscapeUtils.unescapeHtml4(userPoint.getSensorDetail())); // 센서 설명
                
                cell = row.createCell(10);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getIrrigationId()); // 관수ID
                
                cell = row.createCell(11);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getIrrigationName()); // 관수명
                
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
	 * @Description : 기관아이디 중복체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.22  유성우      최초생성
	 * @
	 */
	public boolean selectDupCheck(String sensorId) throws Exception {
		boolean resultFlag = false;
		List<SensorVO> sensorList = mapper.selectSensorDupCheck(sensorId);
		List<SensorVO> sensorControlList = mapper.selectSensorControlDupCheck(sensorId);
		
		if(sensorList.size() > 0 || sensorControlList.size() > 0) {
			resultFlag = true; // 중복 true
		} else {
			resultFlag = false; // 중복 false
		}
		return resultFlag;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertSensorReplySave
	 * @Description : 센서 댓글 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean insertSensorReplySave(String writerId, String title, String locationDetail, String sensorId) throws Exception {
		try {		
			mapper.insertSensorReplyInfo(writerId, title, locationDetail, sensorId);
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertSensorReplySave
	 * @Description : 센서 댓글 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public int getSensorReplyId(String sensorId) throws Exception {
		int replyId = 0;
		try {		
			replyId =  mapper.getSensorReplyId(sensorId);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return replyId;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertReplyFileSave
	 * @Description : 센서 댓글 파일 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean insertReplyFileSave(int replyId, String uuidNm, String oriFileName, String fileSize) throws Exception {
		
		SensorVO sensorReplyParam = new SensorVO();
		
		sensorReplyParam.setReplyId(replyId);
		sensorReplyParam.setUuidName(uuidNm);
		sensorReplyParam.setOriFileName(oriFileName);
		sensorReplyParam.setFileSize(fileSize);
		
		try {					
			mapper.insertReplyFileSave(sensorReplyParam);
		} catch(Exception e) {
			return false;
		}
		
		return true;
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
	public List<SensorVO> selectSensorReplyList(String sensorId) throws Exception {
		List<SensorVO> list = mapper.selectSensorReplyList(sensorId);
		return list;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : deleteSensorInfoDel
	 * @Description : 센서정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean deleteSensorReply(int replyId) throws Exception {
		
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
            
            mapper.deleteSensorReply(replyId); // 댓글 삭제
			mapper.deleteSensorReplyFile(replyId); // 댓글 파일 삭제
            
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateSensorReplyMod
	 * @Description : 센서정보 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean updateSensorReplyMod(int replyId, String title, String locationDetail) throws Exception {

		try {
			SensorVO param = new SensorVO();
			param.setReplyId(replyId);
			param.setTitle(title);
			param.setSensorDetail(locationDetail);
			
			mapper.updateSensorReplyMod(param);
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
	public boolean deleteSensorReplyFile(int replyId) throws Exception {
		
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
	 * @Method Name : selectSensorReplyList
	 * @Description : 센서정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	public List<SensorVO> selectReplyFileList(int replyId) throws Exception {
		List<SensorVO> list = mapper.selectReplyFileList(replyId);
		return list;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateSensorReplyFileMod
	 * @Description : 센서정보 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean updateSensorReplyFileMod(int replyId, String finalUuidName, String oriFileName, String fileSize) throws Exception {
		
		try {
			SensorVO param = new SensorVO();
			param.setReplyId(replyId);
			param.setUuidName(finalUuidName);
			param.setOriFileName(oriFileName);
			param.setFileSize(fileSize);
			
			mapper.updateSensorReplyFileMod(param);
		} catch(Exception e) {
			return false;
		}
		
		return true;
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
	public List<IrrigationVO> selectIrrigationComboList(String localId) throws Exception {
		List<IrrigationVO> list = mapper.selectIrrigationComboList(localId);
		return list;
	}
	
}


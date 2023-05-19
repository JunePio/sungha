package com.gn.sungha.sensorControl;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.text.StringEscapeUtils;
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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gn.sungha.common.Pagination;
import com.gn.sungha.irrigation.IrrigationVO;
import com.gn.sungha.sensor.SensorVO;
import com.gn.sungha.sensorControl.SensorControlMapper;
import com.gn.sungha.sensorControl.SensorControlVO;

/*
 *  센서정보 서비스
 */ 

@Service
public class SensorControlService {

	@Autowired
	private SensorControlMapper mapper;
	
	@Autowired
	private final ObjectMapper objectMapper = new ObjectMapper();

	/**
	 * @Method Name : selectSensorControlList
	 * @Description : 센서정보 조회
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	public List<SensorControlVO> selectSensorControlList(String searchingOrgId, String searchingLocalId, Pagination pagination, String sortColumn, String sortType, String searchingType, String searchingContent) throws Exception {
		
		SensorControlVO param = new SensorControlVO();
		param.setSearchingOrgId(searchingOrgId);
		param.setSearchingLocalId(searchingLocalId);
		param.setSearchingType(searchingType);
		param.setSearchingContent(searchingContent);
		param.setPagination(pagination);
		param.setSortColumn(sortColumn);
		param.setSortType(sortType);		
		
		List<SensorControlVO> list = mapper.selectSensorControlList(param);
		return list;
	}
	
	/**
	 * @Method Name : selectSensorControlListTotalCnt
	 * @Description : 센서정보 총개수
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.22  유성우      최초생성
	 * @
	 */
	public int selectSensorControlListTotalCnt(String searchingOrgId, String searchingLocalId, String searchingType, String searchingContent) throws Exception {
		int listCnt = mapper.selectSensorControlListTotalCnt(searchingOrgId, searchingLocalId, searchingType, searchingContent);
		return listCnt;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertSensorSave
	 * @Description : 센서 저장
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean insertSensorSave(String sensorId, String chipId, String sensor, String organizationId,
			String localId, String sensorDetail) throws Exception {
		try {		
			mapper.insertSensor(sensorId, chipId);
			mapper.insertSensorControl(sensorId, sensor, organizationId, localId, sensorDetail);
		} catch(Exception e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectSensorControlDetail
	 * @Description : 기관정보 상세조회
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public SensorControlVO selectSensorControlDetail(String sensorId) throws Exception {
		SensorControlVO detail = new SensorControlVO();
		try {
			detail = mapper.selectSensorControlDetail(sensorId);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return detail;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectSensorModDetail
	 * @Description : 기관정보 수정조회
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public SensorControlVO selectSensorModDetail(String sensorId) throws Exception {
		SensorControlVO modDetail = mapper.selectSensorControlDetail(sensorId);
		return modDetail;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateSensorControlMod
	 * @Description : 센서 설정 수정
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean updateSensorControlMod(String sensorId, String alarmYn, String num, String batteryMin, String batteryMax, String temperatureMin, String temperatureMax,
			String humidityMin, String humidityMax, String pHMin, String pHMax, String ECMin, String ECMax, String NMin, String NMax, String PMin, String PMax, String KMin, String KMax) throws Exception {
		
		try {
			mapper.updateSensorControlMod(sensorId, alarmYn, num, batteryMin, batteryMax, temperatureMin, temperatureMax, humidityMin, humidityMax, pHMin, pHMax, ECMin, ECMax,
					NMin, NMax, PMin, PMax, KMin, KMax);
		} catch(Exception e) {
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : deleteSensorControlDel
	 * @Description : 센서정보 삭제
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public void deleteSensorControlDel(String sensorId) throws Exception {
		try {
			mapper.deleteSensor(sensorId); // tb_sensor에서 해당 센서 삭제
			mapper.deleteSensorControl(sensorId); // tb_sensor_control에서 해당 센서 설정 삭제
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		 
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectSensorControlDetailForMail
	 * @Description : 메일 발송할 센서 설정 정보 조회
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public SensorControlVO selectSensorDetailForMail(String sensorId) throws Exception {
		SensorControlVO detail = new SensorControlVO();
		try {
			detail = mapper.selectSensorDetailForMail(sensorId);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return detail;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectSensorControlDetailForMail
	 * @Description : 메일 발송할 센서 설정 정보 조회
	 * @Modification Control Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public List<SensorControlVO> selectSensorControlDetailForMail() throws Exception {
		List<SensorControlVO> detail = new ArrayList<SensorControlVO>();
		try {
			detail = mapper.selectSensorControlDetailForMail();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return detail;
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

		List<SensorControlVO> list = mapper.selectSensorControlListExcel(searchingOrgId, searchingLocalId, pagination.getStartList(), pagination.getListSize(), sortColumn, sortType, searchingType, searchingContent);

        
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
    public void createExcelDownloadResponse(HttpServletResponse response, List<SensorControlVO> list) {
    	
        try{
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("센서설정_리스트");

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
            final String fileName = "센서설정_리스트";

            //헤더
            final String[] header = {"번호", "센서ID", "센서명", "관수ID", "관수명", "유심코드", "지역명", "기관명", "배터리", "온도", "습도", "산도", "전도도", "질소", "인", "칼륨", "알람설정"};
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

                SensorControlVO userPoint = list.get(i);
                
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
                cell.setCellValue(userPoint.getIrrigationId()); // 관수ID

                cell = row.createCell(4);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getIrrigationName()); // 관수명

                cell = row.createCell(5);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getUsimId()); // 유심코드
                
                cell = row.createCell(6);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getLocal()); // 지역명

                cell = row.createCell(7);                
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getOrganization()); // 기관명
                
                cell = row.createCell(8);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getBatcaprema() + "%"); // 배터리                 
                
                cell = row.createCell(9);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getTemp() + "˚C"); // 온도
                
                cell = row.createCell(10);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getHumi() + "%"); // 습도
                
                cell = row.createCell(11);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getPh() + "PH"); // 산도
                
                cell = row.createCell(12);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getConduc() + "ds/m"); // 전도도
                
                cell = row.createCell(13);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getNitro() + "mg/kg"); // 질소
                
                cell = row.createCell(14);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getPhos() + "mg/kg"); // 인
                
                cell = row.createCell(15);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getPota() + "cmol/kg"); // 칼륨
                
                cell = row.createCell(16);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getAlarmYn()); // 알림설정
                
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
}


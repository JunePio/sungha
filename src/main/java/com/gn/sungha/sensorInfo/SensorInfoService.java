package com.gn.sungha.sensorInfo;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.sl.usermodel.VerticalAlignment;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gn.sungha.common.Pagination;
import com.gn.sungha.irrigation.IrrigationVO;
import com.gn.sungha.local.localVO;
import com.gn.sungha.organizationInfo.organizationInfoVO;

/**
 * @Class Name : SensorInfoService.java
 * @Description : 센서정보 Service
 * @param : chipId, deviceId, userLevel, firstIndex, lastIndex
 * @Modification Information
 * @ 수정일        수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2022.12.27  CHLEE      최초생성
 * @version 1.0 
 */

@Service
public class SensorInfoService {
	
	@Autowired
	private SensorInfoMapper mapper;
	
	@Autowired
	private final ObjectMapper objectMapper = new ObjectMapper();
	
	/** 관수정보 조회 */
	public List<SensorInfoVO> selectSensorInfoList(String searchingOrgId, String searchingLocalId, String datepicker, String datepicker1, Pagination pagination, String sortColumn, String sortType) throws Exception {
		
		SensorInfoVO param =  new SensorInfoVO();
		
		param.setSearchingOrgId(searchingOrgId);
		param.setSearchingLocalId(searchingLocalId);
		param.setDatepicker(datepicker);
		param.setDatepicker1(datepicker1);
		param.setSortColumn(sortColumn);
		param.setSortType(sortType);
		param.setPagination(pagination);
		
		
		List<SensorInfoVO> list = mapper.selectSensorInfoList(param);
		return list;
	}
	
	/**
	 * @Method Name : selectOrgInfoListTotalCnt
	 * @Description : 기관정보 총개수
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.22  유성우      최초생성
	 * @
	 */
	public int selectSensorInfoListTotalCnt(String searchingOrgId, String searchingLocalId, String datepicker, String datepicker1) throws Exception {
		int listCnt = mapper.selectSensorInfoListTotalCnt(searchingOrgId, searchingLocalId, datepicker, datepicker1);
		return listCnt;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectSensorInfoDetail
	 * @Description : 계측데이터 정보 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.27  이창호      최초생성
	 * @
	 */
	public SensorInfoVO selectSensorInfoDetail(String sensorId,String regDate,String temp,String humi,String ph,String conduc,String nitro,String phos,String pota,String batcaprema) throws Exception {
		SensorInfoVO detail = mapper.selectSensorInfoDetail(sensorId, regDate);
		return detail;
	}
	
	
	
	public Object getUsersPointStats(HttpServletResponse response, boolean excelDownload, String searchingOrgId, String searchingLocalId, String datepicker, String datepicker1, Pagination pagination, String sortColumn, String sortType) throws Exception {
		
		SensorInfoVO param =  new SensorInfoVO();
		
		param.setOrganizationId(searchingOrgId);
		param.setLocalId(searchingLocalId);
		param.setDatepicker(datepicker);
		param.setDatepicker1(datepicker1);
		param.setSortColumn(sortColumn);
		param.setSortType(sortType);
		param.setPagination(pagination);


		//List<SensorInfoVO> userPointList = mapper.selectSensorInfoList(searchingOrgId, searchingLocalId, datepicker, datepicker1, pagination.getStartList(), pagination.getListSize(), sortColumn, sortType);
		List<SensorInfoVO> userPointList = mapper.selectSensorInfoList(param);

        if(excelDownload){
            createExcelDownloadResponse(response, userPointList);
            return null; //없으면 에러!
        }
        
		List<Map> userPointMap = userPointList.stream()
                .map(userPoint -> objectMapper.convertValue(userPoint, Map.class))
                .collect(Collectors.toList());

        return userPointMap;
    }
	
	 /**
     * 엑셀 다운로드 구현
     */ 
    public void createExcelDownloadResponse(HttpServletResponse response, List<SensorInfoVO> userPointList) {

        try{
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("센서현황 계측데이터");
            
            // 상단 설명문구 스타일
            //숫자 포맷은 아래 numberCellStyle을 적용시킬 것이다다
            CellStyle descriptionStyle = workbook.createCellStyle();
            CellStyle numberCellStyle = workbook.createCellStyle();
            numberCellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
            
            // 테이블 헤더용 스타일
            CellStyle headStyle = workbook.createCellStyle();
            
            // 가는 경계선
            descriptionStyle.setBorderTop(BorderStyle.THIN);
            descriptionStyle.setBorderBottom(BorderStyle.THIN);
            descriptionStyle.setBorderLeft(BorderStyle.THIN);
            descriptionStyle.setBorderRight(BorderStyle.THIN);

            // 설명문구 가운데 정렬
            descriptionStyle.setAlignment(HorizontalAlignment.CENTER);
            descriptionStyle.setLocked(true);
            headStyle.setAlignment(HorizontalAlignment.CENTER);

            // 데이터용 경계 문자스타일 테두리만 지정
            headStyle.setBorderTop(BorderStyle.THIN);
            headStyle.setBorderBottom(BorderStyle.THIN);
            headStyle.setBorderLeft(BorderStyle.THIN);
            headStyle.setBorderRight(BorderStyle.THIN);
            
            // 데이터용 경계 숫자스타일 테두리만 지정
            numberCellStyle.setBorderTop(BorderStyle.THIN);
            numberCellStyle.setBorderBottom(BorderStyle.THIN);
            numberCellStyle.setBorderLeft(BorderStyle.THIN);
            numberCellStyle.setBorderRight(BorderStyle.THIN);
            
            // 데이터는 가운데 정렬, 숫자는 오른쪽 정렬
            headStyle.setAlignment(HorizontalAlignment.CENTER);
            numberCellStyle.setAlignment(HorizontalAlignment.RIGHT);
            headStyle.setLocked(true);
            
            // 내용 스타일
            CellStyle bodyStyle = workbook.createCellStyle();
            bodyStyle.setAlignment(HorizontalAlignment.CENTER);
            //bodyStyle.setVerticalAlignment(VerticalAlignment.CENTER);
            bodyStyle.setBorderTop(BorderStyle.THIN);
            bodyStyle.setBorderBottom(BorderStyle.THIN);
            bodyStyle.setBorderLeft(BorderStyle.THIN);
            bodyStyle.setBorderRight(BorderStyle.THIN);
            
            // 데이터 CENTER 정렬            
            CellStyle mergeRowStyle1 = workbook.createCellStyle();
            mergeRowStyle1.setAlignment(HorizontalAlignment.CENTER);
            //mergeRowStyle1.setVerticalAlignment(VerticalAlignment.CENTER);
            mergeRowStyle1.setBorderTop(BorderStyle.THICK);
            mergeRowStyle1.setBorderLeft(BorderStyle.MEDIUM_DASH_DOT_DOT);

            //파일명
            final String fileName = "센서현황 계측데이터 리스트";

            //헤더
            final String[] header = {"순번", "기관명", "지역명", "센서명","계측데이터", "수분함량(%)", "산도(pH)", "전도도(ds/m)", "질소(mg/kg)", "인(mg/kg)", "칼륨(cmol/kg)", "배터리잔량(%)","계측일시"};
            Row row = sheet.createRow(0);
            for (int i = 0; i < header.length; i++) {
                Cell cell = row.createCell(i);
                cell.setCellValue(header[i]);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                
                sheet.autoSizeColumn(i);
                sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 3000);
            }
            
            final String[] header1 = {"순번", "기관명", "지역명", "센서명", "온도(℃)", "수분함량(%)", "산도(pH)", "전도도(ds/m)", "질소(mg/kg)", "인(mg/kg)", "칼륨(cmol/kg)", "배터리잔량(%)","계측일시"};
            Row row1 = sheet.createRow(1);
            for (int i = 0; i < header1.length; i++) {
                Cell cell = row1.createCell(i);
                cell.setCellValue(header1[i]);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                
                sheet.autoSizeColumn(i);
                sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 3000);
            }

            sheet.addMergedRegion(new CellRangeAddress(0, 1, 0, 0)); // CellRangeAddress(첫행, 마지막행, 첫열, 마지막열) // 순번
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 1, 1)); // CellRangeAddress(첫행, 마지막행, 첫열, 마지막열) // 기관명
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 2, 2)); // CellRangeAddress(첫행, 마지막행, 첫열, 마지막열) // 지역명
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 3, 3)); // CellRangeAddress(첫행, 마지막행, 첫열, 마지막열) // 센서명
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 4, 11)); // CellRangeAddress(첫행, 마지막행, 첫열, 마지막열) // 계측데이터
            sheet.addMergedRegion(new CellRangeAddress(0, 1, 12, 12)); // CellRangeAddress(첫행, 마지막행, 첫열, 마지막열) // 계측일시
            

            //바디
            for (int i = 0; i < userPointList.size(); i++) {
                row = sheet.createRow(i + 2);  //헤더 이후로 데이터가 출력되어야하니 +1

                SensorInfoVO userPoint = userPointList.get(i);

                Cell cell = null;
                cell = row.createCell(0);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getRownum()); // 번호

                cell = row.createCell(1);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getOrganization()); // 기관명

                cell = row.createCell(2);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getLocal()); // 지역명

                cell = row.createCell(3);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getSensor()); // 센서명

                cell = row.createCell(4);
                cell.setCellStyle(numberCellStyle);      //숫자포맷 적용
                cell.setCellValue(userPoint.getTemp()); // 온도
                
                cell = row.createCell(5);
                cell.setCellStyle(numberCellStyle);      //숫자포맷 적용
                cell.setCellValue(userPoint.getHumi()); // 수분함량
                
                cell = row.createCell(6);
                cell.setCellStyle(numberCellStyle);      //숫자포맷 적용
                cell.setCellValue(userPoint.getConduc()); // 산도
                
                cell = row.createCell(7);
                cell.setCellStyle(numberCellStyle);      //숫자포맷 적용
                cell.setCellValue(userPoint.getPh()); // 전도도
                
                cell = row.createCell(8);
                cell.setCellStyle(numberCellStyle);      //숫자포맷 적용
                cell.setCellValue(userPoint.getNitro()); // 질소
                
                cell = row.createCell(9);
                cell.setCellStyle(numberCellStyle);      //숫자포맷 적용
                cell.setCellValue(userPoint.getPhos()); // 인
                
                cell = row.createCell(10);
                cell.setCellStyle(numberCellStyle);      //숫자포맷 적용
                cell.setCellValue(userPoint.getPota()); // 칼륨
                
                cell = row.createCell(11);
                cell.setCellStyle(numberCellStyle);      //숫자포맷 적용
                cell.setCellValue(userPoint.getBatcaprema()); // 배터리잔량
                
                cell = row.createCell(12);
                cell.setCellStyle(numberCellStyle);      //숫자포맷 적용
                cell.setCellValue(userPoint.getRegDate()); // 배터리잔량
                
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
	 * @throws Exception 
	 * @Method Name : selectSensorControlInfoDetail
	 * @Description : 계측데이터 임계치 정보 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.27  이창호      최초생성
	 * @
	 */
    public SensorInfoVO selectSensorControlInfoDetail(String sensorId) throws Exception {
		SensorInfoVO detail = mapper.selectSensorControlInfoDetail(sensorId);
		return detail;
	}
	
    
    /**
	 * @throws Exception 
	 * @Method Name : selectSensorInfData
	 * @Description : 항목별 센서정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2023.02.07  이창호      최초생성
	 * @
	 */
	public List<SensorInfoVO> selectSensorInfoSearchData(String searchingOrgId, String searchingLocalId, String searchingSensorId, String searchingSensorGubun) throws Exception {
		
		List<SensorInfoVO> list = mapper.selectSensorInfoSearchData(searchingOrgId, searchingLocalId, searchingSensorId, searchingSensorGubun);
		return list;
	}
	
    
    
    
    
}
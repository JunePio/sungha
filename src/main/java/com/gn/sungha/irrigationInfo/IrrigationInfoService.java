package com.gn.sungha.irrigationInfo;

import java.io.IOException;
import java.net.URLEncoder;
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
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gn.sungha.common.Pagination;

/**
 * @Class Name : IrrigationInfoService.java
 * @Description : 관수정보 Service
 * @param : irrId, irrName, orgId, userLevel, firstIndex, lastIndex
 * @Modification Information
 * @ 수정일        수정자           수정내용
 * @ ----------  -------  -------------------------------
 * @ 2022.12.08  CHLEE      최초생성
 * @version 1.0
 */

@Service

public class IrrigationInfoService {
	
	@Autowired
	private IrrigationInfoMapper mapper;
	
	@Autowired
	private final ObjectMapper objectMapper = new ObjectMapper();
	
	/**
	 * @Method Name : selectIrrigationInfoList
	 * @Description : 관수정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.08  이창호      최초생성
	 * @
	 */
	public List<IrrigationInfoVO> selectIrrigationInfoList(String irrigationId, String irrigation, String organizationId, Pagination pagination, String sortColumn, String sortType) throws Exception {
		List<IrrigationInfoVO> list = mapper.selectIrrigationInfoList(irrigationId, irrigation, organizationId, pagination.getStartList(), pagination.getListSize(), sortColumn, sortType);
		return list;
	}
	
	/**
	 * @Method Name : selectIrrigationInfoListTotalCnt
	 * @Description : 관수정보 총개수
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.28  이창호      최초생성
	 * @
	 */
	public int selectIrrigationInfoListTotalCnt(String irrigationId, String irrigation, String organizationId) throws Exception {
		int listCnt = mapper.selectIrrigationInfoListTotalCnt(irrigationId, irrigation, organizationId);
		return listCnt;
	}
	
	
	
	/**
	 * @Method Name : selectDupCheck
	 * @Description : 관수아이디 중복체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.23  이창호      최초생성
	 * @
	 */
	public boolean selectDupCheck(String irrigationId) throws Exception {
		boolean resultFlag = false;
		List<IrrigationInfoVO> list = mapper.selectDupCheck(irrigationId);
		if(list.size() > 0)
			resultFlag = true;
		return resultFlag;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectirrigationInfoSave
	 * @Description : 관수정보 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.22  이창호      최초생성
	 * @
	 */
	public boolean selectIrrigationInfoSave(String irrigationId, String irrigation, String streamTime, String streamFlow, String nutrientTime, String nutrientSolution, String organizationId) throws Exception {
		try {		
			mapper.insertIrrigationInfoSave(irrigationId, irrigation, streamTime, streamFlow, nutrientTime, nutrientSolution, organizationId);
		} catch(Exception e) {
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectirrigationInfoDetail
	 * @Description : 관수정보 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.28  이창호      최초생성
	 * @
	 */
	public IrrigationInfoVO selectIrrigationInfoDetail(String irrigationId) throws Exception {
		IrrigationInfoVO detail = mapper.selectIrrigationInfoDetail(irrigationId);
		return detail;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectOrgInfoModDetail
	 * @Description : 기관정보 수정조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public IrrigationInfoVO selectIrrigationInfoModDetail(String irrigationId) throws Exception {
		IrrigationInfoVO modDetail = mapper.selectIrrigationInfoModDetail(irrigationId);
		return modDetail;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateOrgInfoMod
	 * @Description : 기관정보 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public void updateIrrigationInfoMod(String irrigationIdDetail, String irrigationId, String irrigation, String streamTime, String streamFlow, String nutrientTime, String nutrientSolution, String organizationId) throws Exception {
		try {		
			mapper.updateIrrigationInfoMod(irrigationIdDetail, irrigationId, irrigation, streamTime, streamFlow, nutrientTime, nutrientSolution, organizationId);
		} catch(Exception e) {
			System.out.println("XXXX" + e);
		}
	
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectOrgInfoDel
	 * @Description : 기관정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public void deleteIrrigationInfoDel(String irrigationId) throws Exception {
		 try {		
			 mapper.deleteIrrigationInfoDel(irrigationId);
			} catch(Exception e) {
				
			}
	}
	
	public Object getUsersPointStats(HttpServletResponse response, boolean excelDownload, String irrigationId, String irrigation, String organizationId, Pagination pagination, String sortColumn, String sortType) throws Exception {

		List<IrrigationInfoVO> userPointList = mapper.selectIrrigationInfoList(irrigationId, irrigation, organizationId, pagination.getStartList(), pagination.getListSize(), sortColumn, sortType);

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
    public void createExcelDownloadResponse(HttpServletResponse response, List<IrrigationInfoVO> userPointList) {

        try{
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("관수제어 현장정보");
            
            // 상단 설명문구 스타일
            CellStyle descriptionStyle = workbook.createCellStyle();
            
            //숫자 포맷은 아래 numberCellStyle을 적용시킬 것이다다
            CellStyle numberCellStyle = workbook.createCellStyle();
            numberCellStyle.setDataFormat(HSSFDataFormat.getBuiltinFormat("#,##0"));
            
            // 테이블 헤더용 스타일
            CellStyle headStyle = workbook.createCellStyle();
            
            // 가는 경계선
            descriptionStyle.setBorderTop(BorderStyle.THIN);
            descriptionStyle.setBorderBottom(BorderStyle.THIN);
            descriptionStyle.setBorderLeft(BorderStyle.THIN);
            descriptionStyle.setBorderRight(BorderStyle.THIN);
            
            // 가는 경계선
            numberCellStyle.setBorderTop(BorderStyle.THIN);
            numberCellStyle.setBorderBottom(BorderStyle.THIN);
            numberCellStyle.setBorderLeft(BorderStyle.THIN);
            numberCellStyle.setBorderRight(BorderStyle.THIN);
            
            // 설명문구 가운데 정렬, 숫자형은 오른쪽 정렬
            descriptionStyle.setAlignment(HorizontalAlignment.CENTER);
            descriptionStyle.setLocked(true);
            numberCellStyle.setAlignment(HorizontalAlignment.RIGHT);
            
            // 헤더 가는 경계선
            headStyle.setBorderTop(BorderStyle.THIN);
            headStyle.setBorderBottom(BorderStyle.THIN);
            headStyle.setBorderLeft(BorderStyle.THIN);
            headStyle.setBorderRight(BorderStyle.THIN);
            
            // 데이터는 가운데 정렬
            headStyle.setAlignment(HorizontalAlignment.CENTER);
            headStyle.setLocked(true);
            
            // 내용 스타일
            CellStyle bodyStyle = workbook.createCellStyle();
            bodyStyle.setAlignment(HorizontalAlignment.CENTER);
            //bodyStyle.setVerticalAlignment(VerticalAlignment.CENTER);
            bodyStyle.setBorderTop(BorderStyle.THIN);
            bodyStyle.setBorderBottom(BorderStyle.THIN);
            bodyStyle.setBorderLeft(BorderStyle.THIN);
            bodyStyle.setBorderRight(BorderStyle.THIN);

            //파일명
            final String fileName = "관수제어 현장정보 리스트";

            //헤더
            final String[] header = {"순번", "관수ID", "관수명", "유량투입시간(분)", "유량투입량(L)", "양액투입시간(분)", "양액투입량(L)", "현장ID", "등록일자"};
            Row row = sheet.createRow(0);
            for (int i = 0; i < header.length; i++) {
                Cell cell = row.createCell(i);
                cell.setCellValue(header[i]);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                
                sheet.autoSizeColumn(i);
                sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 3000);
            }
            
            
            //바디
            for (int i = 0; i < userPointList.size(); i++) {
                row = sheet.createRow(i + 1);  //헤더 이후로 데이터가 출력되어야하니 +1

                IrrigationInfoVO userPoint = userPointList.get(i);

                Cell cell = null;
                cell = row.createCell(0);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getRownum()); // 번호

                cell = row.createCell(1);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getIrrigationId()); // 관수ID

                cell = row.createCell(2);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getIrrigation()); // 관수명

                cell = row.createCell(3);
                cell.setCellStyle(numberCellStyle);      //숫자포맷 적용
                cell.setCellValue(userPoint.getStreamTime()); // 유량투입시간(분)

                cell = row.createCell(4);
                cell.setCellStyle(numberCellStyle);      //숫자포맷 적용
                cell.setCellValue(userPoint.getStreamFlow()); // 유량투입량(L)
                
                cell = row.createCell(5);
                cell.setCellStyle(numberCellStyle);      //숫자포맷 적용
                cell.setCellValue(userPoint.getNutrientTime()); // 양액투입시간(분)
                
                cell = row.createCell(6);
                cell.setCellStyle(numberCellStyle);      //숫자포맷 적용
                cell.setCellValue(userPoint.getNutrientSolution()); // 양액투입량(L)
                
                cell = row.createCell(7);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getOrganizationId()); // 현장ID
                
                cell = row.createCell(8);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getRegDate()); // 등록일자

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

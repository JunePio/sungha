package com.gn.sungha.local;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.RandomStringUtils;
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
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gn.sungha.common.Pagination;
import com.gn.sungha.organizationInfo.organizationInfoVO;

@Service
public class localService {

	@Autowired
	private localMapper mapper;
	
	@Autowired
	private final ObjectMapper objectMapper = new ObjectMapper();
	
	//@Value("${spring.servlet.multipart.location}")
	private String filePath = "C:\\local_file_store\\";;
	
	/**
	 * @Method Name : selectLocalList
	 * @Description : 지역 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	public List<localVO> selectLocalList(String searchingOrgId, String searchingLocalId, Pagination pagination, String sortColumn, String sortType) throws Exception {
		
		localVO param = new localVO();
		param.setOrganizationId(searchingOrgId);
		param.setLocalId(searchingLocalId);
		param.setSortColumn(sortColumn);
		param.setSortType(sortType);
		param.setPagination(pagination);
		
		List<localVO> list = mapper.selectLocalList(param);
		return list;
	}
	
	/**
	 * @Method Name : selectLocalListTotalCnt
	 * @Description : 지역 총개수
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.22  유성우      최초생성
	 * @
	 */
	public int selectLocalListTotalCnt(String searchingOrgId, String searchingLocalId) throws Exception {
		int listCnt = mapper.selectLocalListTotalCnt(searchingOrgId, searchingLocalId);
		return listCnt;
	}
	
	public String selectLatestLocalId() {
		
		String localId = RandomStringUtils.random(36, true, true);
		
		//String temp = mapper.selectLatestLocalId();
		//String temp2 = temp.substring(2);
		//int sub = Integer.parseInt(temp2);
		//String localId = sub + String.format("%08d", 1);
		return localId;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectLocalDelIsOk
	 * @Description : 기관정보 삭제해도 되는지 사용자, 센서, 관수 체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean deleteLocalDelIsOk(String localId) throws Exception {
		boolean checkResult = true;
		localVO checkCount = mapper.selectEtcInfoCount(localId);
		// 사용자 수, 센서 수, 관수 수 1개이상 있으면 false 리턴
		if(checkCount.getUserCnt() > 0 || checkCount.getSensorCnt() > 0 || checkCount.getDeviceCnt() > 0) {
			checkResult = false;
		}
		return checkResult;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectLocalSave
	 * @Description : 지역 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean insertLocalSave(String localId, String localNm, String registOrgId, String localAddressMain,
			String localAddressSub, String localNx, String localNy) throws Exception {
		
		try {
			mapper.insertLocalSave(localId, localNm, registOrgId, localAddressMain, localAddressSub, localNx, localNy);
		} catch(Exception e) {
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertLocalFileSave
	 * @Description : 지역 파일 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean insertLocalFileSave(String localId, String uuidNm, String oriFileName, String fileSize, int i) throws Exception {
		
		try {					
			mapper.insertLocalFileSave(localId, uuidNm, oriFileName, fileSize, String.valueOf(i));
		} catch(Exception e) {
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectLocalModDetail
	 * @Description : 지역 수정조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public localVO selectLocalModDetail(String localId) throws Exception {
		localVO modDetail = mapper.selectLocalModDetail(localId);
		return modDetail;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectLocalFileList
	 * @Description : 지역 파일 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public List<localVO> selectLocalFileList(String localId) throws Exception {
		List<localVO> modDetail = mapper.selectLocalFileList(localId);
		return modDetail;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateLocalModNoFile
	 * @Description : 지역 수정 파일 업로드 제외
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public void updateLocalModNoFile(String orgIdMod, String localIdMod, String localNmMod, String localAddressMainMod, String localAddressSubMod, String localNxMod, String localNyMod) throws Exception {
		mapper.updateLocalModNoFile(orgIdMod, localIdMod, localNmMod, localAddressMainMod, localAddressSubMod, localNxMod, localNyMod);
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateLocalMod
	 * @Description : 지역 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public void updateLocalMod(String orgIdMod, String localIdMod, String localNmMod, String localAddressMainMod, String localAddressSubMod, String localNxMod, String localNyMod) throws Exception {
		mapper.updateLocalMod(orgIdMod, localIdMod, localNmMod, localAddressMainMod, localAddressSubMod, localNxMod, localNyMod);
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateLocalModFileDel
	 * @Description : 지역 수정 & 파일 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public void updateLocalModFileDel(String orgIdMod, String localIdMod, String localNmMod, String localAddressMainMod, String localAddressSubMod, String localNxMod, String localNyMod) throws Exception {
		//mapper.deleteLocalFile(localIdMod);
		mapper.updateLocalMod(orgIdMod, localIdMod, localNmMod, localAddressMainMod, localAddressSubMod, localNxMod, localNyMod);
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateLocalFileMod
	 * @Description : 지역 파일 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public void updateLocalFileMod(String localIdMod, String uuid, String oriFileName, String fileSize, int i) throws Exception {
		mapper.updateLocalFileMod(localIdMod, uuid, oriFileName, fileSize, String.valueOf(i));
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectLocalDel
	 * @Description : 지역 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean localDelValidationCheck(String localIdVal) throws Exception {
		 boolean result = true;
		 
		 try {
			 localVO temp = mapper.localDelValidationCheck(localIdVal);
			 if(temp.getUserCnt() > 0 || temp.getSensorCnt() > 0 || temp.getDeviceCnt() > 0) {
				 result = false;
			 }
		 } catch(Exception e) {
			 result = false;
		 }
		 
		 return result;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : deleteLocal
	 * @Description : 지역 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean deleteLocal(String localIdDel) throws Exception {
		
		//String srcFileName = null;
		//List<String> uuidNames = new ArrayList<String>();
		
        try{
        	/*
        	uuidNames = mapper.selectOriFileName(localIdDel);
        	for(String uuidName : uuidNames) {
        		if(uuidName != null && uuidName != "") {
            		srcFileName = URLDecoder.decode(uuidName,"UTF-8");
                    //UUID가 포함된 파일이름을 디코딩해줍니다.
                    File file = new File(filePath +File.separator + srcFileName);
                    boolean result = file.delete();

                    File thumbnail = new File(file.getParent(),"s_"+file.getName());
                    //getParent() - 현재 File 객체가 나태내는 파일의 디렉토리의 부모 디렉토리의 이름 을 String으로 리턴해준다.
                    result = thumbnail.delete();
            	}
        	}
        	*/
                        
            mapper.deleteLocal(localIdDel);
            //mapper.deleteLocalFile(localIdDel);
            
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
	}
	
	public boolean deleteViewMapFile(String localId) {
		
		String srcFileName = null;
		List<String> uuidNames = new ArrayList<String>();
		
        try{
        	uuidNames = mapper.selectOriFileName(localId);
        	for(String uuidName : uuidNames) {
        		if(uuidName != null && uuidName != "") {
            		srcFileName = URLDecoder.decode(uuidName,"UTF-8");
                    //UUID가 포함된 파일이름을 디코딩해줍니다.
                    File file = new File(filePath +File.separator + srcFileName);
                    boolean result = file.delete();

                    File thumbnail = new File(file.getParent(),"s_"+file.getName());
                    //getParent() - 현재 File 객체가 나태내는 파일의 디렉토리의 부모 디렉토리의 이름 을 String으로 리턴해준다.
                    result = thumbnail.delete();
            	}
        	}
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
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
	public boolean deleteLocalViewFile(String localIdDel) throws Exception {
		
		String srcFileName = null;
		List<String> uuidNames = new ArrayList<String>();
		
        try{
        	uuidNames = mapper.selectOriFileName(localIdDel);
        	for(String uuidName : uuidNames) {
        		if(uuidName != null && uuidName != "") {
            		srcFileName = URLDecoder.decode(uuidName,"UTF-8");
                    //UUID가 포함된 파일이름을 디코딩해줍니다.
                    File file = new File(filePath +File.separator + srcFileName);
                    boolean result = file.delete();

                    File thumbnail = new File(file.getParent(),"s_"+file.getName());
                    //getParent() - 현재 File 객체가 나태내는 파일의 디렉토리의 부모 디렉토리의 이름 을 String으로 리턴해준다.
                    result = thumbnail.delete();
            	}
        	}
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
        
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectOriFileName
	 * @Description : 원본 파일 이름 가져오기
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public List<String> selectOriFileName(String localIdMod) throws Exception {
        return mapper.selectOriFileName(localIdMod);
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectLocalXY
	 * @Description : 해당 지역의 위도, 경도 좌표 가져오기
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public localVO selectLocalXY(String localId) throws Exception {
        return mapper.selectLocalXY(localId);
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
	public Object selectOrgExcel(HttpServletResponse response, String searchingOrgId, String searchingLocalId, String personInCharge, Pagination pagination, String sortColumn, String sortType) throws Exception {

		localVO param = new localVO();
		param.setOrganizationId(searchingOrgId);
		param.setLocalId(searchingLocalId);
		param.setSortColumn(sortColumn);
		param.setSortType(sortType);
		
		List<localVO> list = mapper.selectLocalListExcel(param);

        
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
    public void createExcelDownloadResponse(HttpServletResponse response, List<localVO> list) {
    	
        try{
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("지역_리스트");

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
            final String fileName = "지역_리스트";

            //헤더
            final String[] header = {"번호", "기관명", "지역명", "주소", "경도", "위도", "등록일(수정일)"};
            Row row = sheet.createRow(0);
            for (int i = 0; i < header.length; i++) {
                Cell cell = row.createCell(i);
                cell.setCellValue(header[i]);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                
                sheet.autoSizeColumn(i);                
                sheet.setColumnWidth(i, sheet.getColumnWidth(i) + 5000);
                sheet.setDefaultRowHeight((short) (sheet.getDefaultRowHeight() + 30) );
            }
            
            //sheet.addMergedRegion(new CellRangeAddress(0, 0, 1, 2)); // CellRangeAddress(첫행, 마지막행, 첫열, 마지막열)
            
           
            
            //바디
            for (int i = 0; i < list.size(); i++) {
                row = sheet.createRow(i + 1);  //헤더 이후로 데이터가 출력되어야하니 +1

                localVO userPoint = list.get(i);

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
                cell.setCellValue(userPoint.getLocalAddress()); // 주소

                cell = row.createCell(4);                
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getLocalNx()); // 경도
                
                cell = row.createCell(5);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getLocalNy()); // 위도
                
                cell = row.createCell(6);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getRegDate()); // 등록일(수정일)
                
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

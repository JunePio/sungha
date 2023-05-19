package com.gn.sungha.organizationInfo;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
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
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.postgresql.shaded.com.ongres.scram.common.util.CryptoUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gn.sungha.common.Pagination;
import com.gn.sungha.common.SHA;
import com.gn.sungha.common.Util;
import com.gn.sungha.local.localMapper;
import com.gn.sungha.local.localService;
import com.gn.sungha.local.localVO;
import com.gn.sungha.sensor.SensorVO;
import com.gn.sungha.userMng.UserMngMapper;
import com.gn.sungha.userMng.UserMngVO;

/*
 *  기관정보 서비스
 */

@Service
public class organizationInfoService {
	
	@Autowired
	private organizationInfoMapper mapper;
	
	@Autowired
	private localMapper localMapper;
	
	@Autowired
	private UserMngMapper userMngMapper;
	
	@Autowired
	private final ObjectMapper objectMapper = new ObjectMapper();
	
	@Autowired
	private localService localService;
	
	@Autowired
	private SHA sha;
	
	/**
	 * @Method Name : selectOrgInfoList
	 * @Description : 기관정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	public List<organizationInfoVO> selectOrgInfoList(String searchingOrgId, String searchingLocalId, String personInCharge, Pagination pagination, String sortColumn, String sortType) throws Exception {
		
		organizationInfoVO param = new organizationInfoVO();
		param.setOrganizationId(searchingOrgId);
		param.setLocalId(searchingLocalId);
		param.setPersonInCharge(personInCharge);
		param.setPagination(pagination);
		param.setSortColumn(sortColumn);
		param.setSortType(sortType);
		
		List<organizationInfoVO> list = mapper.selectOrgInfoList(param);
		
		for(organizationInfoVO info : list) {
			if(!Util.isEmpty(info.getEmail())) {
				info.setEmail(sha.decryptAES256(info.getEmail()));
			}
			if(!Util.isEmpty(info.getTelNo())) {
				info.setTelNo(sha.decryptAES256(info.getTelNo()));
				info.setTelNo(info.getTelNo().substring(0, 3) + "-" + info.getTelNo().substring(3, 7) + "-" + info.getTelNo().substring(7, 11));
			}
		}
		
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
	public int selectOrgInfoListTotalCnt(String searchingOrgId, String searchingLocalId, String personInCharge) throws Exception {
		int listCnt = mapper.selectOrgInfoListTotalCnt(searchingOrgId, searchingLocalId, personInCharge);
		return listCnt;
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
	public boolean selectDupCheck(String orgId) throws Exception {
		boolean resultFlag = false;
		List<organizationInfoVO> orgList = mapper.selectOrgDupCheck(orgId);
		List<localVO> localList = mapper.selectLocalDupCheck(orgId);
		List<UserMngVO> userMngList = mapper.selectUserMngDupCheck(orgId);
		if(orgList.size() > 0 || localList.size() > 0 || userMngList.size() > 0) {
			resultFlag = true; // 중복 true
		} else {
			resultFlag = false; // 중복 false
		}
		return resultFlag;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectOrgInfoSave
	 * @Description : 기관정보 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean insertOrgInfoSave(String orgId, String orgNm, String personInCharge, String telNo, String email) throws Exception {
		
		telNo = sha.encryptAES256(telNo);
		email = sha.encryptAES256(email);
		String inputUserPw = sha.encryptAES256(orgId);
		
		try {		
			mapper.insertOrgInfoSave(orgId, orgNm, personInCharge, telNo, email); // 기관 정보 등록
			String localId = orgId;
			String localNm = orgNm;
			String registOrgId = orgId;
			String localAddressMain = "";
			String localAddressSub = "";
			String localNx = "";
			String localNy = "";
			String inputUserId = orgId;
			String inputUserNm = orgNm;
			String userLevelRegist = "ORG_ADMIN";
			String confirmState = "complete";
			
			localMapper.insertLocalSave(localId, localNm, registOrgId, localAddressMain, localAddressSub, localNx, localNy); // 지역 정보 등록
			mapper.insertUserMngSave(inputUserId, inputUserNm, registOrgId, userLevelRegist, telNo, email, confirmState, inputUserPw); // 사용자 정보 등록
			int id = userMngMapper.selectUserMngId(inputUserId);
			HashMap<String, Object> userMngObject = new HashMap<String, Object>();
			userMngObject.put("id", id);
			userMngObject.put("localId", localId);
			userMngMapper.insertUserMngRoleLocal(userMngObject);
		} catch(Exception e) {
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectOrgInfoDetail
	 * @Description : 기관정보 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public organizationInfoVO selectOrgInfoDetail(String organizationId) throws Exception {
		organizationInfoVO detail = mapper.selectOrgInfoDetail(organizationId);
		
		if(!Util.isEmpty(detail.getEmail())) {
			detail.setEmail(sha.decryptAES256(detail.getEmail()));
			String[] temp = detail.getEmail().split("@", 2);
			detail.setEmailHead(temp[0]);
			detail.setEmailBody(temp[1]);
		}
		if(!Util.isEmpty(detail.getTelNo())) {
			detail.setTelNo(sha.decryptAES256(detail.getTelNo()));
			detail.setTelNo(detail.getTelNo().substring(0, 3) + "-" + detail.getTelNo().substring(3, 7) + "-" + detail.getTelNo().substring(7, 11));
			detail.setTelNoMiddle(detail.getTelNo().substring(3, 7));
			detail.setTelNoEnd(detail.getTelNo().substring(7, 11));
		}
		
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
	public organizationInfoVO selectOrgInfoModDetail(String organizationId) throws Exception {
		organizationInfoVO modDetail = mapper.selectOrgInfoModDetail(organizationId);
		
		if(!Util.isEmpty(modDetail.getEmail())) {
			modDetail.setEmail(sha.decryptAES256(modDetail.getEmail()));
			String[] temp = modDetail.getEmail().split("@", 2);
			modDetail.setEmailHead(temp[0]);
			modDetail.setEmailBody(temp[1]);
		}
		if(!Util.isEmpty(modDetail.getTelNo())) {
			modDetail.setTelNo(sha.decryptAES256(modDetail.getTelNo()));
			//modDetail.setTelNo(modDetail.getTelNo().substring(0, 3) + "-" + modDetail.getTelNo().substring(3, 7) + "-" + modDetail.getTelNo().substring(7, 11));
			modDetail.setTelNoMiddle(modDetail.getTelNo().substring(3, 7));
			modDetail.setTelNoEnd(modDetail.getTelNo().substring(7, 11));
		}
		
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
	public void updateOrgInfoMod(String orgId, String orgNm, String personInCharge, String telNo, String email) throws Exception {
		
		telNo = sha.encryptAES256(telNo);
		email = sha.encryptAES256(email);
		
		mapper.updateOrgInfoMod(orgId, orgNm, personInCharge, telNo, email);
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectOrgInfoDelIsOk
	 * @Description : 기관정보 삭제해도 되는지 사용자, 센서, 관수 체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean deleteOrgInfoDelIsOk(String organizationId) throws Exception {
		boolean checkResult = true;
		organizationInfoVO checkCount = mapper.selectEtcInfoCount(organizationId);
		// 사용자 수, 센서 수, 관수 수 1개이상 있으면 false 리턴
		if(checkCount.getUserCnt() > 0 || Integer.parseInt(checkCount.getSensorCnt()) > 0 || checkCount.getDeviceCnt() > 0) {
			checkResult = false;
		}
		return checkResult;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectOrgInfoDel
	 * @Description : 기관정보 삭제 + 지역도 같이 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public void deleteOrgInfoDel(String organizationId) throws Exception {
		 //List<localVO> localIdList = localMapper.selectLocalIdList(organizationId);
		 //for(localVO localId : localIdList) {
			 //localService.deleteViewMapFile(localId.getLocalId()); // 지역과 연계되어 있는 html, jpg 조감도 파일 삭제
			 //localMapper.deleteLocalFile(localId.getLocalId()); // 지역과 연계되어 있는 조감도 파일정보 삭제
		 //}
		 mapper.deleteLocalDel(organizationId);   // 지역정보 삭제
		 mapper.deleteOrgInfoDel(organizationId); // 기관정보 삭제
		 
	}
	
	public Object getUsersPointStats(HttpServletResponse response, boolean excelDownload, String searchingOrgId, String searchingLocalId, String personInCharge, Pagination pagination, String sortColumn, String sortType) throws Exception {
		
		organizationInfoVO param = new organizationInfoVO();
		param.setOrganizationId(searchingOrgId);
		param.setLocalId(searchingLocalId);
		param.setPersonInCharge(personInCharge);
		param.setStartList(pagination.getStartList());
		param.setListSize(pagination.getListSize());
		param.setSortColumn(sortColumn);
		param.setSortType(sortType);
		
        List<organizationInfoVO> userPointList = mapper.selectOrgInfoList(param);
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

		organizationInfoVO param = new organizationInfoVO();
		param.setOrganizationId(searchingOrgId);
		param.setLocalId(searchingLocalId);
		param.setPersonInCharge(personInCharge);
		param.setPagination(pagination);
		param.setSortColumn(sortColumn);
		param.setSortType(sortType);
		
		List<organizationInfoVO> list = mapper.selectOrgInfoListExcel(param);

		for(organizationInfoVO info : list) {
			if(!Util.isEmpty(info.getEmail())) {
				info.setEmail(sha.decryptAES256(info.getEmail()));
			}
			if(!Util.isEmpty(info.getTelNo())) {
				info.setTelNo(sha.decryptAES256(info.getTelNo()));
				info.setTelNo(info.getTelNo().substring(0, 3) + "-" + info.getTelNo().substring(3, 7) + "-" + info.getTelNo().substring(7, 11));
			}
		}
		
		
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
    public void createExcelDownloadResponse(HttpServletResponse response, List<organizationInfoVO> list) {
    	
        try{
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("기관정보_리스트");

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
            final String fileName = "기관정보_리스트";

            //헤더
            final String[] header = {"번호", "기관ID", "기관명", "지역명", "사용자수", "센서수", "관수수", "담당자명", "연락처", "이메일", "등록일(수정일)"};
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

                organizationInfoVO userPoint = list.get(i);

                Cell cell = null;
                cell = row.createCell(0);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getRownum()); // 번호

                cell = row.createCell(1);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getOrganizationId()); // 기관ID

                cell = row.createCell(2);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getOrganization()); // 기관명

                cell = row.createCell(3);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getLocals()); // 지역명

                cell = row.createCell(4);                
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getUserCnt()); // 사용자수
                
                cell = row.createCell(5);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getSensorCnt()); // 센서수
                
                cell = row.createCell(6);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getDeviceCnt()); // 관수수
                
                cell = row.createCell(7);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getPersonInCharge()); // 담당자명
                
                cell = row.createCell(8);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getTelNo()); // 연락처
                
                cell = row.createCell(9);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getEmail()); // 이메일
                
                cell = row.createCell(10);
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

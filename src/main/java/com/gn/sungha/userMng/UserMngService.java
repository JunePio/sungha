package com.gn.sungha.userMng;

import java.io.IOException;
import java.net.URLEncoder;
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
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.gn.sungha.common.Pagination;
import com.gn.sungha.common.SHA;
import com.gn.sungha.common.Util;
import com.gn.sungha.local.localVO;
import com.gn.sungha.organizationInfo.organizationInfoMapper;
import com.gn.sungha.organizationInfo.organizationInfoVO;

/*
 *  사용자정보 서비스
 */

@Service
public class UserMngService {

	@Autowired
	private UserMngMapper mapper;
	
	@Autowired
	private final ObjectMapper objectMapper = new ObjectMapper();
	
	@Autowired
	private SHA sha;
	
	/**
	 * @Method Name : selectUserMngList
	 * @Description : 기관정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	public List<UserMngVO> selectUserMngList(String searchingOrgId, String searchingLocalId, String searchingType, String searchingContent, Pagination pagination, String sortColumn, String sortType) throws Exception {
		
		UserMngVO param = new UserMngVO();
		param.setSearchingOrgId(searchingOrgId);
		param.setSearchingLocalId(searchingLocalId);
		param.setSearchingType(searchingType);
		param.setSearchingContent(searchingContent);
		param.setPagination(pagination);
		param.setSortColumn(sortColumn);
		param.setSortType(sortType);
		
		List<UserMngVO> list = mapper.selectUserMngList(param);
		
		for(UserMngVO info : list) {
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
	 * @Method Name : selectUserMngListTotalCnt
	 * @Description : 기관정보 총개수
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.22  유성우      최초생성
	 * @
	 */
	public int selectUserMngListTotalCnt(String searchingOrgId, String searchingLocalId, String searchingType, String searchingContent) throws Exception {
		int listCnt = mapper.selectUserMngListTotalCnt(searchingOrgId, searchingLocalId, searchingType, searchingContent);
		return listCnt;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateUserMngConfirm
	 * @Description : 승인 변경
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public UserMngVO updateUserMngConfirm(String userId, String confirmStateMod) throws Exception {
		 mapper.updateUserMngConfirm(userId, confirmStateMod); // 승인 변경
		 return mapper.selectUserMngConfirmOrCancelDate(userId, confirmStateMod); // 승인 변경에 따른 승인일 가져오기 or 취소일 가져오기
	}
	
	/**
	 * @Method Name : selectUserMngDupCheck
	 * @Description : 사용자아이디 중복체크
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.22  유성우      최초생성
	 * @
	 */
	public boolean selectUserMngDupCheck(String userId) throws Exception {
		boolean resultFlag = false;
		List<UserMngVO> list = mapper.selectUserMngDupCheck(userId);
		if(list.size() > 0)
			resultFlag = true;
		return resultFlag;
	}
	
	/**
	 * @Method Name : selectRoleLocal
	 * @Description : 권한지역 선택 팝업에 데이터 전송 
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.22  유성우      최초생성
	 * @
	 */
	public List<localVO> selectRoleLocal(String orgId) throws Exception {
		List<localVO> list = mapper.selectRoleLocal(orgId);
		return list;
	}
	
	/**
	 * @Method Name : selectRoleLocalSearchList
	 * @Description : 권한지역 선택 팝업 검색
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.22  유성우      최초생성
	 * @
	 */
	public List<localVO> selectRoleLocalSearchList(String registOrgId, String searchingContent) throws Exception {
		List<localVO> list = mapper.selectRoleLocalSearchList(registOrgId, searchingContent);
		return list;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectUserLevelList
	 * @Description : 사용자 레벨 콤보박스 리스트 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public List<UserMngVO> selectUserLevelList() throws Exception {
		 return mapper.selectUserLevelList();
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : insertUserMngSave
	 * @Description : 사용자정보 저장
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean insertUserMngSave(String inputUserId, String inputUserNm, String registOrgId, String userLevelRegist, String telNo, String email, String roleLocalId) throws Exception {
		String[] localIds = roleLocalId.split(",");
		HashMap<String, Object> userMngObject = new HashMap<String, Object>();
		
		telNo = sha.encryptAES256(telNo);
		email = sha.encryptAES256(email);
		
		try {
			mapper.insertUserMngSave(inputUserId, inputUserNm, registOrgId, userLevelRegist, telNo, email);
			int id = mapper.selectUserMngId(inputUserId);
			for(String localId : localIds) {
				if("".equals(localId))
					continue;
				userMngObject.put("id", id);
				userMngObject.put("localId", localId);				
				mapper.insertUserMngRoleLocal(userMngObject);
			}
			
			
		} catch(Exception e) {
			System.out.println("xxxxxx "+ e);
			return false;
		}
		
		return true;
		
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : selectUserMngDetail
	 * @Description : 기관정보 상세조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public UserMngVO selectUserMngDetail(String userId) throws Exception {
		UserMngVO detail = mapper.selectUserMngDetail(userId);
		
		if(!Util.isEmpty(detail.getEmail())) {
			detail.setEmail(sha.decryptAES256(detail.getEmail()));
			String[] temp = detail.getEmail().split("@", 2);
			detail.setEmailHead(temp[0]);
			detail.setEmailBody(temp[1]);
		}
		if(!Util.isEmpty(detail.getTelNo())) {
			detail.setTelNo(sha.decryptAES256(detail.getTelNo()));
			//detail.setTelNo(detail.getTelNo().substring(0, 3) + "-" + detail.getTelNo().substring(3, 7) + "-" + detail.getTelNo().substring(7, 11));
			detail.setTelNoBody(detail.getTelNo().substring(3, 7));
			detail.setTelNoEnd(detail.getTelNo().substring(7, 11));
		}
		
		return detail;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : updateUserMngMod
	 * @Description : 사용자관리 수정
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean updateUserMngMod(String userId, String userNm, String userLevel, String telNo, String email, String orgId, String roleLocalIdMod) throws Exception {
		
		telNo = sha.encryptAES256(telNo);
		email = sha.encryptAES256(email);
		
		String[] localIds = roleLocalIdMod.split(",");
		HashMap<String, Object> userMngObject = new HashMap<String, Object>();
		try {
			mapper.updateUserMngMod(userId, userNm, userLevel, telNo, email, orgId);
			int id = mapper.selectUserMngId(userId);
			mapper.deleteUserMngRoleLocal(id);
			for(String localId : localIds) {
				userMngObject.put("id", id);
				userMngObject.put("localId", localId);
				mapper.insertUserMngRoleLocal(userMngObject);
			}
			
			
		} catch(Exception e) {
			return false;
		}
		
		return true;
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : deleteUserMngDel
	 * @Description : 기관정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public void deleteUserMngDel(String userId) throws Exception {
		int id = mapper.selectUserMngId(userId); // 사용자ID를 입력하여 ID를 조회한다.
		mapper.deleteUserMngRoleLocal(id); // ID를 입력하여 해당 사용자의 권한지역을 삭제한다.
		mapper.deleteUserMngDel(userId); // tb_users 테이블의 해당 사용자ID를 삭제
		 
	}
	
	/**
	 * @throws Exception 
	 * @Method Name : deleteUserMngDel
	 * @Description : 기관정보 삭제
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.19  유성우      최초생성
	 * @
	 */
	public boolean updatePasswordChange(String userId) throws Exception {
		boolean updateResult = true;
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String securePw = encoder.encode(userId);
		
		/*
		if(encoder.matches("입력받은 비밀번호(암호화 전)", "이미 암호화된 비밀번호")) {
			
		}
		*/
		
		try {
			mapper.updatePasswordChange(userId, securePw); // tb_users 테이블의 해당 사용자ID를 삭제
		} catch(Exception e) {
			e.printStackTrace();
			updateResult = false;
		}
		
		return updateResult;
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
	public Object selectOrgExcel(HttpServletResponse response, String searchingOrgId, String searchingLocalId, String searchingType, String searchingContent, Pagination pagination, String sortColumn, String sortType) throws Exception {		
		
		UserMngVO param = new UserMngVO();
		param.setOrganizationId(searchingOrgId);
		param.setLocalId(searchingLocalId);
		param.setSearchingType(searchingType);
		param.setSearchingContent(searchingContent);
		param.setPagination(pagination);
		param.setSortColumn(sortColumn);
		param.setSortType(sortType);
		
		List<UserMngVO> list = mapper.selectUserMngListExcel(param);

		for(UserMngVO info : list) {
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
    public void createExcelDownloadResponse(HttpServletResponse response, List<UserMngVO> list) {
    	
        try{
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("사용자_리스트");

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
            final String fileName = "사용자_리스트";

            //헤더
            final String[] header = {"번호", "사용자ID", "사용자명", "사용자레벨", "연락처", "이메일", "기관명", "권한지역", "등록일(수정일)", "승인일(취소일)", "승인여부"};
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

                UserMngVO userPoint = list.get(i);

                Cell cell = null;
                cell = row.createCell(0);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getRownum()); // 번호

                cell = row.createCell(1);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getUsername()); // 사용자ID

                cell = row.createCell(2);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getName()); // 사용자명

                cell = row.createCell(3);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getRoleName()); // 사용자레벨

                cell = row.createCell(4);                
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getTelNo()); // 연락처
                
                cell = row.createCell(5);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getEmail()); // 이메일
                
                cell = row.createCell(6);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getOrganization()); // 기관명
                
                cell = row.createCell(7);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getLocals()); // 권한지역
                
                cell = row.createCell(8);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getRegDate()); // 등록일(수정일)
                
                cell = row.createCell(9);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getConfirmDate()); // 승인일(취소일)
                
                cell = row.createCell(10);
                cell.setCellStyle(headStyle);      //문자포맷 적용
                cell.setCellValue(userPoint.getConfirmState()); // 승인여부
                
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

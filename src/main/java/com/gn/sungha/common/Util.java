package com.gn.sungha.common;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

public class Util {
	private static int pLength;

	/**
	 * 교차접속 스크립트 공격 취약성 방지(파라미터 문자열 교체)
	 *
	 * <pre>
	 * << 개정이력(Modification Information) >>
	 *
	 *   수정일         수정자           수정내용
	 *  -------    	 --------    ---------------------------
	 *   2022.12.07   CHLEE          최초 생성
	 *
	 * </pre>
	 */
	public static String clearXSSMinimum(String value) {
		if (value == null || value.trim().equals("")) {
			return "";
		}

		String returnValue = value;

		returnValue = returnValue.replaceAll("&", "&amp;");
		returnValue = returnValue.replaceAll("<", "&lt;");
		returnValue = returnValue.replaceAll(">", "&gt;");
		returnValue = returnValue.replaceAll("\"", "&#34;");
		returnValue = returnValue.replaceAll("\'", "&#39;");
		returnValue = returnValue.replaceAll("\\.", "&#46;");
		returnValue = returnValue.replaceAll("%2E", "&#46;");
		returnValue = returnValue.replaceAll("%2F", "&#47;");
		return returnValue;
	}

	public static String clearXSSMaximum(String value) {
		String returnValue = value;
		returnValue = clearXSSMinimum(returnValue);

		returnValue = returnValue.replaceAll("%00", null);

		returnValue = returnValue.replaceAll("%", "&#37;");

		// \\. => .

		returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
		returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\
		returnValue = returnValue.replaceAll("\\./", ""); // ./
		returnValue = returnValue.replaceAll("%2F", "");

		return returnValue;
	}

	public static String filePathBlackList(String value) {
		String returnValue = value;
		if (returnValue == null || returnValue.trim().equals("")) {
			return "";
		}

		returnValue = returnValue.replaceAll("\\.\\./", ""); // ../
		returnValue = returnValue.replaceAll("\\.\\.\\\\", ""); // ..\

		return returnValue;
	}
	
	/**
	 * 행안부 보안취약점 점검 조치 방안.
	 *
	 * @param value
	 * @return
	 */
	public static String filePathReplaceAll(String value) {
		String returnValue = value;
		if (returnValue == null || returnValue.trim().equals("")) {
			return "";
		}

		returnValue = returnValue.replaceAll("/", "");
		returnValue = returnValue.replaceAll("\\\\", "");
		returnValue = returnValue.replaceAll("\\.\\.", ""); // ..
		returnValue = returnValue.replaceAll("&", "");

		return returnValue;
	}

	public static String fileInjectPathReplaceAll(String value) {
		String returnValue = value;
		if (returnValue == null || returnValue.trim().equals("")) {
			 return "";
		}

		returnValue = returnValue.replaceAll("/", "");
		//returnValue = returnValue.replaceAll("\\..", ""); // ..
		returnValue = returnValue.replaceAll("\\\\", "");// \
		returnValue = returnValue.replaceAll("&", "");

		return returnValue;
	}

	public static String filePathWhiteList(String value) {
		return value;
	}

	public static boolean isIPAddress(String str) {
		Pattern ipPattern = Pattern.compile("\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}");

		return ipPattern.matcher(str).matches();
    }

	 public static String removeCRLF(String parameter) {
		return parameter.replaceAll("\r", "").replaceAll("\n", "");
	 }

	 public static String removeSQLInjectionRisk(String parameter) {
		return parameter.replaceAll("\\p{Space}", "").replaceAll("\\*", "").replaceAll("%", "").replaceAll(";", "").replaceAll("-", "").replaceAll("\\+", "").replaceAll(",", "");
	 }

	 public static String removeOSCmdRisk(String parameter) {
		return parameter.replaceAll("\\p{Space}", "").replaceAll("\\*", "").replaceAll("\\|", "").replaceAll(";", "");
	 }
	 
	 /**
	  * String 객체가 Null이면 지정값으로 반환한다.
	  * 
	  * @parm   String형 객체
	  * @return 변환객체
	  * @see
	  */
	 public static String replaceNull(String value, String convValue) {
		 String rslt = value;
		 if(rslt == null || rslt.trim().length() == 0) rslt = convValue;
		 return rslt;
	 }
	 
	 public static String replaceNull(Object value, String convValue) {
		 Object rslt = value;
		 if(rslt == null) rslt = convValue;
		 	return(String) rslt;
	 }
	 
	 /**
	  * 문자열 자르기
	  * 
	  * @parm value : 잘라낼 문자
	  * @parm startIdx : 시작 지점
	  * @parm pLength : 몇자리 자를 것인지
	  * @return
	  */
	 public static String subStringByLength(String value, int startIdx, int pLentth) {
		 String result = "";
		 if(isEmpty(value)) return "";
		 
		 	value = value.trim();
		 	
		 	int iValueLength = value.length(); //= 문자의 길이를 구함
		 	if(iValueLength < startIdx)   return "";
		 	//= Parameter로 넘어온 길이(pLength)를 넘지 않는 한에서 길이를 제공
		 	int iLength = (iValueLength >= pLength)? pLength:iValueLength;
		 	
		 	result = value.substring(startIdx, iLength);
		 	
		 	return result;
	 }
	 
	 /*private static boolean isEmpty(String value) {
			return false;
		}*/
	  
	 public static boolean isEmpty(Object obj) {
		 if(obj == null) {
			 return true;
		 }else if((obj instanceof String) && (((String) obj).length() == 0) ) {
			 return true;
		 }else if(obj instanceof Map) {
			 return ((Map<?, ?>) obj).isEmpty();
		 }else if(obj instanceof List) {
			 return ((List<?>) obj).isEmpty();
		 }else if(obj instanceof Object[]) {
			 return (((Object[]) obj).length == 0);
		 }
		 
		 return false;
	 }
	 
	 public static boolean isNotEmpty(Object obj) {
		 return !isEmpty(obj);
	 }
	 
	 /**
	  * 널일경우 0으로 변환(INT, STRING) 모두
	  * 
	  * null을 0으로 바꾸기
	  * @parm str 처리 할 문자열
	  * @return int
	  */
	 public static int converStrToInt(String str) {
		 if(str == null || "".equals(str)) {
			 return 0;
		 }
		 try {
			 return Integer.parseInt(str);
		 }catch(NumberFormatException nfe) {
			 return 0;
		 }
	 }
	 
	 /**
	  * 
	  * null을 0으로 변경
	  * @parm num
	  * @return
	  */
	 public static int convertIntegerToInt(Integer num) {
		 if(num == null || "".equals(num)) {
			 return 0;
		 }
		 try {
			 return (int)num;
		 }catch(NumberFormatException nfe) {
			 return 0;
		 }
	 }
	 
	 /**
	  * 
	  * null을 0으로 바꾸기
	  * @parameter str 처리 할 문자열
	  * @return String
	  */
	 public static String convertStrToZero(String str) {
		 if(str == null || str.trim().equals("") || str.equals("null")) {
			 return "0";
		 }
		 
		 return str.trim();
	 }
	 
	 /**
	  * INT(숫자) 여부 판단
	  * 숫자인지 여부 확인
	  * @param s
	  * @return
	  */
	 public static boolean isStringDoubleChk(String s) {
		 try {
			 Double.parseDouble(s);
			 return true;
		 }catch (NumberFormatException e) {
			 return false;
		 }
		 
	 }
	 
	 /**
	  * 특정 문자열 자르기
	  * 문자열에서 특정 문자를 제거하기
	  * @param orgStr
	  * @param removeStr
	  * @return
	  */
	 public static String removeStr(String orgStr, String removeStr)
	 {
		 if(orgStr == null)
			 return "";
		 else
			 return orgStr.replaceAll(removeStr, "");
	 }
	 
	 /**
	  * BYTE SIZE 가져오기
	  * byte size를 가져온다
	  * 
	  * @param str String target
	  * @return int bytelength
	  */
	 public static int getByteSize(String str) {
		 if(str == null || str.length() == 0)
			 return 0;
		 byte[] byteArray = null;
		 try {
			 byteArray = str.getBytes("UTF-8");
		 }catch (UnsupportedEncodingException ex) {}
		 if(byteArray == null) return 0;
		 return byteArray.length;
	 }
	 
	 /**
	  * 앞에 0을 채워넣어 자릿수 맞춤
	  * 
	  * @param length
	  * @param nValue
	  * @return
	  */
	 public static String setNumLength(int length, String szValue) {
		 String szResult = "";
		 int nResult = 0;
		 
		 if(isNumber(szValue))
			 nResult = Integer.parseInt(szValue);
		 else
			 nResult = 0;
		 
		 szResult = String.format("%0"+length+"d", nResult);
		 
		 return szResult;
				 
	 }

	private static boolean isNumber(String szValue) {
		return false;
	}
	
	// VM Heap Max Size
	public static String getMaxMemorySize() {
	   long maxMemory = (Runtime.getRuntime().maxMemory()) / (1024 * 1024);
	   return maxMemory + "MB";
	}
	 
	// VM Heap Total Size
	public static String getTotalMemorySize() {
	   long totalMemory = (Runtime.getRuntime().totalMemory()) / (1024 * 1024);
	   return totalMemory + "MB";
	}
	 
	// VM Heap Allocation Size
	public static String getAllocMemorySize() {
	   long allocMemory = (Runtime.getRuntime().totalMemory()) - (Runtime.getRuntime().freeMemory()) / (1024 * 1024);
	   return allocMemory + "MB";
	}
	 
}

package com.gn.sungha.weatherInfo;

import lombok.RequiredArgsConstructor;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static com.gn.sungha.weatherInfo.ConvertToGrid.convertGRID_GPS;
import static java.lang.Integer.parseInt;

@RequiredArgsConstructor
@RestController
public class WeatherInfoController {
    @Autowired
    private final WeatherInfoService weatherInfoService;
    @GetMapping("/weather/get")
    public void getWeather() throws Exception {
        System.out.println("==========================[기상청 지역날씨정보 API 스케쥴러 시작]============================");
        // 기관에 등록된 지역 정보를 가지고 온다
        List<UserInfoVO> organizationList = weatherInfoService.selectOrganizationInfo();

        for(UserInfoVO drganiztionInfo : organizationList) {

            Map<String, Object> result = getUltraSrtFcst(drganiztionInfo); // 지역날씨정보 API 호출
            Map<String, Object> header = (Map<String, Object>) result.get("header");
            Map<String, Object> body = (Map<String, Object>) result.get("body");

            // API호출 성공인 경우 기상예보데이터  업데이트 진행
            if(header.get("resultCode").equals("00")) {
                Map<String, Object> items = (Map<String, Object>) body.get("items");
                List<Map<String, Object>> item = (List<Map<String, Object>>) items.get("item");
                List<LocalWeatherInfoVO> paramList = new ArrayList<LocalWeatherInfoVO>();
                LocalWeatherInfoVO paramVO = null;
                // 가져온 날씨 예측정보 SET(예측일자, 예측시간, 지역ID, 기온)
                for(Map<String, Object> itemMap : item) {
                    if(itemMap.get("category").equals("T1H")) {
                        System.out.println("기온 : "+(String)itemMap.get("fcstValue"));
                        paramVO = new LocalWeatherInfoVO();
                        paramVO.setFcstDate((String)itemMap.get("fcstDate"));
                        paramVO.setFcstTime((String)itemMap.get("fcstTime"));
                        paramVO.setOrganizationId(drganiztionInfo.getOrganizationId());
                        paramVO.setLocalId(drganiztionInfo.getLocalId());
                        paramVO.setTemperatureValue(parseInt((String)itemMap.get("fcstValue")));
                        paramList.add(paramVO);
                    }
                }

                // 가져온 날씨 예측정보 SET(예측일자, 예측시간, 지역ID, 습도)
                for(Map<String, Object> itemMap : item) {
                    if(itemMap.get("category").equals("REH")) {
                        // 기존 기온정보가 저장된 리스트에 습도정보 SET
                        for(LocalWeatherInfoVO resetVO : paramList) {
                            if(resetVO.getFcstDate().equals((String)itemMap.get("fcstDate")) && resetVO.getFcstTime().equals((String)itemMap.get("fcstTime"))) {
                                System.out.println("습도 : "+(String)itemMap.get("fcstValue"));
                                resetVO.setHumidityValue(parseInt((String)itemMap.get("fcstValue")));
                            }
                        }
                    }
                }

                int updateCnt = weatherInfoService.updateLocalWeatherInfo(paramList);
                //System.out.println(drganiztionInfo.getOrganizationLocal()+"_지역날씨정보 UPDATE :"+updateCnt+"건 완료");
            }
        }
        System.out.println("==========================[기상청 지역날씨정보 API 스케쥴러 종료]============================");
    }
    /** 지역날씨정보 가져오기 */
    public Map<String, Object> getUltraSrtFcst(UserInfoVO userInfoVO) throws Exception {
        System.out.println("=============[기상청 지역날씨정보 API 호출 시작]=============");

        LocalDateTime datetime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
        String base_date = datetime.format(formatter);	// 발표일자
        formatter = DateTimeFormatter.ofPattern("HH");
        String base_time = datetime.format(formatter);	// 발표시각

        LatXLngYVO xy = convertGRID_GPS(0, Double.parseDouble(userInfoVO.getLocalNy()), Double.parseDouble(userInfoVO.getLocalNx()));
        System.out.println("base_date : "+base_date);
        System.out.println("base_time : "+base_time+"00");
        System.out.println("위도: "+Double.parseDouble(userInfoVO.getLocalNy()));
        System.out.println("경도: "+Double.parseDouble(userInfoVO.getLocalNx()));
        System.out.println("x: "+String.valueOf(Math.round(xy.x)));
        System.out.println("y: "+String.valueOf(Math.round(xy.y)));

        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=hQB7rU4D1lfIa0PHyrs8t%2FUmN1hH4%2FVzEFQ9ronntO5zOqd12hLPrwt7hMnMfk%2FgOUV06v%2BvNRzJYh0QouTPCg%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("60", "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*요청자료형식(XML/JSON) Default: XML*/
        urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode(base_date, "UTF-8")); /*발표일자*/
        urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode(base_time+"00", "UTF-8")); /*발표시각*/
        urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode(String.valueOf(Math.round(xy.x)), "UTF-8")); /*예보지점 X 좌표값*/
        urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode(String.valueOf(Math.round(xy.y)), "UTF-8")); /*예보지점 Y 좌표값*/

        URL url = new URL(urlBuilder.toString());
        int TIMEOUT_VALUE = 30000;
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setConnectTimeout(TIMEOUT_VALUE);
        conn.setReadTimeout(TIMEOUT_VALUE);
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        System.out.println("Response code: " + conn.getResponseCode());

        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }

        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();

        String respoens = sb.toString();

        /** -----------Json to Map Start --------------*/
        JSONParser parser = new JSONParser();
        JSONObject jsonobj = null;
        Object obj = null;
        try {
            obj = parser.parse(respoens);
            jsonobj = (JSONObject) obj;
        } catch (ParseException e) {
            System.out.println("ParseException");
        }
        Map<String, Object> result = (Map<String, Object>) jsonobj.get("response");
        /** -----------Json to Map End --------------*/
        System.out.println("=============[기상청 지역날씨정보 API 호출 종료]=============");
        return result;
    }
}

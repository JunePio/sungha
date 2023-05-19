package com.gn.sungha.batch;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import com.gn.sungha.weatherInfo.UserInfoVO;
import com.gn.sungha.weatherInfo.WeatherInfoController;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.expression.ParseException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.gn.sungha.sensorControl.SensorControlController;

@Component
public class ScheduleTask {

	@Autowired
	private SensorControlController sensorControl;
	@Autowired
	private WeatherInfoController weatherInfoController;

	@Scheduled(cron = "0 30 9 * * *")
	public void task1() throws Exception {
		sensorControl.sendMail();
	}
	
	@Scheduled(fixedDelayString = "86400000")
	public void taks2() {
		System.out.println("The current date (2) : " + LocalDateTime.now());
	}


	/** 기상청 지역날씨정보 API호출 및 업데이트 (1시간 주기) */
	//@Scheduled(cron="0 45 0/1 * * *")
	@Scheduled(cron="0 0/10 * * * *")
	public void weatherInfoScheduleRun() throws Exception {
		weatherInfoController.getWeather();
	}
}

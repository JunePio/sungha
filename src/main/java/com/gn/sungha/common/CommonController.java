package com.gn.sungha.common;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.gn.sungha.local.localVO;
import com.gn.sungha.organizationInfo.organizationInfoVO;

@RestController
@RequestMapping(value="/")
public class CommonController {

	/**
	 * @throws Exception 
	 * @Method Name : selectOrgInfoList
	 * @Description : 기관정보 조회
	 * @Modification Information
	 * @ 수정일        수정자     수정내용
	 * @ ----------  -------  -------------------------------
	 * @ 2022.12.07  유성우      최초생성
	 * @
	 */
	@RequestMapping
	public ModelAndView selectIndex() throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("dashboard/dashboard"); // view 파일 경로
		
		return modelAndView;
	}
	/**
	 * index
	 * @return
	 */
	@RequestMapping("index")
	public ModelAndView selectIndexMenu() throws Exception {

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("index"); // view 파일 경로

		return modelAndView;
	}

}

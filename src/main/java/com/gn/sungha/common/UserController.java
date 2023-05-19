package com.gn.sungha.common;

import com.gn.sungha.dashboard.DashboaardSearchVO;
import com.gn.sungha.local.localVO;
import com.gn.sungha.organizationInfo.organizationInfoVO;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.WebAttributes;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping(value="/auth")
public class UserController {

    private final UserService userService;
    private final CommonNmList commonNmList; // 공통 - 기관정보 콤보박스 리스트와 지역 콤보박스 리스트 객체

    /**
     * 로그인 폼
     * @return
     */
    @GetMapping("/login")
    public String login(){
        return "login";
    }

    /**
     * 로그인 실패 폼
     * @return
     */
    @GetMapping("/login_err")
    public String loginErr(@RequestParam(value = "error", required = false) String error,
                            @RequestParam(value = "exception", required = false) String exception,
                            Model model) {
        model.addAttribute("error", error);
        model.addAttribute("exception", exception);
        return "login";
    }

    /**
     * 회원가입 폼
     * @return
     */
    @GetMapping("/signUp")
    public String signUpForm() {
        return "signUp";
    }


    /**
     * 아이디찾기 폼
     * @return
     */
    @GetMapping("/findId")
    public String findId() {
        return "findId";
    }

    /**
     * PassWord찾기 폼
     * @return
     */
    @GetMapping("/findPw")
    public String findPw() {
        return "findPw";
    }

    /**
     * 회원가입 진행
     * @param userVo
     * @return
     */
    @PostMapping(value = "/signUp")
    public String signUp( UserVo userVo) {
        int result = userService.joinUser(userVo);
        return "redirect:/auth/login";
    }

    // 기관정보 셀렉트 박스
    @ResponseBody
    @PostMapping(value = "/orgList.ajax")
    public List<organizationInfoVO> orgList(@RequestBody DashboaardSearchVO vo) throws Exception {
        return commonNmList.selectOrgNmList(vo.getOrganizationId());  // 기관 콤보박스 리스트 조회
    }

    // 지역정보 셀렉트 박스
    @ResponseBody
    @PostMapping(value = "/localList.ajax")
    public List<localVO> localList(@RequestBody DashboaardSearchVO vo) throws Exception {
        return commonNmList.selectLocalNmList(vo.getOrganizationId());
    }

}

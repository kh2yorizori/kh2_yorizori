package com.lgy.YoRiZoRi.login.control;

import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lgy.YoRiZoRi.login.dto.MemDTO;
import com.lgy.YoRiZoRi.login.service.MemService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MemController {

    @Autowired
    private MemService memService;
    
    // 로그인 화면
    @RequestMapping("/login")
    public String login() {
        log.info("@# GET /login");
        return "login";
    }

    // 로그인 처리
    @RequestMapping("/login_yn")
    public String login_yn(HttpServletRequest request) { 
        log.info("@# POST /login_yn: " + request.getParameter("MEMBER_ID")+request.getParameter("admin_ck"));
        
        String id = request.getParameter("MEMBER_ID"); 
        String pw = request.getParameter("PASSWORD"); 
        
        HashMap<String, String> param = new HashMap<String, String>();
        param.put("MEMBER_ID", id);
        param.put("PASSWORD", pw);
        
        ArrayList<MemDTO> dtos = memService.loginYn(param);
        
        if (dtos == null || dtos.isEmpty()) {
            request.setAttribute("msg", "아이디 또는 비밀번호가 잘못 되었습니다.");
            request.setAttribute("url", "login");
            return "alert";
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("id", dtos.get(0).getMemberId());
            session.setAttribute("name", dtos.get(0).getName());
            session.setAttribute("admin", dtos.get(0).getAdminck());
            return "redirect:home";
        }
    }

    // 로그인 성공 화면
    @RequestMapping("/login_ok")
    public String login_ok(HttpSession session) {
        log.info("@# GET /login_ok, session ID: " + session.getAttribute("id"));
        return "login_ok";
    }

    // 회원가입 화면
    @RequestMapping("/register")
    public String register() {
        log.info("@# GET /register");
        return "register";
    }

    /**
     * 실시간 중복 확인 (AJAX)
     * @param fieldType (검사할 필드: "id", "nickname", "email", "phone")
     * @param value (사용자가 입력한 값)
     * @return "SUCCESS" or "FAIL"
     */
    @PostMapping("/checkDuplicate")
    @ResponseBody // JSP를 통하지 않고 데이터 자체를 반환
    public String checkDuplicate(@RequestParam("fieldType") String fieldType, @RequestParam("value") String value) {
        log.info("@# POST /checkDuplicate: fieldType={}, value={}", fieldType, value);
        int count = 0;
        
        switch (fieldType) {
            case "id":
                count = memService.idCheck(value);
                break;
            case "nickname":
                count = memService.nicknameCheck(value);
                break;
            case "email":
                count = memService.emailCheck(value);
                break;
            case "phone":
                count = memService.phoneCheck(value);
                break;
        }
        
        return (count == 0) ? "SUCCESS" : "FAIL";
    }

    @RequestMapping("/registerOk")
    public String registerOk(@RequestParam HashMap<String, String> param, HttpSession session, HttpServletRequest request) {
        log.info("@# POST /registerOk: " + param);

        // ===== 서버단 최종 유효성 검사 =====
        if (memService.idCheck(param.get("MEMBER_ID")) > 0) {
            request.setAttribute("msg", "이미 사용 중인 아이디입니다.");
            request.setAttribute("url", "register");
            return "alert";
        }
        if (memService.nicknameCheck(param.get("NICKNAME")) > 0) {
            request.setAttribute("msg", "이미 사용 중인 닉네임입니다.");
            request.setAttribute("url", "register");
            return "alert";
        }
        if (memService.emailCheck(param.get("EMAIL")) > 0) {
            request.setAttribute("msg", "이미 등록된 이메일입니다.");
            request.setAttribute("url", "register");
            return "alert";
        }
        if (memService.phoneCheck(param.get("PHONE_NUMBER")) > 0) {
            request.setAttribute("msg", "이미 등록된 전화번호입니다.");
            request.setAttribute("url", "register");
            return "alert";
        }

        memService.write(param);
        
        session.setAttribute("id", param.get("MEMBER_ID"));
        session.setAttribute("name", param.get("NAME"));
        session.setAttribute("admin", param.get("ADMIN_CK")); // admin 세션 추가
        
        // 회원가입 성공 후 홈으로 이동하도록 수정
        return "redirect:home"; 
    }
 // 로그아웃
    @RequestMapping("/logout")
    public String logout(HttpServletRequest request) {
        log.info("@# GET /logout");
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        } 
        return "redirect:/login"; // 경로 일관성을 위해 '/' 추가
    }
}



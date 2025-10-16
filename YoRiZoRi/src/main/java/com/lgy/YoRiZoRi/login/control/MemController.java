package com.lgy.YoRiZoRi.login.control;

import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
        log.info("@# POST /login_yn: " + request.getParameter("MEMBER_ID"));
        
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
            return "redirect:login_ok";
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

    @RequestMapping("/registerOk")
    public String registerOk(@RequestParam HashMap<String, String> param, HttpSession session) {
        log.info("@# POST /registerOk: " + param);
        
        memService.write(param);
        
        session.setAttribute("id", param.get("MEMBER_ID"));
        session.setAttribute("name", param.get("NAME"));
        
        return "redirect:login_ok"; 
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
    
 // 마이페이지 조회 (mypage.jsp를 보여주는 역할)
    @RequestMapping("/mypage")
    public String mypage(HttpSession session, Model model) {
        log.info("@# GET /mypage");
        String memberId = (String) session.getAttribute("id");
        if (memberId == null) {
            return "redirect:/login";
        }
        
        MemDTO memberInfo = memService.getMemberInfo(memberId);
        model.addAttribute("member", memberInfo);
        log.info("@# mypage for user: " + memberId);
        
        return "mypage"; 
    }
    
}
package com.lgy.YoRiZoRi.login.control;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
    	log.info("@# login: ");
        return "login";
    }

    // 로그인 처리
    @RequestMapping("/login_yn")
    public String login_yn(HttpServletRequest request, HttpSession session) {
    	log.info("@# login_yn: "+request.getParameter("MEMBER_ID"));
        
    	String id =request.getParameter("MEMBER_ID"); 
    	String pw =request.getParameter("PASSWORD"); 
    	
    	ArrayList<MemDTO> dtos = memService.loginYn(id, pw);
    	
    	if(dtos.isEmpty()) {
    		return "redirect:login";
    	}else {
    		//세션에 이름이랑 아이디 저장
    		session.setAttribute("id", dtos.get(0).getMEMBER_ID());
    		session.setAttribute("name", dtos.get(0).getNAME());
    		
    		return "redirect:login_ok";
    	}
    }
    // 로그인 성공 화면
    @RequestMapping("/login_ok")
    public String login_ok() {
        log.info("@# login_ok");
        return "login_ok";
    }

 // 회원가입 화면
    @RequestMapping("/register")
    public String register() {
        log.info("@# register");
        return "register";
    }

    @RequestMapping("/registerOk")
 // 파라미터에 HttpSession session 을 추가해줍니다.
 public String registerOk(@RequestParam HashMap<String, String> param, HttpSession session) {
     log.info("@# registerOk");
     log.info("@# registerOk" + param);
     
     // 1. 서비스 호출해서 DB에 회원정보 저장
     memService.write(param);
     
     // 2. DB 저장이 성공했으므로, 바로 세션을 만들어줍니다.
     //    param 맵에 사용자가 입력한 정보가 모두 들어있습니다.
     session.setAttribute("id", param.get("MEMBER_ID"));
     session.setAttribute("name", param.get("NAME"));
     
     // 3. 로그인 페이지 대신 login_ok 페이지로 리다이렉트합니다.
     return "redirect:login_ok"; 
 }
    // 로그아웃 기능 추가 (이전 답변 참고)
    @RequestMapping("/logout")
    public String logout(HttpSession session) {
        log.info("@# logout");
        session.invalidate();
        return "redirect:login";
    }
}

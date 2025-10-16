package com.lgy.YoRiZoRi.MY_Page.control;

import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.lgy.YoRiZoRi.MY_Page.dto.MyPageDTO;
import com.lgy.YoRiZoRi.MY_Page.dto.MyRecipeDTO;
import com.lgy.YoRiZoRi.MY_Page.service.MyPageService;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MyPageController {
    
    @Autowired
    private MyPageService service;
    
    // 마이페이지 메인 (회원 정보 보여주기)
    @RequestMapping("/list")
    public String list(HttpSession session, Model model) {
        log.info("@# GET /list");
        String memberId = (String) session.getAttribute("id");
        if (memberId == null) {
            return "redirect:/login";
        }
        
        // [수정] service가 반환하는 MyPageDTO 타입으로 받습니다.
        MyPageDTO userData = service.getUserById(memberId);
        model.addAttribute("user", userData); // "user"라는 이름으로 JSP에 전달
        return "list"; 
    }
    
    // 내가 쓴 레시피 목록 보여주기
    @RequestMapping("/myrecipe")
    public String myrecipe(HttpSession session, Model model) {
        log.info("@# GET /myrecipe");
        String memberId = (String) session.getAttribute("id");
        if (memberId == null) {
            return "redirect:/login";
        }
        
        List<MyRecipeDTO> recipeData = service.getById(memberId);
        model.addAttribute("recipe", recipeData);
        return "myrecipe"; 
    }
    
    // 수정 페이지 보여주기
    @RequestMapping("/mypage_edit")
    public String edit_view(HttpSession session, Model model) {
        log.info("@# GET /mypage_edit");
        String memberId = (String) session.getAttribute("id");
        if (memberId == null) {
            return "redirect:/login";
        }
        
        // [수정] service가 반환하는 MyPageDTO 타입으로 받습니다.
        MyPageDTO userData = service.getUserById(memberId); 
        model.addAttribute("member", userData); // JSP와 변수명 통일
        return "mypage_edit"; 
    }

    // 수정 내용 DB에 저장 (폼 제출 처리)
    @RequestMapping(value = "/modify", method = RequestMethod.POST)
    public String modify_ok(HashMap<String, String> param) { // @RequestParam 제거
        log.info("@# POST /modify: " + param);
        service.modify(param);
        return "redirect:/list"; 
    }
    
    // 회원 탈퇴 처리
    @RequestMapping("/delete")
    public String delete(HttpSession session) {
        log.info("@# POST /delete");
        String memberId = (String) session.getAttribute("id");
        if (memberId == null) {
            return "redirect:/login";
        }
        
        HashMap<String, String> param = new HashMap<String, String>();
        param.put("member_Id", memberId);
        
        service.delete(param);
        session.invalidate(); 
        
        return "redirect:/login";
    }
}
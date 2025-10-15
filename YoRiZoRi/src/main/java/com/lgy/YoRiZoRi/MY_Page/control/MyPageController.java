package com.lgy.YoRiZoRi.MY_Page.control;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgy.YoRiZoRi.MY_Page.dto.MyPageDTO;
import com.lgy.YoRiZoRi.MY_Page.service.MyPageService;

import lombok.extern.slf4j.Slf4j;
@Controller
@Slf4j
public class MyPageController {
	
	@Autowired
	private MyPageService service;
	
//	   @RequestMapping("/list")
//	    public String list2(Model model) {
//	        log.info("@# list()");
//	        model.addAttribute("myPageList", service.list());
//	        return "list"; 
//	    }
		@RequestMapping("/list")
		public String list(@RequestParam("member_Id") String memberId, Model model) {
		    MyPageDTO userData = service.getUserById(memberId); 
		    model.addAttribute("user", userData);
		    return "list"; 
		}
		

	   
	
		@RequestMapping("/modify")
		public String modify(@RequestParam HashMap<String, String> param, Model model) {
		    log.info("@# modify()"+param);
		    service.modify(param);
		    
		    // member_Id가 param에 있는지 확인 후 리다이렉트에 추가
		    String memberId = param.get("member_Id");
		    return "redirect:list?member_Id=" + memberId;
		}
	
	@RequestMapping("/mypage_edit")
	public String edit(@RequestParam("member_Id") String memberId, Model model) {
	    MyPageDTO userData = service.getUserById(memberId); 
	    model.addAttribute("user", userData);
	    return "mypage_edit"; 
	}
	
	@RequestMapping("/delete")
	public String delete(@RequestParam HashMap<String, String> param, Model model) {
		log.info("@# delete() param: " + param);
	    String memberId = param.get("member_Id");
	    log.info("@# delete() member_Id: " + memberId);
	    service.delete(param);
		
		return "redirect:list";
	}
}
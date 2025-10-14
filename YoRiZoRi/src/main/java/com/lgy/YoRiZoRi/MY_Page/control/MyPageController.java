package com.lgy.YoRiZoRi.MY_Page.control;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgy.YoRiZoRi.MY_Page.service.MyPageService;

import lombok.extern.slf4j.Slf4j;
@Controller
@Slf4j
public class MyPageController {
	
	@Autowired
	private MyPageService service;
	
	   @RequestMapping("/list")
	    public String list(Model model) {
	        log.info("@# list()");
	        model.addAttribute("myPageList", service.list());
	        return "list"; 
	    }

	   
	
	@RequestMapping("/modify")
	public String modify(@RequestParam HashMap<String, String> param, Model model) {
		log.info("@# modify()"+param);
		
		service.modify(param);
		
		return "redirect:list";
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

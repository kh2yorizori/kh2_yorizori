package com.lgy.YoRiZoRi.Main_Page.control;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgy.YoRiZoRi.Main_Page.dto.ItemDTO;
import com.lgy.YoRiZoRi.Main_Page.service.ItemService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ItemController {
	@Autowired
	private ItemService service;
	
	//상품 목록 조회
	@RequestMapping("/content_view")
	public String list(Model model) {
		log.info("@# content_view()");
		
		ArrayList<ItemDTO> dto = service.list();
		model.addAttribute("content_view", dto);
		
		return "content_view";
	}
	
//	상품 등록
	@RequestMapping("/write_result")
	public String write_result(@RequestParam HashMap<String, String> param, Model model) {
		log.info("@# write_result()");
		service.write(param);
		
		return "write_result";
	}
	
	@RequestMapping("/write_view")
	public String write_view() {
		log.info("@# write_view()");
		
		return "item_write";
	}
	
//	카테고리 jsp 이동
	@RequestMapping("/category_view")
	public String category_view() {
		log.info("@# category_view()");
		
		return "category";
	}
	
	
//	인기순 조회순 등 눌렀을 때
	@RequestMapping("/select_result")
	public String select_view(
	    @RequestParam(required = false) List<String> category,
	    @RequestParam(required = false) String order,
	    Model model) {

	    log.info("order param: " + order);
	    log.info("category list: " + category);

	    Map<String, Object> paramMap = new HashMap<String, Object>();
	    paramMap.put("order", order);

	    // category가 null이 아닐 때만 넣기
	    if (category != null && !category.isEmpty()) {
	        paramMap.put("categoryList", category);
	    }

	    ArrayList<ItemDTO> dto = service.list_rating(paramMap);
	    model.addAttribute("category_view", dto);

	    return "category_view";
	}


	
	
	@RequestMapping("main_page")
	public String main_view() {
		
		return "page_main";
	}
	
	@RequestMapping("login_view")
	public String login_view() {
		
		return "login";
	}
	@RequestMapping("home")
	public String home() {
		
		return "home";
	}
	
}










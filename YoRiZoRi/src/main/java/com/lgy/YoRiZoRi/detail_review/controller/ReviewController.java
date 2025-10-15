package com.lgy.YoRiZoRi.detail_review.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgy.YoRiZoRi.detail_review.dto.ReviewDTO;
import com.lgy.YoRiZoRi.detail_review.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class ReviewController {
	/*
	@Autowired(required = false)
	private ReviewService service;
	
	@RequestMapping("/list")
	public ArrayList<ReviewDTO> list(Model model) {
		log.info("@# list()");
		
		ArrayList<ReviewDTO> list = service.list();
		model.addAttribute("list", list);
		return list;
	}
	
	
	@RequestMapping("/write")
	public String write(@RequestParam HashMap<String, String> param, Model model) {
		log.info("@# write()");
		
		service.write(param);
		
		return "redirect:list";
	}
	
	@RequestMapping("/review_view")
	public String review_view() {
		log.info("@# review_view()");
		
		return "review_view";
	}
	*/
}

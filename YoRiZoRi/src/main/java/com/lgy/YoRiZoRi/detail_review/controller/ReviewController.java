package com.lgy.YoRiZoRi.detail_review.controller;

import java.util.ArrayList;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lgy.YoRiZoRi.detail_review.dto.ReviewDTO;
import com.lgy.YoRiZoRi.detail_review.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ReviewController {
	
	@Autowired(required = true)
	private ReviewService service;
	
	@RequestMapping("/list/review")
	public ArrayList<ReviewDTO> list(Model model) {
		log.info("@# list()");
		
		ArrayList<ReviewDTO> list = service.list();
		model.addAttribute("list", list);
		return list;
	}
	
	
	// POST 요청만 처리하며, @ResponseBody를 통해 뷰 리턴 없이 성공/실패 문자열을 클라이언트에 반환
		@RequestMapping(value = "/write/review", method = RequestMethod.POST)
	    @ResponseBody // <--- AJAX 처리
		public ReviewDTO write_con(ReviewDTO dto) { 
			log.info("@# write() - POST 요청 처리");
	        log.info("@# Received Review Data: {}", dto); // DTO 데이터 로그 확인
			
			try {
				ReviewDTO savedDto = service.write(dto);
//	            service.write(dto);
	            
	            dto.setCreated_at(new Date());
	            log.info("@# Return DTO with current time and IDs: {}", savedDto);
	            
	            return savedDto;
	        } catch (Exception e) {
	            log.error("@# DB Insert Failed!", e);
	            
	            return new ReviewDTO(); 
	        }
		}
	
	@RequestMapping("/review_view")
	public String review_view() {
		log.info("@# review_view()");
		
		return "review_view";
	}
	
}

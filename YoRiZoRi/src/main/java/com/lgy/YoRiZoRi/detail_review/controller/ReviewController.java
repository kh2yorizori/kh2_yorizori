package com.lgy.YoRiZoRi.detail_review.controller;

import java.util.ArrayList;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lgy.YoRiZoRi.detail_review.dto.ReviewDTO;
import com.lgy.YoRiZoRi.detail_review.service.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
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
		public ReviewDTO write_rev(ReviewDTO dto) { 
			log.info("@# write() - POST 요청 처리");
	        log.info("@# Received Review Data: {}", dto); // DTO 데이터 로그 확인
			
			try {
				ReviewDTO savedDto = service.write(dto);
				
	            log.info("@# Return DTO with current time and IDs: {}", savedDto);
	            
	            return savedDto;
	        } catch (Exception e) {
	        	e.printStackTrace();
	            log.error("@# DB Insert Failed!", e);
	            
	            return new ReviewDTO(); 
	        }
		}
	
	@RequestMapping("/review_view")
	public String review_view() {
		log.info("@# review_view()");
		
		return "review_view";
	}
	
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public String uploadImage(@RequestParam MultipartFile file, String member_id) throws Exception {
		// 파일 내용 byte[]로 변환
	    byte[] fileBytes = file.getBytes();
	    String fileName = file.getOriginalFilename();
	    String fileId = UUID.randomUUID().toString(); // 파일 ID 생성
	    
	    ReviewDTO dto = service.findById(member_id);
	    dto.setId(fileId);
	    dto.setName(fileName);
	    dto.setImg(fileBytes);
	    
	    return "redirect:review_view";
	}
	
	
	
}

package com.lgy.YoRiZoRi.detail_comment.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lgy.YoRiZoRi.detail_comment.dto.CommentDTO;
import com.lgy.YoRiZoRi.detail_comment.service.CommentService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommentController {
	
	@Autowired(required = true)
	private CommentService service;
	
	@RequestMapping("/list")
	public String list(Model model) { // return 타입을 String으로 변경하여 View를 반환
		log.info("@# list()");
		
        // 이 list() 메서드는 특정 member_id에 대한 댓글 목록을 가져와야 합니다.
        // 현재는 member_id를 전달받지 못하므로, 이 부분은 기능 구현 시 수정이 필요합니다.
        // 임시로 전체 목록을 가져온다고 가정합니다.
		ArrayList<CommentDTO> list = service.list();
		model.addAttribute("list", list);
		return "comment_view"; // list 화면을 보여줄 뷰 이름을 반환
	}
	
//	public ArrayList<CommentDTO> list(Model model) {
//		log.info("@# list()");
//		
//		ArrayList<CommentDTO> list = service.list();
//		model.addAttribute("list", list);
//		return list;
//	}
	
	
//	@RequestMapping("/write")
//	public String write(@RequestParam CommentDTO dto) {
//		log.info("@# write()");
//		
//		service.write(dto);
//		
//		return "redirect:comment_view";
//	}
	
	// POST 요청만 처리하며, @ResponseBody를 통해 뷰 리턴 없이 성공/실패 문자열을 클라이언트에 반환
		@RequestMapping(value = "/write", method = RequestMethod.POST)
	    @ResponseBody // <--- AJAX 처리
		public String write(CommentDTO dto) { 
			log.info("@# write() - POST 요청 처리");
	        log.info("@# Received Comment Data: {}", dto); // DTO 데이터 로그 확인
			
			try {
	            service.write(dto);
	            return "SUCSSESS";
	        } catch (Exception e) {
	            log.error("@# DB Insert Failed!", e);
	            return null; 
	        }
		}
	
	@RequestMapping("/comment_view")
	public String comment_view() {
		log.info("@# comment_view()");
		
		return "comment_view";
	}
}

package com.lgy.YoRiZoRi.detail_comment.controller;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.lgy.YoRiZoRi.detail_comment.dto.CommentDTO;
import com.lgy.YoRiZoRi.detail_comment.service.CommentService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CommentController {
	@Autowired(required = false)
	private CommentService service;
	
	@RequestMapping("/list")
	public ArrayList<CommentDTO> list(Model model) {
		log.info("@# list()");
		
		ArrayList<CommentDTO> list = service.list();
		model.addAttribute("list", list);
		return list;
	}
	
	
	@RequestMapping("/write")
	public String write(@RequestParam HashMap<String, String> param, Model model) {
		log.info("@# write()");
		
		service.write(param);
		
		return "redirect:list";
	}
	
	@RequestMapping("/write_view")
	public String write_view() {
		log.info("@# write_view()");
		
		return "write_view";
	}
}

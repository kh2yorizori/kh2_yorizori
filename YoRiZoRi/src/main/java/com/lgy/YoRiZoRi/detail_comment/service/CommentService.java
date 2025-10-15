package com.lgy.YoRiZoRi.detail_comment.service;

import java.util.ArrayList;

import com.lgy.YoRiZoRi.detail_comment.dto.CommentDTO;


public interface CommentService {
	public ArrayList<CommentDTO> list();
	public void write(CommentDTO dto);
//	public void modify(HashMap<String, String> param);
//	public void delete(HashMap<String, String> param);
}

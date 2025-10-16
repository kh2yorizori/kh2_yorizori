package com.lgy.YoRiZoRi.detail_comment.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.lgy.YoRiZoRi.detail_comment.dto.CommentDTO;

@Service
public interface CommentService {
	public ArrayList<CommentDTO> list();
	public CommentDTO write(CommentDTO dto);
//	public void writeTopLevel(CommentDTO dto); 
//	public void writeReply(CommentDTO dto); 
//	public CommentDTO getParentComment(int comment_id);
//	public void updateStep(CommentDTO dto);
//	public void modify(HashMap<String, String> param);
//	public void delete(HashMap<String, String> param);
}

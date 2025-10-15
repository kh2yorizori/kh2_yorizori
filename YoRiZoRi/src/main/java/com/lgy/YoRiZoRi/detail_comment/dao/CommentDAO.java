package com.lgy.YoRiZoRi.detail_comment.dao;

import java.util.ArrayList;

import com.lgy.YoRiZoRi.detail_comment.dto.CommentDTO;


public interface CommentDAO {
	public ArrayList<CommentDTO> list();
	public void write(CommentDTO dto);
	public String getWroteTime(CommentDTO dto);
//	public CommentDTO contentView(HashMap<String, String> param);
//	public void modify(HashMap<String, String> param);
//	public void delete(HashMap<String, String> param);

}

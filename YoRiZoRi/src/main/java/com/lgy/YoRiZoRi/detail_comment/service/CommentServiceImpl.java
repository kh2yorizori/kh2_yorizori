package com.lgy.YoRiZoRi.detail_comment.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.lgy.YoRiZoRi.detail_comment.dao.CommentDAO;
import com.lgy.YoRiZoRi.detail_comment.dto.CommentDTO;


public class CommentServiceImpl implements CommentService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<CommentDTO> list() {
		CommentDAO  dao = sqlSession.getMapper(CommentDAO.class);
		ArrayList<CommentDTO> list = dao.list();
		
		return list;
	}

	@Override
	public void write(HashMap<String, String> param) {
		CommentDAO dao = sqlSession.getMapper(CommentDAO.class);
			
		dao.write(param);
	}

}

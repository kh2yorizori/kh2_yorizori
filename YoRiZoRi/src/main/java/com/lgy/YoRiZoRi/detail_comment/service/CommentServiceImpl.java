package com.lgy.YoRiZoRi.detail_comment.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.YoRiZoRi.detail_comment.dao.CommentDAO;
import com.lgy.YoRiZoRi.detail_comment.dto.CommentDTO;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired(required = true)
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<CommentDTO> list() {
		CommentDAO dao = sqlSession.getMapper(CommentDAO.class);
		ArrayList<CommentDTO> list = dao.list();
		
		return list;
	}

	@Override
	public void write(CommentDTO dto) {
		CommentDAO dao = sqlSession.getMapper(CommentDAO.class);
			
		dao.write(dto);
	}

	@Override
	public String getWroteTime(CommentDTO dto) {
		CommentDAO dao = sqlSession.getMapper(CommentDAO.class);

		String time = dao.getWroteTime(dto);
		return time;
	}

}

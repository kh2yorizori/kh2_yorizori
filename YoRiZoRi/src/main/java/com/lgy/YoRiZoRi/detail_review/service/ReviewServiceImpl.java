package com.lgy.YoRiZoRi.detail_review.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

import com.lgy.YoRiZoRi.detail_review.dao.ReviewDAO;
import com.lgy.YoRiZoRi.detail_review.dto.ReviewDTO;



public class ReviewServiceImpl implements ReviewService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<ReviewDTO> list() {
		ReviewDAO  dao = sqlSession.getMapper(ReviewDAO.class);
		ArrayList<ReviewDTO> list = dao.list();
		
		return list;
	}

	@Override
	public void write(HashMap<String, String> param) {
		ReviewDAO dao = sqlSession.getMapper(ReviewDAO.class);
			
		dao.write(param);
	}

}

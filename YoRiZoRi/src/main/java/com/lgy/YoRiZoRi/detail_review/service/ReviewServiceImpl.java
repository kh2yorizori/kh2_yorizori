package com.lgy.YoRiZoRi.detail_review.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.YoRiZoRi.detail_review.dao.ReviewDAO;
import com.lgy.YoRiZoRi.detail_review.dto.ReviewDTO;


@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired(required = true)
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<ReviewDTO> list() {
		ReviewDAO  dao = sqlSession.getMapper(ReviewDAO.class);
		ArrayList<ReviewDTO> list = dao.list();
		
		return list;
	}

	@Override
	public ReviewDTO write(ReviewDTO dto) {
		ReviewDAO dao = sqlSession.getMapper(ReviewDAO.class);
			
//		System.out.println("!@!@$ review impl 마지막 완성된 dto" + dto);
		dao.write(dto);
		ReviewDTO completeDto = dao.findById(dto.getReview_id());
		
		return completeDto;
	}

}

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
		ReviewDTO completeDto = dao.findById(dto.getMember_id());
		
		return completeDto;
	}

	@Override
	public ReviewDTO findById(String member_id) {
		ReviewDAO dao = sqlSession.getMapper(ReviewDAO.class);
		ReviewDTO dto = dao.findById(member_id);
		
		return dto;
	}

	/*
	@Override
	public void uploadImage(ReviewDTO dto) {
		ReviewDAO dao = sqlSession.getMapper(ReviewDAO.class);
		
		dao.uploadImage(dto);

	}

	@Override
	public Map<String, Object> selectImage(String img_name) {
		ReviewDAO dao = sqlSession.getMapper(ReviewDAO.class);
		Map<String, Object> map = dao.selectImage(img_name);
		
		return map;
	}
*/
}

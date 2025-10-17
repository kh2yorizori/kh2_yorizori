package com.lgy.YoRiZoRi.detail_review.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.lgy.YoRiZoRi.detail_review.dto.ImageDTO;
import com.lgy.YoRiZoRi.detail_review.dto.ReviewDTO;

@Service
public interface ReviewService {
	public ArrayList<ReviewDTO> list();
	public ReviewDTO write(ReviewDTO dto);
	public ReviewDTO findById(String member_id);
//	public void uploadImage(ReviewDTO dto);
//	public Map<String, Object> selectImage(String image_name);
//	public void modify(HashMap<String, String> param);
//	public void delete(HashMap<String, String> param);
}

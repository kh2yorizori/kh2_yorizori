package com.lgy.YoRiZoRi.detail_review.dao;

import java.util.ArrayList;
import java.util.Map;

import com.lgy.YoRiZoRi.detail_review.dto.ReviewDTO;



public interface ReviewDAO {
	public ArrayList<ReviewDTO> list();
	public ReviewDTO findById(String review_id);
	public void write(ReviewDTO dto);
	public void uploadImage(ReviewDTO dto);
	public Map<String, Object> selectImage(String image_name);
//	public CommentDTO contentView(HashMap<String, String> param);
//	public void modify(HashMap<String, String> param);
//	public void delete(HashMap<String, String> param);

}

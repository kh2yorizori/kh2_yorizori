package com.lgy.YoRiZoRi.detail_review.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.lgy.YoRiZoRi.detail_review.dto.ReviewDTO;



public interface ReviewDAO {
	public ArrayList<ReviewDTO> list();
	public ReviewDTO findById(Integer review_id);
	public void write(ReviewDTO dto);
//	public CommentDTO contentView(HashMap<String, String> param);
//	public void modify(HashMap<String, String> param);
//	public void delete(HashMap<String, String> param);

}

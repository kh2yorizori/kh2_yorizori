package com.lgy.YoRiZoRi.detail_review.service;

import java.util.ArrayList;
import java.util.HashMap;


import com.lgy.YoRiZoRi.detail_review.dto.ReviewDTO;


public interface ReviewService {
	public ArrayList<ReviewDTO> list();
	public void write(HashMap<String, String> param);
//	public void modify(HashMap<String, String> param);
//	public void delete(HashMap<String, String> param);
}

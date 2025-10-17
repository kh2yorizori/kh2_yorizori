package com.lgy.YoRiZoRi.detail_review.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewDTO {
	private int review_id;
	private int recipe_id;
	private String member_id;
	private String content;
	private int rating;
	private String image;
	private Date created_at;
	private String id;
	private String name;
	private byte[] img;
}

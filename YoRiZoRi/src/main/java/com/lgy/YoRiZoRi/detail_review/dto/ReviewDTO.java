package com.lgy.YoRiZoRi.detail_review.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ReviewDTO {
	private int comment_id;
	private int ref_id;
	private int cmt_step;
	private int cmt_depth;
	private int recipe_id;
	private String member_id;
	private String cmt_content;
	private Date created_ar;
}

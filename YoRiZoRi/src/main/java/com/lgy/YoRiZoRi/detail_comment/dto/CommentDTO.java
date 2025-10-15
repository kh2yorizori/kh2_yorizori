package com.lgy.YoRiZoRi.detail_comment.dto;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class CommentDTO {
	private int comment_id;
	private int ref_id;
	private int cmt_step;
	private int cmt_depth;
	private int recipe_id;
	private String member_id;
	private String content;
	private Date created_at;
}

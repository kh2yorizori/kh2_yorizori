package com.lgy.YoRiZoRi.MY_Page.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MyRecipeDTO {

	
	private int recipe_id ;
	private String member_Id;
	private String title;
	private String description;
	private String serving_size;
	private String main_image;
	private Date create_at;
	private Date cooking_time;
	private int difficulty;
	private int hit;
	private int comment_count;
}

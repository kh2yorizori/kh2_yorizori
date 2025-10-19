package com.lgy.YoRiZoRi.Main_Page.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ItemDTO {
//	private String name;
//	private int price;
//	private String description;
	
	private int recipeId;
	private String member_Id;
	private String title;
	private String description;
	private int servingSize;
	private String mainImage;
	private Date created_at;
	private int difficulty;
	private String cookingTime;
	private int hit;
	private int rating;
}

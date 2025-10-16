package com.lgy.YoRiZoRi.MY_Page.dto;



import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor
public class MyPageDTO {

	private String member_Id;
	private String password;
	private String name;
	private String nickname;
	private String email;
	private String profile_image;
	private String phone_number;
	private Date birthDate;
	private Integer gender; // 1이면 남성 , 2면 여성

	
	
}
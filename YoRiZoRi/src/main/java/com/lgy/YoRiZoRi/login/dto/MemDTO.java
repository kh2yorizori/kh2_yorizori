package com.lgy.YoRiZoRi.login.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemDTO {
	private String MEMBER_ID;
	private String NAME;
	private String PASSWORD;
	private String NICKNAME;
	private String EMAIL;
	private String PROFILE_IMAGE;
	private String PHONE_NUMBER;
	private Date BIRTHDATE;
	private Integer GENDER;
	private Date JOIN_DATE;
}

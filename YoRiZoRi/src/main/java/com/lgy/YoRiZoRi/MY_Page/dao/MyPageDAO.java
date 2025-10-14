package com.lgy.YoRiZoRi.MY_Page.dao;

import java.util.HashMap;
import java.util.List;

import com.lgy.YoRiZoRi.MY_Page.dto.MyPageDTO;

public interface MyPageDAO {
	 List<MyPageDTO> list();
	public void modify(HashMap<String, String> param);
	public void delete(HashMap<String, String> param);
}

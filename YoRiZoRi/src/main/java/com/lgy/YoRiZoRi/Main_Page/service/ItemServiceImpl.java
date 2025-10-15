package com.lgy.YoRiZoRi.Main_Page.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.YoRiZoRi.Main_Page.dao.ItemDAO;
import com.lgy.YoRiZoRi.Main_Page.dto.ItemDTO;



@Service
public class ItemServiceImpl implements ItemService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<ItemDTO> list() {
		ItemDAO dao = sqlSession.getMapper(ItemDAO.class);
		ArrayList<ItemDTO> dto = dao.list();
		
		return dto;
	}

	@Override
	public void write(HashMap<String, String> param) {
		ItemDAO dao = sqlSession.getMapper(ItemDAO.class);
		dao.write(param);
		
	}

//	@Override
//	public ArrayList<ItemDTO> list_rating(HashMap<String, String> param) {
//		ItemDAO dao = sqlSession.getMapper(ItemDAO.class);
//		ArrayList<ItemDTO> dto = dao.list
//				
//				return dto;
//	}
	@Override
	public ArrayList<ItemDTO> list_rating(Map<String, Object> param) {
	    String order = (String) param.get("order");
	    if (!("hit".equals(order) || "rating".equals(order))) {
	        order = "hit";
	        param.put("order", order);
	    }
	    // categoryList는 MyBatis에서 바로 사용하므로 따로 처리할 필요 없음

	    ItemDAO dao = sqlSession.getMapper(ItemDAO.class);
	    return dao.list_rating(param);
	}

	
}

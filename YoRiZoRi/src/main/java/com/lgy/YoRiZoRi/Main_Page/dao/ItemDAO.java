package com.lgy.YoRiZoRi.Main_Page.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.lgy.YoRiZoRi.Main_Page.dto.ItemDTO;


public interface ItemDAO {
	public ArrayList<ItemDTO> list_rating(Map<String, Object> param);
	public ArrayList<ItemDTO> list();
	public void write(HashMap<String, String> param);
	
	public ArrayList<ItemDTO> getRandomRecipes();
}

package com.lgy.YoRiZoRi.Main_Page.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.lgy.YoRiZoRi.Main_Page.dto.ItemDTO;



public interface ItemService {
	public ArrayList<ItemDTO> list();
	public ArrayList<ItemDTO> list_rating(Map<String, Object> param);
	public void write(HashMap<String, String> param);
}

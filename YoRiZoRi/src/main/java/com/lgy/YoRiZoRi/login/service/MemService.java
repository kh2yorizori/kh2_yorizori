package com.lgy.YoRiZoRi.login.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.lgy.YoRiZoRi.login.dto.MemDTO;

public interface MemService {
     public ArrayList<MemDTO> loginYn(String id, String pw);
     public void write(HashMap<String, String> param);
}
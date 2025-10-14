package com.lgy.login_p.service;

import java.util.ArrayList;
import java.util.HashMap;
// RequestParam import 삭제

import com.lgy.login_p.dto.MemDTO;

public interface MemService {
     public ArrayList<MemDTO> loginYn(String id, String pw);
     public void write(HashMap<String, String> param);
}
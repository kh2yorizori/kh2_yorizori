package com.lgy.YoRiZoRi.login.dao;


import java.util.ArrayList;
import java.util.HashMap;
import org.apache.ibatis.annotations.Param;

import com.lgy.YoRiZoRi.login.dto.MemDTO;


public interface MemDAO {
  public ArrayList<MemDTO> loginYn(@Param("MEMBER_ID") String id, @Param("PASSWORD") String pw);
  public void write(HashMap<String, String> param);
}
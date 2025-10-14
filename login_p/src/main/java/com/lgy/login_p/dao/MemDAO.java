package com.lgy.login_p.dao;

// 사용하지 않는 Date import 삭제
import java.util.ArrayList;
import java.util.HashMap;
import org.apache.ibatis.annotations.Param;

import com.lgy.login_p.dto.MemDTO;

public interface MemDAO {
     public ArrayList<MemDTO> loginYn(@Param("MEMBER_ID") String id, @Param("PASSWORD") String pw);
     public void write(HashMap<String, String> param);
}
package com.lgy.YoRiZoRi.login.dao;

import java.util.ArrayList;
import java.util.HashMap;
import com.lgy.YoRiZoRi.login.dto.MemDTO;

public interface MemDAO {
    // ... 기존 loginYn, write 메소드는 그대로 ...
    ArrayList<MemDTO> loginYn(HashMap<String, String> param);
    void write(HashMap<String, String> param);

    // [추가] 회원 ID로 한 명의 모든 정보를 조회하는 메소드
    MemDTO getMemberInfo(String memberId);
}
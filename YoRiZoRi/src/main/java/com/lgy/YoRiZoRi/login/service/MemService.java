package com.lgy.YoRiZoRi.login.service;

import java.util.ArrayList;
import java.util.HashMap;
import com.lgy.YoRiZoRi.login.dto.MemDTO;

public interface MemService {
    
    // 기존 메소드
    ArrayList<MemDTO> loginYn(HashMap<String, String> param);
    void write(HashMap<String, String> param);

    // [추가] 마이페이지를 위한 회원 정보 조회 업무를 지시서에 추가
    MemDTO getMemberInfo(String memberId); 
}
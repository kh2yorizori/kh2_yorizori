package com.lgy.YoRiZoRi.login.dao;

import java.util.ArrayList;
import java.util.HashMap;
import com.lgy.YoRiZoRi.login.dto.MemDTO;

public interface MemDAO {
    // 기존 메소드
    ArrayList<MemDTO> loginYn(HashMap<String, String> param);
    void write(HashMap<String, String> param);
    MemDTO getMemberInfo(String memberId);

    // 중복 확인을 위한 메소드 추가
    int idCheck(String memberId);
    int nicknameCheck(String nickname);
    int emailCheck(String email);
    int phoneCheck(String phoneNumber);
}

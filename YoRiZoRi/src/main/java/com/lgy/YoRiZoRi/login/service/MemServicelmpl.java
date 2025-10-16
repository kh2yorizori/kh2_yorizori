package com.lgy.YoRiZoRi.login.service;

import java.util.ArrayList;
import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.lgy.YoRiZoRi.login.dao.MemDAO;
import com.lgy.YoRiZoRi.login.dto.MemDTO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemServicelmpl implements MemService {

    @Autowired
    private MemDAO memDAO;
    
    @Override
    public ArrayList<MemDTO> loginYn(HashMap<String, String> param) {
        log.info("@# MemServiceImpl.loginYn() start");
        return memDAO.loginYn(param);
    }
    
    @Override
    public void write(HashMap<String, String> param) {
        log.info("@# MemServiceImpl.write() start");
        param.putIfAbsent("PROFILE_IMAGE", "default_profile.jpg");
        memDAO.write(param);
    }

    // [추가] 지시받은 getMemberInfo 업무를 실제로 처리하는 방법
    @Override
    public MemDTO getMemberInfo(String memberId) {
        log.info("@# MemServiceImpl.getMemberInfo() start for ID: " + memberId);
        return memDAO.getMemberInfo(memberId);
    }
}
package com.lgy.login_p.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.login_p.dao.MemDAO;
import com.lgy.login_p.dto.MemDTO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemServicelmpl implements MemService{

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<MemDTO> loginYn(String id, String pw) {
		// MyBatis의 getMapper 메소드를 통해 MemDAO 인터페이스의 구현체를 얻음
				MemDAO dao = sqlSession.getMapper(MemDAO.class);
				
				// DAO의 loginYn 메소드를 호출하여 ID와 PW를 전달하고, 결과를 반환받습니다.
				// 로그인 성공 시: 회원 정보가 담긴 ArrayList (크기 1)
				// 로그인 실패 시: 비어있는 ArrayList (크기 0)
				ArrayList<MemDTO> dtos = dao.loginYn(id, pw);
				
				return dtos;
	}

	 @Override
	    public void write(HashMap<String, String> param) { 
	        log.info("@# MemServiceImpl.write() 메소드 실행됨.");
	        
	        param.put("profile_image", "DEFAULT.jpg");//이거 존나 애 먹음 ㅇㅇ 바탕화면에 jpg 있어야 함 아마?
	        
	        MemDAO dao = sqlSession.getMapper(MemDAO.class); 
	        
	        dao.write(param);
	    }
	
}

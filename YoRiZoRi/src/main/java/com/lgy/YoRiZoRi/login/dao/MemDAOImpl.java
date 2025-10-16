package com.lgy.YoRiZoRi.login.dao;

import java.util.ArrayList;
import java.util.HashMap;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.lgy.YoRiZoRi.login.dto.MemDTO;

@Repository
public class MemDAOImpl implements MemDAO {

    @Autowired
    private SqlSession sqlSession;

    private static final String NAMESPACE = "com.lgy.YoRiZoRi.login.dao.MemDAO";

    @Override
    public ArrayList<MemDTO> loginYn(HashMap<String, String> param) {
        return (ArrayList)sqlSession.selectList(NAMESPACE + ".loginYn", param);
    }

    @Override
    public void write(HashMap<String, String> param) {
        sqlSession.insert(NAMESPACE + ".write", param);
    }

    // [추가] 인터페이스에 새로 추가된 getMemberInfo 메소드의 실제 구현
    @Override
    public MemDTO getMemberInfo(String memberId) {
        // ID는 하나이므로, 결과가 하나만 나오는 selectOne 메소드를 사용합니다.
        return sqlSession.selectOne(NAMESPACE + ".getMemberInfo", memberId);
    }
}
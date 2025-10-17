package com.lgy.YoRiZoRi.detail_comment.service;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lgy.YoRiZoRi.detail_comment.dao.CommentDAO;
import com.lgy.YoRiZoRi.detail_comment.dto.CommentDTO;

@Service
public class CommentServiceImpl implements CommentService {

	@Autowired(required = true)
	private SqlSession sqlSession;
	
	@Override
	public ArrayList<CommentDTO> list() {
		CommentDAO dao = sqlSession.getMapper(CommentDAO.class);
		ArrayList<CommentDTO> list = dao.list();
		
		return list;
	}
	@Override
	public CommentDTO write(CommentDTO dto) {
		CommentDAO dao = sqlSession.getMapper(CommentDAO.class);
			
		// 1. ref_id 확인을 통한 최상위 댓글 또는 대댓글 구분
		if (dto.getRef_id() == 0) {
			// ===============================================
			// 1-1. 최상위 댓글 (Top-Level Comment)
			// ===============================================
			
			// writeTopLevel을 호출합니다.
			// 이 메서드에서는 cmt_step=0, cmt_depth=0으로 설정 후 INSERT하며,
			// DTO에 ref_id가 0으로 오면, DAO에서 comment_id를 얻어 ref_id를 업데이트합니다.
			System.out.println("impl : 1번dto : "+ dto);
			dao.writeTopLevel(dto);
			return dto;
			
		} else {
			// ===============================================
			// 1-2. 대댓글 (Reply Comment)
			// ===============================================
			
			// 2-1. 부모 댓글의 정보를 가져와서 cmt_step과 cmt_depth를 계산합니다.
			int parentCommentId = dto.getRef_id(); // 현재 dto의 ref_id는 부모 ID
			CommentDTO parent = dao.getParentComment(parentCommentId);
			
			System.out.println("impl : parent : "+ parent);
			if (parent == null) {
                // 부모 댓글(참조 댓글)이 DB에 존재하지 않으면 처리할 수 없으므로,
                // 이 경우 최상위 댓글로 처리하거나 예외를 던질 수 있습니다. 
                // 여기서는 예외 처리 없이 기본 동작(최상위 댓글)으로 대체합니다.
				dto.setRef_id(0);
				System.out.println("impl : 2번dto : "+ dto);
                dao.writeTopLevel(dto); 
                return dto;
            }
			
			// 2-2. 댓글 순서(cmt_step) 확보: 
			// 현재 부모 댓글의 cmt_step보다 큰 모든 댓글들의 step을 1씩 증가시켜 
			// 새로 들어올 댓글이 부모 댓글 바로 아래에 위치할 공간을 만듭니다.
			dao.updateStep(parent); 
			
			// 2-3. 새 댓글의 ref_id, cmt_step, cmt_depth 설정
//			새로운 댓글은 부모 댓글과 같은 루트 스레드에 속해야 합니다.
			// 부모의 ref_id가 곧 루트 댓글의 ID입니다.
			dto.setRef_id(parent.getComment_id()); 
			// 새로운 댓글의 step은 부모의 step보다 1 크게 설정
			dto.setCmt_step(parent.getCmt_step() + 1);
			// 새로운 댓글의 depth는 부모의 depth보다 1 깊게 설정
			dto.setCmt_depth(parent.getCmt_depth() + 1);
			// ref_id는 이미 DTO에 부모 댓글의 ID로 설정되어 넘어왔다고 가정합니다.
			// (Controller에서 DTO 바인딩 시 ref_id가 설정됩니다.)
			
			// 2-4. 대댓글 저장
			System.out.println("!@!@$ comment_impl 마지막 완성된 dto" + dto);
			dao.writeReply(dto);
			return dto;
		}
	}
}

package com.lgy.YoRiZoRi.detail_comment.dao;

import java.util.ArrayList;

import com.lgy.YoRiZoRi.detail_comment.dto.CommentDTO;


public interface CommentDAO {
	public ArrayList<CommentDTO> list();
	public CommentDTO write(CommentDTO dto);
	// Top-level comment (ref_id, cmt_step, cmt_depth are all 0 before insert)
	public void writeTopLevel(CommentDTO dto); 
	// Reply comment (cmt_step and cmt_depth are set in service)
	public void writeReply(CommentDTO dto); 
	// Get parent comment info (for determining step and depth)
	public CommentDTO getParentComment(int comment_id);
	// Update cmt_step to make space for a new reply
	public void updateStep(CommentDTO dto);
//	public CommentDTO contentView(HashMap<String, String> param);
//	public void modify(HashMap<String, String> param);
//	public void delete(HashMap<String, String> param);

}

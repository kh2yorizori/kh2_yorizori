package com.lgy.YoRiZoRi.Detailed_Page.service;

import java.util.List;

import com.lgy.YoRiZoRi.Detailed_Page.dto.DetailDTO;
import com.lgy.YoRiZoRi.Detailed_Page.dto.CommentDTO;
import com.lgy.YoRiZoRi.Detailed_Page.dto.ReviewDTO;
import com.lgy.YoRiZoRi.Recipe.dto.CategoryDTO;

public interface detailService {
    DetailDTO getRecipeDetailWithHit(int id);
    DetailDTO getRecipeDetailForUpdate(int id); // 수정용 조회 메서드 추가
    void updateRecipe(DetailDTO recipeDto); // 업데이트 메서드 추가
    List<CategoryDTO> getAllCategories();
    void deleteRecipe(int recipeId);
    
    // ## 댓글 관련 메서드 ##
    
    // 댓글 작성
    boolean insertComment(CommentDTO comment);
    
    // 댓글 수정
    boolean updateComment(CommentDTO comment);
    
    // 댓글 삭제
    boolean deleteComment(int commentId);
    
    // 대댓글 작성
    boolean insertReply(CommentDTO comment);
    
    // 댓글 ID로 댓글 조회
    CommentDTO getCommentById(int commentId);
    
    // ## 후기 관련 메서드 ##
    
    // 후기 작성
    boolean insertReview(ReviewDTO review);
    
    // 후기 수정
    boolean updateReview(ReviewDTO review);
    
    // 후기 삭제
    boolean deleteReview(int reviewId);
    
    // 후기 ID로 후기 조회
    ReviewDTO getReviewById(int reviewId);
    
    // 특정 레시피의 평균 평점 조회
    double getAverageRating(int recipeId);
    
    // 특정 레시피의 후기 개수 조회
    int getReviewCount(int recipeId);
}
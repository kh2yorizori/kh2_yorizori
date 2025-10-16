package com.lgy.YoRiZoRi.Recipe.service;

import com.lgy.YoRiZoRi.Recipe.dto.RecipeDTO;

public interface RecipeService {
	/**
	 * 레시피와 관련 파일들을 등록합니다.
	 * @param recipeDTO 폼에서 전송된 레시피 데이터
	 * @param uploadPath 서버에 파일이 저장될 실제 경로
	 * @throws Exception
	 */
	void registerRecipe(RecipeDTO recipeDTO, String uploadPath) throws Exception;
}
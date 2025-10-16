package com.lgy.YoRiZoRi.Recipe.dao;

import com.lgy.YoRiZoRi.Recipe.dto.IngredientDTO;
import com.lgy.YoRiZoRi.Recipe.dto.RecipeDTO;
import com.lgy.YoRiZoRi.Recipe.dto.StepDTO;

// @Mapper 어노테이션 삭제!
public interface RecipeDAO {
    // 레시피 기본 정보
    void insertRecipe(RecipeDTO recipeDTO);

    // 조리 순서
    void insertStep(StepDTO stepDTO);
    void insertStepImage(StepDTO stepDTO);
    
    // 재료
    void insertIngredient(IngredientDTO ingredientDTO);
    void insertRecipeIngredient(IngredientDTO ingredientDTO);
    
    // [추가] 재료 이름으로 ingredient_id를 찾는 메소드
    IngredientDTO findIngredientByName(String name);
}
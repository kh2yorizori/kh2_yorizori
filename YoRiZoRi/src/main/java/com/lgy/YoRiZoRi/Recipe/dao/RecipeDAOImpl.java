package com.lgy.YoRiZoRi.Recipe.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.lgy.YoRiZoRi.Recipe.dto.IngredientDTO;
import com.lgy.YoRiZoRi.Recipe.dto.RecipeDTO;
import com.lgy.YoRiZoRi.Recipe.dto.StepDTO;

@Repository
public class RecipeDAOImpl implements RecipeDAO {

    @Autowired
    private SqlSession sqlSession;

    // Mapper XML의 namespace와 일치해야 합니다.
    private static final String NAMESPACE = "com.lgy.YoRiZoRi.Recipe.dao.RecipeDAO";

    @Override
    public void insertRecipe(RecipeDTO recipeDTO) {
        sqlSession.insert(NAMESPACE + ".insertRecipe", recipeDTO);
    }

    @Override
    public void insertStep(StepDTO stepDTO) {
        sqlSession.insert(NAMESPACE + ".insertStep", stepDTO);
    }

    @Override
    public void insertStepImage(StepDTO stepDTO) {
        sqlSession.insert(NAMESPACE + ".insertStepImage", stepDTO);
    }

    @Override
    public void insertIngredient(IngredientDTO ingredientDTO) {
        sqlSession.insert(NAMESPACE + ".insertIngredient", ingredientDTO);
    }

    @Override
    public void insertRecipeIngredient(IngredientDTO ingredientDTO) {
        sqlSession.insert(NAMESPACE + ".insertRecipeIngredient", ingredientDTO);
    }

    // [추가] 빠져있던 메소드를 구현합니다.
    @Override
    public IngredientDTO findIngredientByName(String name) {
        return sqlSession.selectOne(NAMESPACE + ".findIngredientByName", name);
    }
}
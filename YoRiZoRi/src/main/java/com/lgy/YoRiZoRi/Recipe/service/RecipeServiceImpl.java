package com.lgy.YoRiZoRi.Recipe.service;

import java.io.File;
import java.util.UUID;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import com.lgy.YoRiZoRi.Recipe.dao.RecipeDAO;
import com.lgy.YoRiZoRi.Recipe.dto.IngredientDTO;
import com.lgy.YoRiZoRi.Recipe.dto.RecipeDTO;
import com.lgy.YoRiZoRi.Recipe.dto.StepDTO;

@Service
public class RecipeServiceImpl implements RecipeService {

    private static final Logger log = LoggerFactory.getLogger(RecipeServiceImpl.class);

    @Autowired
    private RecipeDAO recipeDAO;

    private String saveFile(MultipartFile file, String uploadPath) throws Exception {
        if (file == null || file.isEmpty()) { return null; }
        String originalFilename = file.getOriginalFilename();
        String savedFilename = UUID.randomUUID().toString() + "_" + originalFilename;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) { uploadDir.mkdirs(); }
        File dest = new File(uploadPath, savedFilename);
        file.transferTo(dest);
        return savedFilename;
    }

    @Override
    @Transactional
    public void registerRecipe(RecipeDTO recipeDTO, String uploadPath) throws Exception {
        log.info("레시피 등록 시작: " + recipeDTO.getTitle());

        // 1. 레시피 기본 정보 저장
        String mainImageName = saveFile(recipeDTO.getMainImageFile(), uploadPath);
        recipeDTO.setMainImage(mainImageName != null ? mainImageName : "default_main.jpg");
        recipeDAO.insertRecipe(recipeDTO);
        log.info("레시피 정보 저장 완료. 생성된 ID: " + recipeDTO.getId());

        // 2. 조리 순서 저장
        if (recipeDTO.getSteps() != null) {
            for (StepDTO step : recipeDTO.getSteps()) {
                step.setRecipeId(recipeDTO.getId());
                recipeDAO.insertStep(step);
                String stepImageName = saveFile(step.getImageFile(), uploadPath);
                if (stepImageName != null) {
                    step.setImage(stepImageName);
                    recipeDAO.insertStepImage(step);
                }
            }
            log.info("조리 순서 " + recipeDTO.getSteps().size() + "개 저장 완료.");
        }
        
        // 3. 재료 저장 로직 (최종 수정본)
        if (recipeDTO.getIngredients() != null) {
            for (IngredientDTO currentIngredient : recipeDTO.getIngredients()) {
                // 3-1. DB에 해당 이름의 재료가 있는지 먼저 '조회'합니다.
                IngredientDTO foundIngredient = recipeDAO.findIngredientByName(currentIngredient.getName());
                
                if (foundIngredient == null) {
                    // 3-2. 조회 결과가 없으면(null), '신규' 재료이므로 DB에 INSERT 합니다.
                    //      이 호출은 UNIQUE 제약조건 오류를 일으키지 않습니다.
                    recipeDAO.insertIngredient(currentIngredient);
                    log.info("신규 재료 등록: " + currentIngredient.getName() + ", 생성된 ID: " + currentIngredient.getIngredientId());
                } else {
                    // 3-3. 조회 결과가 있으면, '기존' 재료이므로 조회된 ID를 DTO에 설정합니다.
                    currentIngredient.setIngredientId(foundIngredient.getIngredientId());
                    log.info("기존 재료 사용: " + currentIngredient.getName() + ", ID: " + currentIngredient.getIngredientId());
                }
                
                // 3-4. DTO에 현재 레시피의 ID를 설정합니다.
                currentIngredient.setRecipeId(recipeDTO.getId());
                
                // 3-5. 'recipe_ingredient' 테이블에 최종 연결 정보를 저장합니다.
                recipeDAO.insertRecipeIngredient(currentIngredient);
            }
            log.info("재료 " + recipeDTO.getIngredients().size() + "개 연결 완료.");
        }
        log.info("레시피 등록 성공!");
    }
}
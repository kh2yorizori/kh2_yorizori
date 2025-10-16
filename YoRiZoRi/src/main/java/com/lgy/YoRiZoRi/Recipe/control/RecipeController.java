package com.lgy.YoRiZoRi.Recipe.control;

import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.beans.propertyeditors.CustomNumberEditor;

import com.lgy.YoRiZoRi.Recipe.dto.RecipeDTO;
import com.lgy.YoRiZoRi.Recipe.service.RecipeService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class RecipeController {
    
    @Autowired
    private RecipeService service;

    @Autowired
    private ServletContext servletContext; // 파일의 실제 저장 경로를 얻기 위해 주입

    // 레시피 등록 페이지로 이동
    @RequestMapping("/write_recipe")
    public String write_view() {
        log.info("@# GET write_recipe()");
        return "write_recipe";
    }

    // 폼에서 빈 문자열로 넘어온 숫자 필드를 null로 처리하여 Integer 타입 변환 오류 방지
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Integer.class, new CustomNumberEditor(Integer.class, true));
    }

    // 레시피 폼 제출 처리
    @RequestMapping(value="recipe/submit", method=RequestMethod.POST)
    public String submitRecipe(@ModelAttribute RecipeDTO recipeDTO, RedirectAttributes redirectAttributes) {
        log.info("@# POST recipe/submit");
        try {
            // 웹 애플리케이션 내의 /resources/uploads 폴더의 실제 서버 경로를 찾음
            String uploadPath = servletContext.getRealPath("/resources/uploads");
            log.info("@# Upload Path: " + uploadPath);
            
            // 파일 처리 및 DB 저장을 모두 서비스 레이어에 위임
            service.registerRecipe(recipeDTO, uploadPath);

            redirectAttributes.addFlashAttribute("msg", "레시피가 성공적으로 등록되었습니다.");
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("msg", "레시피 등록 중 오류가 발생했습니다.");
        }

        // 등록 성공/실패 여부와 관계없이 레시피 목록 페이지로 리다이렉트
        return "redirect:/"; // 메인 페이지로 이동
    }
}
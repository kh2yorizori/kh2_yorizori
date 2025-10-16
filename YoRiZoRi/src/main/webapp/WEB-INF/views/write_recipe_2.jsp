<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>레시피 등록</title>

<!-- Noto Sans KR 폰트 추가 -->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;600;700&display=swap" rel="stylesheet">
<script src="https://cdn.tailwindcss.com"></script>
<script>
    // Tailwind Custom Configuration for YoRiZoRi Theme
    tailwind.config = {
        theme: {
            extend: {
                colors: {
                    'yozori-primary': '#5563DE', // 로그인 페이지의 메인 색상
                    'yozori-secondary': '#e9ecef', // 회원가입 버튼 색상
                    'yozori-dark': '#333333', // 텍스트/헤더 색상
                },
                fontFamily: {
                    sans: ['Noto Sans KR', 'sans-serif'],
                },
            }
        }
    }
</script>
<style>
    /* Tailwind CSS가 로드된 후 커스텀 스타일 */
    .recipe-form-container {
        max-width: 900px;
    }
    .input-group {
        display: flex;
        gap: 10px;
        align-items: center;
    }
    /* 폰트 적용 (Tailwind config으로 대부분 처리되지만 안전을 위해 body에 적용) */
    body {
        font-family: 'Noto Sans KR', sans-serif;
    }
</style>
</head>
<body class="bg-gray-100 p-8 min-h-screen flex justify-center items-start">

    <div class="recipe-form-container bg-white p-8 rounded-xl shadow-2xl w-full mt-10">
        <!-- 헤더 색상 및 폰트 변경 -->
        <h1 class="text-3xl font-extrabold text-yozori-dark mb-6 border-b pb-3 border-gray-200">
            🍳 새 레시피 등록
        </h1>
        
        <!-- form action은 나중에 만들 RecipeController의 메서드로 지정해야 합니다. -->
<!--         <form action="registerRecipe" method="post"> -->
        <form action="registerRecipe" method="post" autocomplete="off" onsubmit="reIndexIngredients(); reIndexSteps();">
            
            <!-- 섹션 1: 기본 정보 (RECIPE 테이블) -->
            <section class="mb-8 p-6 border border-yozori-primary rounded-lg bg-white border-opacity-30">
                <h2 class="text-xl font-semibold text-yozori-dark mb-4">1. 기본 정보</h2>
                
                <!-- 레시피 제목 -->
                <div class="mb-4">
                    <label for="title" class="block text-sm font-medium text-gray-600">레시피 제목</label>
                    <input type="text" id="title" name="title" required
                        class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-yozori-primary focus:ring-yozori-primary p-2">
                </div>
                
                <!-- 레시피 설명 -->
                <div class="mb-4">
                    <label for="description" class="block text-sm font-medium text-gray-600">간단 설명</label>
                    <textarea id="description" name="description" rows="3" required
                        class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-yozori-primary focus:ring-yozori-primary p-2"></textarea>
                </div>
                
                <!-- 인원 / 시간 / 난이도 -->
                <div class="grid grid-cols-3 gap-4">
                    <div>
                        <label for="servingSize" class="block text-sm font-medium text-gray-600">인분 (몇 인분)</label>
                        <input type="number" id="servingSize" name="servingSize" value="4" min="1" required
                            class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-yozori-primary focus:ring-yozori-primary p-2">
                    </div>
                    <div>
                        <label for="cookingTime" class="block text-sm font-medium text-gray-600">조리 시간</label>
                        <select id="cookingTime" name="cookingTime"
                            class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-yozori-primary focus:ring-yozori-primary p-2">
                            <option value="30분 이내">30분 이내</option>
                            <option value="1시간 이내">1시간 이내</option>
                            <option value="1시간 이상">1시간 이상</option>
                        </select>
                    </div>
                    <div>
                        <label for="difficulty" class="block text-sm font-medium text-gray-600">난이도</label>
                        <select id="difficulty" name="difficulty"
                            class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-yozori-primary focus:ring-yozori-primary p-2">
                            <option value="1">1 (쉬움)</option>
                            <option value="2">2 (보통)</option>
                            <option value="3">3 (어려움)</option>
                        </select>
                    </div>
                </div>
            </section>

            <!-- 섹션 2: 재료 입력 (INGREDIENT, RECIPE_INGREDIENT) -->
            <!-- 배경색 제거, border 색상을 yozori-primary로 변경 -->
            <section class="mb-8 p-6 border border-yozori-primary rounded-lg bg-white border-opacity-30">
			    <h2 class="text-xl font-semibold text-yozori-dark mb-4 flex justify-between items-center">
			        2. 재료 목록
			        <button type="button" id="addIngredientBtn" class="px-3 py-1 bg-yozori-primary text-white rounded-md hover:bg-[#3b49b0] transition duration-150 text-sm">재료 추가</button>
			    </h2>
			    
			    <div id="ingredientList" class="space-y-3">
			        <div class="input-group">
			            <input type="text" name="ingredients[0].name" placeholder="재료명 (예: 돼지고기 목살)"
			                class="flex-1 border-gray-300 rounded-md shadow-sm focus:border-yozori-primary focus:ring-yozori-primary p-2">
			            <input type="text" name="ingredients[0].quantity" placeholder="수량 (예: 200g, 1컵)"
			                class="w-1/4 border-gray-300 rounded-md shadow-sm focus:border-yozori-primary focus:ring-yozori-primary p-2">
			            <button type="button" class="remove-btn text-red-500 text-lg hover:text-red-700 font-bold hidden">&times;</button>
			        </div>
			    </div>
			</section>

            <!-- 섹션 3: 요리 단계 입력 (RECIPE_STEP) -->
            <!-- 배경색 제거, border 색상을 yozori-primary로 변경 -->
            <section class="mb-8 p-6 border border-yozori-primary rounded-lg bg-white border-opacity-30">
			    <h2 class="text-xl font-semibold text-yozori-dark mb-4 flex justify-between items-center">
			        3. 요리 단계
			        <button type="button" id="addStepBtn" class="px-3 py-1 bg-yozori-primary text-white rounded-md hover:bg-[#3b49b0] transition duration-150 text-sm">단계 추가</button>
			    </h2>
			
			    <div id="stepList" class="space-y-4">
			        <div class="step-group p-3 border border-gray-300 rounded-lg bg-gray-50">
			            <label class="block text-sm font-medium text-gray-600 mb-1">단계 1</label>
			            <textarea name="steps[0].instruction" rows="2" placeholder="단계별 요리 설명"
			                class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-yozori-primary focus:ring-yozori-primary p-2"></textarea>
			            <input type="hidden" name="steps[0].stepNumber" value="1">
			            <button type="button" class="remove-step-btn text-red-500 text-sm hover:text-red-700 mt-2 hidden">단계 삭제</button>
			        </div>
			    </div>
			</section>
            
            <!-- 섹션 4: 카테고리 (RECIPE_CATEGORY) -->
            <!-- 배경색 제거, border 색상을 yozori-primary로 변경 -->
            <section class="mb-8 p-6 border border-yozori-primary rounded-lg bg-white border-opacity-30">
                <h2 class="text-xl font-semibold text-yozori-dark mb-4">4. 카테고리 선택</h2>
                <div class="flex flex-wrap gap-4">
                    <!-- 체크박스 색상 변경 -->
                    <label class="flex items-center space-x-2">
                        <input type="checkbox" name="categoryIds" value="1" class="rounded text-yozori-primary focus:ring-yozori-primary">
                        <span class="text-gray-700">한식</span>
                    </label>
                    <label class="flex items-center space-x-2">
                        <input type="checkbox" name="categoryIds" value="2" class="rounded text-yozori-primary focus:ring-yozori-primary">
                        <span class="text-gray-700">베이킹</span>
                    </label>
                    <label class="flex items-center space-x-2">
                        <input type="checkbox" name="categoryIds" value="3" class="rounded text-yozori-primary focus:ring-yozori-primary">
                        <span class="text-gray-700">찌개/국</span>
                    </label>
                    <label class="flex items-center space-x-2">
                        <input type="checkbox" name="categoryIds" value="4" class="rounded text-yozori-primary focus:ring-yozori-primary">
                        <span class="text-gray-700">양식</span>
                    </label>
                </div>
            </section>

            <!-- 제출 버튼 -->
            <div class="flex justify-center mt-6">
                <button type="submit" 
                    class="px-10 py-3 bg-yozori-primary text-white font-bold text-lg rounded-lg shadow-lg hover:bg-[#3b49b0] transition duration-300">
                    레시피 등록 완료
                </button>
            </div>
        </form>
    </div>
    
<script>
    // 💡 globalIndex는 새로운 항목 추가 시 인덱스를 부여하는 데 사용합니다.
    // 초기 항목이 [0]을 사용하므로, 다음 추가 항목은 1부터 시작해야 합니다.
    // HTML 마크업에 이미 [0]이 있으므로, next index는 1입니다.
    let globalIngredientIndex = 1; 
    let globalStepIndex = 1; // 단계 번호는 1부터 시작하지만, 배열 인덱스로는 0이 사용되므로, 다음 추가 인덱스는 1입니다.

    // 🚨 최종 유효성 검사 함수: 빈 항목의 name 속성을 제거합니다.
    function cleanAndValidateForm() {
    
    // 🚨 1. 인덱스 재정렬 함수 호출 (반드시 추가되어야 인덱스 꼬임 문제 해결)
    //    이 함수들이 0부터 순서대로 name 속성(예: ingredients[0].name)을 재부여합니다.
    reIndexIngredients(); 
    reorderSteps();

    // --- 디버깅용 로그: 폼 제출 직전, 유효한 필드 이름 확인 ---
    // (이 로그는 이제 [0], [1]...로 순서대로 찍혀야 합니다.)
    console.log("=== FINAL INGREDIENT/STEP NAMES BEFORE SUBMIT ===");
    const allInputs = document.forms[0].querySelectorAll('input[name], textarea[name]');
    allInputs.forEach(input => {
         console.log(input.name + ": " + input.value.trim());
    });
    console.log("==================================================");
    // -----------------------------------------------------------------


    // 2. 재료 청소 (재정렬 후, 빈 값이라면 name 제거)
    const ingredientGroups = document.getElementById('ingredientList').querySelectorAll('.input-group');
    Array.from(ingredientGroups).forEach(group => {
        const nameInput = group.querySelector('input[placeholder*="재료명"]');
        const quantityInput = group.querySelector('input[placeholder*="수량"]');
        
        if (nameInput && quantityInput) {
            const nameValue = nameInput.value.trim();
            const quantityValue = quantityInput.value.trim();
            
            // 값이 없다면 name 제거
            if (nameValue === '' && quantityValue === '') {
                nameInput.removeAttribute('name');
                quantityInput.removeAttribute('name');
            }
        }
    });

    // 3. 단계 청소 (재정렬 후, 빈 값이라면 name 제거)
    const stepGroups = document.getElementById('stepList').querySelectorAll('.step-group');
    Array.from(stepGroups).forEach(group => {
        const instructionInput = group.querySelector('textarea');
        const stepNumberInput = group.querySelector('input[type="hidden"]');
        
        if (instructionInput) {
            const instructionValue = instructionInput.value.trim();

            // 값이 없다면 name 제거
            if (instructionValue === '') {
                instructionInput.removeAttribute('name');
                // hidden input의 name도 함께 제거
                if (stepNumberInput) stepNumberInput.removeAttribute('name'); 
            }
        }
    });
    
    // 폼 제출을 계속 진행합니다.
    return true;
}

        // 2. 단계 청소
        const stepGroups = document.getElementById('stepList').querySelectorAll('.step-group');
        Array.from(stepGroups).forEach(group => {
            const instructionInput = group.querySelector('textarea'); 
            const stepNumberInput = group.querySelector('input[type="hidden"]'); 
            
            if (instructionInput) {
                const instructionValue = instructionInput.value.trim();

                // 값이 없다면 name 제거
                if (instructionValue === '') {
                    instructionInput.removeAttribute('name');
                    if (stepNumberInput) stepNumberInput.removeAttribute('name');
                }
            }
        });
        
        // 폼 제출을 계속 진행합니다.
        return true; 
    }


    // 3. 재료 추가 버튼 로직 (globalIndex를 사용하여 인덱스 부여)
    document.getElementById('addIngredientBtn').addEventListener('click', () => {
        const list = document.getElementById('ingredientList');
        const newGroup = document.createElement('div');
        newGroup.className = 'input-group';
        
        const newIndex = globalIngredientIndex++; // 새로운 인덱스 사용
        
        newGroup.innerHTML = `
            <input type="text" name="ingredients[${newIndex}].name" placeholder="재료명 (예: 양파)" required
                class="flex-1 border-gray-300 rounded-md shadow-sm focus:border-yozori-primary focus:ring-yozori-primary p-2">
            <input type="text" name="ingredients[${newIndex}].quantity" placeholder="수량 (예: 1개)" required
                class="w-1/4 border-gray-300 rounded-md shadow-sm focus:border-yozori-primary focus:ring-yozori-primary p-2">
            <button type="button" class="remove-btn text-red-500 text-lg hover:text-red-700 font-bold">&times;</button>
        `;
        list.appendChild(newGroup);
        updateRemoveButtonVisibility();
    });

    // 4. 단계 추가 버튼 로직 (globalIndex를 사용하여 인덱스 부여)
    document.getElementById('addStepBtn').addEventListener('click', () => {
        const list = document.getElementById('stepList');
        const newGroup = document.createElement('div');
        newGroup.className = 'step-group p-3 border border-gray-300 rounded-lg bg-gray-50';
        
        const nextStepNumber = document.getElementById('stepList').children.length + 1; // 현재 DOM 개수로 단계 번호 결정
        const arrayIndex = nextStepNumber - 1; // 배열 인덱스는 0부터 시작
        
        newGroup.innerHTML = `
            <label class="block text-sm font-medium text-gray-600 mb-1">단계 ${nextStepNumber}</label>
            <textarea name="steps[${arrayIndex}].instruction" rows="2" placeholder="단계별 요리 설명" required
                class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:border-yozori-primary focus:ring-yozori-primary p-2"></textarea>
            <input type="hidden" name="steps[${arrayIndex}].stepNumber" value="${nextStepNumber}">
            <button type="button" class="remove-step-btn text-red-500 text-sm hover:text-red-700 mt-2">단계 삭제</button>
        `;
        list.appendChild(newGroup);
        updateRemoveButtonVisibility();
    });


    // 5. 삭제 버튼 로직 (DOM 조작)
    document.getElementById('ingredientList').addEventListener('click', (e) => {
        if (e.target && e.target.classList.contains('remove-btn')) {
            const list = document.getElementById('ingredientList');
            if (list.children.length > 1) {
                e.target.closest('.input-group').remove();
                updateRemoveButtonVisibility();
            }
        }
    });
    
    document.getElementById('stepList').addEventListener('click', (e) => {
        if (e.target && e.target.classList.contains('remove-step-btn')) {
            const list = document.getElementById('stepList');
            if (list.children.length > 1) {
                e.target.closest('.step-group').remove();
                
                // 단계 삭제 후 단계 번호를 다시 매겨야 합니다.
                reorderSteps();
                
                updateRemoveButtonVisibility();
            }
        }
    });

    // 6. 단계 삭제 시 순서 재배치 함수 (필요)
    function reorderSteps() {
        const stepGroups = document.getElementById('stepList').querySelectorAll('.step-group');
        let currentStepNumber = 1;
        
        Array.from(stepGroups).forEach((group) => {
            const instructionInput = group.querySelector('textarea');
            const stepNumberInput = group.querySelector('input[type="hidden"]');
            
            // 라벨 업데이트
            group.querySelector('label').textContent = `단계 ${currentStepNumber}`;

            // name 속성 및 value 업데이트 (배열 인덱스는 stepNumber - 1)
            const arrayIndex = currentStepNumber - 1; 

            if (instructionInput) instructionInput.name = `steps[${arrayIndex}].instruction`;
            if (stepNumberInput) {
                stepNumberInput.value = currentStepNumber;
                stepNumberInput.name = `steps[${arrayIndex}].stepNumber`;
            }

            currentStepNumber++;
        });
        // globalStepIndex는 현재 마지막 단계 번호로 업데이트
        globalStepIndex = currentStepNumber; 
    }


    // 7. 삭제 버튼 표시 여부 업데이트 (기존 코드 유지)
    function updateRemoveButtonVisibility() {
        const ingredientGroups = document.getElementById('ingredientList').children;
        Array.from(ingredientGroups).forEach(group => {
            const removeBtn = group.querySelector('.remove-btn');
            if (removeBtn) {
                removeBtn.classList.toggle('hidden', ingredientGroups.length === 1);
            }
        });
        
        const stepGroups = document.getElementById('stepList').children;
        Array.from(stepGroups).forEach(group => {
            const removeBtn = group.querySelector('.remove-step-btn');
            if (removeBtn) {
                removeBtn.classList.toggle('hidden', stepGroups.length === 1);
            }
        });
    }

    // 8. 페이지 로드 시 초기 상태 설정
    window.onload = function() {
        // 초기 단계 항목의 인덱스 보정 (HTML에 [0]이 있으므로)
        reorderSteps(); 
        updateRemoveButtonVisibility();
    };
        
</script>    
</body>
</html>

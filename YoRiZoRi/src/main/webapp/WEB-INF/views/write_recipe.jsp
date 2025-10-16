<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>레시피 등록</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <h2>레시피 등록</h2>

    <form action="${pageContext.request.contextPath}/recipe/submit" method="post" enctype="multipart/form-data">
        <fieldset>
            <legend>레시피 정보</legend>
            제목: <input type="text" name="title" required><br>
            설명: <textarea name="description" required></textarea><br>
            인분 수: <input type="number" name="servingSize"><br>
            난이도(1~5): <input type="number" name="difficulty" min="1" max="5"><br>
            조리 시간: <input type="text" name="cookingTime"><br>
            메인 이미지: <input type="file" name="mainImageFile"><br>
        </fieldset>

        <fieldset>
            <legend>재료</legend>
            <div id="ingredients">
                <div class="ingredient">
                    재료명: <input type="text" name="ingredients[0].name" required>
                    양: <input type="text" name="ingredients[0].quantity" required>
                    <button type="button" class="removeIngredientBtn">삭제</button>
                </div>
            </div>
            <button type="button" id="addIngredientBtn">재료 추가</button>
        </fieldset>

        <fieldset>
            <legend>조리 순서</legend>
            <div id="steps">
                <div class="step">
                    순서: <input type="text" name="steps[0].stepNumber" value="1" readonly size="3" style="text-align:center;">
                    설명: <input type="text" name="steps[0].instruction" required>
                    이미지: <input type="file" name="steps[0].imageFile">
                    <button type="button" class="removeStepBtn">삭제</button>
                </div>
            </div>
            <button type="button" id="addStepBtn">조리 순서 추가</button>
        </fieldset>

        <button type="submit">등록</button>
    </form>

    <div id="ingredient-template" style="display: none;">
        <div class="ingredient">
            재료명: <input type="text" name="ingredients[__INDEX__].name" required>
            양: <input type="text" name="ingredients[__INDEX__].quantity" required>
            <button type="button" class="removeIngredientBtn">삭제</button>
        </div>
    </div>
    
    <div id="step-template" style="display: none;">
        <div class="step">
            순서: <input type="text" name="steps[__INDEX__].stepNumber" value="__STEP_NUMBER__" readonly size="3" style="text-align:center;">
            설명: <input type="text" name="steps[__INDEX__].instruction" required>
            이미지: <input type="file" name="steps[__INDEX__].imageFile">
            <button type="button" class="removeStepBtn">삭제</button>
        </div>
    </div>


    <script>
        $(document).ready(function() {
            // --- 재료 추가/삭제 로직 (템플릿 방식) ---
            $('#addIngredientBtn').click(function () {
                const newIndex = $('#ingredients .ingredient').length;
                const template = $('#ingredient-template').html();
                const newHtml = template.replace(/__INDEX__/g, newIndex); // 모든 __INDEX__를 숫자로 변경
                $('#ingredients').append(newHtml);
            });
    
            $('#ingredients').on('click', '.removeIngredientBtn', function () {
                if ($('#ingredients .ingredient').length > 1) {
                    $(this).closest('.ingredient').remove();
                    // 삭제 후 인덱스 재정렬
                    $('#ingredients .ingredient').each(function (index) {
                        $(this).find('input').each(function() {
                           const name = $(this).attr('name');
                           const newName = name.replace(/\[\d+\]/, `[${index}]`);
                           $(this).attr('name', newName);
                        });
                    });
                }
            });
    
            
            // --- 조리 순서 추가/삭제 로직 (템플릿 방식) ---
            $('#addStepBtn').click(function () {
                const newIndex = $('#steps .step').length;
                const newStepNumber = newIndex + 1;
                const template = $('#step-template').html();
                let newHtml = template.replace(/__INDEX__/g, newIndex);
                newHtml = newHtml.replace(/__STEP_NUMBER__/g, newStepNumber);
                $('#steps').append(newHtml);
            });
    
            $('#steps').on('click', '.removeStepBtn', function () {
                if ($('#steps .step').length > 1) {
                    $(this).closest('.step').remove();
                    // 삭제 후 인덱스 및 순서 번호 재정렬
                    $('#steps .step').each(function (index) {
                        const stepNumber = index + 1;
                        $(this).find('input[name*="stepNumber"]').val(stepNumber); // 순서 번호 업데이트
                        
                        $(this).find('input').each(function() {
                            const name = $(this).attr('name');
                            const newName = name.replace(/\[\d+\]/, `[${index}]`);
                            $(this).attr('name', newName);
                        });
                    });
                }
            });
        });
    </script>
</body>
</html>
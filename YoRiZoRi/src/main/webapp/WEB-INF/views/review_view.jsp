<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script type="text/javascript">
		function fn_submit(){
			console.log("@@jsjs");
			
			var ReviewContent = $("#content").val();
			
	        if (ReviewContent.trim() === "") {
	            alert("내용을 입력해주세요.");
	            return;
	        }
			
	        var formData = $("#frm").serialize();
	        
	        $("#content").val("");
	        
	        $.ajax({
				type:"post"
				,data:formData
				,url:"/write/review"
				,dataType: "json"
					,success: function(data) {
						if (!data || !data.member_id || !data.created_at || !data.recipe_id) {
		                    alert("저장 실패 또는 시간 정보 누락(사용자ID/시간/레시피ID)");
		                    document.getElementById("result").innerHTML = "<h3>DB 저장 실패 또는 응답 데이터 오류</h3>";
							}
						
						var wroteTime = formatTime(data.created_at);
	    				alert("저장완료 (DB 저장 시각: " + wroteTime + ")");
	    				
	    				var finalCommentHtml = '<div id="review_' + data.comment_id + '" style="border: 1px solid #007bff; padding: 10px; margin-bottom: 5px; border-radius: 4px;">' +
				   	    					   '<img src="" alt="사용자가 업로드한 사진" width="50px";hight="50px">'+	                    
	    				   					   '<strong>' + data.member_id + '</strong>' +
	    				                       '<p style="margin: 5px 0;">' + data.content + '</p>' +
	    				                       '<div style="color: #007bff; font-size: 0.8em;">작성일시: ' + wroteTime + '</div>';
	    				
					},error : function(jqXHR, textStatus, errorThrown) {
						console.error("AJAX Error:", textStatus, errorThrown, jqXHR.responseText);
						alert("오류발생: 서버 응답을 확인하세요.");	
						document.getElementById("result").innerHTML = "<h3>ajax fail: " + textStatus + "</h3>";
					}
	        });
			
// 	        var newReviewHtml = '<div class="p-4 border-b border-gray-200 bg-white rounded-lg shadow-sm mb-4">' +
//             '<p class="text-gray-700 mt-1 whitespace-pre-wrap">' + ReviewContent + '</p>' +
//             '<div class="text-xs text-gray-400 mt-2">방금 작성됨 (클라이언트 테스트)</div>' +
//             '</div>';
	        
	        $("#review-list").append(finalCommentHtml);

	</script>
</head>
<body>
		<!-- 댓글 목록 표시 영역 -->
        <h2 class="text-xl font-semibold mb-4 text-gray-800">후기 목록</h2>
        <div id="review-list">
        </div>
        
        <!-- AJAX 테스트 결과 영역 -->
        <p id="result" class="mt-6 p-3 bg-yellow-100 border border-yellow-300 rounded-md text-sm">
            여기는 서버 통신 (AJAX) 결과가 표시되는 영역입니다.
        </p>
        
        
	<table width="500" border="1">
		<form method="post" id="frm">
		<input type="hidden" name="recipe_id" id="recipe_id" value="1">
		
			<tr colspan="2">
				<td>nickname</td>
			</tr>
			<tr>
				<td name="image" id="image">이미지 등록</td>
			</tr>
			<tr>
				<td>별점</td>
				<td name="rating" id="rating">별별별별별</td>
			</tr>
				<td>내용</td>
				<td>
					<textarea rows="5" name="content" id="content"></textarea>
				</td>
			</tr>
			<tr colspan="2">
				<td>
					<input type="button" onclick="fn_submit()" value="후기작성">
				</td>
			</tr>
		</form>
	</table>
	
</body>
</html>
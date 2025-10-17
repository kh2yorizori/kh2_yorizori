<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script type="text/javascript">
		function formatTime(timestamp) {
		    if (!timestamp) return '시간 정보 없음';
		    var date = new Date(timestamp); 
		    var year = date.getFullYear();
		    var month = ('0' + (date.getMonth() + 1)).slice(-2);
		    var day = ('0' + date.getDate()).slice(-2);
		    var hour = ('0' + date.getHours()).slice(-2);
		    var minute = ('0' + date.getMinutes()).slice(-2);
		    return year + '-' + month + '-' + day + ' ' + hour + ':' + minute;
		}
		
		function fn_review_submit(){
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
				,url:"${pageContext.request.contextPath}/write/review"
				,dataType: "json"
					,success: function(data) {
						if (!data || !data.review_id) {
		                    alert("저장 실패 또는 정보 누락(고유ID)");
		                    document.getElementById("result").innerHTML = "<h3>DB 저장 실패 또는 응답 데이터 오류</h3>";
							return;	
						}
						
						var wroteTime = formatTime(data.created_at);
	    				alert("저장완료 (DB 저장 시각: " + wroteTime + ")");
	    				
	    				var finalReviewHtml = '<div id="review_' + data.review_id + '" style="border: 1px solid #007bff; padding: 10px; margin-bottom: 5px; border-radius: 4px;">
				   	    					   + data.image +'<img src="" alt="사용자가 업로드한 사진" width="50px";hight="50px">'+	                    
	    				   					   '<br>작성자 ID : <strong>' + data.member_id + '</strong>' +
	    				   					   '<div style="color: orange;">별점: ' + data.rating + '점</div>' +
	    				                       '<p style="margin: 5px 0;">' + data.content + '</p>' +
	    				                       '<div style="color: #007bff; font-size: 0.8em;">작성일시: ' + wroteTime + '</div>';

	    				$("#review-list").append(finalReviewHtml);
	                    document.getElementById("result").innerHTML = "<div>DB 저장 성공! 작성 시각: " + wroteTime + "</div>";

					},error : function(jqXHR, textStatus, errorThrown) {
						console.error("AJAX Error:", textStatus, errorThrown, jqXHR.responseText);
						console.log(status, error);
						alert("오류발생: 서버 응답을 확인하세요.");	
						document.getElementById("result").innerHTML = "<h3>ajax fail: " + textStatus + "</h3>";
					}
	        });
		};
		
		function upload(){
	        var form = $("#fileUploadForm").val();
	        var data = new FormData(form);
	        data.append("member_id", $("member_id"));
	        $("#btnUpload").prop('disabled', true);
	        
	        $.ajax({
	            type: "POST",
	            enctype: "multipart/form-data",
	            url: "${pageContext.request.contextPath}/write/upload",
	            data: data,
	            processData: false,
	            contentType: false,
	            cache: false,
	            timeout: 600000,
	            success: function (data) {
	                $("#result").text(data.member_id);
	                $("#image").append(data.file);
	                console.log("SUCCESS : ", data);
	                $("#btnUpload").prop('disabled', false);
	            },
	            error: function (e) {
	                $("#result").text(e.responseText);
	                console.log("ERROR : ", e);
	                $("#btnUpload").prop('disabled', false);
	            }
	        });
		};
			
// 	        var newReviewHtml = '<div class="p-4 border-b border-gray-200 bg-white rounded-lg shadow-sm mb-4">' +
//             '<p class="text-gray-700 mt-1 whitespace-pre-wrap">' + ReviewContent + '</p>' +
//             '<div class="text-xs text-gray-400 mt-2">방금 작성됨 (클라이언트 테스트)</div>' +
//             '</div>';
	        

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
        
        
	<form method="post" id="frm">
	<table width="500" border="1">
		<input type="hidden" name="recipe_id" id="recipe_id" value="1">
		<input type="hidden" name="member_id" id="member_id" value="chef_kim">
		
			<tr colspan="2">
				<td>nickname</td>
			</tr>
			<tr>
				<td>
					<img src="#" name="image" id="image" alt="후기대표사진"><br/>
					<input type="file" name="file" id="file"/><br/>
					<input type="button" name="btnUpload" id="btnUpload" 
					method="POST" enctype="multipart/form-data" value="이미지 등록"
					onclick="upload()"> 
				</td>
			</tr>
			<tr>
				<td>별점</td>
				<td><input type="hidden" name="rating" id="rating" value="5"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea rows="5" name="content" id="content"></textarea>
				</td>
			</tr>
			<tr colspan="2">
				<td>
					<input type="button" onclick="fn_review_submit()" value="후기작성">
				</td>
			</tr>
		</table>
		</form>
	<pre>
        <span id="result"></span>
    </pre>
</body>
</html>
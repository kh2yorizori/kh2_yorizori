<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script type="text/javascript">
		function fn_submit(){
			console.log("@@jsjs");
			
			var cmtContent = $("#cmt_content").val();
			
	        if (cmtContent.trim() === "") {
	            alert("내용을 입력해주세요.");
	            return;
	        }
			
	        var contentData = {
		            cmt_content: $("#cmt_content").val()
		        };
			
	        var newCommentHtml = '<div class="p-4 border-b border-gray-200 bg-white rounded-lg shadow-sm mb-4">' +
            '<p class="text-gray-700 mt-1 whitespace-pre-wrap">' + cmtContent + '</p>' +
            '<div class="text-xs text-gray-400 mt-2">방금 작성됨 (클라이언트 테스트)</div>' +
            '</div>';
	        
	        $("#comment-list").append(newCommentHtml);

	        $("#cmt_content").val("");
	        
			$.ajax({
				type:"post"
				,data:contentData
				,url:"write_view"
				,success: function(data) {
// 					alert("저장완료");	
// 					document.getElementById("result").innerHTML = "<div>" + data + "</div>";
				}
				,error: function() {
					alert("오류발생");	
					document.getElementById("result").innerHTML = "<h3>ajax fail</h3>";
				}
			});
		};
	</script>
</head>
<body>
		<!-- 댓글 목록 표시 영역 -->
        <h2 class="text-xl font-semibold mb-4 text-gray-800">댓글 목록</h2>
        <div id="comment-list">
        </div>
        
        <!-- AJAX 테스트 결과 영역 -->
        <p id="result" class="mt-6 p-3 bg-yellow-100 border border-yellow-300 rounded-md text-sm">
            여기는 서버 통신 (AJAX) 결과가 표시되는 영역입니다.
        </p>
        
        
	<table width="500" border="1">
		<form method="post" id="frm">
			<tr colspan="2">
				<td>nickname</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea rows="5" name="cmt_content" id="cmt_content"></textarea>
				</td>
			</tr>
			<tr colspan="2">
				<td>
					<input type="button" onclick="fn_submit()" value="댓글작성">
				</td>
			</tr>
		</form>
	</table>
	
</body>
</html>
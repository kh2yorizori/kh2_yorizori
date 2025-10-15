<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script type="text/javascript">
		function fn_submit(){
			console.log("@@@ fn_submit()");
			
			var cmtContent = $("#content").val();
			
	        if (cmtContent.trim() === "") {
	            alert("내용을 입력해주세요.");
	            return;
	        }
	        
	        var formData = $("#frm").serialize();
			
	        var newCommentHtml = '<div>' +
            '<p>' + cmtContent + '</p>' +
            '<div>방금 작성됨 (클라이언트 테스트)</div>' +
            '</div>';
	        
	        $("#comment-list").append(newCommentHtml);
	        $("#content").val("");
	        
			$.ajax({
				type:"post"
				,data:formData
				,url:"write"
				,success: function(data) {
					alert("저장완료");	
					document.getElementById("result").innerHTML = "<div>" + data + "</div>";
					fn_getWroteTime();
				}
				,error: function(error) {
					alert("오류발생" + error);	
					document.getElementById("result").innerHTML = "<h3>ajax fail</h3>";
				}
			});
		};
		
		function fn_getWroteTime(){
			console.log("@@@ fn_getWroteTime()");
			$.ajax({
				type:"post"
				,data:formData
				,url:"getWroteTime"
				,success : function(data){
					alert("저장완료");	
					document.getElementById("timeResult").innerHTML = "<div>" + data + "</div>";
				}
			,error : function(error){
				alert("오류발생" + error);	
				}
			});
		};
	</script>
</head>
<body>
		<!-- 댓글 목록 표시 영역 -->
        <h2 >댓글 목록</h2>
        <div id="comment-list">
        </div>
        <div><p id="wroteTime"></p></div>
        
        <!-- AJAX 테스트 결과 영역 -->
        <p id="result" >
            여기는 서버 통신 (AJAX) 결과가 표시되는 영역입니다.
        </p>
        <p id="timeResult">
        	작성일자가 표시되는 영역입니다.
        </p>
        
        
	<table width="500" border="1">
		<form method="post" id="frm">
			<tr>
				<td>nickname</td>
				<td><input type="hidden" name="member_id" id="member_id" value="chef_kim"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea rows="3" name="content" id="content"></textarea>
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
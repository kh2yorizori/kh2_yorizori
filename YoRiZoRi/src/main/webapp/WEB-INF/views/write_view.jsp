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
			var contentData = {
		            cmt_content: $("#cmt_content").val()
		        };
			
			 document.getElementById("result").innerHTML = "<h3>[테스트] 입력 내용:</h3><p style='border: 1px solid #ccc; padding: 10px; background-color: #f9f9f9;'>" + contentData.cmt_content + "</p>";
			
			$.ajax({
				type:"post"
				,data:contentData
				,url:"write_view"
				,success: function(data) {
// 					alert("저장완료");	
// 					document.getElementById("result").innerHTML = data;
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
	<table width="500" border="1">
<!-- 		<form method="post" action="write"> -->
		<form id="frm">
			<tr>
				<td colspan="2">nickname</td>
				
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea rows="5" name="cmt_content" id="cmt_content"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" onclick="fn_submit()" value="댓글작성">
<!-- 					&nbsp; -->
<!-- 					<a href="list">목록보기</a> -->
				</td>
			</tr>
		</form>
	</table>
	<p id="hello"></p>
	<p id="result"></p>
</body>
</html>
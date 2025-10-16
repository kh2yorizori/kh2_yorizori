<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script type="text/javascript">
		//날짜를 'YYYY-MM-DD HH:MM' 형식으로 포맷하는 함수
		function formatTime(timestamp) {
		    if (!timestamp) return '시간 정보 없음';
		    // 서버에서 Date 객체가 Unix Time(밀리초) 또는 ISO String으로 올 수 있으므로 new Date()로 변환
		    var date = new Date(timestamp); 
		    var year = date.getFullYear();
		    var month = ('0' + (date.getMonth() + 1)).slice(-2);
		    var day = ('0' + date.getDate()).slice(-2);
		    var hour = ('0' + date.getHours()).slice(-2);
		    var minute = ('0' + date.getMinutes()).slice(-2);
		    return year + '-' + month + '-' + day + ' ' + hour + ':' + minute;
		}

		function fn_submit(){
			console.log("@@@ fn_submit()");
			
			var cmtContent = $("#content").val();
			var memberId = $("#member_id").val();
			
	        if (cmtContent.trim() === "") {
	            alert("내용을 입력해주세요.");
	            return;
	        }
	        
	        var formData = $("#frm").serialize();

	        $("#content").val("");
	        
			$.ajax({
				type:"post"
				,data:formData
				,url:"write"
				,dataType: "json"
				,success: function(data) {
					// data는 서버에서 반환된 CommentDTO의 JSON 객체
					
					if (!data || !data.created_at) {
                    alert("저장 실패 또는 시간 정보 누락");
                    document.getElementById("result").innerHTML = "<h3>DB 저장 실패 또는 응답 데이터 오류</h3>";
					}
                    // 시간 포맷팅 및 최종 댓글 추가
    				var wroteTime = formatTime(data.created_at);
    				alert("저장완료 (DB 저장 시각: " + wroteTime + ")");
                    
    				var finalCommentHtml = '<div style="border: 1px solid #007bff; padding: 10px; margin-bottom: 5px; border-radius: 4px;">' +
                    '<strong>' + data.member_id + '</strong>' +
                    '<p style="margin: 5px 0;">' + data.content + '</p>' +
                    '<div style="color: #007bff; font-size: 0.8em;">작성일시: ' + wroteTime + '</div>' +
                    '</div>';
                    $("#comment-list").append(finalCommentHtml);
                    
                    document.getElementById("result").innerHTML = "<div>DB 저장 성공! 작성 시각: " + wroteTime + "</div>";
               	 }
				,error: function(error) {
					alert("오류발생" + error);	
					document.getElementById("result").innerHTML = "<h3>ajax fail</h3>";
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
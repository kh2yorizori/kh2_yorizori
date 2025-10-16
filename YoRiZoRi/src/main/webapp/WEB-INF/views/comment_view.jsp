<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery.js"></script>
<script type="text/javascript">
		//'YYYY-MM-DD HH:MM' 형식
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

		// 전역 변수로 현재 작성 중인 댓글의 부모 ID를 저장
		// 0이면 최상위 댓글, 아니면 부모 댓글의 comment_id
		var currentRefId = 0; 
		
		// '대댓글 작성' 버튼 클릭 시 호출될 함수
		function fn_open_reply_form(parent_comment_id) {
		    // 댓글 작성 폼을 대댓글 모드로 전환
		    currentRefId = parent_comment_id;
		    
		    // 폼 위에 부모 댓글 정보 등을 표시해주는 것도 좋습니다.
		    $("#form-title").text("대댓글 작성 (부모 ID: " + parent_comment_id + ")");
		    
		    // Optionally, move the form near the parent comment or focus on the textarea.
		    $("#content").focus(); 
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

	     // 대댓글인 경우 ref_id를 폼 데이터에 추가
			if (currentRefId > 0) {
				formData += "&ref_id=" + currentRefId;
			} else {
				// 최상위 댓글인 경우 ref_id=0을 명시적으로 추가하거나 서버에서 처리 (여기서는 서버 처리 가정)
				// 현재 DTO에 ref_id가 int이므로, 폼에 ref_id 필드가 없으면 null/0으로 바인딩될 수 있음.
				// 명시적으로 추가하는 것이 안전합니다.
				formData += "&ref_id=0"; 
			}
	     
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
    				
    				// ** 중요: cmt_depth에 따라 들여쓰기 추가 **
    				var paddingLeft = (data.cmt_depth * 20) + 'px'; 
        				var finalCommentHtml = '<div id="comment-' + data.comment_id + '" style="border: 1px solid #007bff; padding: 10px; margin-bottom: 5px; border-radius: 4px; margin-left: ' + paddingLeft + ';">' +
                        '<strong>' + data.member_id + '</strong>' +
                        '<p style="margin: 5px 0;">' + data.content + '</p>' +
                        '<div style="color: #007bff; font-size: 0.8em;">작성일시: ' + wroteTime + '</div>' +
                        // fn_open_reply_form 호출 시 현재 댓글의 ID (data.comment_id) 전달
                        '<input type="button" name="reply" onclick="fn_open_reply_form(' + data.comment_id + ')" value="대댓글작성"></div>';
                        $("#comment-list").append(finalCommentHtml);
    					
    					// 댓글 작성 후 폼 초기화
    					currentRefId = 0;
    					$("#form-title").text("새 댓글 작성");
                    
//     				var finalCommentHtml = '<div style="border: 1px solid #007bff; padding: 10px; margin-bottom: 5px; border-radius: 4px;">' +
//                     '<strong>' + data.member_id + '</strong>' +
//                     '<p style="margin: 5px 0;">' + data.content + '</p>' +
//                     '<div style="color: #007bff; font-size: 0.8em;">작성일시: ' + wroteTime + '</div>' +
//                     '<input type="button" name="reply" onclick="fn_submit()" value="대댓글작성"></div>';
//                     $("#comment-list").append(finalCommentHtml);
                    
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
    <h2>댓글 목록</h2>
    <div id="comment-list"></div>
    
    <!-- AJAX 테스트 결과 영역 -->
    <p id="result" >
        여기는 서버 통신 (AJAX) 결과가 표시되는 영역입니다.
    </p>
        
	<table width="500" border="1">
		<form method="post" id="frm">
			<caption id="form-title">새 댓글 작성</caption>
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
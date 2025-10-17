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

// ========================fn_open_reply_form(parent_comment_id) =====================
		// '대댓글 작성' 버튼 클릭 시 호출될 함수
		function fn_open_reply_form(parent_comment_id) {
			// 1. 폼의 ref_id 필드 값을 부모 댓글 ID로 설정
			    $("#ref_id").val(parent_comment_id);
		    
			// 2. 폼 제목 변경 및 포커스
			    $("#form-title").text("대댓글 작성 (부모 ID: " + parent_comment_id + ")");
			    $("#content").focus(); 
			    
			// 3. '대댓글 취소' 버튼 표시
			    $("#cancel-reply-btn").show();
		}
		
// ========================fn_cancel_reply() =====================
		// '대댓글 취소' 버튼 클릭 시 호출될 함수
		function fn_cancel_reply() {
		    // 1. ref_id를 최상위 댓글인 0으로 재설정
		    $("#ref_id").val(0);
		    
		    // 2. 폼 초기화
		    $("#form-title").text("새 댓글 작성");
		    $("#content").val('');
		    
		    // 3. 취소 버튼 숨기기
		    $("#cancel-reply-btn").hide();
		}
		
// ======================fn_submit()===============================
		function fn_submit(){
			console.log("@@@ fn_submit()");
			
// 			var cmtContent = $("#content").val();
// 			var memberId = $("#member_id").val();
// 			var refId = $("ref_id").val();
// 			var commentId = refId;

			var cmtContent = $("#content").val();

// 	        formData += "&comment_id=" + commentId;
	        
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
					if (!data || !data.member_id || !data.created_at) {
                    alert("저장 실패 또는 시간 정보 누락(ID/시간)");
                    document.getElementById("result").innerHTML = "<h3>DB 저장 실패 또는 응답 데이터 오류</h3>";
					}
                    // 시간 포맷팅 및 최종 댓글 추가
    				var wroteTime = formatTime(data.created_at);
    				alert("저장완료 (DB 저장 시각: " + wroteTime + ")");
    				
    				// ** 중요: cmt_depth에 따라 들여쓰기 추가 **
    				var paddingLeft = (data.cmt_depth * 20) + 'px'; 
    				
       				var finalCommentHtml = '<div id="comment_' + data.comment_id + '" style="border: 1px solid #007bff; padding: 10px; margin-bottom: 5px; border-radius: 4px; margin-left: ' + paddingLeft + ';">' +
                       '<strong>' + data.member_id + '</strong>' +
                       '<p style="margin: 5px 0;">' + data.content + '</p>' +
                       '<div style="color: #007bff; font-size: 0.8em;">작성일시: ' + wroteTime + '</div>' +
                       // fn_open_reply_form 호출 시 현재 댓글의 ID (data.comment_id) 전달
                       '<input type="button" name="reply" onclick="fn_open_reply_form(' + data.comment_id + ')" value="대댓글작성"></div>';
                        
    				$("#comment-list").append(finalCommentHtml);
    					
    			
//     				var finalCommentHtml = '<div style="border: 1px solid #007bff; padding: 10px; margin-bottom: 5px; border-radius: 4px;">' +
//                     '<strong>' + data.member_id + '</strong>' +
//                     '<p style="margin: 5px 0;">' + data.content + '</p>' +
//                     '<div style="color: #007bff; font-size: 0.8em;">작성일시: ' + wroteTime + '</div>' +
//                     '<input type="button" name="reply" onclick="fn_submit()" value="대댓글작성"></div>';
//                     $("#comment-list").append(finalCommentHtml);
                    
                    // 댓글 작성 후 폼 초기화 (대댓글 모드 해제)
                    document.getElementById("result").innerHTML = "<div>DB 저장 성공! 작성 시각: " + wroteTime + "</div>";
               	 }
				,error: function(jqXHR, textStatus, errorThrown) {
					console.error("AJAX Error:", textStatus, errorThrown, jqXHR.responseText);
					alert("오류발생: 서버 응답을 확인하세요.");	
					document.getElementById("result").innerHTML = "<h3>ajax fail: " + textStatus + "</h3>";
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
				<tr>
                    <td colspan="2">
                        <input type="hidden" name="ref_id" id="ref_id" value="0">
                    </td>
                </tr>
				<tr colspan="2">
				<td>
					<input type="button" onclick="fn_submit()" value="댓글작성">
					<!-- 대댓글 취소 -->
                    <input type="button" id="cancel-reply-btn" onclick="fn_cancel_reply()" value="대댓글 취소" style="display:none; background-color: #f8d7da; border: 1px solid #f5c6cb;">
				</td>
			</tr>
		</form>
	</table>
	
</body>
</html>
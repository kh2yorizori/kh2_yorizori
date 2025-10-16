<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<html>
<head>
    <title>마이페이지 목록</title>
</head>
<body>
    <h2>마이페이지 목록</h2>

    <table border="1" cellpadding="5" cellspacing="0">
        <thead>
            <tr>
                <th>게시글</th>
                <th>제목</th>
            </tr>
        </thead>
        <tbody>
           
            <c:forEach var="recipe" items="${recipe}">
                <tr>
                    <td>${recipe.member_Id}</td>
                    
                   <td> <a href="recipe?recipe_id=${recipe.recipe_id}">${recipe.title}</a> </td>
                  
                  
                  </tr>
             </c:forEach>
		
			
                

        </tbody>
       
    </table>
</body>
</html>
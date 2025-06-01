<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	session.invalidate(); //세션 초기화
	//out.println("<script>alert('로그아웃');</script>");
	out.println("<script>location.href = document.referrer;</script>");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>야경명소</title>
</head>
<body>

</body>
</html>
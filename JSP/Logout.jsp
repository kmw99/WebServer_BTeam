<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	session.invalidate(); //세션 초기화
	out.println("<script>location.href = document.referrer;</script>");
%>
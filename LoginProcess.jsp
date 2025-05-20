<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("login-id");
	String password = request.getParameter("login-pw");
	int result = 0;
	
	Connection conn = null;
	String sql = "SELECT * FROM users WHERE username=? AND password=?";
	
	try {
		String jdbcDriver = "jdbc:mysql://54.165.192.20:3306/NightViewDB"
				+ "?useUnicode=true&characterEncoding=UTF-8";
		String dbUser = "mainweb"; //sql id
		String dbPass = "1234"; //sql pw
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, password);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			result = rs.getInt(1);
		}
		
		//어드민 확인
		if(result == 1 && id.equals("admin")) {
			result += 1;
		}
		else if(result != 0) {
			result = 1;
		}
		
		//세션에 저장(1: 유저 / 2: 어드민)
		if(result != 0) {
			session.setAttribute("login", result);
			session.setAttribute("id", id);
		}
	}
	catch(Exception e) {
		out.println("<script>alert('연결 실패');</script>");
		e.printStackTrace();
	}
%>

<%
	if(result == 1) {
		out.println("<script>alert('로그인 되었습니다.');</script>");
		out.println("<script>location.href='Main.jsp'</script>");
	}
	else if(result == 2) {
		out.println("<script>alert('관리자 로그인입니다.');</script>");
		out.println("<script>location.href='Main.jsp'</script>");
	}
	else {
		out.println("<script>alert('아이디와 비밀번호를 확인하세요.');</script>");
		out.println("<script>history.back()</script>");
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 처리</title>
</head>
<body>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<%
	request.setCharacterEncoding("UTF-8");
	String uid = request.getParameter("login-id");
	String password = request.getParameter("login-pw");
	
	Connection conn = null;
	String sql = "SELECT * FROM users WHERE username=? AND password=?";
	
	boolean loginSuccess = false;
	boolean isAdmin = false;

	try {
		String jdbcDriver = "jdbc:mysql://54.172.75.243:3306/NightViewDB"
			+ "?useUnicode=true&characterEncoding=UTF-8";
		String dbUser = "mainweb";
		String dbPass = "1234";
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, uid);
		pstmt.setString(2, password);
		ResultSet rs = pstmt.executeQuery();

		if(rs.next()) {
			loginSuccess = true;
			if(uid.equals("admin")) {
				isAdmin = true;
			}
		}
		
		if(loginSuccess) {
			session.setAttribute("login", uid);
		}
	}
	catch(Exception e) {
		e.printStackTrace();
	}

%>

<%
	if(loginSuccess) {
		if(isAdmin) {
			//out.println("<script>alert('관리자 로그인입니다.');</script>");
		} else {
			//out.println("<script>alert('로그인 되었습니다.');</script>");
		}
		session.setMaxInactiveInterval(1800);
		out.println("<script>location.href = document.referrer;</script>");
	} else {
		out.println("<script>alert('아이디와 비밀번호를 확인하세요.');</script>");
		out.println("<script>history.back()</script>");
	}
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
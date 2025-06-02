<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	int result = 0;
	
	Connection conn = null;
	String sql = "SELECT COUNT(id) AS result FROM user_info WHERE id=? AND password=?";
	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
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
		
		//세션에 저장(1: 유저 / 2: 어드민)
		if(result != 0) {
			session.setAttribute("login", result);
			session.setAttribute("id", id);
		}
	}
	catch(Exception e) {
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
		out.println("<script>location.href='LoginForm.jsp'</script>");
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
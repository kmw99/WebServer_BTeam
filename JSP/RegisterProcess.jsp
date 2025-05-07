<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	String email = request.getParameter("mail");
	String name = request.getParameter("name");
	
	Connection conn = null;
	String sql = "INSERT INTO user_info values(?, ?, ?, ?)";
	
	//성공 확인여부
	int result = 0;
	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, password);
		pstmt.setString(3, email);
		pstmt.setString(4, name);
		
		if(pstmt.executeUpdate() != 0) {
			result += 1;
		}
	}
	catch(Exception e) {
		e.printStackTrace();
	}
%>

<%
	if(result == 1) {
		out.println("<script>alert('회원가입이 완료되었습니다.');</script>");
		out.println("<script>location.href='LoginForm.jsp'</script>");
	}
	else {
		out.println("<script>alert('회원가입에 실패했습니다.');</script>");
		out.println("<script>location.href='RegisterForm.jsp'</script>");
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 처리</title>
</head>
<body>

</body>
</html>
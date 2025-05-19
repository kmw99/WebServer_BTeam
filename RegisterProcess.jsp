<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
	//초기값 설정
	request.setCharacterEncoding("utf-8");
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	int result = 0; //성공 확인여부
	//
	
	//드라이버 로딩
	Class.forName("com.mysql.jdbc.Driver");

	try {
		String jdbcDriver = "jdbc:mysql://44.201.133.151:3306/users"
				+ "?useUnicode=true&characterEncoding=UTF-8";
		String dbUser = "mainweb"; //sql id
		String dbPass = "1234"; //sql pw
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
		
		String id = request.getParameter("signup-id"); //아이디
		String password = request.getParameter("signup-pw"); //비밀번호
		String passwordcf = request.getParameter("signup-pw-confirm"); //비밀번호 확인
		
		ps = conn.prepareStatement("SELECT * FROM users WHERE username=" + id);
		rs = ps.executeQuery();
		
		if(!password.equals(passwordcf)) { //비번 다를 때
			result = -1;
		}
		else if(id.equals(rs.getString("username"))) { //중복된 아이디일 때
			result = -2;
		}
		else {
			ps = conn.prepareStatement("INSERT INTO users values(" + id + ", " + password + ")");
			if(ps.executeUpdate() != 0) {
				result += 1;
			}	
		}
		
		if(result == 1) {
			out.println("<script>alert('회원가입이 완료되었습니다.');</script>");
			out.println("<script>hitory.back()</script>");
		}
		else if(result == -1) {
			out.println("<script>alert('비밀번호를 확인해주세요.');</script>");
			out.println("<script>history.back()</script>");
		}
		else if(result == -2) {
			out.println("<script>alert('이미 존재하는 아이디입니다.');</script>");
			out.println("<script>history.back()</script>");
		}
		else {
			out.println("<script>alert('회원가입에 실패했습니다.');</script>");
			out.println("<script>history.back()</script>");
		}
	}
	catch(Exception e) {
		e.printStackTrace();
	}
%>

<%

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
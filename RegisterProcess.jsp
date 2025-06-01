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
	
	String user_id = request.getParameter("signup-id"); //아이디
	String password = request.getParameter("signup-pw"); //비밀번호
	String passwordcf = request.getParameter("signup-pw-confirm"); //비밀번호 확인
	//
	
	//드라이버 로딩
	Class.forName("com.mysql.jdbc.Driver");

	try {
		String jdbcDriver = "jdbc:mysql://54.165.192.20:3306/NightViewDB"
				+ "?useUnicode=true&characterEncoding=UTF-8";
		String dbUser = "mainweb"; //sql id
		String dbPass = "1234"; //sql pw
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);

		ps = conn.prepareStatement("SELECT * FROM users WHERE username=?");
		ps.setString(1, user_id);
		
		rs = ps.executeQuery();
		
		if(!password.equals(passwordcf)) { //비번 다를 때
			result = -1;
		}
		/*
		else if(id.equals(rs.getString("username"))) { //중복된 아이디일 때
			out.println("<script>alert('아이디 중복일때');</script>");
			result = -2;
		}
		*/
		else {
			ps = conn.prepareStatement("INSERT INTO users values(?, ?, ?)");
			ps.setInt(1, 0);
			ps.setString(2, user_id);
			ps.setString(3, password);
			if(ps.executeUpdate() != 0) {
				result += 1;
			}	
		}
	}
	catch(Exception e) {
		out.println("<script>alert('연결 실패');</script>");
		e.printStackTrace();
	}
%>

<%
	if(result == 1) {
		out.println("<script>alert('회원가입이 완료되었습니다.');</script>");
		out.println("<script>location.href = document.referrer;</script>");
	}
	else if(result == -1) {
		out.println("<script>alert('비밀번호를 확인해주세요.');</script>");
		out.println("<script>location.href = document.referrer;</script>");
	}
	else if(result == -2) {
		out.println("<script>alert('이미 존재하는 아이디입니다.');</script>");
		out.println("<script>location.href = document.referrer;</script>");
	}
	else {
		out.println("<script>alert('회원가입에 실패했습니다.');</script>");
		out.println("<script>location.href = document.referrer;</script>");
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
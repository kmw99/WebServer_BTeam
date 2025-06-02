<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("var");
	Connection conn = null;
	String sql = "DELETE FROM user_info WHERE id = ?";
	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		if(pstmt.executeUpdate() != 0) {
			out.println("<script>alert('삭제 성공')</script>");
			out.println("<script>location.href='MemberList.jsp'</script>");
		}
	}
	catch(Exception e) {
		e.printStackTrace();
		out.println("<script>alert('삭제 실패')</script>");
		out.println("<script>location.href='MemberList.jsp'</script>");
	}
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버 삭제</title>
</head>
<body>

</body>
</html>
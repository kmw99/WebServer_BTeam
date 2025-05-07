<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>

<%
	Connection conn = null;
	String sql = "SELECT * FROM user_info";
	ArrayList<String> arr = new ArrayList<String>();
	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		
		while(rs.next()) {
			arr.add(rs.getString(1));
		}
		
		//어드민은 멤버 리스트에서 제거
		arr.remove("admin");
	}
	catch(Exception e) {
		e.printStackTrace();
	}
%>

<%
	out.print("<h3>회원 리스트</h3>");
	for(String id : arr) {
		out.print("<a href=MemberInfo.jsp?var=" + id + ">" + id + "</a&nbsp;&nbsp;&nbsp;&nbsp;");
		out.print("<ahref=MemberDelete.jsp?var=" + id + ">" + "삭제</a><br>");
	};
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버 리스트</title>
</head>
<body>

</body>
</html>
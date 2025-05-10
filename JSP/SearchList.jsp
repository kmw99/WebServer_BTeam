<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<table>
		<tr>
			<td>분류</td>	
			<td>장소명</td>
			<td>주소</td>
			<td>설명</td>
		</tr>
		<%
		//초기값 설정
		request.setCharacterEncoding("utf-8");
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		//
		
		//드라이버 로딩
		Class.forName("com.mysql.jdbc.Driver");
		String searchKey = request.getParameter("searchKey"); //검색키 가져오기
		String searchValue = request.getParameter("searchValue"); //검색값 가져오기
		//
		
		try {
			String jdbcDriver = "jdbc:mysql://localhost:3306/NightViewDB"
					+ "?useUnicode=true&characterEncoding=UTF-8"; //null 부분에 mysql 데베명 기입
			String dbUser = "mainweb"; //sql id
			String dbPass = "1234"; //sql pw
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
			//검색 조건별로 테이블 나누기
			if(searchKey == null & searchValue == null) { //키 X, 값 X
				ps = conn.prepareStatement("SELECT * FROM places"); //모든 테이블 선택
			}
			else if(searchKey != null & searchValue == null) { //키 O, 값 X
				ps = conn.prepareStatement("SELECT * FROM places"); //모든 테이블 선택
			}
			else if(searchKey != null & searchValue != null) { //키 O, 값 O
				ps = conn.prepareStatement("SELECT * FROM places WHERE " + searchKey + " LIKE ?"); //해당 키 테이블 선택
				ps.setString(1, "%" + searchValue + "%");
			}
			//
			
			//검색값 토대로 테이블 출력
			rs = ps.executeQuery();
			while(rs.next()) {
				%>
				<tr>
					<td><%= rs.getString("category") %></td>
					<td><%= rs.getString("name") %></td>
					<td><%= rs.getString("address") %></td>
					<td><%= rs.getString("description") %>
				</tr>
				<%
			}
			//
		}
		catch(SQLException e) {
			out.println(e.getMessage());
			e.printStackTrace();
		}
		finally {
			//Statement 종료
			if(rs != null) {
				try { rs.close(); }
				catch(SQLException e) {}
			}
			if(ps != null) {
				try { ps.close(); }
				catch(SQLException e) {}
			}
			//
			
			//Connection 종료
			if(conn != null) {
				try { conn.close(); }
				catch(SQLException e) {}
			}
		}
			//
		%>
	</table>
</body>
</html>
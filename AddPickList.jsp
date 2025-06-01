<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<%
request.setCharacterEncoding("utf-8");
String userId = (String) session.getAttribute("login");
int placeId = Integer.parseInt(request.getParameter("placeId"));

if(userId != null) {
	Connection conn = null;
	PreparedStatement ps = null;
	
    try {
        Class.forName("com.mysql.jdbc.Driver");
        String jdbcDriver = "jdbc:mysql://54.172.75.243:3306/NightViewDB?useUnicode=true&characterEncoding=UTF-8";
        conn = DriverManager.getConnection(jdbcDriver, "mainweb", "1234");

        ps = conn.prepareStatement("INSERT INTO favorites(user_id, place_id) VALUES(?, ?)");
        ps.setString(1, userId);
        ps.setInt(2, placeId);
        ps.executeUpdate();
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (ps != null) try { ps.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>

</body>
</html>
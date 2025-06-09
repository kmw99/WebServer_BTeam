<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset="UTF-8">
</head>
<body>
	<form action="<%=request.getContextPath()%>/Search/SearchList.jsp" method="post">
		<select name="searchKey"> <!-- 검색 종류 -->
			<option value="category">분류</option>
			<option value="name">장소명</option>
			<option value="address">주소</option>
		</select>
		<input type="text" name="searchValue"> <!-- 검색값 -->
		<input type="submit" value="검색">
	</form>
</body>
</html>

<%@ include file="./log.jsp"%>
<%
	// 로그 데이터 추출
	writeLog( "새 책을 등록합니다", request, session );
%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 참고: https://hyunki99.tistory.com/56 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
<h3>로그인</h3>
<form id="userinfoForm" action="LoginProcess.jsp" method="post">
	<table>
		<tr>
			<td> <input type="text" name="id" placeholder="ID"> </td>
		</tr>
		<tr>
			<td> <input type="password" name="password" placeholder="PW"> </td>
		</tr>
		<tr>
			<td align="center">
				<a href="RegisterForm.jsp">회원가입</a>
			</td>
			<td align="center">
				<input type="submit" value="로그인">
			</td>
		</tr>
	</table>
</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script type="text/javascript">
	//유효성 검사
	function Validation() {
		//변수에 저장
		var uid = document.getElementById("uid"); //유저 아이디
		var password = document.getElementById("password"); //비밀번호
		var cpw = document.getElementById("cpw"); //비밀번호 확인
		var mail = document.getElementById("mail"); //이메일
		var name = document.getElementById("uname"); //이름
		//var year = document.getElementById("year");
		//var hobby = document.getElementById("hobby");
		//var me = document.getElementById("me");
		
		//아이디 확인
		if(uid.value.length < 4) {
			alert("아이디를 4자 이상 입력하세요.");
			uid.focus();
			
			return false;
		}
		else if(!checkEngNumber(uid.value)) { //아이디 대소문자 확인
			alert("영문 대소문자, 숫자만 입력하세요.");
			uid.focus();
			
			return false;
		}
		
		//비밀번호 확인(추후 비밀번호 보안 수준은 수정 예정)
		if(password.value.length < 8) {
			alert("비밀번호를 8자 이상 입력하세요.");
			password.focus();
			
			return false;
		}
		else if(!checkEngNumber(password.value)) { //비밀번호 대소문자 확인
			alert("영문 대소문자, 숫자만 입력하세요.");
			password.focus();
			
			return false;
		}
		else if(password.value == uid.value) { //아이디 비밀번호 비교
			alert("아이디와 동일한 비밀번호를 사용할 수 없습니다.");
			password.focus();
			
			return false;
		}
		
		//이메일 확인
		if(mail.value.length == 0) {
			alert("메일주소를 입력하세요.");
			mail.focus();
			
			return false;
		}
		else if(mail.value.indexOf("@") == -1 ||
				mail.value.indexOf(".") == -1 ||
				mail.value.length <= 5) {
			alert("잘못된 이메일 형식입니다.");
			mail.focus();
			
			return false;
		}
		
		//이름 확인
		if(uname.value == "") {
			alert("이름을 입력하세요.");
			uname.focus();
			
			return false;
		}
		else if(!checkKorEng(uname.value)) {
			alert("한글, 영어만 입력하세요.");
			uname.focus();
			
			return false;
		}
		
		/*
		//생일 확인
		if(year.value == "") {
			alert("출생년도를 입력하세요.");
			year.focus();
			
			return false;
		}
		else if(!(year.value >= 1900 && year.value <= 2025)) {
			alert("출생년도를 정확히 입력하주세요.");
			year.focus();
			
			return false;
		}
		
		//관심분야 확인
		if(!checkedHobby(hobby)) {
			alert("지역을 선택해주세요.");
			hobby.focus();
			
			return false;
		}
		
		//자기소개 확인
		if(me.value.length > 10) {
			alert("10글자 이내로 입력해주세요.");
			me.focus();
			
			return false;
		}
		*/
	}
	
	//영어, 숫자만 포함된 문자열인지 확인
	function CheckEngNumber(value) {
		var count = 0;
		
		for(var i = 0; i < value.length; i++) {
			if(('a' <= value.charCodeAt(i) && value.charCodeAt(i) <= 'z') ||
				('A' <= value.charCodeAt(i) && value.charCodeAt(i) <= 'Z') ||
				('0' <= value.charCodeAt(i) && value.charCodeAt(i) <= '9')) {
				count += 1;
			}
		}
		
		//count == 문자열 길이라면 true
		if(count === (value.length)) {
			return true;
		}
		else {
			false;
		}
	}
	
	//영어, 한글 확인
	function CheckKorEng(value) {
		var count = 0;
		
		for(var i = 0; i < value.length; i++) {
			if(('a' <= value.charCodeAt(i) && value.charCodeAt(i) <= 'z') ||
				('A' <= value.charCodeAt(i) && value.charCodeAt(i) <= 'Z') ||
				('0' <= value.charCodeAt(i) && value.charCodeAt(i) <= '9') ||
				(44032 <= value.charCodeAt(i) && value.charCodeAt(i) <= 55203)) {
				count += 1;
			}
		}
		
		//count == 문자열 길이라면 true
		if(count === (value.length)) {
			return true;
		}
		else {
			false;
		}
	}
	
	//관심분야 체크 확인
	function CheckedHobby(arr) {
		for(var i = 0; i < arr.length; i++) {
			if(arr[i].checked == true) {
				return true;
			}
		}
		
		return false;
	}
</script>
</head>
<body>
<br>
<div align="center">
</div>
<br><br>
<form id = "userinfoForm" action="RegisterProcess.jsp" method="post" onsubmit="return Validation();">
	<table text-align="center" align="center" border="1" width="800" height="600" cellspacing="0">
		<tr>
			<td align="left" colspan="2" height="50"> <b>회원 기본 정보</b></td>
		</tr>
		<tr>
			<td align="left" height="1"><input type="text" size="33" name="name" id="uname" placeholder="이름"></td>
		</tr>
		<tr>
			<td align="left" height="1"><input type="text" size="33" name="id" id="id" minlength="4" maxlength="12" placeholder="아이디(4 ~ 12자, 영어 대소문자, 숫자)"></td>
		</tr>
		<tr>
			<td align="left" height="1"><input type="password" size="33" name="password" id="password" minlength="8" placeholder="비밀번호(최소 8자, 영문 대소문자, 숫자)"></td>
		</tr>
		<tr>
			<td align="left" height="1"><input type="password" size="33" name="cpw" id="cpw" placeholder="비밀번호 확인"></td>
		</tr>
		<tr>
			<td align="left" height="1"><input type="email" size="33" name="mail" id="mail" placeholder="이메일(예시: nightview@email.com)"></td>
		</tr>
	</table>
	<br>
	<div align="center">
		<input type="submit" width="30" id="btn" value="회원가입">
		<input type="reset" value="초기화">
	</div>
</form>
</body>
</html>
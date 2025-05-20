<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <title>검색결과</title>
  <link href="style.css" rel="stylesheet" type="text/css" />
  <style>

    #search-form {
      display: flex;
      justify-content: center;
      align-items: flex-end;
      width: 350px;
      margin: 100px auto 0 auto;
      border-bottom: 2px solid #222; /* 두꺼운 밑줄 */
      padding-bottom: 10px;
      background: transparent;
    }

    #search-input {
      border: none;
      outline: none;
      background: transparent;
      font-size: 18px;
      margin-right: auto;
      color: #555;
      width: 120px;
      text-align: left;
    }

    #search-form button {
      border: none;
      background: transparent;
      font-size: 18px;
      color: #555;
      cursor: pointer;
      margin-left: auto;
    }

    #search-results {
      margin-top: 20px;
      border-top: 2px solid white;
    }

    #search-results div {
      margin-bottom: 10px;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 5px;
      box-shadow: 0 0 5px rgba(0,0,0,0.1);
    }

    #search-results h3 {
      margin-top: 0;
    }

    #data-list {
      display: block;
    }

    /* 로그인/회원가입 radio 토글 숨김 */
    .hidden-toggle {
      display: none;
    }

    #search-results {
      margin-top: 30px;
      display: flex;
      flex-direction: column;
      gap: 24px;
    }

    .result-box {
      background: white;
      border-radius: 12px;
      margin: 40px auto;
      padding: 32px 32px 24px 32px;
      width: 800px;
      box-sizing: border-box;
      color: black;
      display: flex;
      gap: 32px;
      align-items: flex-start;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
    }

    .place-photo {
      width: 180px;
      height: 180px;
      object-fit: cover;
      border-radius: 8px;
      background: #fff;
      border: 2px solid #fff;
      flex-shrink: 0;
    }

    .place-info {
      flex: 1;
      display: flex;
      flex-direction: column;
      gap: 10px;
      font-size: 1.1rem;
    }

    /*장소명*/
    .place-name {
      font-weight: bold;
      font-size: 1.3rem;
      margin-right: 80px;
    }
    
    /*즐겨찾기 버튼*/
    .place-name-row {
      display: flex;
      align-items: center;
      justify-content: space-between; /* 좌우 끝으로 정렬 */
      margin-bottom: 10px;
      width: 100%;  
    }
    
    /*주소명*/
    .place-address {
      font-size: 1rem;
    }
    
    /*즐겨찾기 버튼 크기*/
    .side-icon {
      width: 32px;   
      height: 32px;
      object-fit: contain;
    }

    .place-homepage a {
      color: blue;
      text-decoration: underline;
    }

    .place-map {
      background: #fff;
      color: #333;
      margin-top: 36px;
      border-radius: 8px;
      height: 200px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.2rem;
    }

    .site-footer {
      width: 100%;
      background: #222;
      color: #fff;
      padding: 18px 0;
      position: relative;
      margin-top: 60px;
      font-size: 1rem;
      letter-spacing: 1px;
    }

    .footer-content {
      width: 90%;
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      justify-content: center;
      gap: 32px;
      align-items: center;
      text-align: center;
    }
    
    html, body {
      height: 100%;
      margin: 0;
      padding: 0;
    }

    body {
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    .site-footer {
      margin-top: auto;
    }
  </style>
</head>
<body>
	<%@ include file="Header.jsp" %>
	<%@ include file="SearchForm.jsp" %>

	<%
		//초기값 설정
		request.setCharacterEncoding("utf-8");
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		//
		
		//드라이버 로딩
		Class.forName("com.mysql.jdbc.Driver");
		String id = request.getParameter("id");
		
		try {
			String jdbcDriver = "jdbc:mysql://54.165.192.20:3306/NightViewDB"
					+ "?useUnicode=true&characterEncoding=UTF-8";
			String dbUser = "mainweb"; //sql id
			String dbPass = "1234"; //sql pw
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
			ps = conn.prepareStatement("SELECT * FROM places WHERE address_id LIKE ?");
			ps.setString(1, id);
			
			//검색값 토대로 테이블 출력
			rs = ps.executeQuery();
	%>

			<!--검색 결과 나오는 섹션-->
			<div class="result-box">
			  <img class="place-photo" src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80" alt="장소 사진">
			  <div class="place-info">
			    <div class="place-name-row">
			      <span class="place-name"><%= rs.getString("name") %>장소명</span>
			      <img
			        id="sideIcon"
			        class="side-icon"
			        src="https://drive.google.com/thumbnail?id=1wSVy1uCzkvqWD3DzC5HDGV4p-UyXoIvl&sz=w1000"
			        alt="즐겨찾기"
			        onclick="toggleIcon()"
			        style="cursor:pointer;"
			      >
			    </div>
			    <div class="place-address">주소: <%= rs.getString("address") %></div>
			    <div class="place-contact">연락처: </div>
			    <div class="place-homepage">홈페이지: <a href="https://seoulforest.or.kr" target="_blank">https://seoulforest.or.kr</a></div>
			    <div class="place-traffic">교통편</div>
			    <div class="place-hours">운영시간</div>
			    <div class="place-parking">주차</div>
			    <div class="place-map">
			      <!-- 지도 API 자리 -->
			      지도 API 자리
			    </div>
			  </div>
			</div>

	<%
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
	%>

	<%@ include file="Footer.jsp" %>
</body>
<!--즐겨찾기 버튼 눌렀을 때 이미지 바뀌는 코드-->
<script>
    const img1 = "https://drive.google.com/thumbnail?id=1wSVy1uCzkvqWD3DzC5HDGV4p-UyXoIvl&sz=w1000";
    const img2 = "https://drive.google.com/thumbnail?id=194oCvn-FOQTQWFqpvmjXa3KZ6pL-LwFu&sz=w1000";
    
    function toggleIcon() {
      const icon = document.getElementById("sideIcon");
      if (icon.getAttribute('src') === img1) {
        icon.setAttribute('src', img2);
      } else {
        icon.setAttribute('src', img1);
      }
    }
  </script>
</html>
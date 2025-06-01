<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <link href="style.css" rel="stylesheet" type="text/css" />
  <style>
    #search-results {
      margin-top: 30px;
      display: flex;
      flex-direction: column;
      gap: 24px;
    }

    .pickresult-box {
      display: flex;
      align-items: center;
      background: white;
      border-radius: 12px;
      margin: 50px 300px;
      padding: 20px;
      color: #fff;
      box-shadow: 0 2px 8px rgba(0,0,0,0.08);
      gap: 32px;
      color: #222;
      transition: box-shadow 0.3s, transform 0.3s;
    }

    .pickresult-box:hover {
      box-shadow: 0 8px 24px rgba(33,33,33,0.18);
      transform: scale(1.03);
      cursor: pointer;
    }

    .pickplace-photo {
      width: 150px;
      height: 150px;
      object-fit: cover;
      border-radius: 8px;
      background: #fff;
    }

    .pickplace-info {
      flex: 1;
      display: flex;
      flex-direction: column;
      gap: 8px;
      font-size: 1.1rem;
      width: 100%;
    }
    /*장소명*/
    .pickplace-name {
      font-weight: bold;
      font-size: 1.3rem;
      margin-right: 80px;
    }
    /*즐겨찾기 버튼*/
    .pickplace-name-row {
      display: flex;
      align-items: center;
      justify-content: space-between; /* 좌우 끝으로 정렬 */
      margin-bottom: 10px;
      width: 100%;  
    }
    /*주소명*/
    .pickplace-address {
      font-size: 1rem;
    }
    /*즐겨찾기 버튼 크기*/
    .pickside-icon {
      width: 32px;   
      height: 32px;
      object-fit: contain;
    }
    
     .pick-title {
      margin-left: 300px;
      margin-bottom: 18px;
      color: #257090;
      font-size: 2rem;
      font-weight: bold;
      letter-spacing: 1px;
    }

    .pick-desc {
      margin-left: 300px;
      color: #888;  
      font-size: 1.1rem;
    }
  </style>
  </head>
<body>
	<%@ include file="Header.jsp" %>
    <h2 class="pick-title">나의 Pick 리스트</h2>
    <p class="pick-desc">관심 장소를 한눈에 확인하고 관리하세요!</p>
	<%
			//초기값 설정
			request.setCharacterEncoding("utf-8");
			Connection conn = null;
			PreparedStatement ps = null;
			ResultSet rs = null;
			//
			
			//드라이버 로딩
			Class.forName("com.mysql.jdbc.Driver");
			//
			
			try {
				String jdbcDriver = "jdbc:mysql://54.165.192.20:3306/NightViewDB"
						+ "?useUnicode=true&characterEncoding=UTF-8";
				String dbUser = "mainweb"; //sql id
				String dbPass = "1234"; //sql pw
				conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
				ps = conn.prepareStatement("SELECT * FROM favorites user_id=?"); //로그인 세션으로 즐겨찾기 목록 불러오기
				ps.setString(1, (String)session.getAttribute("login"));
				
				//검색값 토대로 테이블 출력
				rs = ps.executeQuery();
				while(rs.next()) {
	%>
<!--검색 결과 나오는 섹션-->
<div class="pickresult-box">
  <img class="pickplace-photo" src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80" alt="장소 사진">
  <div class="pickplace-info">
    <div class="pickplace-name-row">
      <span class="pickplace-name">장소명</span>
      <img
        id="sideIcon"
        class="pickside-icon"
        src="https://drive.google.com/thumbnail?id=194oCvn-FOQTQWFqpvmjXa3KZ6pL-LwFu&sz=w1000"
        alt="즐겨찾기"
        onclick="toggleIcon()"
        style="cursor:pointer;"
      >
    </div>
    <div class="pickplace-address">주소</div>
  </div>
</div>
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
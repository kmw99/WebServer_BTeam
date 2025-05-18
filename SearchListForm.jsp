<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <title>검색리스트</title>
  <link href="style.css" rel="stylesheet" type="text/css" />
  <style>
    #search-results {
      margin-top: 30px;
      display: flex;
      flex-direction: column;
      gap: 24px;
    }

    .result-box {
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

    .result-box:hover {
      box-shadow: 0 8px 24px rgba(33,33,33,0.18);
      transform: scale(1.03);
      cursor: pointer;
    }

    .place-photo {
      width: 150px;
      height: 150px;
      object-fit: cover;
      border-radius: 8px;
      background: #fff;
    }

    .place-info {
      flex: 1;
      display: flex;
      flex-direction: column;
      gap: 8px;
      font-size: 1.1rem;
      width: 100%;
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
  </style>
  </head>
<body>
	<%@ include file="Header.jsp" %>
	
	<form id="search-form" action="SearchListForm.jsp" method="get">
	<select name="searchKey" id="search-key">
    	<option value="name">장소명</option>
		<option value="address">주소</option>
    </select>
    <input type="search" name="searchValue" id="search-input" placeholder="검색어 입력" />
    <button type="submit">검색</button>
	</form>
	
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
			String jdbcDriver = "jdbc:mysql://44.201.133.151:3306/NightViewDB"
					+ "?useUnicode=true&characterEncoding=UTF-8";
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
				<div class="result-box" Onclick="location.href='SearchResultForm.jsp'" data-id=<%= rs.getString("address_id") %>>
					<img class="place-photo" src=<%= rs.getString("images") %> alt="장소 사진">
					<div class="place-info">
		      			<div class="place-name-row">
		        		<span class="place-name"><%= rs.getString("name") %></span>
		        		<img
							id="sideIcon"
							class="side-icon"
							src="https://drive.google.com/thumbnail?id=1wSVy1uCzkvqWD3DzC5HDGV4p-UyXoIvl&sz=w1000"
							alt="즐겨찾기"
							onclick="toggleIcon()"
							style="cursor:pointer;"
				        >
		      			</div>
	      			<div class="place-address"><%= rs.getString("address") %></div>
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
<!--검색 결과 나오는 섹션-->
  
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
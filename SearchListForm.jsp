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
	<%
		//초기값 설정
		request.setCharacterEncoding("utf-8");
		Connection conn = null;
		PreparedStatement ps = null;
		PreparedStatement fv = null;
		ResultSet rs = null;
		ResultSet fs = null;
		int isIn = 0;
		//
		
		//드라이버 로딩
		Class.forName("com.mysql.jdbc.Driver");
		String searchKey = request.getParameter("searchKey"); //검색키 가져오기
		String searchValue = request.getParameter("searchValue"); //검색값 가져오기
		//
	%>

	<%@ include file="Header.jsp" %>
	<%@ include file="SearchForm.jsp" %>

	<div>'<%= searchValue %>'에 관한 결과입니다.</div>
	<%
		try {
			String jdbcDriver = "jdbc:mysql://54.172.75.243:3306/NightViewDB"
					+ "?useUnicode=true&characterEncoding=UTF-8";
			String dbUser = "mainweb"; //sql id
			String dbPass = "1234"; //sql pw
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
			//검색 조건별로 테이블 나누기
			if(searchKey == null && searchValue == null) { //키 X, 값 X
				ps = conn.prepareStatement("SELECT * FROM places"); //모든 테이블 선택
			}
			else if(searchKey != null && searchValue == null) { //키 O, 값 X
				ps = conn.prepareStatement("SELECT * FROM places"); //모든 테이블 선택
			}
			else if(searchKey != null && searchValue != null) { //키 O, 값 O
				ps = conn.prepareStatement("SELECT * FROM places WHERE " + searchKey + " LIKE ?"); //해당 키 테이블 선택
				ps.setString(1, "%" + searchValue + "%");
			}
			//
			
			//검색값 토대로 테이블 출력
			rs = ps.executeQuery();
			while(rs.next()) {
				fv = conn.prepareStatement("SELECT * FROM favorites WHERE user_id=? AND address_id=?");
				fv.setString(1, (String)session.getAttribute("login"));
				fv.setInt(2, rs.getInt("address_id"));
				fs = fv.executeQuery();
				if(fs.next()) {
					isIn = 1;
				}
				else {
					isIn = 0;
				}
				int addressId = rs.getInt("address_id");
	%>
		<div role="button" class="result-box" data-place-name='<%= rs.getString("name") %>' Onclick="GoToDetailPage(this)">
			<img class="place-photo" src='<%= rs.getString("images") %>' alt="장소 사진">
			<div class="place-info">
      			<div class="place-name-row">
        		<span class="place-name"><%= rs.getString("name") %></span>
        		<img
					id="sideIcon"
					class="side-icon"
					src= <%if(isIn == 1) {
						%>
						"https://drive.google.com/thumbnail?id=194oCvn-FOQTQWFqpvmjXa3KZ6pL-LwFu&sz=w1000"
						<%
						} else {
						%>
						"https://drive.google.com/thumbnail?id=1wSVy1uCzkvqWD3DzC5HDGV4p-UyXoIvl&sz=w1000"
						<%
						}
						%>
					alt="즐겨찾기"
					data-place-id="<%= addressId %>"
					onclick="event.stopPropagation(); toggleIcon(this);"
					style="cursor:pointer;"
		        >
      			</div>
     			<div class="place-address"><%= rs.getString("address") %></div>
   			</div>
  			</div>
				
				<script>
					function GoToDetailPage(boxElem) {
						const placeName = boxElem.getAttribute('data-place-name');
						location.href = "SearchResultForm.jsp?name=" + encodeURIComponent(placeName);
					}
				</script>
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
function toggleIcon(iconElem) {
    const placeId = iconElem.getAttribute("data-place-id");

    if (!placeId) {
        console.error("Missing placeId from data attribute.");
        alert("잘못된 장소 ID입니다.");
        return;
    }

    const userLoggedIn = <%= session.getAttribute("login") != null ? "true" : "false" %>;
    if (!userLoggedIn) {
        alert("로그인 후 이용 가능합니다.");
        return;
    }

    const img1 = "https://drive.google.com/thumbnail?id=1wSVy1uCzkvqWD3DzC5HDGV4p-UyXoIvl&sz=w1000";
    const img2 = "https://drive.google.com/thumbnail?id=194oCvn-FOQTQWFqpvmjXa3KZ6pL-LwFu&sz=w1000";
    const currentSrc = iconElem.getAttribute("src");

    const action = (currentSrc === img1) ? "add" : "remove";
    const targetUrl = (action === "add") ? "AddPickList.jsp" : "RemovePickList.jsp";

    fetch(targetUrl, {
        method: "POST",
        headers: {
            "Content-Type": "application/x-www-form-urlencoded"
        },
        body: new URLSearchParams({ placeId: placeId })
    })
    .then(res => res.text())
    .then(result => {
        if (result.trim() === "success") {
            iconElem.setAttribute('src', (action === "add") ? img2 : img1);
        } else {
            alert("DB 처리 실패");
        }
    })
    .catch(err => {
        console.error("에러 발생:", err);
        alert("요청 실패");
    });
}
</script>
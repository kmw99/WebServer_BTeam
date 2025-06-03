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
    .pickresult-box {
      display: flex;
      align-items: center;
      background: white;
      border-radius: 12px;
      margin: 25px 300px;
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
			ResultSet list = null;
			int isIn = 1;
			//
			
			//드라이버 로딩
			Class.forName("com.mysql.jdbc.Driver");
			//
			
			try {
				String jdbcDriver = "jdbc:mysql://3.88.203.213:3306/NightViewDB"
						+ "?useUnicode=true&characterEncoding=UTF-8";
				String dbUser = "mainweb"; //sql id
				String dbPass = "1234"; //sql pw
				conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
				ps = conn.prepareStatement("SELECT * FROM favorites WHERE user_id=?"); //로그인 세션으로 즐겨찾기 목록 불러오기
				ps.setString(1, (String)session.getAttribute("login"));
				
				//검색값 토대로 테이블 출력
				rs = ps.executeQuery();
				
				while(rs.next()) {
				int addressId = rs.getInt("address_id");
				ps = conn.prepareStatement("SELECT * FROM places WHERE address_id=? ORDER BY name ASC");
				ps.setInt(1, rs.getInt("address_id"));
				list = ps.executeQuery();
				list.next();
	%>
<!--검색 결과 나오는 섹션-->
<div role="button" class="pickresult-box" data-place-name='<%= list.getString("name") %>' Onclick="GoToDetailPage(this)">
  <img class="pickplace-photo" src=<%= list.getString("images") %> alt="장소 사진">
  <div class="pickplace-info">
    <div class="pickplace-name-row">
      <span class="pickplace-name"><%= list.getString("name") %></span>
      <img
        id="sideIcon"
        class="pickside-icon"
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
    <div class="pickplace-address"><%= list.getString("address") %></div>
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
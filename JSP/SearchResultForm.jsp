<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.DriverManager" %>
<%@ page import = "java.sql.Connection" %>
<%@ page import = "java.sql.PreparedStatement" %>
<%@ page import = "java.sql.ResultSet" %>
<%@ page import = "java.sql.SQLException" %>
<%@ page import = "java.net.URLEncoder" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <link href="style.css" rel="stylesheet" type="text/css" />
  <style>
    #data-list {
      display: block;
    }

    /* 로그인/회원가입 radio 토글 숨김 */
    .hidden-toggle {
      display: none;
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
  </style>
</head>
<body>
	<%@ include file="Header.jsp" %>
	<%@ include file="SearchForm.jsp" %>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=914a6d66ecdbb0b690b058ee9333d4df&libraries=services"></script>

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
		String name = request.getParameter("name");
		
		try {
			String jdbcDriver = "jdbc:mysql://54.152.1.123:3306/NightViewDB"
					+ "?useUnicode=true&characterEncoding=UTF-8";
			String dbUser = "mainweb"; //sql id
			String dbPass = "1234"; //sql pw
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPass);
			
			ps = conn.prepareStatement("SELECT * FROM places WHERE name= ?");
			ps.setString(1, name);
			
			//검색값 토대로 테이블 출력
			rs = ps.executeQuery();
			rs.next();
			
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
			
			int addressId = rs.getInt(1);
			PreparedStatement info = conn.prepareStatement("SELECT * FROM contact_info WHERE address_id= ?");
			info.setInt(1, addressId);
			ResultSet infoRs = info.executeQuery();
			infoRs.next();
			
			PreparedStatement tp = conn.prepareStatement("SELECT * FROM transport WHERE address_id= ?");
			tp.setInt(1, addressId);
			ResultSet tpRs = tp.executeQuery();
			tpRs.next();
			
			String address = rs.getString("address");
			if (address == null || address.trim().isEmpty() ||
			    address.equalsIgnoreCase("null") || address.equalsIgnoreCase("NULL")) {
			    address = "서울특별시 중구 세종대로 110"; // fallback
			}
			String encodedAddress = URLEncoder.encode(address, "UTF-8");
	%>

			<!--검색 결과 나오는 섹션-->
			<div class="result-box">
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
			        onclick="toggleIcon(this)"
			        style="cursor:pointer;"
			      >
			    </div>
			    <div class="place-address">주소: <%= rs.getString("address") %></div>
   				<%
				    String phone = infoRs.getString("phone");
				    if (phone != null && !phone.trim().equals("") && !phone.equalsIgnoreCase("NULL")) {
				%>
					<div class="place-contact">연락처: <%= infoRs.getString("phone") %></div>
				<%
				    }
				    else {
				%>
					<div class="place-contact">연락처: X</div>
				<% 
				    }
				%>
				<%
				    String website = infoRs.getString("website");
				    if (website != null && !website.trim().equals("") && !website.equalsIgnoreCase("NULL")) {
				%>
				    <div class="place-homepage">
				        홈페이지: <a href="<%= website %>" target="_blank"><%= website %></a>
				    </div>
				<%
				    }
				    else {
				%>
					<div class="place-homepage">홈페이지: X</div>
				<% 
				    }
				%>
			    <div class="place-hours">운영시간: <%= infoRs.getString("opening_hours") %></div>
			    <div class="place-traffic">교통편</div>
			    <%
				    String bus = tpRs.getString("bus");
				    if (bus != null && !bus.trim().equals("") && !bus.equalsIgnoreCase("NULL")) {
				%>
					<div class="place-traffic">버스: <%= tpRs.getString("bus") %></div>
				<%
				    }
				    else {
				%>
					<div class="place-traffic">버스: X</div>
				<% 
				    }
				%>
							    <%
				    String subway = tpRs.getString("subway");
				    if (subway != null && !subway.trim().equals("") && !subway.equalsIgnoreCase("NULL")) {
				    	subway = subway.replace("?", ", ");
				%>
					<div class="place-traffic">지하철: <%= subway %></div>
				<%
				    }
				    else {
				%>
					<div class="place-traffic">지하철: X</div>
				<% 
				    }
				%>
			    <!--<div class="place-parking">주차: </div> -->
			    <div id="map" class="place-map" style="width:100%; height:300px;"></div>
				<script>
				  window.onload = function () {
				    var mapContainer = document.getElementById('map');
				    var mapOption = {
				      center: new kakao.maps.LatLng(37.5665, 126.9780),
				      level: 3
				    };
				
				    var map = new kakao.maps.Map(mapContainer, mapOption);
				
				    var geocoder = new kakao.maps.services.Geocoder();
				    var address = decodeURIComponent("<%= encodedAddress %>");
				
				    geocoder.addressSearch(address, function (result, status) {
				      if (status === kakao.maps.services.Status.OK) {
				        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				
				        var marker = new kakao.maps.Marker({
				          map: map,
				          position: coords
				        });
				
				        var infowindow = new kakao.maps.InfoWindow({
				          content: '<div style="padding:5px;font-size:14px;">' + address + '</div>'
				        });
				        infowindow.open(map, marker);
				
				        map.setCenter(coords);
				      } else {
				        alert("주소 검색 실패: " + status);
				      }
				    });
				  }
				</script>
			</div>
			</div>

	<%
		}
		catch(SQLException e) {
			out.println(e.getMessage());
			e.printStackTrace();
		}
		finally {
			// Statement 종료
			if(rs != null) {
				try { rs.close(); }
				catch(SQLException e) {}
			}
			if(ps != null) {
				try { ps.close(); }
				catch(SQLException e) {}
			}
			//
			
			// Connection 종료
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
</html>
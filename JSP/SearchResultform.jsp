<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <title>replit</title>
  <link href="style.css" rel="stylesheet" type="text/css" />
  <style>
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
  </style>
  </head>
<body>
<!--검색 결과 나오는 섹션-->
<div class="result-box">
  <img class="place-photo" src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80" alt="장소 사진">
  <div class="place-info">
    <div class="place-name-row">
      <span class="place-name">장소명</span>
      <img
        id="sideIcon"
        class="side-icon"
        src="https://drive.google.com/thumbnail?id=1wSVy1uCzkvqWD3DzC5HDGV4p-UyXoIvl&sz=w1000"
        alt="즐겨찾기"
        onclick="toggleIcon()"
        style="cursor:pointer;"
      >
    </div>
    <div class="place-address">주소</div>
    <div class="place-contact">연락처</div>
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
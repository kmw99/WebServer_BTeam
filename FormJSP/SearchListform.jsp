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
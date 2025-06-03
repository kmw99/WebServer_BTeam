<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
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
  </style>
</head>
<body>
<!--검색창 있는 섹션-->
  <form id="search-form" action="SearchListForm.jsp" method="get">
    <select name="searchKey" id="search-key">
      <option value="name">장소명</option>
      <option value="address">주소</option>
    </select>
    <input type="search" name="searchValue" id="search-input" placeholder="검색어 입력" />
    <button type="submit">검색</button>
  </form>
</body>

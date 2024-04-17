<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="kr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap"
          rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <%--<link rel="stylesheet" href="dashStyle.css">--%>
    <title>Admin Dashboard</title>
    <style>
        body, ul {
            margin: 0;
            padding: 0;
            list-style: none;
        }

        .sidebar {
            width: 225px;
            height: calc(100vh - 100px);
            background-color: #f0f0f0;
            padding: 20px;
            float: left;
        }

        .logo {
            width: 145px;
            margin-bottom: 20px;
        }

        .menu a {
            display: block;
            color: black;
            text-decoration: none;
            padding: 10px;
            border-radius: 5px;
        }

        .menu-item {
            margin-bottom: 5px;
            display: block;
            color: black;
            text-decoration: none;
            padding: 10px;
            border-radius: 5px;
            font-size: 20px;
            background-color: #f0f0f0; /* 기본 배경색 */
        }


        .menu-item.active > a,
        .menu-item > a:hover {
            background-color: #ddd;
        }


        .toggle-icon {
            float: right;
        }
        /* 하위 메뉴 스타일 */
        .submenu {
            display: none;
            padding: 10px;
            margin-top: 5px;
            background-color: #ffffff; /* 하위 메뉴의 배경색 */
            border: 1px solid #dddddd; /* 경계선 설정 */
            box-shadow: 0px 2px 5px rgba(0,0,0,0.1); /* 그림자 효과 추가 */
            border-radius: 5px; /* 경계선 둥글게 */
        }

        .submenu a {
            padding: 8px;
            display: block; /* 링크를 블록 요소로 만들어 줄마다 표시 */
            color: #333333; /* 텍스트 색상 */
            text-decoration: none; /* 링크 밑줄 제거 */
            border-radius: 4px; /* 링크 경계선 둥글게 */
        }

        .submenu a:hover {
            background-color: #f5f5f5; /* 호버 시 배경색 변경 */
        }


    </style>
</head>
<body>

<div class="sidebar">
    <img src="../image/staticImage/logo.png" class="logo" alt="쇼핑몰 로고">
    <ul class="menu">
        <li class="menu-item dashboard"><a href="#">대시보드</a></li>
        <li class="menu-item">
            <a href="#">상품관리 <span class="toggle-icon">+</span></a>
            <ul class="submenu">
                <li><a href="./productList.jsp">상품 목록</a></li>
                <li><a href="./addProduct.jsp">상품 추가</a></li>
                <li><a href="#">상품 수정</a></li>
                <li><a href="#">상품 삭제</a></li>
            </ul>
        </li>
        <li class="menu-item">
            <a href="#">회원관리 <span class="toggle-icon">+</span></a>
            <ul class="submenu">
                <li><a href="#">회원 목록</a></li>
                <li><a href="#">회원 추가</a></li>
                <li><a href="#">회원 수정</a></li>
                <li><a href="#">회원 삭제</a></li>
            </ul>
        </li>
        <li class="menu-item">
            <a href="#">주문관리 <span class="toggle-icon">+</span></a>
            <ul class="submenu">
                <li><a href="#">주문 목록</a></li>
                <li><a href="#">주문 처리</a></li>
                <li><a href="#">반품 처리</a></li>
                <li><a href="#">환불 처리</a></li>
            </ul>
        </li>
        <li class="menu-item">
            <a href="#">통계 <span class="toggle-icon">+</span></a>
            <ul class="submenu">
                <li><a href="#">매출 통계</a></li>
                <li><a href="#">방문자 통계</a></li>
                <li><a href="#">상품별 통계</a></li>
                <li><a href="#">지역별 통계</a></li>
            </ul>
        </li>
    </ul>
</div>
<script src="dashScript.js"></script>
</body>

</html>

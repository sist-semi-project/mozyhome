<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap"
	rel="stylesheet"> 
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="dashStyle.css">

<title>Admin Dashboard</title>
<style type="text/css">

body {
        background-color: #f8f9fa; /* 회색 계열의 배경 */
    }

    /* 네비게이션 바 색상 */
    .sidebar {
        background-color: #343a40; /* 어두운 회색 */
        width: 235px;
    height: 100vh;
    padding: 20px;
}
    }

    /* 로고 디자인 */
    .logo {
        width: 150px; /* 로고 이미지의 너비 */
        margin: 20px auto; /* 로고를 가운데 정렬 */
        display: block; /* 로고 이미지를 블록 요소로 설정하여 가운데 정렬 */
    }

 /* 폰트 */
    body, .menu-item a, .submenu a {
        font-family: 'Noto Sans KR', sans-serif; /* 한국어 폰트 선택 */
    }

    /* 네비게이션 메뉴 디자인 */
    .menu-item a {
        color: #ffffff; /* 흰색 텍스트 */
        text-decoration: none; /* 밑줄 제거 */
        padding: 10px 20px; /* 네비게이션 메뉴의 패딩 설정 */
        display: block; /* 네비게이션 메뉴를 블록 요소로 설정하여 전체 너비를 차지하도록 함 */
    }

    .menu-item a:hover {
        background-color: #495057; /* 호버 시 어두운 회색 */
    }

    /* 서브메뉴 디자인 */
    .submenu {
        display: none; /* 서브메뉴 숨김 */
        background-color: #495057; /* 어두운 회색 배경 */
    }

    .submenu a {
        color: #ffffff; /* 흰색 텍스트 */
        padding: 10px 30px; /* 서브메뉴의 패딩 설정 */
        display: block; /* 서브메뉴를 블록 요소로 설정하여 전체 너비를 차지하도록 함 */
    }

    .submenu a:hover {
        background-color: #343a40; /* 호버 시 더 어두운 회색 */
    }
    
    .menu-item {
    margin-bottom: 5px;
    display: block;
    color: black;
    text-decoration: none;
    padding: 10px;
    border-radius: 5px;
    font-size: 20px;
    background-color: #495057;
}

.sidebar {
    text-align: center; /* 텍스트를 가운데 정렬합니다. */
}

.logo {
    display: inline-block; /* 이미지를 인라인 블록 요소로 설정합니다. */
    margin-bottom: 20px; /* 이미지 아래 여백을 추가합니다. */
}


</style>
</head>
<body>

	<div class="sidebar">
		<img src="../image/staticImage/logo2.png" class="logo" alt="쇼핑몰 로고">
		<ul class="menu">
			<li class="menu-item"><a href="#"  style="font-size: 25px; line-height: 24px;"><i class="fa-solid fa-cart-shopping"  style="margin-right: 5px;"></i>상품<span
					class=""></span></a>
				<ul class="">
					<li><a href="./productList.jsp">상품관리</a></li>
					<li><a href="./addProduct.jsp">상품등록</a></li>
			<!-- 	<li><a href="#">상품 수정</a></li>
					<li><a href="#">상품 삭제</a></li> -->
				</ul></li>
			<li class="menu-item"><a href="#"  style="font-size: 25px; line-height: 24px;"><i class="fas fa-users" style="margin-right: 5px;"></i>회원<span
					class=""></span></a>
				<ul class="">
					<li><a href="#">회원관리</a></li>
<!-- 					<li><a href="#">회원 추가</a></li>
				 	<li><a href="#">회원 수정</a></li>
					<li><a href="#">회원 삭제</a></li> -->
				</ul></li>
			<li class="menu-item"><a href="#"  style="font-size: 25px; line-height: 24px;"><i class="fas fa-shopping-basket" style="margin-right: 5px;"></i>주문<span
					class=""></span></a>
				<ul class="">
					<li><a href="#">주문관리</a></li>
					<!-- <li><a href="#">주문 처리</a></li>
					<li><a href="#">반품 처리</a></li>
					<li><a href="#">환불 처리</a></li>  -->
				</ul></li>
		</ul>
		<br><br><br><br><br><br>
		<button type="button" onclick="location.href='adminLogin.jsp'" class="btn btn-primary mt-4">로그아웃</button>
		
	</div>

</body>

</html>

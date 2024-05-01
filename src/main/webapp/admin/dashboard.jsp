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

<style>
	body {
		display: flex;
		height: 1250px;
		background-color: #f8f9fa;
		font-family: 'Noto Sans KR', sans-serif;
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

<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<title>메인페이지</title>

<style type="text/css">
	
	.swiper-button-prev, .swiper-button-next{
		background-color: #fff;
  		opacity: 1;
  		padding: 15px 23px;
  		border-radius: 100px;
  		color: black !important;
  		margin-left: 50px;
  		margin-right: 50px;
	}
	
	.swiper-button-prev:after,.swiper-button-next:after {
		font-size: 1.2rem !important;
		font-weight: 600 !important;
	}
	
	.swiper-pagination-bullet {
		opacity: 0.7;
  		background: white !important;
  		padding: 1px 50px;
  		border-radius: 0px;
	}
	
	.swiper-pagination-bullet-active {
		opacity: 0.7;
		background: #FF5C00 !important;
	}

	.mdpick, .new, .category, .review{
		width: 1200px;
    	margin: 0 auto;
	}
	
	::webkit-scrollbar-thumb{
		background: #FF5C00 !important;
	}
	
	::webkit-scrollbar-track{
		background: white !important;
	}

	
	
</style>
</head>
<body>

<div class="swiper mySwiper">
    <div class="swiper-wrapper">
        <div class="swiper-slide"><img src="./image/staticImage/mainBanner.png" alt="광고 1" style="width: 100%;"></div>
        <div class="swiper-slide"><img src="./image/staticImage/mainBanner.png" alt="광고 2" style="width: 100%;"></div>
        <div class="swiper-slide"><img src="./image/staticImage/mainBanner.png" alt="광고 3" style="width: 100%;"></div>
        <div class="swiper-slide"><img src="./image/staticImage/mainBanner.png" alt="광고 4" style="width: 100%;"></div>
        <div class="swiper-slide"><img src="./image/staticImage/mainBanner.png" alt="광고 5" style="width: 100%;"></div>
    </div>
    <!-- Add Pagination -->
    <div class="swiper-pagination"></div>
    <!-- Add Navigation -->
    <div class="swiper-button-prev"></div>
    <div class="swiper-button-next"></div>
    <div class="swiper-scrollbar"></div>
</div>

<div style="width: 1500px; margin: 0 auto;" align="center;">
	<div class="mdpick" style="margin-top: 100px;">
		<span style="font-size: 32px;">MD PICK</span>
		<img alt="" src="./image/staticImage/Vector.png">

			<div class="swiper mySwiper">
				<div class="swiper-wrapper" style="width: 1200px;">
					<div class="swiper-slide">
						<img src="./image/productSave/floorlampA.png" alt="광고 1" style="width: 100%;">
					</div>
					<div class="swiper-slide">
						<img src="./image/staticImage/mainBanner.png" alt="광고 2" style="width: 100%;">
					</div>
					<div class="swiper-slide">
						<img src="./image/staticImage/mainBanner.png" alt="광고 3" style="width: 100%;">
					</div>
					<div class="swiper-slide">
						<img src="./image/staticImage/mainBanner.png" alt="광고 4" style="width: 100%;">
					</div>
					<div class="swiper-slide">
						<img src="./image/staticImage/mainBanner.png" alt="광고 5" style="width: 100%;">
					</div>
				</div> 
				<!-- Add Pagination -->
				<div class="swiper-pagination"></div>
				<!-- Add Navigation -->
				<div class="swiper-button-prev"></div>
				<div class="swiper-button-next"></div>
				<div class="swiper-scrollbar"></div>
			</div>
		</div>
		
		<div class="new" style="margin-top: 100px;">
		<span style="font-size: 32px;">NEW</span>
		<img alt="" src="./image/staticImage/Vector.png">

			<div class="swiper mySwiper">
				<div class="swiper-wrapper" style="width: 1200px;">
					<div class="swiper-slide">
						<img src="./image/productSave/floorlampA.png" alt="광고 1" style="width: 100%;">
					</div>
					<div class="swiper-slide">
						<img src="./image/staticImage/mainBanner.png" alt="광고 2" style="width: 100%;">
					</div>
					<div class="swiper-slide">
						<img src="./image/staticImage/mainBanner.png" alt="광고 3" style="width: 100%;">
					</div>
					<div class="swiper-slide">
						<img src="./image/staticImage/mainBanner.png" alt="광고 4" style="width: 100%;">
					</div>
					<div class="swiper-slide">
						<img src="./image/staticImage/mainBanner.png" alt="광고 5" style="width: 100%;">
					</div>
				</div> 
				<!-- Add Pagination -->
				<div class="swiper-pagination"></div>
				<!-- Add Navigation -->
				<div class="swiper-button-prev"></div>
				<div class="swiper-button-next"></div>
				<div class="swiper-scrollbar"></div>
			</div>
		</div>
		
		<div class="category" style="margin-top: 200px;">
			<table class="table-bordered" style="width: 1200px;">
				<tr>
					<td><span style="align-content: bottom;">sofa</span><a href="index.jsp?main=product/productList.jsp?cate_num=11"><img src="./image/staticImage/cate_sofa.png"></a></td>
					<td><a href="index.jsp?main=product/productList.jsp?cate_num=12"><img src="./image/staticImage/cate_table.png"></a></td>
				</tr>
				
				<tr>
					<td><a href="index.jsp?main=product/productList.jsp?cate_num=22"><img src="./image/staticImage/cate_chair.png"></a></td>
					<td><a href="index.jsp?main=product/productList.jsp?cate_num=4"><img src="./image/staticImage/cate_lamp.png"></a></td>
				</tr>
				
				<tr>
					<td colspan="2" align="center"><a href="index.jsp?main=product/productList.jsp?cate_num=5"><img src="./image/staticImage/cate_etc2.png" style="height: 400px;"></a></td>
				</tr>
		
			</table>
		</div>
		
		<div class="review" style="margin-top: 100px;">
		<span style="font-size: 32px;">REVIEW</span>
		<img alt="" src="./image/staticImage/Vector.png">

			<div class="swiper mySwiper">
				<div class="swiper-wrapper" style="width: 1200px;">
					<div class="swiper-slide">
						<img src="./image/productSave/floorlampA.png" alt="리뷰 1" style="width: 100%;">
					</div>
					<div class="swiper-slide">
						<img src="./image/staticImage/mainBanner.png" alt="리뷰 2" style="width: 100%;">
					</div>
					<div class="swiper-slide">
						<img src="./image/staticImage/mainBanner.png" alt="리뷰 3" style="width: 100%;">
					</div>
					<div class="swiper-slide">
						<img src="./image/staticImage/mainBanner.png" alt="리뷰 4" style="width: 100%;">
					</div>
					<div class="swiper-slide">
						<img src="./image/staticImage/mainBanner.png" alt="리뷰 5" style="width: 100%;">
					</div>
				</div> 
				<!-- Add Pagination -->
				<div class="swiper-pagination"></div>
				<!-- Add Navigation -->
				<div class="swiper-button-prev"></div>
				<div class="swiper-button-next"></div>
				<div class="swiper-scrollbar"></div>
			</div>
		</div>
		
		
</div>


</body>
<script>
    var mySwiper = new Swiper('.mySwiper', {
        loop:true,
        spaceBetween: 30,
        centeredSlides: true,
        autoplay: {
            delay: 3500,
            disableOnInteraction: false,
        },
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },
        effect: 'slide', // 'slide', 'fade', 'cube', 'coverflow' 또는 'flip' 중 선택
        scrollbar: {
            el: '.swiper-scrollbar',
         }
    });
</script>
</html>
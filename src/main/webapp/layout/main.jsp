<%@page import="data.dto.ReviewDto"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="data.dao.mainDao"%>
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
	/* 스와이프 디자인 */
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
		opacity: 0;
  		background: white !important;
  		padding: 1px 50px;
  		border-radius: 0px;
	}
	
	.swiper-pagination-bullet-active {
		opacity: 0;
		background: #FF5C00 !important;
	}

	.mdpick, .new, .category, .review{
		width: 1200px;
    	margin: 0 auto;
	}
	
	.swiper-scrollbar{
		background-color: white;
		height: 1500px;
	}
	
	body > div.layout.main > div.swiper.mySwiper.swiper-initialized.swiper-horizontal.swiper-backface-hidden > div.swiper-scrollbar.swiper-scrollbar-horizontal > div {
    	background-color:  #FF5C00 !important;
	}
	/* 스와이프 디자인 끝 */
	
	a{
		text-decoration: none !important;
		color:black !important;
		cursor: pointer;		
	}
	
</style>

<script type="text/javascript">
	$(function(){
		// 상품 클릭 시 상품상세로 이동
		$("a.goDetail").click(function(){
			var pronum=$(this).attr("pronum");
			//alert(pronum);
			
			// 디테일 페이지로 이동 #review
			location.href="index.jsp?main=product/detailpage.jsp?pro_num="+pronum;
		});
	});
</script>
</head>
<%
	// 0423 17:47 작업중 - new 상품 출력
	mainDao mdao=new mainDao();
	List<ProductDto> nlist = new ArrayList<ProductDto>();
	nlist=mdao.getNewProducts();
	
	List<ReviewDto> rlist = new ArrayList<ReviewDto>();
	rlist=mdao.getReview();
	
	NumberFormat nf=new DecimalFormat("#,###.##원");
%>
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
	<!-- md pick -->
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
		
		<!-- new 
		https://jongs-story.tistory.com/m/17 더보기버튼
		-->
		<div class="new" style="margin-top: 180px;">
			<span style="font-size: 32px;">NEW</span>
			<img alt="" src="./image/staticImage/Vector.png">
			
			<div>
				<table>
					<tr>
					<%
						int nline=0;
					
						for(int i=0; i<4; i++){
							ProductDto pdto=nlist.get(i);
						%>		
							<td width="330px" align="center" style="padding: 40px 10px 50px;">
								<a pronum="<%=pdto.getPro_num()%>" class="goDetail">
								<img src="<%=pdto.getPro_main_img()%>" style="padding-bottom: 8px;">
								<span><%=pdto.getPro_name() %></span> <br>
								<span><%=nf.format(pdto.getPro_price()) %></span>
								</a>
							</td>		
						<%
								if((nline+1)%4==0){%>
									</tr><tr>
								<%}
							%>
						<%}
					
					%>
					</tr>
					<tr>
						<td colspan="4" align="center">
							<a id="newMore" href="index.jsp?main=product/newProductList.jsp"><img alt="" src="./image/staticImage/more_bs.png"></a>
						</td>
					</tr>
				</table>
			
			</div>

		</div>
		
		<!-- category -->
		<div class="category" style="margin-top: 180px;">
			<table class="table-bordered" style="width: 1200px;">
				<tr>
					<td><a href="index.jsp?main=product/productList.jsp?cate_num=11"><img src="./image/staticImage/cate_sofa.png"></a></td>
					<td><a href="index.jsp?main=product/productList.jsp?cate_num=12"><img src="./image/staticImage/cate_table.png"></a></td>
				</tr>
				
				<tr>
					<td><a href="index.jsp?main=product/productList.jsp?cate_num=22"><img src="./image/staticImage/cate_chair.png"></a></td>
					<td><a href="index.jsp?main=product/productList.jsp?cate_num=4"><img src="./image/staticImage/cate_lamp.png"></a></td>
				</tr>
				
				<tr>
					<td colspan="2" align="center" style="height: 350px;"><a href="index.jsp?main=product/productList.jsp?cate_num=5"><img src="./image/staticImage/cate_etc2.png" style="height:400px;"></a></td>
				</tr>
		
			</table>
		</div>
		
		<!-- review -->
		<div class="review" style="margin-top: 180px;">
			<span style="font-size: 32px;">REVIEW</span>
			<img alt="" src="./image/staticImage/Vector.png">
				<div>
					<table>
						<%
						int rline = 0;

						// 반복문을 사용하여 이미지 출력
						for (int i = 0; i < 12; i++) {
							ReviewDto rdto = rlist.get(i);
						%>
						<!-- 각 행의 시작 -->
						<%
						if (rline % 4 == 0) {
						%>
						<tr>
							<%
							}
							%>

							<td width="330px" align="center" style="padding: 20px 10px 0px;">
								<a pronum="<%=rdto.getPro_num()%>" class="goDetail"> 
								<img src="./image/reviewSave/etcB.jpg" style="padding-bottom: 8px;">
								<%-- <img src="<%=rdto.getReview_image() %>" style="padding-bottom: 8px;"> --%>
							</a>
							</td>

							<!-- 각 행의 끝 -->
							<%
							if ((rline + 1) % 4 == 0) {
							%>
						</tr>
						<%}%>

						<%
						rline++;
						%>
						<%}%>

						<!-- 마지막 행이 모자랄 경우 빈 셀로 채워주기 -->
						<%
						if (rline % 4 != 0) {
						%>
						<%
						int emptyCells = 4 - (rline % 4);
						%>
						<%
						for (int j = 0; j < emptyCells; j++) {
						%>
						<td></td>
						<%}%>
						</tr>
						<%}%>
				</table>
			</div>
		</div>


</body>
<script>
	var mySwiper = new Swiper('.mySwiper', {
		loop : true,
		spaceBetween : 30,
		centeredSlides : true,
		autoplay : {
			delay : 3500,
			disableOnInteraction : false,
		},
		pagination : {
			el : '.swiper-pagination',
			clickable : true,
		},
		navigation : {
			nextEl : '.swiper-button-next',
			prevEl : '.swiper-button-prev',
		},
		effect : 'slide', // 'slide', 'fade', 'cube', 'coverflow' 또는 'flip' 중 선택
		scrollbar : {
			el : '.swiper-scrollbar',
		}
	});
</script>
</html>
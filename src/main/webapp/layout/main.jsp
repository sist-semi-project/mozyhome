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
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link rel="stylesheet"
	href="https://unpkg.com/swiper/swiper-bundle.min.css" />
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<title>메인페이지</title>

<style type="text/css">
/* md pick 디자인 */
.summary_desc {
	font-size: 13px;
	color: #999;
	font-weight: 400;
	letter-spacing: 0;
	display: block;
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

.md_pick .listmain_cont .list .infomation .info {
	display: flex;
	height: 230px; /*mdpick 길이 조절*/
	flex-flow: column;
}

.md_pick .listmain_cont .list .infomation .info .title {
	font-family: Montserrat;
	font-size: 26px;
	font-weight: 700;
	color: #141414;
	text-overflow: ellipsis;
	white-space: nowrap;
	overflow: hidden;
}

.md_pick .listmain_cont .list .infomation {
	background-color: #fff;
	padding: 10px;
}

.md_pick .listmain_cont .list .infomation .info a {
	display: block;
	margin-top: 20px;
}

* {
	outline: none;
}

.md_pick .listmain_cont .list .infomation .info .summary_desc {
	flex: 1;
	margin-top: 20px;
	font-size: 18px;
	font-weight: 500;
	line-height: 28px;
	color: #141414;
	display: -webkit-box;
	-webkit-line-clamp: 4;
	-webkit-box-orient: vertical;
	overflow: hidden;
	white-space: normal;
}

.swiper_next {
	right: 1px;
}

.swiper_prev, .swiper_next {
	position: absolute;
	top: 50%;
	transform: translate(0, -50%);
	z-index: 1;
	cursor: pointer;
}

.swiper_prev.swiper-button-disabled, .swiper_next.swiper-button-disabled
	{
	display: none;
}

h1, h3 {
	margin: 0;
}

.items {
	border: 1px solid black;
	/* Creates a black border around the element */
}
/* md pick 디자인 끝 */

/* 스와이프 디자인 */
.swiper-button-prev, .swiper-button-next {
	background-color: #fff;
	opacity: 1;
	padding: 15px 23px;
	border-radius: 100px;
	color: black !important;
	margin-left: 50px;
	margin-right: 50px;
}

.swiper-button-prev:after, .swiper-button-next:after {
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

.mdpick, .new, .category, .review {
	width: 1200px;
	margin: 0 auto;
}

.swiper-scrollbar {
	background-color: white;
	height: 1500px;
}

body>div.layout.main>div.swiper.mySwiper.swiper-initialized.swiper-horizontal.swiper-backface-hidden>div.swiper-scrollbar.swiper-scrollbar-horizontal>div
	{
	background-color: #FF5C00 !important;
}

/* 스와이프 디자인 끝 */
a {
	text-decoration: none !important;
	color: black !important;
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
mainDao mdao = new mainDao();
List<ProductDto> nlist = new ArrayList<ProductDto>();
nlist = mdao.getNewProducts();

List<ReviewDto> rlist = new ArrayList<ReviewDto>();
rlist = mdao.getReview();

NumberFormat nf = new DecimalFormat("#,###.##원");
%>
<body>

	<div class="swiper mySwiper">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<img src="./image/staticImage/mainBanner2.png" alt="배너 1"
					style="width: 100%;">
			</div>
			<div class="swiper-slide">
				<img src="./image/staticImage/mainBanner1.png" alt="배너 2"
					style="width: 100%;">
			</div>
			<div class="swiper-slide">
				<img src="./image/staticImage/mainBanner3.png" alt="배너 3"
					style="width: 100%;">
			</div>
			<div class="swiper-slide">
				<img src="./image/staticImage/mainBanner4.png" alt="배너 4"
					style="width: 100%;">
			</div>
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
		<div class="mdpick" style="margin-top: 150px;">
			<span style="font-size: 32px;">MD PICK</span> <img alt="" src="./image/staticImage/Vector.png">

			<div class="swiper mySwiper">
				<section
					class="xans-element- xans-product xans-product-listmain-6 xans-product-listmain xans-product-6 md_pick main_sec">
					<!--
        $count = 9
        $moreview = yes
        -->
					<div class="list_header">
						<div class="info">
							<br>
							<!-- <p class="desc">서브타이틀</p> -->
						</div>
					</div>
					<div class="listmain_contain">
						<div
							class="listmain_cont pick-swiper swiper-initialized swiper-horizontal swiper-backface-hidden">
							<ul class="list swiper-wrapper"
								id="swiper-wrapper-984f101776f2693cc" aria-live="polite">
								<li class="items swiper-slide xans-record- swiper-slide-active"
									role="group" aria-label="1 / 5"
									style="width: 481.333px; margin-right: 41px;">
									<div class="thumbnail">
										<a href="index.jsp?main=product/detailpage.jsp?pro_num=436">
											<picture>
											<img src="https://linetaste.com/web/product/small/202310/9929ace48353fe4c3a80da830200e7fa.jpeg" alt=""></picture>
										</a>
									</div>
									<div class="infomation">
										<div class="info">
											<h4 class="title">TeTaTeT Flute</h3>
											<p class="summary_desc">램프 헤드는 가볍고 공중에 떠 있는 것처럼 보이며 테이블에 마법 같은 조명 효과를 줍니다. 휴대에도 용이한 이 조명은 테이블 주변 뿐만 아니라 모든 장소에서 독특한 분위기를 연출합니다.</p>

										</div>
									</div>
								</li>
								<li class="items swiper-slide xans-record- swiper-slide-next"
									role="group" aria-label="2 / 5"
									style="width: 481.333px; margin-right: 41px;">
									<div class="thumbnail">
										<a href="index.jsp?main=product/detailpage.jsp?pro_num=291"> <picture>
											<img src="https://chapterone.kr/web/product/big/202208/6282ae7765987e2b26e5cc0440f5b154.jpg" alt=""></picture></a>
									</div>
									<div class="infomation">
										<div class="info">
											<h4 class="title">TRIPODE G5 램프</h3>
											<p class="summary_desc">
												Santa & Cole은 스페인에 본사를 둔 소규모의 독립형 글로벌 디자인 제품 에디트 브랜드입니다. 책 편집자가 이야기를 다루는 것처럼, Santa & Cole은 사물을 다룹니다.</p>
										</div>
									</div>
								</li>
								<li class="items swiper-slide xans-record-" role="group"
									aria-label="3 / 5"
									style="width: 481.333px; margin-right: 41px;">
									<div class="thumbnail">
										<a href="index.jsp?main=product/detailpage.jsp?pro_num=428"> <picture>
											<img src="https://chapterone.kr/web/product/big/202105/bb67da846f2800901558a92161cff185.jpg" alt=""></picture></a>
									</div>
									<div class="infomation">
										<div class="info">
											<h4 class="title">서큘러 라운지 3인 소파</h3>
											<p class="summary_desc">
												브랜드명인 Kar는 환생을 의미하는 산스크리트어 '카르마'에 그 뿌리를 두고 있습니다.
												동양 철학을 기반으로 가구와 패션디자인을 아우르는 에스테틱 브랜드입니다.</p>

										</div>
									</div>
								</li>
								<li class="items swiper-slide xans-record-" role="group"
									aria-label="4 / 5"
									style="width: 481.333px; margin-right: 41px;">
									<div class="thumbnail">
										<a href="index.jsp?main=product/detailpage.jsp?pro_num=217"> <picture>
											<img src="https://chapterone.kr/web/product/big/202205/38f75e4a474c665bf14a77de011a2e6b.png" alt=""></picture></a>
									</div>
									<div class="infomation">
										<div class="info">
											<h4 class="title">스토리지 SR01DWA</h3>
											<p class="summary_desc">몬스트럭쳐는 사용자 중심의 모듈 선반 시스템 브랜드입니다. 다양성은 우리의 창의력을 끝없이 이끌어 낼 수 있습니다.</p>

										</div>
									</div>
								</li>
								<li class="items swiper-slide xans-record-" role="group"
									aria-label="5 / 5"
									style="width: 481.333px; margin-right: 41px;">
									<div class="thumbnail">
										<a href="index.jsp?main=product/detailpage.jsp?pro_num=245"> <picture>
											<img src="https://chapterone.kr/web/product/big/202403/d25950984397edb368d7ee6ff99e8767.jpg" alt=""></picture></a>
									</div>
									<div class="infomation">
										<div class="info">
											<h4 class="title">스노우맨22 V2 테이블 스탠드</h3>
											<p class="summary_desc">일광전구는 1962년 창립 이래 
											반세기 동안 축적된 기술과 풍부한 경험을 바탕으로 국내 조명시장을 수성하는 토종 기업입니다.</p>

										</div>
									</div>
								</li>
							</ul>
							<span class="swiper-notification" aria-live="assertive"
								aria-atomic="true"></span>
						</div>
						<div class="swiper_next md_pick_next" tabindex="0" role="button"
							aria-label="Next slide"
							aria-controls="swiper-wrapper-984f101776f2693cc"
							aria-disabled="false">
							<img src="https://chapterone.kr/web/img/svg/next_btn.svg"
								alt="다음">
						</div>
						<div class="swiper_prev md_pick_prev swiper-button-disabled"
							tabindex="-1" role="button" aria-label="Previous slide"
							aria-controls="swiper-wrapper-984f101776f2693cc"
							aria-disabled="true">
							<img src="	https://chapterone.kr/web/img/svg/prev_btn.svg"
								alt="이전">
						</div>
			<script>
                (()=>{
                    const timeSwiper = new Swiper(".pick-swiper",{
                        spaceBetween: 16,
                        slidesPerView: 1.4,
                        navigation : {
                            nextEl : '.md_pick_next',
                            prevEl : '.md_pick_prev',
                        },
                        breakpoints: {
                            // when window width is >= 320px
                            767: {
                                spaceBetween: 30,
                                slidesPerView: 2,
                            },
                            1024: {
                                spaceBetween: 41,
                                slidesPerView: 3,
                            },
                        },
                    });
                })();
            </script>
					</div>
				</section>
			</div>
		</div>

		<!-- new -->
		<div class="new" style="margin-top: 180px;">
			<span style="font-size: 32px;">NEW</span> <img alt="" src="./image/staticImage/Vector.png">

			<div>
				<table>
					<tr>
						<%
						int nline = 0;

						for (int i = 0; i < 4; i++) {
							ProductDto pdto = nlist.get(i);
						%>
						<td width="330px" align="center" style="padding: 20px 10px 50px;">
							<a pronum="<%=pdto.getPro_num()%>" class="goDetail"> <img
								src="<%=pdto.getPro_main_img()%>" style="padding-bottom: 8px;">
								<span><%=pdto.getPro_name()%></span> <br> <span><%=nf.format(pdto.getPro_price())%></span>
						</a>
						</td>
						<%
						if ((nline + 1) % 4 == 0) {
						%>
					</tr>
					<tr>
						<%
						}
						%>
						<%
						}
						%>
					</tr>
					<tr>
						<td colspan="4" align="center"><a id="newMore"
							href="index.jsp?main=product/newProductList.jsp"><img alt=""
								src="./image/staticImage/more_bs.png"></a></td>
					</tr>
				</table>

			</div>

		</div>

		<!-- category -->
		<div class="category" style="margin-top: 170px;">
			<table class="table-bordered" style="width: 1200px;">
				<tr>
					<td><a
						href="index.jsp?main=product/productList.jsp?cate_num=11"><img
							src="./image/staticImage/cate_sofa.png"></a></td>
					<td><a
						href="index.jsp?main=product/productList.jsp?cate_num=12"><img
							src="./image/staticImage/cate_table.png"></a></td>
				</tr>

				<tr>
					<td><a
						href="index.jsp?main=product/productList.jsp?cate_num=22"><img
							src="./image/staticImage/cate_chair.png"></a></td>
					<td><a
						href="index.jsp?main=product/productList.jsp?cate_num=4"><img
							src="./image/staticImage/cate_lamp.png"></a></td>
				</tr>

				<tr>
					<td colspan="2" align="center" style="height: 300px;"><a
						href="index.jsp?main=product/productList.jsp?cate_num=5"><img
							src="./image/staticImage/cate_etc.png"></a></td>
				</tr>

			</table>
		</div>

		<!-- review -->
		<div class="review" style="margin-top: 180px;">
			<span style="font-size: 32px;">REVIEW</span> <img alt=""
				src="./image/staticImage/Vector.png">
			<div>
				<table>
					<%
					int rline = 0;

					// 반복문을 사용하여 이미지 출력
					for (int i = 0; i < 8; i++) {
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
								<!-- <img src="./image/reviewSave/etcB.jpg" style="padding-bottom: 8px;"> -->
								<img src="<%=rdto.getReview_image() %>" style="padding-bottom: 8px; height: 280px; width: 280px;">
						</a>
						</td>
						<!-- 각 행의 끝 -->
						<%
						if ((rline + 1) % 4 == 0) {
						%>
					</tr>
					<%
					}
					%>

					<%
					rline++;
					%>
					<%
					}
					%>

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
					<%
					}
					%>
					</tr>
					<%
					}
					%>

					<tr>
						<td colspan="4" align="center"><a id="newMore" href="index.jsp?main=review/reviewList.jsp">
							<img alt="" src="./image/staticImage/more_bs.png" style="margin-top: 50px;"></a>
						</td>
					</tr>
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
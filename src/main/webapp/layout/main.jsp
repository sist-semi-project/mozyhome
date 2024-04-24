<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<title>메인페이지</title>

<style type="text/css">

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
    height: 249px;
    flex-flow: column;
}

.md_pick .listmain_cont .list .infomation .info .title {
    font-family: Montserrat;
    font-size: 30px;
    font-weight: 700;
    color: #141414;
    text-overflow: ellipsis;
    white-space: nowrap;
    overflow: hidden;
}

.md_pick .listmain_cont .list .infomation {
    background-color: #fff;
    padding: 40px;
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

.swiper_prev.swiper-button-disabled, .swiper_next.swiper-button-disabled {
    display: none;
}

h1, h3 {
    margin: 0;
}
	
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
	

.items {
    border: 2px solid black; /* Creates a black border around the element */
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
    <div class="swiper-scrollbar"></div>.
    .
     
</div>

<div style="width: 1500px; margin: 0 auto;" align="center;">
	<div class="mdpick" style="margin-top: 100px;">
		<span style="font-size: 32px;">MD PICK</span>
		<img alt="" src="./image/staticImage/Vector.png">

			<div class="swiper mySwiper">
				<section class="xans-element- xans-product xans-product-listmain-6 xans-product-listmain xans-product-6 md_pick main_sec"><!--
        $count = 9
        $moreview = yes
        --><div class="list_header">
            <div class="info">
               <br>
                <!-- <p class="desc">서브타이틀</p> -->
            </div>
        </div>
<div class="listmain_contain">
            <div class="listmain_cont pick-swiper swiper-initialized swiper-horizontal swiper-backface-hidden">
                <ul class="list swiper-wrapper" id="swiper-wrapper-984f101776f2693cc" aria-live="polite">
<li class="items swiper-slide xans-record- swiper-slide-active" role="group" aria-label="1 / 9" style="width: 481.333px; margin-right: 41px;">
    <div class="thumbnail">
        <a href="index.jsp?main=product/detailpage.jsp?pro_num=331">
            <picture><img src="//chapterone.kr/web/product/big/202404/3dd92c49d77959c3b96bd63dd6dc9210.png" alt=""></picture></a>
    </div>
    <div class="infomation">
        <div class="info">
            <h3 class="title">[킨토 테이블웨어, 30%] 캐스트 엠버 저그 (2 SIZE)</h3>
            <p class="summary_desc">킨토 테이블웨어는 시간이 흐를수록 변치않은 세련된과 친숙함으로 오래도록 사용하기 좋습니다. 프로모션 기간동안 30% 혜택으로 만나보세요.</p>
            
        </div>
    </div>
</li>
                    <li class="items swiper-slide xans-record- swiper-slide-next" role="group" aria-label="2 / 9" style="width: 481.333px; margin-right: 41px;">
    <div class="thumbnail">
        <a href="#">
            <picture><img src="//chapterone.kr/web/product/big/202404/4bb9a15373bafb274e11e9461cb1cd44.png" alt=""></picture></a>
    </div>
    <div class="infomation">
        <div class="info">
            <h3 class="title">[킨토 테이블웨어, 30%] 캐스트 엠버 글래스 (4 SIZE)</h3>
            <p class="summary_desc">골동품 같은 따뜻함을 느낄 수 있는 CAST AMBER series 입니다. 부담없이 사용하고 컵을 쌓아서 컴팩트하게 수납할 수 있습니다.</p>
            
        </div>
    </div>
</li>
<li class="items swiper-slide xans-record-" role="group" aria-label="3 / 9" style="width: 481.333px; margin-right: 41px;">
    <div class="thumbnail">
        <a href="#">
            <picture><img src="//chapterone.kr/web/product/big/202404/954d95be220417c280d8bad9bd957813.png" alt=""></picture></a>
    </div>
    <div class="infomation">
        <div class="info">
            <h3 class="title">[킨토 테이블웨어, 30%] 캐스트 티컵 &amp; 소서 SET</h3>
            <p class="summary_desc">단순하고 질서있는 아름다움을 가진 CAST. 손가락의 위치, 컵 본체에 미치는 중력, 들어올리려는 손의 힘, 이 3가지 요소의 섬세한 밸런스를 고려해 디자인 되었습니다.</p>
            
        </div>
    </div>
</li>
<li class="items swiper-slide xans-record-" role="group" aria-label="4 / 9" style="width: 481.333px; margin-right: 41px;">
    <div class="thumbnail">
        <a href="#">
            <picture><img src="//chapterone.kr/web/product/big/202404/b423b7de2c760c8192cb7f265e687b64.png" alt=""></picture></a>
    </div>
    <div class="infomation">
        <div class="info">
            <h3 class="title">[킨토 테이블웨어, 30%] 히비 젓가락 - 아이언우드 (2 SIZE)</h3>
            <p class="summary_desc"></p>
           
        </div>
    </div>
</li>
<li class="items swiper-slide xans-record-" role="group" aria-label="5 / 9" style="width: 481.333px; margin-right: 41px;">
    <div class="thumbnail">
        <a href="#">
            <picture><img src="//chapterone.kr/web/product/big/202401/daf9a8e88fc60bf844f7692686e1731b.png" alt=""></picture></a>
    </div>
    <div class="infomation">
        <div class="info">
            <h3 class="title">가니메드 와인쿨러 실버 S</h3>
            <p class="summary_desc">묵직한 황동의 손잡이와 은색 바디의 대비가 고급스럽죠. 표면의 망치 텍스쳐가 유니크함을 더해줍니다. 와인쿨러, 과일 혹은 꽃 바구니로도 활용 가능하니 어느곳에 두어도 멋진 오브제가 될거에요.</p>
           
        </div>
    </div>
</li>
<li class="items swiper-slide xans-record-" role="group" aria-label="6 / 9" style="width: 481.333px; margin-right: 41px;">
    <div class="thumbnail">
        <a href="#">
            <picture><img src="//chapterone.kr/web/product/big/202309/60d5f690f8059ad9e46010393d914b7e.png" alt=""></picture></a>
    </div>
    <div class="infomation">
        <div class="info">
            <h3 class="title">얼음 집게</h3>
            <p class="summary_desc">윤여동작가의 얼음 집게. 미끄러운 얼음을 보다 효율적으로 집기 위한 집게입니다. 와인쿨러, 파올라씨 고블렛잔과 함께 사용하기를 추천드려요.</p>
            
        </div>
    </div>
</li>
<li class="items swiper-slide xans-record-" role="group" aria-label="7 / 9" style="width: 481.333px; margin-right: 41px;">
    <div class="thumbnail">
        <a href="#">
            <picture><img src="//chapterone.kr/web/product/big/202402/4771b4dd34c12e47dae9cb097db0ff02.png" alt=""></picture></a>
    </div>
    <div class="infomation">
        <div class="info">
            <h3 class="title">[THE GIFT IDEA, 10%] 튤립 고블렛</h3>
            <p class="summary_desc">용도와 관계없이 무엇을 담아내어 놓든 그 공간의 감도가 올라가는 감각적인 디자인의 잔이에요. 누구에게 선물해도 기분 좋게 주고 받을 수 있는 선물은 술잔이 가장 좋은 것 같아요.</p>
           
        </div>
    </div>
</li>
<li class="items swiper-slide xans-record-" role="group" aria-label="8 / 9" style="width: 481.333px; margin-right: 41px;">
    <div class="thumbnail">
        <a href="#">
            <picture><img src="//chapterone.kr/web/product/big/202401/9b9d8d97a1b45b0209b5c87d9e776cfd.png" alt=""></picture></a>
    </div>
    <div class="infomation">
        <div class="info">
            <h3 class="title">[THE GIFT IDEA, 5%] 방울 작은 잔 #1</h3>
            <p class="summary_desc">다양한 물성을 다루는 작가들과의 협업으로 만들어진 작은 잔 기획전. 우리가 함께하는 첫 잔의 한 모금, 한 순간의 의미가 아름답게 기억되기를 바랍니다.</p>
        </div>
    </div>
</li>
<li class="items swiper-slide xans-record-" role="group" aria-label="9 / 9" style="width: 481.333px; margin-right: 41px;">
    <div class="thumbnail">
        <a href="#">
            <picture><img src="//chapterone.kr/web/product/big/202401/1aa2c27137052e4486c85a3d0a544534.png" alt=""></picture></a>
    </div>
    <div class="infomation">
        <div class="info">
            <h3 class="title">[THE GIFT IDEA] 한지 작은 잔</h3>
            <p class="summary_desc">얇게 빚으면 휘는 흙의 특징을 이용해서 한지가 가지고 있는 아름답고 고급스러운 질감을 도자기로 재현해냈습니다. 박성극 작가의 아름다운 한지 시리즈, 작은 잔으로 준비해보세요.</p>
        </div>
    </div>
</li>
                </ul>
<span class="swiper-notification" aria-live="assertive" aria-atomic="true"></span></div>
            <div class="swiper_next md_pick_next" tabindex="0" role="button" aria-label="Next slide" aria-controls="swiper-wrapper-984f101776f2693cc" aria-disabled="false"><img src="https://chapterone.kr/web/img/svg/next_btn.svg" alt="다음"></div>
            <div class="swiper_prev md_pick_prev swiper-button-disabled" tabindex="-1" role="button" aria-label="Previous slide" aria-controls="swiper-wrapper-984f101776f2693cc" aria-disabled="true"><img src="	https://chapterone.kr/web/img/svg/prev_btn.svg" alt="이전"></div>        
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dropdown Menu</title>
<link rel="stylesheet" href="./header/header.css" />

<style type="text/css">
	
/* 검색 토글창 디자인 시작 */
	body {
		font-family: 'Noto Sans KR';
		text-decoration: none;
		font-size: 14px;
	}
	#shopify-section-header > header > div > ul > li > a, 
	#shopify-section-header > header > div > ul > li > a,
	#shopify-section-header > header > div > ul > li > div > div > div.header-nav__sub-nav-links > div > a,
	#shopify-section-header > header > div > ul > li > div > div > div.header-nav__sub-nav-images > a{
		text-decoration: none;	
		color: black;
	}	
	
	#search {
	    width: 100%;
	    height: 20rem;
	    position: absolute;
	    display: none;
	    background:rgb(249, 248, 246);
	    z-index: 1000;
	    justify-content: center; /* 수평 가운데 정렬 */
	    align-items: center; /* 수직 가운데 정렬 */
	    display: flex; /* 부모 요소를 플렉스 박스로 설정합니다. */    
	}

	#search input {
	    width: 30%;
	    height: 30px;
	    font-size: 15px;
	    border: none;
	    outline: none;
	    background:rgba(249, 248, 246, 0);
	    border-bottom: 1px black solid;
	    margin-bottom: 10px;
	    flex-direction: column;
	    text-indent: 3px;
	}
	
	#enter {
	    font-size: 18px;
	    border: none;   
	    width: 50px;
	    height: 30px;
	    border-radius: 15px;
	    background:rgba(249, 248, 246, 0);
	    color: black;
	    cursor: pointer;
	    margin-bottom: 10px;
	}

	#close {
	    position: absolute;
	    top: 0;
	    right: 0;
	    margin: 10px;
	    color: black;
	}
/* 검색 토글창 디자인 끝 */
</style>

<script type="text/javascript">
	// 검색 기능
	$(function() {
		$("#search").hide();
		
		$("#searchIcon").click(function() {
			var keyword = $("#keyword").val();
			//alert(keyword);
			if(keyword==""){
				alert("검색어를 입력해주세요");
			} else{
				location.href="index.jsp?main=search/searchList.jsp?search="+keyword;
			}
		});

		document.getElementById('keyword').addEventListener('keypress',function(event) {
			// 엔터 키가 눌렸는지 확인
			if (event.keyCode === 13) {
				event.preventDefault(); // 폼 제출을 방지
				document.getElementById('searchIcon').click(); // '사이즈 추가' 버튼 클릭 이벤트 발생
			}
		});	
		
		$("#close").click(function(){
			//alert("click");
			$("#search").hide();
		})
		
	});
	
	function openSetting(){
	    /* if(document.getElementById('search').style.display==='block'){
	        document.getElementById('search').style.display='none';
	    }else{
	        document.getElementById('search').style.display='block';
	    } */
	    
	    $("#search").slideToggle(225);
	}
	// 검색 기능 끝

</script>
</head>
<body>
	<div id="shopify-section-header" class="shopify-section">
		<header class="header js-header" role="banner" style="width: 100%;">
			<div class="header__top">

				<ul class="header__nav"
					style="padding-right: 40px; padding-left: 0px;">

					<li
						class="header__nav-top-level header__nav-top-level--has-children">
						<a href="index.jsp?main=product/productList.jsp?cate_num=1"
						class="header__nav-top-level-link" data-name="Living">Living</a>
						<div class="header-nav__sub-nav">
							<div class="header-nav__sub-nav-inner">
								<div class="header-nav__sub-nav-links">
									<div class="header-nav__column"></div>
									<div class="header-nav__column">

										<a class="header-nav__sub-nav-link" 
										href="index.jsp?main=product/productList.jsp?cate_num=11">소파</a>

										<a class="header-nav__sub-nav-link"
											href="index.jsp?main=product/productList.jsp?cate_num=12">테이블</a>

									</div>

								</div>
								<div class="header-nav__sub-nav-images">
									<a href="index.jsp?main=product/productList.jsp?cate_num=1"> <img
										src="//maidenhome.com/cdn/shop/files/01_Shop_All_Living_Top_Nav.jpg?v=1710959897&amp;width=330"
										alt=""
										srcset="//maidenhome.com/cdn/shop/files/01_Shop_All_Living_Top_Nav.jpg?v=1710959897&amp;width=330 330w"
										width="330" height="248">
										<p>Shop All Living</p>
									</a><a
										href="index.jsp?main=product/productList.jsp?cate_num=12">
										<img
										src="//maidenhome.com/cdn/shop/files/02_The_Ella_Table_Top_Nav.jpg?v=1710959897&amp;width=330"
										alt=""
										srcset="//maidenhome.com/cdn/shop/files/02_The_Ella_Table_Top_Nav.jpg?v=1710959897&amp;width=330 330w"
										width="330" height="248">
										<p>The Ella Coffee Table</p>
									</a>
								</div>
							</div>
						</div>
					</li>


					<li
						class="header__nav-top-level header__nav-top-level--has-children">
						<a href="index.jsp?main=product/productList.jsp?cate_num=2"
						class="header__nav-top-level-link" data-name="Dining">Dining</a>
						<div class="header-nav__sub-nav">
							<div class="header-nav__sub-nav-inner">
								<div class="header-nav__sub-nav-links">
									<div class="header-nav__column">
										<a class="header-nav__sub-nav-link"
											href="index.jsp?main=product/productList.jsp?cate_num=21">식탁</a> <a
											class="header-nav__sub-nav-link"
											href="index.jsp?main=product/productList.jsp?cate_num=22">의자</a>
									</div>
								</div>
								<div class="header-nav__sub-nav-images">
									<a href="index.jsp?main=product/productList.jsp?cate_num=2"> <img
										src="//maidenhome.com/cdn/shop/files/03_Shop_All_Dining_Top_Nav.jpg?v=1710959896&amp;width=330"
										alt=""
										srcset="//maidenhome.com/cdn/shop/files/03_Shop_All_Dining_Top_Nav.jpg?v=1710959896&amp;width=330 330w"
										width="330" height="248">
										<p>Shop All Dining</p>
									</a><a
										href="index.jsp?main=product/productList.jsp?cate_num=22">
										<img
										src="//maidenhome.com/cdn/shop/files/04_The_Garrett_Chair_Top_Nav.jpg?v=1710959896&amp;width=330"
										alt=""
										srcset="//maidenhome.com/cdn/shop/files/04_The_Garrett_Chair_Top_Nav.jpg?v=1710959896&amp;width=330 330w"
										width="330" height="248">
										<p>The Garrett Dining Chair</p>
									</a>
								</div>
							</div>
						</div>
					</li>




					<li
						class="header__nav-top-level header__nav-top-level--has-children">
						<a href="index.jsp?main=product/productList.jsp?cate_num=3"
						class="header__nav-top-level-link" data-name="Bedroom">Bedroom</a>
						<div class="header-nav__sub-nav">
							<div class="header-nav__sub-nav-inner">
								<div class="header-nav__sub-nav-links">
									<div class="header-nav__column">
										<a class="header-nav__sub-nav-link"
											href="index.jsp?main=product/productList.jsp?cate_num=31">침대</a> <a
											class="header-nav__sub-nav-link"
											href="index.jsp?main=product/productList.jsp?cate_num=32">수납</a>
									</div>
								</div>
								<div class="header-nav__sub-nav-images">
									<a href="index.jsp?main=product/productList.jsp?cate_num=3"> <img
										src="//maidenhome.com/cdn/shop/files/05_Shop_All_Bedroom_Top_Nav.jpg?v=1710959896&amp;width=330"
										alt=""
										srcset="//maidenhome.com/cdn/shop/files/05_Shop_All_Bedroom_Top_Nav.jpg?v=1710959896&amp;width=330 330w"
										width="330" height="248">
										<p>Shop All Bedroom</p>
									</a><a
										href="index.jsp?main=product/productList.jsp?cate_num=32">
										<img
										src="//maidenhome.com/cdn/shop/files/06_The_Marais_Dresser_Top_Nav.jpg?v=1710959896&amp;width=330"
										alt=""
										srcset="//maidenhome.com/cdn/shop/files/06_The_Marais_Dresser_Top_Nav.jpg?v=1710959896&amp;width=330 330w"
										width="330" height="248">
										<p>The Marais 6-Drawer Dresser</p>
									</a>
								</div>
							</div>
						</div>
					</li>

					<li
						class="header__nav-top-level header__nav-top-level--has-children">
						<a href="index.jsp?main=product/productList.jsp?cate_num=4"
						class="header__nav-top-level-link" data-name="Lamp">Lamp</a>
						<div class="header-nav__sub-nav">
							<div class="header-nav__sub-nav-inner">
								<div class="header-nav__sub-nav-links">
									<div class="header-nav__column">
										<a class="header-nav__sub-nav-link"
											href="index.jsp?main=product/productList.jsp?cate_num=42">장스탠드</a>
										<a class="header-nav__sub-nav-link"
											href="index.jsp?main=product/productList.jsp?cate_num=41">단스탠드</a>
									</div>
								</div>
								<div class="header-nav__sub-nav-images">
									<a
										href="index.jsp?main=product/productList.jsp?cate_num=4">
										<img
										src="//maidenhome.com/cdn/shop/files/07_Collections_Top_Nav_1.jpg?v=1711376362&amp;width=330"
										alt=""
										srcset="//maidenhome.com/cdn/shop/files/07_Collections_Top_Nav_1.jpg?v=1711376362&amp;width=330 330w"
										width="330" height="248">
										<p>Spring/Summer 2024</p>
									</a>
								</div>
							</div>
						</div>
					</li>




					<li
						class="header__nav-top-level header__nav-top-level--has-children">
						<a href="index.jsp?main=product/productList.jsp?cate_num=5"
						class="header__nav-top-level-link" data-name="ETC">ETC</a>
						<div class="header-nav__sub-nav">
							<div class="header-nav__sub-nav-inner">
								<div class="header-nav__sub-nav-links">
									<div class="header-nav__column">
										<a class="header-nav__sub-nav-link"
											href="index.jsp?main=product/productList.jsp?cate_num=51">ETC</a>

									</div>
								</div>
								<div class="header-nav__sub-nav-images">
									<a href="index.jsp?main=product/productList.jsp?cate_num=5"> <img
										src="//maidenhome.com/cdn/shop/files/08_Swatches_Top_Nav.jpg?v=1710959897&amp;width=330"
										alt=""
										srcset="//maidenhome.com/cdn/shop/files/08_Swatches_Top_Nav.jpg?v=1710959897&amp;width=330 330w"
										width="330" height="248">
										<p></p>
									</a>
								</div>
							</div>
						</div>
					</li>
				</ul>



				<div class="header__logo">
					<h1 class="site-header__logo" itemscope=""
						itemtype="http://schema.org/Organization">
						<a href="index.jsp" itemprop="url" class="site-header__logo-link"> <img
							width="216" height="36" class="text-logo"
							src="./image/staticImage/logo.png" alt="Maiden Home"
							itemprop="logo">
						</a>
					</h1>
				</div>



				<ul class="header__nav">
					<li
						class="header__nav-top-level header__nav-top-level--has-children">
						<a onclick="openSetting()"
						class="header__nav-top-level-link" data-name=" "> <img
						src="./image/staticImage/searchicon_bs.png"></a>
					</li>

					<li
						class="header__nav-top-level header__nav-top-level--has-children">
						<a href="index.jsp?main=SemiLogin/Login.jsp"
						class="header__nav-top-level-link" data-name="Login">Login</a>
					</li>




					<li
						class="header__nav-top-level header__nav-top-level--has-children">
						<a href="index.jsp?main=wishlist/wishlist.jsp"
						class="header__nav-top-level-link" data-name=""> <img
						src="./image/staticImage/hearticon_bs.png"></a>
					</li>




					<li
						class="header__nav-top-level header__nav-top-level--has-children">
						<a href="index.jsp?main=cart/mycart.jsp"
						class="header__nav-top-level-link" data-name=""> <img
						src="./image/staticImage/shoppingbag_bs.png"></a>
					</li>




					<li
						class="header__nav-top-level header__nav-top-level--has-children">
						<a href="index.jsp?main=member/mypage.jsp"
						class="header__nav-top-level-link" data-name="MyPage">MyPage</a>
					</li>
				</ul>



			</div>


		</header>
	</div>
	
	<div id="search">
        <input type="text" id="keyword" placeholder="SEARCH">
        <button type="button" id="enter">
        	<img alt="" src="./image/staticImage/serachicon_bs.png" id="searchIcon" width="22px">
        </button>
        
        <span id="close"><i class="bi bi-x-lg"></i></span>
    </div>
    
	<script src="./header/header.js"></script>


</body>
</html>
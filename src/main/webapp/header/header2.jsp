<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<html lang="en"><head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Dropdown Menu</title>
<link rel="stylesheet" >
<style type="text/css">

		/* main style */
/* main style */
.article, .aside, .details, .figcaption, .figure, .footer, .header, .hgroup, .main, .nav, .section, .summary {
    display: block;
}

.site-header__logo a, .site-header__logo img {
    display: block;
    margin: 0 auto;
    width: 216px;
    height: 16px;
}

h1 a, .h1 a, h2 a, .h2 a, h3 a, .h3 a, h4 a, .h4 a, h5 a, .h5 a, h6 a, .h6 a {
    text-decoration: none;
    font-weight: inherit;
}

.body, .input, .textarea, .button, .select {
    font-size: 14px;
    line-height: 1.6;
    color: #333;
    font-weight: 300;
    -webkit-font-smoothing: antialiased;
    -webkit-text-size-adjust: 100%;
}

.site-header__logo a, .site-header__logo a:hover, .site-header__logo a:focus {
    text-decoration: none;
}

a:active, a:hover {
    outline: 0;
}

.header {
    border-color: #947044;
    background-color: #fff;
    border-top: 3px solid;
}

.header__top {
    display: -webkit-box;
    display: -webkit-flex;
    display: flex;
    -webkit-box-align: center;
    webkit-align-items: center;
    align-items: center;
    -webkit-box-pack: justify;
    -webkit-justify-content: space-between;
    justify-content: space-between;
    padding: 20px;
}

.header__cart {
    text-align: right;
}

*, *:after, *:before {
    box-sizing: inherit;
}

img {
    border: 0;
    max-width: 100%;
}

*, input, :before, :after {
    box-sizing: border-box;
}

a:hover, a:focus {
    color: #b89365;
}

a:active, a:hover {
    outline: 0;
}

.header {
    border-color: #947044;
    background-color: #fff;
    border-top: 3px solid;
}

.header__top {
    display: -webkit-box;
    display: -webkit-flex;
    display: flex;
    -webkit-box-align: center;
    -webkit-align-items: center;
    align-items: center;
    -webkit-box-pack: justify;
    -webkit-justify-content: space-between;
    justify-content: space-between;
    padding: 20px;
}

.header__cart {
    text-align: right;
}

.site-header__logo-link {
    margin: 0 auto;
}

#shopify-section-header {
    position: -webkit-sticky;
    position: sticky;
    top: 0;
    z-index: 6;
    font-family: Graphik Web;
}

/* main media */
@media (min-width: 500px) {
    .header {
        padding: 32px 62px 0;
        overflow: hidden;
    }

    .header__top {
        padding: 0;
    }

    .header__cart,
    .header__hamburger,
    .header__logo {
        -webkit-flex-basis: 33.3333%;
        flex-basis: 33.3333%;
    }

    .header__cart,
    .header__hamburger {
        -webkit-flex-basis: 20px;
        flex-basis: 20px;
    }

    .header__hamburger {
        visibility: hidden;
    }

    .header__nav {
        display: flex;
        -webkit-box-orient: horizontal;
        -webkit-box-direction: normal;
        flex-direction: row;
        margin-top: 32px;
        border-top: 0;
        -webkit-box-pack: center;
        justify-content: center;
        min-height: auto;
    }

    .header__nav-top-level {
        padding: 0 30px 24px;
        border-bottom: 0;
        position: static;
        cursor: pointer;
    }

    .header__nav-top-level-link {
        margin: 0;
        color: #4a4a4a;
    }

    .header-nav__sub-nav {
        display: -webkit-box;
        display: -webkit-flex;
        display: flex;
        position: absolute;
        left: 0;
        top: 100%;
        width: 100%;
        padding: 42px 32px;
        background-color: hsla(40, 23%, 97%, .98);
        -webkit-box-pack: center;
        -webkit-justify-content: center;
        -ms-flex-pack: center;
        justify-content: center;
        webkit-transform: scaleY(0);
        transform: scaleY(0);
        opacity: 0;
        pointer-events: none;
    }

    .header-nav__sub-nav-inner {
        min-width: 640px;
        gap: 80px;
        padding: 0;
        width: auto;
        -webkit-box-pack: center;
        -webkit-justify-content: center;
        justify-content: center;
    }

    .header-nav__sub-nav-links {
        grid-gap: 0 40px;
        width: auto;
        -webkit-box-orient: horizontal;
        -webkit-box-direction: normal;
        -webkit-flex-direction: row;
        flex-direction: row;
    }

    .header-nav__sub-nav-images {
        display: -webkit-box;
        display: -webkit-flex;
        display: flex;
        grid-gap: 70px;
    }

    .header-nav__sub-nav-images>a:hover p {
        font-weight: 500;
    }

    p {
        margin: 0 0 21.5px;
    }

    .header-nav__sub-nav-images p {
        margin: 14px 0 0;
        text-transform: uppercase;
        color: #333;
        font-size: 11px;
        letter-spacing: 1.65px;
        text-align: center;
    }

    .header__top {
        padding: 0;
    }
}




}
			/*main  open */

.header__nav--open {
    display: -webkit-box;
    display: -webkit-flex;
    display: flex;
}

.header__nav-top-level-link:focus, .header__nav-top-level-link:hover {
    color: #333;
    -webkit-tap-highlight-color: transparent;
}

.header__nav-top-level--open .header__nav-top-level-link:after {
    background-color: #947044;
}



		/* media open */
@media (min-width: 1160px){
.header__nav {
    display: -webkit-box;
    display: -webkit-flex;
    display: flex;
    -webkit-box-orient: horizontal;
    -webkit-box-direction: normal;
    -webkit-flex-direction: row;
    flex-direction: row;
    margin-top: 32px;
    border-top: 0;
    -webkit-box-pack: center;
    -webkit-justify-content: center;
    justify-content: center;
    min-height: auto;
}

.header__nav--open .header-nav__sub-nav {
    -webkit-transform-origin: top;
    transform-origin: top;
    -webkit-transform: scaleY(1);
    transform: scaleY(1);
    -webkit-transition: -webkit-transform .3s;
    transition: -webkit-transform .3s;
    transition: transform .3s;
    transition: transform .3s, -webkit-transform .3s;
}

.header-nav__sub-nav {
    display: -webkit-box;
    display: -webkit-flex;
    display: flex;
    position: absolute;
    left: 0;
    top: 100%;
    width: 100%;
    padding: 42px 32px;
    background-color: hsla(40, 23%, 97%, .98);
    -webkit-justify-content: center;
    justify-content: center;
    -webkit-transform: scaleY(0);
    transform: scaleY(0);
    opacity: 0;
    pointer-events: none;
}

.header__nav-top-level--open .header__nav-top-level-link {
    color: transparent;
}

.header__nav-top-level--open .header__nav-top-level-link:before {
    content: attr(data-name);
    position: absolute;
    left: 0;
    top: 0;
    font-weight: 500;
    color: #4a4a4a;
    white-space: nowrap;
}

.header__nav-top-level--open .header__nav-top-level-link:after {
    content: "";
    position: absolute;
    width: 100%;
    height: 2px;
    bottom: -24px;
    left: 0;
}

.header__nav--open .header-nav__sub-nav {
    -webkit-transform-origin: top;
    transform-origin: top;
    -webkit-transform: scaleY(1);
    transform: scaleY(1);
    -webkit-transition: -webkit-transform .3s;
    transition: -webkit-transform .3s;
    transition: transform .3s;
    transition: transform .3s, -webkit-transform .3s;
}

.header__nav-top-level--open .header-nav__sub-nav {
    opacity: 1;
    -webkit-transition: opacity .2s;
    transition: opacity .2s;
    pointer-events: all;
}

.header__nav-top-level--open .header-nav__sub-nav {
    display: -webkit-box;
    display: -webkit-flex;
    display: flex;
}

.header-nav__sub-nav-links p {
    font-size: 10px;
}

}

</style>
</head>
<body>
<div id="shopify-section-header" class="shopify-section">
	<header class="header js-header" role="banner">
		<div class="header__top">
				
				
					<!-- -----------------------상품 페이지들-------------------------- -->
				<ul class="header__nav">
			<li class="header__nav-top-level header__nav-top-level--has-children">
				<a href="#" class="header__nav-top-level-link" data-name="Living">Living</a>
			<div class="header-nav__sub-nav">
					<div class="header-nav__sub-nav-inner">
						<div class="header-nav__sub-nav-links">
							<div class="header-nav__column"></div>
							<div class="header-nav__column">
							
								<p>Living</p>
								<a class="header-nav__sub-nav-link" href="https://maidenhome.com/pages/sofas">Sofas</a> <a class="header-nav__sub-nav-link" href="https://maidenhome.com/pages/sectionals">Sectionals</a>
							</div>
							<div class="header-nav__column">

								<p>Tables</p>
								<a class="header-nav__sub-nav-link" href="https://maidenhome.com/pages/coffee-tables">Coffee
									Tables</a> <a class="header-nav__sub-nav-link" href="https://maidenhome.com/pages/side-tables">Side Tables</a>

								<a class="header-nav__sub-nav-link" href="https://maidenhome.com/pages/console-tables">Console
									Tables</a>  
							</div>
						</div>
						<div class="header-nav__sub-nav-images">
							<a href="#"> <img src="//maidenhome.com/cdn/shop/files/01_Shop_All_Living_Top_Nav.jpg?v=1710959897&amp;width=330" alt="" srcset="# 330w" width="330" height="248">
								<p>Shop All Living</p>
							</a><a href="#">
								<img src="//maidenhome.com/cdn/shop/files/02_The_Ella_Table_Top_Nav.jpg?v=1710959897&amp;width=330" alt="" srcset="# 330w" width="330" height="248">
								<p>The Ella Coffee Table</p>
							</a>
						</div>
					</div>
				</div>
			</li>
			
			<li class="header__nav-top-level header__nav-top-level--has-children">
				<a href="https://maidenhome.com/pages/shop-all-dining" class="header__nav-top-level-link" data-name="Dining">Dining</a>
			<div class="header-nav__sub-nav">
					<div class="header-nav__sub-nav-inner">
						<div class="header-nav__sub-nav-links">
							<div class="header-nav__column">
								<a class="header-nav__sub-nav-link" href="https://maidenhome.com/pages/dining-tables">Dining
									Tables</a> <a class="header-nav__sub-nav-link" href="https://maidenhome.com/pages/dining-chairs-and-benches">Dining
									Chairs &amp; Benches</a>
							</div>
						</div>
						<div class="header-nav__sub-nav-images">
							<a href="https://maidenhome.com/pages/shop-all-dining"> <img src="//maidenhome.com/cdn/shop/files/03_Shop_All_Dining_Top_Nav.jpg?v=1710959896&amp;width=330" alt="" srcset="//maidenhome.com/cdn/shop/files/03_Shop_All_Dining_Top_Nav.jpg?v=1710959896&amp;width=330 330w" width="330" height="248">
								<p>Shop All Dining</p>
							</a><a href="https://maidenhome.com/collections/the-garrett-dining-chair?color=Cliff&amp;size=One%20Size&amp;finish=Natural%20Walnut&amp;currentFabric=Woolen%20Boucl%C3%A9&amp;currentType=dining-chair">
								<img src="//maidenhome.com/cdn/shop/files/04_The_Garrett_Chair_Top_Nav.jpg?v=1710959896&amp;width=330" alt="" srcset="//maidenhome.com/cdn/shop/files/04_The_Garrett_Chair_Top_Nav.jpg?v=1710959896&amp;width=330 330w" width="330" height="248">
								<p>The Garrett Dining Chair</p>
							</a>
						</div>
					</div>
				</div>
			</li>
			
		
			<li class="header__nav-top-level header__nav-top-level--has-children">
				<a href="https://maidenhome.com/pages/shop-all-bedroom" class="header__nav-top-level-link" data-name="Bedroom">Bedroom</a>
			<div class="header-nav__sub-nav">
					<div class="header-nav__sub-nav-inner">
						<div class="header-nav__sub-nav-links">
							<div class="header-nav__column">
								<a class="header-nav__sub-nav-link" href="https://maidenhome.com/pages/beds">Beds</a> <a class="header-nav__sub-nav-link" href="https://maidenhome.com/pages/nightstands">Nightstands</a>

								<a class="header-nav__sub-nav-link" href="https://maidenhome.com/pages/dressers">Dressers</a> 
							</div>
						</div>
						<div class="header-nav__sub-nav-images">
							<a href="https://maidenhome.com/pages/shop-all-bedroom"> <img src="//maidenhome.com/cdn/shop/files/05_Shop_All_Bedroom_Top_Nav.jpg?v=1710959896&amp;width=330" alt="" srcset="# 330w" width="330" height="248">
								<p>Shop All Bedroom</p>
							</a><a href="https://maidenhome.com/collections/the-marais-6-drawer-dresser">
								<img src="//maidenhome.com/cdn/shop/files/06_The_Marais_Dresser_Top_Nav.jpg?v=1710959896&amp;width=330" alt="" srcset="# 330w" width="330" height="248">
								<p>The Marais 6-Drawer Dresser</p>
							</a>
						</div>
					</div>
				</div>
			</li>


			<li class="header__nav-top-level header__nav-top-level--has-children">
				<a href="https://maidenhome.com/pages/spring-summer-2024" class="header__nav-top-level-link" data-name="Lamp">Lamp</a>
			<div class="header-nav__sub-nav">
					<div class="header-nav__sub-nav-inner">
						<div class="header-nav__sub-nav-links">
							<div class="header-nav__column">
								<a class="header-nav__sub-nav-link" href="#">Ode
									to Duality</a>
							</div>
						</div>
						<div class="header-nav__sub-nav-images">
							<a href="#">
								<img src="//maidenhome.com/cdn/shop/files/07_Collections_Top_Nav_1.jpg?v=1711376362&amp;width=330" alt="" srcset="# 330w" width="330" height="248">
								<p>Spring/Summer 2024</p>
							</a>
						</div>
					</div>
				</div>
			</li>



			<li class="header__nav-top-level header__nav-top-level--has-children">
				<a href="#" class="header__nav-top-level-link" data-name="ETC">ETC</a>
			<div class="header-nav__sub-nav">
					<div class="header-nav__sub-nav-inner">
						<div class="header-nav__sub-nav-links">
							<div class="header-nav__column">
								<a class="header-nav__sub-nav-link" href="#">Fabric
									&amp; Leather</a>
							</div>
						</div>
						<div class="header-nav__sub-nav-images">
							<a href="#"> <img src="//maidenhome.com/cdn/shop/files/08_Swatches_Top_Nav.jpg?v=1710959897&amp;width=330" alt="" srcset="# 330w" width="330" height="248">
								<p></p>
							</a>
						</div>
					</div>
				</div>
			</li>
		</ul>
		<!-- ------------------------------상품 페이지들 마무리-------------------------- -->


			
			
			
			<!-- ------------------메인 로고--------------------- -->
			<div class="header__logo">
				<h1 class="site-header__logo" itemscope="" itemtype="http://schema.org/Organization">
					<a href="/" itemprop="url" class="site-header__logo-link" data-name="">
 				<img height="232"  class="text-logo" src="../icon/logo.png" alt="MozyHome" itemprop="logo"> 
					</a>
				</h1>
			</div>
		
			
			<!-- -----------------------사용자 간편한 화면 이동----------------------- -->
			<ul class="header__nav">
			<li class="header__nav-top-level header__nav-top-level--has-children">
				<a href="#" class="header__nav-top-level-link">search 
				<!-- <img src="../icon/searchicon_bs.png"> -->
				</a>
			</li>
			
			<li class="header__nav-top-level header__nav-top-level--has-children">
				<a href="#" class="header__nav-top-level-link" data-name="Login">Login
				</a>
			</li>
			
		
			<li class="header__nav-top-level header__nav-top-level--has-children">
				<a href="#" class="header__nav-top-level-link" data-name="Like">Like</a>
			</li>




			<li class="header__nav-top-level header__nav-top-level--has-children">
				<a href="#" class="header__nav-top-level-link" data-name="Cart">Cart</a>
				<!-- <img src="../icon/searchicon_bs.png"> -->
			</li>


			<li class="header__nav-top-level header__nav-top-level--has-children">
				<a href="#" class="header__nav-top-level-link" data-name=MyPage>MyPage</a>
			</li>
		</ul>
		</div>
			<!-- -----------------------사용자 간편한 화면 이동 마무리----------------------- -->

	</header>
</div>
<script type="text/javascript">

  function debounce (func, wait, immediate) {
    let timeout
    return function () {
      const context = this
      const args = arguments
      const later = function () {
        timeout = null
        if (!immediate) func.apply(context, args)
      }
      const callNow = immediate && !timeout
      clearTimeout(timeout)
      timeout = setTimeout(later, wait)
      if (callNow) func.apply(context, args)
    }
  };

  function closeSubNav () {
    const topLevelNavItems = document.querySelectorAll('.header__nav-top-level')
    topLevelNavItems.forEach((topLevelItems) => {
      topLevelItems.classList.remove('header__nav-top-level--open')
    })
  }

  // Click event to toggle subnav
  const headerNav = document.querySelector('.header__nav')
  const topLevelNavItems = document.querySelectorAll('.header__nav-top-level')
  topLevelNavItems.forEach((topLevelNavItem) => {
    // Open on hover
    topLevelNavItem.addEventListener('mouseenter', () => {
      if (window.innerWidth > 1160) {
        headerNav.classList.add('header__nav--open')
        topLevelNavItem.classList.add('header__nav-top-level--open')
      }
    })

    // Close when leaving
    topLevelNavItem.addEventListener('mouseleave', () => {
      if (window.innerWidth > 1160) {
        headerNav.classList.remove('header__nav--open')
        closeSubNav()
      }
    })

    // Click to toggle
    topLevelNavItem.addEventListener('click', (e) => {
      if (window.innerWidth <= 1160 && e.target.closest('.header__nav-top-level').classList.contains('header__nav-top-level--has-children')) {
        // Prevent Default for mobile links that have children
        if (e.target.classList.contains('header__nav-top-level-link')) {
          e.preventDefault()
        }

        topLevelNavItems.forEach((topLevelItems) => {
          if (topLevelItems !== topLevelNavItem) {
            topLevelItems.classList.remove('header__nav-top-level--open')
          }
        })

        topLevelNavItem.classList.contains('header__nav-top-level--open') ? topLevelNavItem.classList.remove('header__nav-top-level--open') : topLevelNavItem.classList.add('header__nav-top-level--open')
      }
    })
  })

</script>


</body></html>

</body>
</html>
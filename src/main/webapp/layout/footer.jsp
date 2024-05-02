<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>푸터영역</title>
<style type="text/css">
#footer {
	padding: 15px 0 25px;
	background-color: #f5f5f5;
}

footer {
	display: block;
	unicode-bidi: isolate;
}

#footer .content {
	width: 100%;
	max-width: 1586px;
	padding: 0 20px;
	box-sizing: border-box;
	margin: 0 auto;
}


html, body, div, dl, dt, dd, ul, ol, li, h1, h2, h3, h4, h5, h6, pre,
	code, form, fieldset, legend, input, textarea, p, blockquote, th, td,
	img {
	margin: 0;
	padding: 0;
	color: #353535;
}

div {
	display: block;
	unicode-bidi: isolate;
}
.copyright {
    padding: 20px 20px 0;
    border-top: 1px solid #ececec;
    box-sizing: border-box;
    text-align: center;
    font-size: 12px;
    color: #666;
}
#footer .content .info_list {
    display: grid;
    grid-template-columns: repeat(6, max-content);
    gap: 20px;
    padding: 20px 0;
    margin: 0 auto;
    justify-content: space-between;
}
* {
    outline: none;
    text-decoration: none;
}
#footer .content .info_list .item .drop_cont .drop_item .info_cont {
    line-height: 18px;
}
#footer .content .info_list .item .title {
    font-size: 16px;
    font-weight: 700;
    margin-bottom: 10px;
    display: flex;
    justify-content: space-between;
}

h3 {
    display: block;
    font-size: 1.17em;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold;
    unicode-bidi: isolate;
}
li {
    list-style: none;
    list-style-position: initial;
    list-style-image: initial;
    list-style-type: none;
}
</style>
</head>
<body>
	<footer id="footer"
		class="xans-element- xans-layout xans-layout-footer ">
		<div class="content">
			<ul class="info_list">
				<li class="item cs_center">
					<h3 class="title">
						CS CENTER
						<path d="M8 10.9998L3 5.9998L3.7 5.2998L8 9.5998L12.3 5.2998L13 5.9998L8 10.9998Z" fill="#161616"></path>
					</h3>

					<div class="drop_cont">
						<ul class="drop_item">
							<li class="info_item">
								<p class="info_cont">
									02-3482-4632<br> 월-금 09:00 - 18:00<br>
								</p>
							</li>

						</ul>
					</div>
				</li>

				<li class="item bank">
					<h3 class="title">
						BANK
							<path d="M8 10.9998L3 5.9998L3.7 5.2998L8 9.5998L12.3 5.2998L13 5.9998L8 10.9998Z" fill="#161616"></path>
					</h3>

					<div class="drop_cont">
						<div class="drop_item">
							<span>모지은행: 123456-78-901234 </span> <br>
							<span>예금주: 모지홈</span>
						</div>
					</div>
				</li>

				<li class="item contact">
					<h3 class="title">
						CONTACT
							<path d="M8 10.9998L3 5.9998L3.7 5.2998L8 9.5998L12.3 5.2998L13 5.9998L8 10.9998Z" fill="#161616"></path>
					</h3>

					<div class="drop_cont">
						<ul class="drop_item">
							<li class="info_item">
								<p class="info_cont">mozyhome@mozyhome.com</p>
							</li>
						</ul>
					</div>
				</li>

				<li class="item sns">
					<h3 class="title">
						SNS
							<path d="M8 10.9998L3 5.9998L3.7 5.2998L8 9.5998L12.3 5.2998L13 5.9998L8 10.9998Z" fill="#161616"></path>
					</h3>

					<div class="drop_cont">
						<ul class="drop_item">
							<li class="info_item"><a href="https://www.instagram.com" target="_blank" style="text-decoration: none; color: #353535;;"><i class="bi bi-instagram"></i>&nbsp;mozyhome</a></li>

						</ul>
					</div>
				</li>

				<li class="item info">
					<h3 class="title">
						INFO
							<path d="M8 10.9998L3 5.9998L3.7 5.2998L8 9.5998L12.3 5.2998L13 5.9998L8 10.9998Z" fill="#161616"></path>
					</h3>

					<div class="drop_cont">
						<ul class="drop_item">
							<li class="info_item">STORE</li>
							<li class="info_item">ABOUT</li>
							<li class="info_item">FAQ</li>
							<li class="info_item">NOTICE</li>
						</ul>
					</div>
				</li> 
				<li class="item company">
					<h3 class="title">
						Team INFO
							<path d="M8 10.9998L3 5.9998L3.7 5.2998L8 9.5998L12.3 5.2998L13 5.9998L8 10.9998Z" fill="#161616"></path>
					</h3>
					<div class="drop_cont">
						<ul class="drop_item">
							<li class="info_item">김우찬</li>
							<li class="info_item">김태윤</li>
							<li class="info_item">박범수</li>
							<li class="info_item">우예은</li>
							<li class="info_item">한동희</li>
						</ul>
					</div>
				</li>
			</ul>
			<div class="copyright">© 2024 MOZYHOME</div>
		</div>
		
		
	</footer>
</body>
</html>
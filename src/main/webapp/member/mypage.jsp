<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
html,body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,input,textarea,p,blockquote,th,td,img {
    margin: 0;
    padding: 0;
    color: #353535;
}
html {
    width: 100%;
    height: 100%;
    scroll-behavior: smooth;
    font-size: 10px;
}

a {
    text-decoration: none !important;
    color: #000;
}

a:hover {
    text-decoration: none;
}

a:active {
    text-decoration: none;
}

li {
    list-style: none;
}

#body {
    background-color: #fff;
}

#body-begin {
    clear: both;
    height: 1px;
}

#body-end {
    clear: both;
    height: 200px;
}
.sub_container {
    max-width: 800px;
    padding: 0 20px;
    margin: 0 auto;
    box-sizing: border-box;
}
h1.page-title {
    text-align: center;
    font-size: 24px;
    font-weight: 700;
    letter-spacing: 5px;
    color: #222;
    line-height: 27px;
    padding-top: 75px;
    padding-bottom: 60px;
}
.mypage {
    padding: 0 1.6rem 0;
}

.mypage .myshop_wrap {
    padding: 3.6rem 0;
}
.mypage .myshop_wrap .myshop_main {
    border-top: 1px solid #D8D8D8;
    border-bottom: 1px solid #D8D8D8;
}

.mypage .myshop_wrap .myshop_item:not(:first-of-type) {
    border-top: 1px solid #F5F5F5;
}

.mypage .myshop_wrap .myshop_item a {
    display: flex;
    justify-content: space-between;
    font-size: 1.4rem;
    padding: 1.6rem;
    font-weight: 500;
    color: #616161;
    align-items: center;
}

.mypage .myshop_wrap .myshop_item a > span {
    display: flex;
    justify-content: center;
}

.my_logout {
    width: max-content;
    margin: 0 auto;
}

.my_logout a {
    font-size: 12px;
    color: #929292;
    text-align: center;
    text-decoration: underline;
}

</style>
</head>
<%
session.setAttribute("mem_id", "must12");
String mem_id = (String) session.getAttribute("mem_id");

%>
<body>
<div id="body">
<div id="body-begin"></div>
	<div class="sub_container">
    <h1 class="page-title">MY PAGE</h1>
    <section class="mypage">
    <div class="myshop_wrap">
	    <ul class="myshop_main">
	    	<li class="myshop_item">
                <a href="index.jsp?main=order/orderList.jsp">
                    <span>주문 목록</span>
					<svg width="18" height="18" viewbox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7.27875 4.5L6.22125 5.5575L9.65625 9L6.22125 12.4425L7.27875 13.5L11.7788 9L7.27875 4.5Z" fill="black" fill-opacity="0.54"></path></svg></a>
            </li>
            <li class="myshop_item">
                 <a href="index.jsp?main=member/modify.jsp">
                     <span>회원 정보</span>
                     <svg width="18" height="18" viewbox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7.27875 4.5L6.22125 5.5575L9.65625 9L6.22125 12.4425L7.27875 13.5L11.7788 9L7.27875 4.5Z" fill="black" fill-opacity="0.54"></path></svg></a>
            </li>
            <li class="myshop_item ">
                    <a href="index.jsp?main=wishlist/wishlist.jsp">
                        <span>위시리스트</span>
                        <svg width="18" height="18" viewbox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7.27875 4.5L6.22125 5.5575L9.65625 9L6.22125 12.4425L7.27875 13.5L11.7788 9L7.27875 4.5Z" fill="black" fill-opacity="0.54"></path></svg></a>
                </li>
                <li class="myshop_item">
                    <a href="/myshop/addr/list.html">
                        <span>고객센터</span>
                        <svg width="18" height="18" viewbox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7.27875 4.5L6.22125 5.5575L9.65625 9L6.22125 12.4425L7.27875 13.5L11.7788 9L7.27875 4.5Z" fill="black" fill-opacity="0.54"></path></svg></a>
                </li>
	    </ul>
    </div>
    
    
    
    <div class="my_logout">
            <a href="#"><p>로그아웃</p></a>
    </div>
    </section>
    </div>
<div id="body-end"></div>
</div>
</body>
</html>
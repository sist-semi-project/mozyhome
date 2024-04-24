<%@page import="data.dao.ProductDao"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="data.dto.OrderDetailDto"%>
<%@page import="data.dao.OrderDetailDao"%>
<%@page import="data.dto.MemberDto"%>
<%@page import="data.dao.MemberDao"%>
<%@page import="data.dto.OrderDto"%>
<%@page import="data.dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>주문완료</title>
<style type="text/css">
html,body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,input,textarea,p,blockquote,th,td,img {
    margin: 0;
    padding: 0;
    color: #353535;
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
#userStyle {
    padding: 40px 0 0;
}

#userStyle.order_result_style {
    background: #fff;
}
#userStyle table tbody th {
    padding: 0;
    border: 0;
    background-color: transparent;
}
#frm_order_result table {
    width: 100%;
}
.order_result_style #frm_order_result table {
    margin: 0 !important;
}

.resultArea {
    position: relative;
    margin: 20px 20px 12px;
    padding: 31px 0 18px;
    background: #fff;
}

.resultArea h3 {
    margin: 0 auto;
    width: max-content;
}

.resultArea:after {
    position: absolute;
    top: 100%;
    left: 0;
    display: block;
    content: "";
    width: 100%;
    height: 5px;
    background: url("//img.echosting.cafe24.com/skin/mobile/order/bg_resultarea.png") repeat-x 0 bottom;
    background-size: auto 5px;
}

.resultArea .message {
    padding: 20px 0 15px;
    text-align: center;
    font-size: 18px;
    color: #333;
    line-height: 26px;
}

.resultArea .message strong {
    font-weight: 800;
}
#mCafe24Order .resultInfo {
    margin: 15px 0;
    border-top: 1px solid #929292;
    border-bottom: 1px solid #929292;
}
#mCafe24Order .ec-base-table tbody th {

    font-weight: 400;
    color: #616161;
    width: 57px;
    display: flex;
    align-items: center;
    justify-content: flex-start;
    column-gap: 2px;
}
#mCafe24Order .resultInfo .ec-base-table tr {
    border-bottom: 0;
}
.ec-base-table tr {
    border-bottom: 1px solid #F5F5F5;
    padding: 12.5px 16px;
    box-sizing: border-box;
    width: 100%;
    display: flex;
    column-gap: 10px;
}
#mCafe24Order .contents .segment .ec-base-table th {
    width: auto;
}

#mCafe24Order .contents .segment .ec-base-table td {
    flex: 1;
    width: 100%;
    text-align: right;
}

#mCafe24Order .contents .segment .ec-base-table td span {
    font-size: 16px;
    font-weight: 500;
    color: #616161;
}



.right {
    text-align: right;
}
.txtEm {
    color: #141414;
    display: inline-block;
}
.pannelArea .contents .ec-base-table tr {
    padding: 8px 12px;
}
.pannelArea .contents .ec-base-table th {
    width: 80px;
    white-space: nowrap;
}
.ec-base-table.typeView {
    color: #929292;
    font-size: 12px;
    border-top: 1px solid #929292;
    border-bottom: 1px solid #929292;
}

.ec-base-table.typeView > table > tbody > tr::after {
    content: "";
    display: none;
    clear: both;
}

.ec-base-table.typeView > table > tbody > tr > td {
    color: #616161;
    float: right;
}
#mCafe24Order .ec-base-fold .ec-base-prdInfo,#mCafe24Order .pannelArea .ec-base-prdInfo {
    margin: 0;
}
.segment {
    position: relative;
}
.order_result_style .pannelArea.pannel_product .contents {
    border: 1px solid #d8d8d8;
    border-radius: 8px;
    box-sizing: border-box;
    overflow: auto;
}
#mCafe24Order .ec-base-prdInfo.soldout .prdBox {
    position: relative;
}
#mCafe24Order .ec-base-prdInfo .prdBox {
    position: relative;
    display: -webkit-flex;
    display: -ms-flex;
    display: flex;
    align-items: center;
}
#mCafe24Order .ec-base-prdInfo.soldout .prdBox:before {
    z-index: 1;
    display: block;
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    filter: alpha(opacity=50);
    opacity: 0.5;
    background: #fff;
}
#mCafe24Order .ec-base-prdInfo .thumbnail {
    overflow: hidden;
    width: 64px;
    height: 80px;
    margin-right: 12px;
    box-sizing: border-box;
}

#mCafe24Order .ec-base-prdInfo .thumbnail img {
    width: 100%;
}

#mCafe24Order .ec-base-prdInfo .description {
    overflow: hidden;
    -webkit-flex: 1;
    -ms-flex: 1;
    flex: 1;
    padding: 0;
}

#mCafe24Order .ec-base-prdInfo .description img {
    vertical-align: middle;
}
.name {
    font-size: 14px;
    font-weight: 500;
    color: #333;
}
#mCafe24Order .ec-base-prdInfo .description .info {
    margin: 0 0 4px;
}

#mCafe24Order .ec-base-prdInfo .description .info li {
    margin: 4px 0 0;
    font-size: 12px;
    color: #616161;
    line-height: 18px;
}

#mCafe24Order .ec-base-prdInfo .description .info li .option {
    font-size: 12px;
    color: #929292;
    font-weight: 400;
}

#mCafe24Order .ec-base-prdInfo .description .info li.price_info {
    font-size: 1.4rem;
    font-weight: 500;
    margin-top: 12px;
    color: #616161;
}

#mCafe24Order .ec-base-prdInfo .description .info li.price_info span {
    position: relative;
    display: inline-block;
    padding-right: 10px;
    margin-right: 10px;
}
#mCafe24Order .ec-base-prdInfo .description .info li.price_info span::after {
    content: "";
    display: block;
    width: 1px;
    height: 80%;
    background-color: #C7C7C7;
    position: absolute;
    top: 50%;
    right: 0;
    transform: translate(0,-50%);
}

#mCafe24Order .ec-base-prdInfo .description .info li.price_info span:last-child::after {
    display: none;
}

#mCafe24Order .ec-base-prdInfo .description .info .price {
    color: #333;
}

#mCafe24Order .ec-base-prdInfo .description .info .price .discount {
    font-weight: normal;
    text-decoration: line-through;
    color: #bcbcbc;
}

#mCafe24Order .ec-base-prdInfo .description .info .price .discount.priceValue {
    display: block;
}

#mCafe24Order .ec-base-prdInfo .description .info .price .discount .refer {
    text-decoration: line-through;
    vertical-align: top;
}

#mCafe24Order .ec-base-prdInfo .description .info .price .strike {
    font-weight: normal;
    text-decoration: line-through;
}
#mCafe24Order .ec-base-prdInfo .description .price .quantity {
    position: relative;
    display: inline-block;
    padding: 0 0 0 14px;
}

#mCafe24Order .ec-base-prdInfo .description .price .quantity:before {
    display: block;
    content: "*";
    position: absolute;
    top: 2px;
    left: 0;
}

#mCafe24Order .ec-base-prdInfo .description .info li.mileage img {
    margin: 0 0 2px;
    vertical-align: top;
}

#mCafe24Order .ec-base-prdInfo .description input[type="number"] {
    max-width: 51px;
}

#mCafe24Order .ec-base-prdInfo .description .info li.point {
    color: #508bed;
}

#mCafe24Order .ec-base-prdInfo .description .info .amount button {
    margin: 0;
    padding: 0;
    border: 0;
}

#mCafe24Order .ec-base-prdInfo .description .info .amount {
    width: 50px;
}
#mCafe24Order .ec-base-prdInfo .description .info li.price_info {
    font-size: 1.4rem;
    font-weight: 500;
    margin-top: 12px;
    color: #616161;
}

#mCafe24Order .ec-base-prdInfo .description .info li.price_info span {
    position: relative;
    display: inline-block;
    padding-right: 10px;
    margin-right: 10px;
}

#mCafe24Order .ec-base-prdInfo .description .info li.price_info span::after {
    content: "";
    display: block;
    width: 1px;
    height: 80%;
    background-color: #C7C7C7;
    position: absolute;
    top: 50%;
    right: 0;
    transform: translate(0,-50%);
}
#mCafe24Order .pannelArea .contents .ec-base-table tr {
    padding: 8px 12px;
}
.order_result_style .ec-base-table tr {
    display: flex;
    align-items: center;
}
#mCafe24Order .pannelArea .contents .ec-base-table th {
    width: 80px;
    white-space: nowrap;
}
#mCafe24Order .ec-base-prdInfo .description .info li.price_info span:last-child::after {
    display: none;
}
#mCafe24Order .title {
    padding: 0 11px 12px;
    word-wrap: break-word;
    word-break: break-all;
    -webkit-tap-highlight-color: rgba(255,255,255,0);
    display: -webkit-flex;
    display: -ms-flex;
    display: -moz-flex;
    display: flex;
    -webkit-flex-wrap: wrap;
    -ms-flex-wrap: wrap;
    -moz-flex-wrap: wrap;
    flex-wrap: wrap;
    -webkit-justify-content: space-between;
    -ms-justify-content: space-between;
    -moz-justify-content: space-between;
    justify-content: space-between;
}
#mCafe24Order .title h2 {
    font-size: 16px;
    font-weight: 700;
    color: #333;
    line-height: 19px;
}

#mCafe24Order .pannelArea.payment_info tr {
    background-color: #F5F5F5;
    }

#mCafe24Order .pannelArea.payment_info .segment {
    border-top: 1px solid #929292;
    border-bottom: 1px solid #929292;
}

#mCafe24Order .pannelArea.payment_info .segment tr {
    border-color: #ECECEC;
}
#mCafe24Order .totalPay {
    margin-top: 0 !important;
    padding: 14px 16px;
    color: #fff;
    font-size: 18px;
    word-wrap: break-word;
    word-break: break-all;
    display: -webkit-flex;
    display: -ms-flex;
    display: -moz-flex;
    display: flex;
    -webkit-flex-wrap: wrap;
    -ms-flex-wrap: wrap;
    -moz-flex-wrap: wrap;
    flex-wrap: wrap;
    -webkit-justify-content: space-between;
    -ms-justify-content: space-between;
    -moz-justify-content: space-between;
    justify-content: space-between;
}
#mCafe24Order .gBlank10 {
    display: block;
    margin-top: 10px;
}
#mCafe24Order .totalPay .heading {
    margin: 0 4px 0 0;
    font-size: 14px;
    font-weight: 500;
}
.order_result_style .totalPay .txtStrong {
    color: #EA6000 !important;
    font-size: 14px !important;
}
#mCafe24Order .segment .totalPay {
    border-top-width: 0;
    padding-bottom: 13px;
}

.gCellNarrow.ec-base-table table tbody tr {
    display: table-row;
    align-items: center;
    width: 100%;
    justify-content: space-between;
}
#mCafe24Order .ec-base-table.gCellNarrow tbody th {
    font-size: 14px;
    font-weight: 500;
    color: #616161;
}
.gCellNarrow.ec-base-table table tbody tr:nth-child(2) .txtEm {
    color: #EA6000 !important;
}
gCellNarrow th {
    color: #999;
}
#mCafe24Order .agreeArea .insuranceDetail .ec-base-table.gCellNarrow {
    margin: 9px 0;
}
#mCafe24Order .resultInfo .ec-base-table.gCellNarrow {
    margin: 16px 0;
    padding: 0 12px;
    color: #141414;
    font-size: 14px;
    font-weight: 500;
}
#mCafe24Order .resultInfo .ec-base-table.gCellNarrow table {
    width: 100%;
}
.order_result_style .resultInfo .ec-base-table.gCellNarrow tbody th {
    font-weight: 400 !important;
}

#mCafe24Order .ec-base-button {
    margin: 10px auto;
    text-align: right;
}
#mCafe24Order .ec-base-button[class*="gColumn"] {
    display: -webkit-flex;
    display: -ms-flex;
    display: -moz-flex;
    display: flex;
    margin: 0 16px;
}

#mCafe24Order .ec-base-button[class*="gColumn"]:after {
    content: none;
}

#mCafe24Order .ec-base-button[class*="gColumn"] a,#mCafe24Order .ec-base-button[class*="gColumn"] button {
    -webkit-flex: 1;
    -ms-flex: 1;
    -moz-flex: 1;
    flex: 1;
    padding: 14.5px 4px;
    font-size: 16px;
    font-weight: 600;
    white-space: nowrap;
}
.order_result_style .ec-base-button[class*="gColumn"] {
    gap: 12px !important;
}

.order_result_style .ec-base-button[class*="gColumn"] a,.order_result_style .ec-base-button[class*="gColumn"] button {
    font-size: 14px !important;
}
#mCafe24Order .btnEm {
    padding: 14.5px 10px;
    font-size: 16px;
    font-weight: 600;
    border: 1px solid #D8D8D8;
    background: #fff;
    color: #616161;
}
#mCafe24Order .btnSubmit {
    padding: 14.5px 10px;
    font-size: 16px;
    font-weight: 600;
    color: #fff;
    border: 1px solid #EA6000;
    background: #EA6000;
}
#mCafe24Order .btnNormal,#mCafe24Order .btnStrong,#mCafe24Order .btnBasic,#mCafe24Order .btnSubmit,#mCafe24Order .btnEm,#mCafe24Order .btnBase {
    display: inline-block;
    letter-spacing: -0.4px;
    text-align: center;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
a {
    text-decoration: none !important;
}
</style>
</head>
<body>
<%
String mem_id = (String) session.getAttribute("myid"); 

//MemberDao 인스턴스 생성
MemberDao memberDao = new MemberDao();
MemberDao mdao = new MemberDao();
MemberDto mdto = mdao.getMemberInfo(mem_id);	


String order_num = request.getParameter("orderNumber");
OrderDao odao = new OrderDao();
OrderDto odto = odao.getOneData(order_num);

OrderDetailDao odtdao = new OrderDetailDao();
OrderDetailDto odtdto = odtdao.getOrderDetailsByMember(order_num);
String pro_num = odtdto.getPro_num();
ProductDao pdao = new ProductDao();
ProductDto pdto = pdao.getProduct(pro_num); 
%>
<div id="body">
<div id="body-begin"></div>
<div class="sub_container">
	<h1 class="page-title">ORDER</h1>
	<div id="userStyle" class="order_result_style">
		 <form id="frm_order_result" name="frm_order_result" method="post">
		 <div id="mCafe24Order" class="xans-element- xans-order xans-order-result typeHeader order_result">
		 
		 
		 	<!-- [주문완료정보] -->
			<div class="resultArea">
            <h3>
                <picture><svg width="60" height="60" viewbox="0 0 60 60" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M30.5 3.75C16.0039 3.75 4.25 15.5039 4.25 30C4.25 44.4961 16.0039 56.25 30.5 56.25C44.9961 56.25 56.75 44.4961 56.75 30C56.75 15.5039 44.9961 3.75 30.5 3.75ZM41.8379 21.4277L29.498 38.5371C29.3256 38.7778 29.0982 38.974 28.8348 39.1093C28.5714 39.2446 28.2795 39.3152 27.9834 39.3152C27.6873 39.3152 27.3954 39.2446 27.132 39.1093C26.8686 38.974 26.6412 38.7778 26.4688 38.5371L19.1621 28.4121C18.9395 28.1016 19.1621 27.668 19.543 27.668H22.291C22.8887 27.668 23.457 27.9551 23.8086 28.4473L27.9805 34.2363L37.1914 21.4629C37.543 20.9766 38.1055 20.6836 38.709 20.6836H41.457C41.8379 20.6836 42.0605 21.1172 41.8379 21.4277Z" fill="#EA6000"></path></svg></picture>
			</h3>
            <p class="message">
                <strong>고객님의 주문이<br>정상적으로 완료되었습니다.</strong>
            </p>
            <div class="resultInfo">
                <div class="ec-base-table gCellNarrow">
                    <table border="0">
                        <tbody>
							<tr>
							<th scope="row">주문번호</th>
                                <td class="right"><span class="txtEm"><%=order_num %></span></td>
                            </tr>
							<tr>
							<th scope="row">결제금액</th>
                                <td class="right">
                                    <span class="txtEm">
                                        &#8361;<%=odto.getOrder_total_payment() %>
                                    </span>
                                </td>
                            </tr>
						</tbody>
					</table>
				</div>
	        </div>
	        </div>
	        
	        
        	<!-- [배송지정보] -->
			<div class="pannelArea">
            	<div class="">
            		<div class="">
	                    <div class="title">
	                        <h2>배송지</h2>
	                    </div>
	                    <div class="contents">
	                        <div class="segment">
	                            <div class="ec-base-table typeView">
	                                <table border="0">
	                                    <colgroup>
										<col style="width: 94px">
										<col style="width: auto">
										</colgroup>
										<tbody>
											<tr>
												<th scope="row">받는사람</th>
		                                        <td><%=odto.getOrder_name()%></td>
		                                    </tr>
											<tr>
												<th scope="row">주소</th>
		                                        <td><%=odto.getOrder_addr()%></td>
		                                    </tr>
											<tr>
												<th scope="row">연락처</th>
		                                    	<td><%=odto.getOrder_hp()%></td>
		                                    </tr>
											<tr>
												<th scope="row">배송요청</th>
		                                    	<td><%=odto.getOrder_delivery_request() %></td>
		                                    </tr>
										</tbody>
									</table>
								</div>
	                        </div>
	                    </div>
	                </div>
				</div>
	        </div>
        
	        <!-- [주문상품] -->
			<div class="pannelArea pannel_product">
	            <div class="title">
	                <h2>주문상품</h2>
	            </div>
	            <div class="contents">
	                <!-- 국내배송상품 주문내역 -->
	                <div class="orderArea">
	                    <div class="" nspace="normal">
	                        <div class="xans-element- xans-order">
	                        	<div class="ec-base-prdInfo">
	                                <div class="prdBox">
	                                    <div class="thumbnail">
	                                        <a href="index.jsp?main=product/detailpage.jsp?pro_num=<%=pro_num %>"><img src="<%=pdto.getPro_main_img()%>" width="90" height="90"></a>
	                                    </div>
	                                    <div class="description">
	                                        <strong class="name" title="상품명"><%= pdto.getPro_name() %></strong>
	                                        <ul class="info">
	                                            <li title="옵션">
	                                                <p class="option ">
	                                                    [옵션: <%=odtdto.getOrder_color()%>: <%=odtdto.getOrder_size()%>]
	                                                 </p>
	                                            </li>
	                                            <li class="price_info">
	                                                <span id="">&#8361;<%=pdto.getPro_price()%></span>
	                                                <span><%=odtdto.getOrder_detail_su()%>개</span>
	                                            </li> 
	                                        </ul>
										</div>
	                                </div>
	                            </div>
							</div>
	                    </div> 
	                </div>
	        	</div>
	        </div>         
        
        
	        <!-- [결제정보] -->
			<div class="pannelArea payment_info">
	            <div class="title">
	                <h2>결제정보</h2>
	            </div>
	            <div class="contents">
	                <div class="segment">
	                    <div class="ec-base-table gCellNarrow">
	                        <table border="0">
	                            <colgroup>
								<col style="width: 140px">
								<col style="width: auto">
								</colgroup>
								<tbody>
								<tr>
									<th scope="row">주문상품</th>
		                        	<td class="right">&#8361;<%=odto.getOrder_total_payment()%></td>
		                        </tr>
								<tr>
									<th scope="row">배송비</th>
		                        	<td class="right">+&#8361;<%=odto.getOrder_delivery_fee()%></td>
		                        </tr>
								</tbody>
							</table>
						</div>
	                    <div class="totalPay gBlank10">
	                        <h3 class="heading">총 결제금액</h3>
	                        <strong class="txtStrong">&#8361;<%=odto.getOrder_total_payment()%></strong>
	                    </div>
	                </div>
	            </div>
	        </div>
        
        <div class="ec-base-button gColumn">
            <a href="/myshop/order/list.html" class="btnEm btn_radius">주문확인하기</a>
            <a href="/" class="btnSubmit btn_radius">쇼핑계속하기</a>
        </div>
        
        
        
        
        
		 </div>
		 
		 </form>
	</div>

</div>
<div id="body-end"></div>
</div>

</body>
</html>
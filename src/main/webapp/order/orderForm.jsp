<%@page import="data.dto.ProductDto"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="data.dto.MemberDto"%>
<%@page import="data.dao.MemberDao"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="data.dao.CartDao"%>
<%@page import="data.dto.CartDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 양식</title>
<style type="text/css">
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
#mCafe24Order .ec-base-fold {
    position: relative;
    margin: 0 0 24px;
    padding: 0;
    border-top: 1px solid #D8D8D8;
    border-bottom: 1px solid #D8D8D8;
    background: #fff;
}

#mCafe24Order .ec-base-fold > .title {
    position: relative;
    border-bottom: 1px solid #ececec;

    box-sizing: border-box;
}

#mCafe24Order .title h2 {
    font-size: 16px;
    font-weight: 700;
    color: #333;
    line-height: 19px;
}

.ec-base-fold.selected > .contents {
    overflow: visible;
    opacity: 1;
    height: auto;
    border-top-width: 1px;
}
.ec-base-table tr {
    border-bottom: 1px solid #F5F5F5;
    padding: 12.5px 16px;
    box-sizing: border-box;
    width: 100%;
    display: flex;
    column-gap: 10px;
}

tr {
    display: table-row;
    vertical-align: inherit;
    unicode-bidi: isolate;
    border-color: inherit;
}
table {
    width: 100%;
    border: 0;
    border-spacing: 0;
    border-collapse: collapse;
}

input[type="text"], input[type="tel"] {
    width: 100%;
    border-radius: 8px;
    background: #F5F5F5;
    color: #616161;
    border: 0;
    box-sizing: border-box;
    padding: 8px 16px;
    font-size: 14px;
    font-weight: 400;
    line-height: 18px;
}
input[type="text"] {
    height: auto;
    line-height: 20px;
    padding: 2px 4px;
    color: #333;
    font-size: 12px;
}

.address_content td .address_box {
    display: flex;
    gap: 5px;
}

.address_content td > input {
    margin-top: 5px;
}

.inputTypeText {
    vertical-align: top;
    color: #141414;
    text-align: left;
    font-size: 1.4rem;
    font-weight: 400;
}

#btn_search_rzipcode {
    border: 1px solid #d8d8d8;
    border-radius: 8px;
    padding: 8px 20px;
    color: #616161;
    background: #d8d8d8;
    height: auto;
    font-size: 14px;
    font-weight: 500;
    line-height: 17px;
    width: max-content;
    white-space: nowrap;
    margin: 0;
}
.ec-base-table tbody th {

    font-weight: 400;
    color: #616161;
    width: 80px;
    display: flex;
    align-items: center;
    justify-content: flex-start;
    column-gap: 2px;
}
.ec-base-table tbody tr#ec-orderer-address th,#mCafe24Order .ec-base-table tbody tr#ec-receiver-address th {
    height: 36px;
}

.ec-base-table td {
    font-size: 12px;
    color: var(--gray-6-color);
    flex: 1 1 0%;
    text-align: right;
    border: 0;
}

.ec-base-table td .ec-base-mail {
    display: flex;
    align-items: center;
}

#mCafe24Order .ec-base-table td select {
    flex: 1;
}

.ec-base-table tr {
    border-bottom: 1px solid #F5F5F5;
    padding: 12.5px 16px;
    box-sizing: border-box;
    width: 100%;
    display: flex;
    column-gap: 10px;
}

.ec-base-table p.info {
    border-bottom: 1px solid #e8e5e4;
    color: #757575;
    line-height: 1.5;
    font-size: 14px;
    background: url(//img.echosting.cafe24.com/skin/base/common/ico_info.gif) no-repeat 9px 4px;
}







.order_table {
    display: block;
    width: 100%;
}
.order_tbody {
    row-gap: 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}
.order_tr {
    display: block;
    width: 100%;
}

.order_td {
    width: 100%;
    display: block;
}
.order_body {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    justify-content: flex-start;
    padding: 4px 16px;
    border-radius: 4px;
    border: 1px solid #ECECEC;
    box-sizing: border-box;
    background: white;
    width: 100%;
}
.body_main .info .product_name {
    font-size: 13px;
    font-weight: 400;
    line-height: 21px;
    color: #333;
    margin-bottom: 4px;
}
.body_main .info .product_option {
    width: 70%;
    font-size: 12px;
    line-height: 14px;
    color: #929292;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    padding-bottom: 12px;
}
.body_main .info .price {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    column-gap: 21px;
}
.order_body .body_main {
    column-gap: 16px;
    padding: 12px 0;
    display: flex;
    align-items: flex-start;
    justify-content: flex-start;
    width: 100%;
}
.order_body .body_main img {
    width: 133px;
    height: 133px;
}
.order_body .body_main .info {
    display: flex;
    flex-direction: column;
    flex: 1 1 0%;
    align-items: flex-start;
    justify-content: center;
    text-align: left;
}
.body_main .info .price {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    column-gap: 21px;
}

.body_main .info .price p {
    position: relative;
    font-size: 14px;
    font-weight: 500;
    line-height: 17px;
    color: #616161;
}

.body_main .info .price p:first-child::after {
    content: '';
    position: absolute;
    display: block;
    width: 1px;
    height: 12px;
    top: 2px;
    right: -10px;
    background: #C7C7C7;
}








#ec-jigsaw-area-paymethod #payment_input_tcash table tbody tr td {
    border: 0;
}


#mCafe24Order .segment {
    position: relative;
}

#mCafe24Order .segment:first-child,#mCafe24Order .segment:first-child[class*='displaynone'] + .segment,#mCafe24Order .segment:first-child[style*='display: none'] + .segment {
    border-top-width: 0;
}
#mCafe24Order .payMethod > li {
    position: relative;
    margin-bottom: 10px;
    border-top: 1px solid #ECECEC;
    overflow: hidden;
}

#mCafe24Order .payMethod > li.ec-paymethod-newArea .inner {
    display: grid;
    grid-template-columns: repeat(2,1fr);
    padding: 0 16px;
    gap: 12px;
}

#mCafe24Order .payMethod > li.ec-paymethod-recentArea {
    padding: 0 16px;
}

#mCafe24Order .payMethod > li.ec-paymethod-recentArea > label {
    padding: 10px 8px;
}

#mCafe24Order .payMethod > li.ec-paymethod-recentArea > .inner {
    color: #fff !important;
    background-color: #333;
    border: 1px solid #EA6000;
    text-align: center;
    padding: 12px 20px !important;
    width: calc(50% - 8px);
    box-sizing: border-box;
    margin-bottom: 8px;
}
#mCafe24Order .payMethod > li > input {
    position: absolute;
    right: 14px;
    top: 9px;
}

#mCafe24Order .payMethod > li > label {
    display: block;
    margin: 0;
    padding: 10px 24px;
    box-sizing: border-box;
    font-weight: 700;
    color: #000;
    font-size: 14px;
}

#mCafe24Order .payMethod > li > label::before,#mCafe24Order .payMethod > li > label::after {
    display: none;
}

#mCafe24Order .payMethod > li .inner {
    display: none;
}

#mCafe24Order .payMethod > li.selected > label {
    color: #000;
    background: #fff;
}
#mCafe24Order .payMethod > li.selected > .inner {
    gap: 8px;
    display: grid;
    overflow: visible;
    opacity: 1;
    height: auto;
    padding: 0 16px;
    -webkit-transition: height .3s ease,opacity .3s ease-out;
    -moz-transition: height .3s ease,opacity .3s ease-out;
    -ms-transition: height .3s ease,opacity .3s ease-out;
    -o-transition: height .3s ease,opacity .3s ease-out;
    transition: height .3s ease,opacity .3s ease-out;
    font-size: 14px;
    font-weight: 500;
    color: #212121;
}

#mCafe24Order #payment_input_cash table::before {
    display: none;
}

#mCafe24Order #payment_input_cash #payment_input_cash {
    padding: 12px 16px;
}

#mCafe24Order .payMethod > li .inner {
    display: none;
    opacity: 0;
    height: 0;
}
#mCafe24Order .payMethod > li .inner > .ec-base-label {
    display: inline-flex;
    align-items: center;
    margin: 0;
}

#mCafe24Order .payMethod > li .inner > .ec-base-label input {
    width: 1px;
    height: 1px;
    display: none;
}

#mCafe24Order .payMethod > li .inner > .ec-base-label label {
    text-align: center;
    padding: 12px 20px;
    width: 100%;
    box-sizing: border-box;
    background-color: #fff;
    border: 1px solid #d8d8d8;
}
#mCafe24Order .payMethod > li .inner > .ec-base-label label::before,#mCafe24Order .payMethod > li .inner > .ec-base-label label::after {
    display: none;
}

#mCafe24Order .payMethod > li .inner > .ec-base-label input:checked + label {
    color: #fff;
    background-color: #EA6000;
    border: 1px solid #EA6000;
}
#mCafe24Order .ec-base-button {
    margin: 10px auto;
    text-align: right;
}
#mCafe24Order .ec-base-button.gFull {
    margin: 0;
    width: 100%;
    box-sizing: border-box;
    padding: 0;
}
#mCafe24Order .ec-base-button.gFull [class*="btn"],[class*="btn"].gFull {
    width: 100%;
    margin-bottom: 0 !important;
}

#mCafe24Order .ec-base-button.gFull [class*="btn"] {
    margin: 0 0 7px;
    padding: 16px;
    font-size: 16px;
    font-weight: 600;
    border-radius: 0 !important;
}
#mCafe24Order .btnNormal,#mCafe24Order .btnStrong,#mCafe24Order .btnBasic,#mCafe24Order .btnSubmit,#mCafe24Order .btnEm,#mCafe24Order .btnBase {
    display: inline-block;
    letter-spacing: -0.4px;
    text-align: center;
    -moz-box-sizing: border-box;
    box-sizing: border-box;
}
#mCafe24Order .btnSubmit {
    padding: 14.5px 10px;
    font-size: 16px;
    font-weight: 600;
    color: #fff;
    border: 1px solid #EA6000;
    background: #EA6000;
}








.ec-paymethod-input-detail .ec-base-table table {
    border: 0;
}
#payment_input_cash table td {
    border: 0;
    text-align: left !important;
}

#mCafe24Order #omessage_select,#mCafe24Order #fmessage_select,#mCafe24Order #ship_hope_time,#mCafe24Order #fship_hope_time,#mCafe24Order .xans-order-ordadd select,#mCafe24Order #bankaccount,#mCafe24Order #receiver_id_card_type {
    width: 100%;
}
#userStyle table tbody th {
    padding: 0;
    border: 0;
    background-color: transparent;
}

#mCafe24Order .contents .segment .ec-base-table td span {
    font-size: 16px;
    font-weight: 500;
    color: #616161;
}








</style>
<!-- 다음 우편번호 서비스 API 스크립트 로드 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	//다음 우편번호 서비스를 실행하는 함수
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = ''; // 주소 변수 초기화

                if (data.userSelectedType === 'R') { // 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }
                
             	// 우편번호와 주소를 해당 필드에 설정
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
             	// 상세 주소 입력란에 포커스 설정
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
	
 	// 결제 수단에 따라 은행 정보 입력란을 표시하거나 숨기는 함수
    function showBankInfo() {
        var paymentMethod = document.querySelector('input[name="payment_method"]:checked').value;

        var bankInfoDiv = document.getElementById("bankInfo");
        if (paymentMethod === "bank_transfer") {
        	// 무통장입금 선택 시 은행 정보 입력란 표시
            bankInfoDiv.style.display = "block";
        } else {
        	// 신용카드 선택 시 은행 정보 입력란 숨김
            bankInfoDiv.style.display = "none";
        }
    }
</script>
</head>
<body>
<% 
request.setCharacterEncoding("utf-8");
String mem_id = (String) session.getAttribute("myid");  

MemberDao memberDao = new MemberDao();
MemberDto memberDto = memberDao.getMemberInfo(mem_id);

// 구매방법 여부
Boolean directPurchase = (Boolean) session.getAttribute("directPurchase"); //바로구매 ture, 장바구니 false

NumberFormat nf = NumberFormat.getInstance();

%>
<!-- 주문 정보를 입력받는 폼 -->
<div id="body">
<div id="body-begin"></div>
<div class="sub_container">
<h1 class="page-title">주문서</h1>
<div id="userStyle" style="width: auto">
<form action="index.jsp?main=order/orderAction.jsp" method="post">  
	<div id="mCafe24Order">
	<h3>주문상품</h3>
    	<%
    	String pro_main_img = "";// 상품 이미지
    	String pro_size = "";// 사이즈
    	String pro_color = "";// 색
    	String pro_su = "";// 수량
    	String pro_price = "";// 가격
    	String pro_name = "";// 상품명
    	String pro_num = "";// 상품 번호
    	
    	int totalProductPrice = 0; // 총 상품금액 	
	    int deliveryFee = 3000; // 배송비 설정
	    int finalPayment = 0; // 최종 결제 금액(총 상품금액 + 배송비)
	 	
    	if (directPurchase != null && directPurchase) {
		    // 제품 상세페이지에서 바로 구매하는 경우의 처리
    		
    		pro_num = request.getParameter("pro_num");
		    pro_su = request.getParameter("cnt"); 
    		pro_color = request.getParameter("color"); 
    		pro_size = request.getParameter("size");
    		
    		//해당상품에대한 데이터
    		ProductDao pdao = new ProductDao();
    		ProductDto pdto = pdao.getProduct(pro_num);
    		pro_main_img = pdto.getPro_main_img(); 
    		pro_name = pdto.getPro_name(); 
    		int price = pdto.getPro_price(); 

    		// 총 상품금액 계산 (상품 가격 * 수량)
			totalProductPrice = price * Integer.parseInt(pro_su);
			
%>
    		
			
			<table class="order_table">
	    	<tbody class="order_tbody">
		    	<tr class="order_tr">
					<td class="order_td">		
					<div class="order_body">
						<div class="body_main">
				            <a href="#"><img src="<%=pro_main_img%>"></a>
				            <div class="info">
				                <p class="product_name"><%=pro_name%></p>
				                <p class="product_option">[<%=pro_size %> : <%=pro_color %>]</p>
				                <div class="price">
			                    	<p>&#8361;<%=pro_price %></p>
			                    	<p><%=pro_su %>개</p>
				                </div>
				            </div>
				        </div>
					</div>
					</td>
				</tr>
			</tbody>
		</table>
		<%
    		
		} else {
		    // 장바구니에서 구매하는 경우의 처리
			CartDao cdao=new CartDao();
			List<HashMap<String,String>> list=cdao.getCartList(mem_id);
			
			for(int i=0; i<list.size(); i++ ){
				HashMap<String,String> map=list.get(i);
				pro_su = map.get("cart_su"); // 주문상세테이블에 들어갈 수???
				pro_num = map.get("pro_num"); // 주문상세테이블에 들어갈 상품 번호???
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
						
    	%>
    	<table class="order_table">
	    	<tbody class="order_tbody">
		    	<tr class="order_tr">
					<td class="order_td">		
					<div class="order_body">
						<div class="body_main">
				            <a href="#"><img src="<%=map.get("pro_main_img")%>"></a>
				            <div class="info">
				                <p class="product_name"><%= map.get("pro_name") %></p>
				                <p class="product_option">[<%=map.get("cart_size") %> : <%= map.get("cart_color") %>]</p>
				                <div class="price">
			                    	<p>&#8361;<%=map.get("pro_price") %></p>
			                    	<p><%=map.get("cart_su") %>개</p>
				                </div>
				            </div>
				        </div>
					</div>
					</td>
				</tr>
			</tbody>
		</table>
    	<%	
	    	}
			
			// 총 상품금액 계산
		    for (HashMap<String, String> map : list) {
		        int price = Integer.parseInt(map.get("pro_price"));
		        int quantity = Integer.parseInt(map.get("cart_su"));
		        totalProductPrice += (price * quantity);
		    }
			
		}
	
		%>
		
	<input type="hidden" name="pro_su" value="<%= pro_su %>">
	<input type="hidden" name="pro_num" value="<%= pro_num %>">
	<input type="hidden" name="pro_size" value="<%= pro_size %>">
	<input type="hidden" name="pro_color" value="<%= pro_color %>">
	
	
	
	
	
	<!-- 수령자 정보   -->
    <div class="ec-base-fold">
    
    <div class="title">
    	<h3>배송지</h3>
    </div>
    
    
	    <div class="contents">
	    	<div class="ec-base-table typeWrite">
		    <table>
		    <colgroup>
			<col style="width: 102px">
			<col style="width: auto">
			</colgroup>
			<tbody>
				<tr>
				<th scope="row">
				        받는사람 <img src="http://img.echosting.cafe24.com/skin/base_ko_KR/order/ico_required.gif" alt="필수">
				</th>
				    <td><input name="receiver_name" class="inputTypeText" size="15" type="text"/></td>
				</tr>
				
				<tr>
				<th scope="row">
				        휴대폰 <img src="http://img.echosting.cafe24.com/skin/base_ko_KR/order/ico_required.gif" alt="필수">
				</th>
				    <td><input name="receiver_hp" class="inputTypeText" size="15" type="text"/></td>
				</tr>
				
				<tr id="ec-receiver-address" class="address_content">
				<th scope="row">주소 <img src="http://img.echosting.cafe24.com/skin/base_ko_KR/order/ico_required.gif" alt="필수"></th>
				    <td>
				        <div class="address_box">
				            <input id="postcode" name="receiver_zipcode" class="inputTypeText" size="6" maxlength="6" readonly type="text"  />                                                        
				            <a href="#none" id="btn_search_rzipcode" onclick="execDaumPostcode()">주소검색</a>
				        </div>
				        <input id="address" name="receiver_addr" class="inputTypeText" size="40" readonly="1" type="text" /> 
				        
				        <input id="detailAddress" name="receiver_address_detail" class="inputTypeText" size="40" type="text" /> 
						
				    </td>
				</tr>
				<tr>
					<th scope="row">
					배송메세지
					</th>
					<td><input name="order_delivery_request" class="inputTypeText" size="15" type="text"/></td>
				</tr>
				
				
		    </tbody>
		    </table>
		    </div>
	    </div>
    
    
	</div>








	<div id="ec-jigsaw-area-payment" class="ec-base-fold eToggle selected">
	    <h3>결제 정보</h3>
		
		<%
		
		// 총 상품금액이 100원 초과일 경우 무료배송
	    if(totalProductPrice > 100){
	    	deliveryFee = 0;
	    }
	    
	    // 최종 결제 금액 계산
		finalPayment = totalProductPrice + deliveryFee;
		
		%>
	
	    <input type="hidden" name="deliveryFee" value="<%= deliveryFee %>">
		<input type="hidden" name="finalPayment" value="<%= finalPayment %>">
		
		
		
		<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
		<div id="ec-jigsaw-area-payment" class="ec-base-fold eToggle selected">
		    <div id="ec-jigsaw-title-payment" class="title">
		        
		    </div>
		    <div class="contents">
		        <div class="segment">
		            <div class="ec-base-table gCellNarrow">
		                <table border="1">
							<colgroup>
								<col style="width:155px">
								<col style="width:auto">
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">주문상품</th>
						        	<td class="right"><span id="total_product_base_price_id" class="price">&#8361;<%= nf.format(totalProductPrice) %></span></td>
						        </tr>
								<tr>
									<th scope="row">배송비</th>
	                        		<td class="right"><span class="price">+<span id="total_ship_price_id">&#8361;<%= deliveryFee %></span></span></td>
	                    		</tr>
								<tr>
									<th scope="row">결제금액</th>
						        	<td class="right"><span id="total_product_base_price_id" class="price">&#8361;<%= nf.format(finalPayment) %></span></td>
	                    		</tr>
							</tbody>
						</table>
					</div>
				</div>	
		    </div>
		</div>
	
	
	
		
		
		
		<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->
		<div id="ec-jigsaw-area-paymethod" class="ec-base-fold eToggle selected">
			<div id="ec-jigsaw-title-paymethod" class="title">
		        <h3>결제수단</h3>
		    </div>
		    <div class="contents">
		    	<div class="segment">
	            	<ul class="payMethod">
	            		<li class="ec-paymethod-newArea selected">
	            			<label for="paymethod-new">결제수단 선택</label>
	            			<div class="inner">
	            				<span class="ec-base-label">
		            				<input onclick="showBankInfo()" id="creditCard" name="payment_method" fw-filter="isFill" fw-label="결제방식" value="credit_card" type="radio" checked="checked"/>
		            				<label for="creditCard" >카드 결제</label>
	            				</span>
	            				<span class="ec-base-label">
		            				<input onclick="showBankInfo()" id="bankTransfer" name="payment_method" fw-filter="isFill" fw-label="결제방식" value="bank_transfer" type="radio"/>
		            				<label for="bankTransfer" >무통장 입금</label>
	            				</span> 
	            			</div>
	            		</li>
	            	</ul>
            	</div>
            	<div id="bankInfo" style="display: none;">
            	<div class="ec-paymethod-input-detail">
            		<div id="payment_input_cash" class="ec-base-table typeWrite">
	                	<table border="1">
		                	<colgroup>
								<col style="width:100px">
								<col style="width:auto">
							</colgroup>
							<tbody>
								<tr>
								<th scope="row">입금은행 <img src="http://img.echosting.cafe24.com/skin/base_ko_KR/order/ico_required.gif" alt="필수"></th>
									<td><select id="bankaccount" name="bankaccount" fw-label="무통장 입금은행" >
										<option value="-1">::: 선택해 주세요. :::</option>
										<option value="카카오뱅크">카카오뱅크 123456789101112 주식회사 모지홈</option>
										</select>
									</td>
								</tr>
								<tr>
								<th scope="row">입금자명 <img src="http://img.echosting.cafe24.com/skin/base_ko_KR/order/ico_required.gif" alt="필수"></th>
							    	<td><input id="pname" name="pname" fw-label="무통장 입금자명" class="inputTypeText" size="15" maxlength="20" type="text"/></td>
								</tr>
							</tbody>
	                	</table>
                	</div>
            	</div>
            	</div>
		    </div>
		</div>
		
		<!-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! -->

	    
	    
	    
	    <!-- !!!!!!!!!!!!!!!!!!!!! -->
	    <div class="ec-base-button gFull" id="orderFixItem">
            <button type="submit" class="btnSubmit" id="btn_payment">&#8361;
                <span id="total_order_sale_price_view"><%= nf.format(finalPayment) %></span> 
                <span class="">결제하기</span>
            </button>
        </div>
</form>
</div>
</div>
</div>
</body>
</html>
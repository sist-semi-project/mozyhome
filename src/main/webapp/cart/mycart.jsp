<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.CartDao"%>
<%@page import="java.text.NumberFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>Insert title here</title>
<style type="text/css">
	.cart_su{
		border-radius: 10px; /* 둥근 정도를 조절할 수 있습니다. */
	    padding: 20px; /* 내용과 경계 사이의 간격을 조절할 수 있습니다. */
		width: 24px;
		height: 18px;
		background: #FF5C00;
		border-radius: 15px;
	}
	
	.cart_select_all{
		width: 15px;
		height: 15px;
		background: #ffffff;
		border-radius: 50%;
		border: 1px solid #000000;
	}
	
	.cart_div{
	
	}
	
	.cart_img{
	width: 124px;
	}
	
	
</style>
</head>

<%

String id=(String)session.getAttribute("mem_id");
System.out.println(id);
CartDao cdao=new CartDao();
List<HashMap<String,String>> list=cdao.getCartList(id);

System.out.println(list);

NumberFormat nf=NumberFormat.getInstance();
%>

<body>
	<!-- 장바구니 header -->
	<div class="cart_div">
		<h5>장바구니</h5>
		<div class="cart_su"></div>
		<hr width="780px" style="height: 0px;
		border: 1px solid #FF5C00;"
		>
	</div>
	
	<!-- 장바구니 list -->
	<div>
		<input class="cart_select_all"  id="cart_select_all"  type="checkbox">
		<hr class="cart_header_hr">
			
	<%
	int totalmoney=0;
	for(int i=0; i<list.size(); i++ )
	{
		HashMap<String,String> map=list.get(i);
		//사진얻기
		String pro_main_img=map.get("pro_main_img");
	%>
		<input type="checkbox" class="cart_select">
		<img class="cart_img" alt="" src="<%=pro_main_img%>">
		<b><%=map.get("pro_name") %></b>
		<b>[옵션:<%=map.get("cart_size") %>]</b>
		<b>[옵션:<%=map.get("cart_color") %>]</b>
		<b><%=map.get("cart_su") %></b>
		<b><%=map.get("pro_price") %></b>
	<%}%>
	
	<span>
		상품금액<span></span>
	</span>
	<span>할인금액</span>
	<span>배송비</span>
	<span>Total</span>
	</div>
	
	<!-- 장바구니 button -->
	<div>
		<button class="buy_btn" id="buy_btn">선택상품 구매</button>
		<button class="all_buy_btn" id="all_buy_btn">전체상품 구매</button>
		<button class="del_btn" id="del_btn">선택삭제</button>
		<button class="all_del_btn" id="all_del_btn">전체삭제</button>
	</div>
</body>
</html>
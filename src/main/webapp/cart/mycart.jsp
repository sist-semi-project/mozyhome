<%@page import="data.dao.ProductDao"%>
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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>Insert title here</title>
<style type="text/css">
.cart_su {
	border-radius: 10px; /* 둥근 정도를 조절할 수 있습니다. */
	padding: 20px; /* 내용과 경계 사이의 간격을 조절할 수 있습니다. */
	width: 24px;
	height: 18px;
	background: #FF5C00;
	border-radius: 15px;
}

.cart_select_all {
	width: 15px;
	height: 15px;
	background: #ffffff;
	border-radius: 50%;
	border: 1px solid #000000;
}

.cart_div {
	
}

.cart_img {
	width: 124px;
}
</style>
</head>

<%
//2024-04-19 추가 
session.setAttribute("directPurchase", false);

//String id=(String)session.getAttribute("mem_id");
String id = "dragon";
System.out.println(id);
CartDao cdao = new CartDao();
List<HashMap<String, String>> list = cdao.getCartList(id);

System.out.println(list);

NumberFormat nf = NumberFormat.getInstance();
%>

<body>
	<!-- 장바구니 header -->
	<div class="cart_div">
		<h5>장바구니</h5>
		<div class="cart_su"></div>
		<hr width="780px" style="height: 0px; border: 1px solid #FF5C00;">
	</div>

	<!-- 장바구니 list -->
	<form action="order/orderForm.jsp" class="cart_process">
		<div>
			<input class="cart_select_all" id="cart_select_all" type="checkbox">
			<hr class="cart_header_hr">
			<%
			int totalmoney = 0;
			for (int i = 0; i < list.size(); i++) {
				HashMap<String, String> map = list.get(i);
				//사진얻기
				String pro_main_img = map.get("pro_main_img");
				int cart_su = Integer.parseInt(map.get("cart_su"));
				int pro_price = Integer.parseInt(map.get("pro_price"));
				int total_price = cart_su * pro_price;
				String pro_num = map.get("pro_num");
				ProductDao pdao = new ProductDao();
				int real_pro_price = pdao.getProPrice(pro_num);
			%>
			<input type="hidden" id="realProPrice<%=i%>" value="<%=real_pro_price%>">
				
			<input type="checkbox" class="cart_select" name=<%=map.get("cart_num")%> value=<%=map.get("cart_num")%>> 
			
			<img class="cart_img" alt="" src="<%=pro_main_img%>"> 
				
			<b><%=map.get("pro_name")%></b>
			
			<b>[옵션:<%=map.get("cart_size")%>]</b> 
			
			<b>[옵션:<%=map.get("cart_color")%>]</b> 
			
			<input type="number" min="1" max="99"
				value="<%=map.get("cart_su")%>" step="1" name="cnt"
				id="quantity<%=i%>" onchange="updateTotalPrice(<%=i%>)">


			<%
			String pro_priceStr = map.get("pro_price");

			pro_price = Integer.parseInt(pro_priceStr);
			%>

			<b id="totalPrice<%=i%>" value="<%=total_price%>">₩<%=nf.format(total_price)%></b>


			<%
			}
			%>
			<span> 상품금액<span></span>
			</span> <span>할인금액</span> <span>배송비</span> <span>Total</span>
		</div>
		<!-- 장바구니 button -->
		<div>
			<button type="submit" class="buy_btn" onclick="buyBtn()"
				class="buy_btn">선택상품 구매</button>
			<button class="all_buy_btn" onclick="allBuyBtn()" class="all_buy_btn">전체상품
				구매</button>
			<button class="del_btn" onclick="delBtn()" class="del_btn">선택삭제</button>
			<button class="all_del_btn" onclick="allDelBtn()" class="all_del_btn">전체삭제</button>
		</div>
	</form>




	<script type="text/javascript">
	
	$(document).ready(function(){
  
		//수량 맞춰서 가격 변경
		 function updateTotalPrice(index) {
	        var quantity = parseInt(document.getElementById("quantity" + index).value);
	        var real_pro_price = parseInt(document.getElementById("realProPrice" + index).value);
	        
	        console.log("Real Unit Price:", real_pro_price);
	        
	        var totalPrice = quantity * real_pro_price;
	        document.getElementById("totalPrice" + index).innerHTML = "₩" + totalPrice.toLocaleString(); // 쉼표 추가하여 가격 표시
	    }
		
		//전체 선택 체크박스
		$(".cart_select_all").click(function(){
			  
			  var chk=$(this).is(":checked");
			  
			  $(".cart_select").prop("checked",chk);
		  });
		
		//선택상품 구매 버튼
		$("buy_btn")
	  
		//전체상품 구매 버튼
		
		//선택삭제 버튼
		
		//전체삭제 버튼
		
	});
	</script>
</body>
</html>
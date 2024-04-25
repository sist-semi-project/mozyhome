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

String id=(String)session.getAttribute("myid");

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
	<form action="index.jsp?main=order/orderForm.jsp" class="cart_process" method="post">
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
			%>
			<div>

				<input type="checkbox" class="cart_select"
					name=<%=map.get("cart_num")%> cart_num="<%=map.get("cart_num")%>">

				<div class="pro_num" pro_num="<%=map.get("pro_num")%>">

					<img class="cart_img" alt="" src="<%=pro_main_img%>"> <b><%=map.get("pro_name")%></b>

					<b>[옵션:<%=map.get("cart_size")%>]
					</b> <b>[옵션:<%=map.get("cart_color")%>]
					</b>

				</div>

				<%
				ProductDao pdao = new ProductDao();
				int real_pro_price = pdao.getProPrice(pro_num);
				%>

				<input type="hidden" id="realProPrice<%=i%>"
					value="<%=real_pro_price%>"> <input type="number" min="1"
					max="99" value="<%=map.get("cart_su")%>" step="1" name="cnt"
					id="quantity<%=i%>" onchange="updateTotalPrice(<%=i%>)">

				<%
				String pro_priceStr = map.get("pro_price");

				pro_price = Integer.parseInt(pro_priceStr);
				%>

				<b id="totalPrice<%=i%>" value="<%=total_price%>">₩<%=nf.format(total_price)%></b>
			</div>
			<%
			}
			%>
			<span> 상품금액<span></span>
			</span> <span>할인금액</span> <span>배송비</span> <span>Total</span>
		</div>
		<!-- 장바구니 button -->
		<div>
			<button type="submit" class="buy_btn"
				class="buy_btn">선택상품 구매</button>
			<button class="all_buy_btn" onclick="allBuyBtn()" class="all_buy_btn"
				type="submit">전체상품 구매</button>
			<button class="del_btn" class="del_btn" type="button">선택삭제</button>
			<button class="all_del_btn" class="all_del_btn" type="button">전체삭제</button>
		</div>
	</form>




	<script type="text/javascript">
//수량 맞춰서 가격 변경
    function updateTotalPrice(index) {
        var quantity = parseInt(document.getElementById("quantity" + index).value);
        var real_pro_price = parseInt(document.getElementById("realProPrice" + index).value);
        
        console.log("Real Unit Price:", real_pro_price);
        
        var totalPrice = quantity * real_pro_price;
        document.getElementById("totalPrice" + index).innerHTML = "₩" + totalPrice.toLocaleString();
    }

//도큐먼트 준비하고 스크립트 적용 함수    
$(document).ready(function(){
	
    //전체 선택 체크박스
    $(".cart_select_all").click(function(){
          var chk=$(this).is(":checked");
          $(".cart_select").prop("checked",chk);
      });

    //상품 클릭시 디테일 페이지로 이동
     $("div.pro_num").click(function(){
      var pro_num=$(this).attr("pro_num");
      location.href="index.jsp?main=product/detailpage.jsp?pro_num="+pro_num;
    });

	
    // 선택 상품 구매 버튼
	$(".buy_btn").click(function(){
		var cart_num_su = []; // 선택된 상품들의 정보를 담을 배열
          
        $(".cart_select:checked").each(function(i, elt){
      	    var cart_num = $(this).attr("cart_num");
    		var cart_su = parseInt(document.getElementById('quantity' + i).value);	
    		cart_num_su.push({
    		        "cart_num": cart_num,
    		        "cart_su": cart_su
			});
			console.log(cart_num_su);

      	});
		buy(cart_num_su);
	});
   
   
    //전체상품 구매 버튼
     $(".all_buy_btn").click(function(){
    	 var cnt=$(".cart_select").length;
    	 
    	  if(cnt==0){
              alert("장바구니에 상품이 없습니다.");
              return;
          };
          
          $(".cart_select").each(function(i, elt){
      	    var cart_num = $(this).attr("cart_num");
			var cart_su = parseInt(document.getElementById('quantity' + i).value);	
			cart_num_su.push({
			        "cart_num": cart_num,
			        "cart_su": cart_su
			    });
      	});
      	    buy(cart_num_su);
    });
    
    
    //선택삭제 버튼
    $(".del_btn").click(function(){
      var cnt=$(".cart_select:checked").length;
      
      if(cnt==0){
          alert("먼저 삭제할 상품을 1개 이상 선택해 주세요");
          return ;
      };
      
      $(".cart_select:checked").each(function(i, elt){
    	    var cart_num = $(this).attr("cart_num");
    	    del(cart_num);
    	});
      
    });
        
    //전체삭제 버튼
     $(".all_del_btn").click(function(){
    	    if(confirm("모든 상품을 삭제하시겠습니까?")){
    	        $(".cart_select").each(function(i, elt){
    	            var cart_num = $(this).attr("cart_num");
    	            del(cart_num);
    	        });
    	    }
    	});
     
    //del 함수
	function del(cart_num)
	{
	 $.ajax({
		  
			  type:"get",
			  url:"cart/cartdelete.jsp",
			  dataType:"html",
			  data:{"cart_num":cart_num},
			  success:function(){
				  
        	    	location.reload();
        	    	
	          }
		  });
	 }
    
	//buy함수
	function buy(cart_num_su)
	{
		console.log({cart_num_su});
	$.ajax({

			  type:"post",
			  url:"index.jsp?main=order/orderForm.jsp",
			  dataType:"json",
			  traditional: true,
			  data: { "cart_num_su": cart_num_su }, // 배열을 JSON 문자열로 변환하여 전송
			  success:function(res){
				  console.log({res});
				  
				  window.location.href = "index.jsp?main=order/orderForm.jsp";
	    	    	
	          }
		  });
	 }
    
});
        


</script>
</body>
</html>
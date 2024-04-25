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
<link rel="stylesheet" href="./review/reviewCss.css">

</head>

<%
//2024-04-19 추가 
session.setAttribute("directPurchase", false);

String id=(String)session.getAttribute("myid");

System.out.println(id);

CartDao cdao = new CartDao();
List<HashMap<String, String>> list = cdao.getCartList(id);
int listSize=list.size();

System.out.println(list);

NumberFormat nf = NumberFormat.getInstance();
%>

<body>

<div id="mycart">
	<!-- 장바구니 header -->
	<div class="cart_div">
		<div class="cart_title">
			<h5 class="cart_title_cart">CART</h5>
			<div class="cart_su"><%=listSize%></div>
		</div>
			<hr style="height: 0px; border: 1px solid #FF5C00;">
	</div>
	<!-- 장바구니 list -->
	<form action="index.jsp?main=order/orderForm.jsp" class="cart_process" method="post">
		<div class="cartListDiv">
		<div class="cartAllChkDiv">
			<input class="cart_select_all" id="cart_select_all" type="checkbox">
			<p>전체선택</p>
		</div>	
			<hr style="height: 0px; border: 1px solid #000000;">
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
			<div class="cartListDiv2">

				<input type="checkbox" class="cart_select"
					name=<%=map.get("cart_num")%> cart_num="<%=map.get("cart_num")%>">

				<div class="pro_num proInfo" pro_num="<%=map.get("pro_num")%>">

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
					id="quantity<%=i%>" onchange="updateTotalPrice(<%=i%>)" class="cartCnt">

				<%
				String pro_priceStr = map.get("pro_price");

				pro_price = Integer.parseInt(pro_priceStr);
				%>

				<b id="totalPrice<%=i%>" value="<%=total_price%>">₩<%=nf.format(total_price)%></b>
				
				</div>
		
				<hr class="cartListHr">
			<%
			}
			%>
			<span> 상품금액<span></span>
			</span> <span>할인금액</span> <span>배송비</span> <span>Total</span>
		</div>
		<!-- 장바구니 button -->
		<div class="cartBtnDiv">
			<button type="button" class="buy_btn cartbtn" onclick="buyBtn()"
				class="buy_btn">선택상품 구매</button>
			<button class="all_buy_btn" onclick="allBuyBtn()" class="all_buy_btn cartbtn"
				type="button">전체상품 구매</button>
			<button class="del_btn" class="del_btn cartbtn" type="button">선택삭제</button>
			<button class="all_del_btn" class="all_del_btn cartbtn" type="button">전체삭제</button>
		</div>
	</form>

</div>


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

	//선택상품 구매 버튼
     $(".buy_btn").click(function() {
    	    var formData = []; // 선택된 상품들의 정보를 담을 배열
    	    
    	    var cnt=$(".cart_select").length;
       	 
    	    // 선택된 상품들의 정보 수집
    	    $(".cart_select:checked").each(function() {
    	        var cart_num = $(this).attr("cart_num");
    	        var cart_su = parseInt($(this).closest("div").find(".quantity").val());
    	        
    	        // Form 데이터로 묶어 배열에 추가
    	        formData.push({
    	            "cart_num": cart_num,
    	            "cart_su": cart_su
    	        });
    	    });
    	    
    	    // Form 데이터를 서버로 전송
    	    $.ajax({
    	        type: "POST",
    	        url: "index.jsp?main=order/orderForm.jsp", // 데이터 처리를 위한 JSP 파일
    	        data: formData, // JSON 데이터가 아닌 Form 데이터를 전송
    	        success: function(response) {
    	            alert("주문이 완료되었습니다.");
    	            // 여기에 추가적인 동작을 구현할 수 있습니다.
    	        },
    	        error: function(xhr, status, error) {
    	            alert("주문 요청에 실패했습니다. 다시 시도해주세요.");
    	            console.error(error);
    	        }
    	    });
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
    
});
        


</script>
</body>
</html>
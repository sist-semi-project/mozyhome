<%@page import="data.dao.WishlistDao"%>
<%@page import="data.dao.CartDao"%>
<%@page import="java.util.List"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="data.dao.MemberDao"%>
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
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="./review/reviewCss.css">
<title>Insert title here</title>
<script type="text/javascript">
</script>
</head>

<%

//2024-04-19 추가 
session.setAttribute("directPurchase", true);

String pro_num = request.getParameter("pro_num");

String loginok = (String) session.getAttribute("loginok");

String mem_id = (String) session.getAttribute("myid");


//아이디에 해당하는 멤버 시퀀스
MemberDao mdao = new MemberDao();
String mem_num = mdao.getNum(mem_id);

//해당상품에대한 데이터
ProductDao pdao = new ProductDao();
ProductDto pdto = pdao.getProduct(pro_num);

NumberFormat nf = NumberFormat.getCurrencyInstance();

//위시리스트 표시
WishlistDao wdao = new WishlistDao();
boolean existwish = wdao.checkWishlist(mem_num, pro_num);
%>


<div id="detailpage">
	<form action="index.jsp?main=order/orderForm.jsp" id="form1" method="post">
		<div id="detailpagediv">

		<!-- cart 데이터에 넣을 mem_num, pro_num -->
		<input type="hidden" name="mem_num" value="<%=mem_num%>"> <input
			type="hidden" name="pro_num" value="<%=pro_num%>">

		<!-- 상품이미지 -->
		<div class="imgdiv">
			<div class="mainimgdiv">
				<img class="imgmain" alt="" src="<%=pdto.getPro_main_img()%>">
			</div>
	
			<div class="subimgdiv">
				<img class="subimg" alt="" src="<%=pdto.getPro_sub_img1()%>"> <img
					class="subimg" alt="" src="<%=pdto.getPro_sub_img2()%>"> <img
					class="subimg" alt="" src="<%=pdto.getPro_sub_img3()%>"> <img
					class="subimg" alt="" src="<%=pdto.getPro_sub_img4()%>">
			</div>
		</div>
		
		
		<!-- 상품정보 -->
		<div class="info_and_btn_div">
			<div class="infodiv">
				<h4><%=pdto.getPro_name()%></h4>
				<h4><%=nf.format(pdto.getPro_price())%></h4>
				<h4>
					<label>price</label>
					<%=pdto.getPro_price()%></h4>
				<h4>
					Quantity<input type="number" min="1" max="99" value="1" step="1"
						name="cnt" id="quantity" onchange="updateTotalPrice()">
				</h4>
	
				<!-- 사이즈 선택 옵션 -->
				<%
				String sizeCheck = pdto.getPro_size();
				if (sizeCheck != null) {
				%>
				<h4>
					<label>Color</label> <select style="width: 300px;" name="size">
						<option value="option1" selected="selected" value="1">-[필수]옵션을
							선택해 주세요-</option>
						<%
						String getSize = pdto.getPro_size();
						String[] size = getSize.split(",");
						for (int i = 0; i < size.length; i++) {
						%>
						<option value="<%=size[i]%>"><%=size[i]%></option>
						<%
						}
						}
						%>
					</select>
				</h4>
	
				<!-- 색깔 선택 옵션 -->
				<%
				String colorCheck = pdto.getPro_color();
				if (colorCheck != null) {
				%>
				<h4>
					<label>Size</label> <select style="width: 300px;" name="color">
						<option value="option2" selected="selected" value="1">-[필수]옵션을
							선택해 주세요-</option>
						<%
						String getColor = pdto.getPro_color();
						String[] color = getColor.split(",");
						for (int i = 0; i < color.length; i++) {
						%>
						<option value="<%=color[i]%>"><%=color[i]%></option>
						<%
						}
						}
						%>
					</select>
				</h4>
	
				<!-- 구분 선 -->
				<hr>
	
				<!-- total 비용 -->
				<h4 id="totalPrice">
					총 상품금액
					<%=nf.format(pdto.getPro_price())%></h4>
	
				<script type="text/javascript">
					function updateTotalPrice(){
						var quantity = parseInt(document.getElementById("quantity").value);
						var unitPrice = <%=pdto.getPro_price()%>;
						var totalPrice = quantity * unitPrice;
						document.getElementById("totalPrice").innerHTML = "총 상품금액(수량)"+totalPrice;
						}
				</script>
			</div>
	
			<!-- 장바구니, 위시리스트, buy now 버튼 -->
	
			<div class="btndiv">
			<div class="heartCartBuy">
				<button name="heart" class="heart" id="heart" type="button">
					<%
					if (existwish == true) {
					%>
					<i class="bi bi-suit-heart-fill"
						style="font-size: 25px; color: #FF5C00;"></i>
					<%
					} else {
					%>
					<i class="bi bi-suit-heart" style="font-size: 25px; color: #FF5C00;"></i>
					<%
					}
					%>
				</button>
	
				<button name="cart" class="cart" type="button">
					<i class="bi bi-cart" style="font-size: 25px;"></i>
				</button>
	
				<!-- 구매버튼 판매, 단종, 재입고 옵션마다 다르게 -->
				<%
				String pro_status = pdto.getPro_sale_status();
				if (pro_status.equals("판매중")) {
				%>
				<button type="submit" name="buynow" class="buynow">BUY NOW</button>
				<%
				} else if (pro_status.equals("품절")) {
				%>
				<button name="no_buynow" class="no_buynow" disabled>품절</button>
				<%
				} else if (pro_status.equals("단종")) {
				%>
				<button name="soldout" class="soldout" disabled>판매가 중지된
					제품입니다</button>
				<%
				}
				%>
				</div>
				<div>
				<button class="infobtn" type="button">DESCRIPTION</button>
				<div class="description" style="display: none;"><%=pdto.getPro_explain()%></div>
				<br>
				<button class="infobtn" type="button">PRODUCT DETAIL</button>
				<div class="description" style="display: none;"><%=pdto.getPro_explain()%></div>
				<br>
				<button class="infobtn" type="button">SHOPPING GUIDE</button>
				<div class="description" style="display: none;"><%=pdto.getPro_explain()%></div>
				<br>
				</div>
			</div>
			</div>
		
	</form>
	</div>
</div>

	<hr>
	<div>
		<% session.setAttribute("pro_num", pro_num); %>
		<jsp:include page="../review/reviewList.jsp"></jsp:include>
	</div>
	



	<!-- 장바구니 버튼 함수-->
	<script type="text/javascript">
	$(document).ready(function() {
		
    $(".cart").click(function(){
    	var login="<%=loginok%>";

			if (login == "null") {
				alert("먼저 로그인을 해주세요");
				return;
			}

			
			//장바구니에 같은 옵션있으면 '장바구니에 이미 담겨져 있습니다' alert 띄우기
			<%CartDao cdao = new CartDao();
			cdao.overlapProDel(pro_num);%>
			
				//옵션 선택 안하고 장바구니 넣을때
				var pro_color = $('select[name="color"]').val();
				    
				var pro_size = $('select[name="size"]').val();
				
				if(pro_size=="option1"||pro_color=="option2")
					{
					alert("옵션을 선택해주세요");
					return;
					}
					
			//form태그 가져오기
			var cartdata = $("#form1").serialize();
			//alert(cartdata);

			//insert
			$.ajax({
				type : "post",
				dataType : "html",
				data : cartdata,
				url : "index.jsp?main=product/detailprocess.jsp",
				success : function() {

					var a = confirm("장바구니에 저장하였습니다\n장바구니로 이동하려면 [확인]을 눌러주세요");

					if (a) {
						location.href = "index.jsp?main=cart/mycart.jsp";
					}
				}
			});
		});
    
    
		//BUY NOW 버튼 함수
	  $(".buynow").click(function(){
    	var login="<%=loginok%>";

			if (login == "null") {
				alert("먼저 로그인을 해주세요");
				return;
			}
			
			//옵션 선택 안하고 장바구니 넣을때
			var pro_color = $('select[name="color"]').val();
			    
			var pro_size = $('select[name="size"]').val();
			
			if(pro_size=="option1"||pro_color=="option2")
				{
				alert("옵션을 선택해주세요");
				return false;
				}
		return true;
	});
			
		//상품 상세설명 버튼 3개
	    $(".infobtn").click(function() {
	        // 버튼이 속한 부모 요소에서 다음에 오는 div를 찾아서 토글
	        $(this).next("div.description").slideToggle();
	    });
		

		//위시리스트 버튼 함수
	    $("#heart").click(function() {
	        var login = "<%=loginok%>";

	        if (login == "null") {
	            alert("먼저 로그인을 해주세요");
	            window.location.href = "loginMain.jsp";
	            return;
	        }

	        var existwish = <%=existwish%>;

	        var pro_num = <%=pro_num%>;
	        var mem_num = "<%=mem_num%>";

	        $.ajax({
	            type: "post",
	            dataType: "json",
	            data: { pro_num: pro_num, mem_num: mem_num },
	            url: "product/wishProccess.jsp",
	            success: function(res) {
	                console.log({ res });

	                if (res.status) {
	                    $("#heart").html('<i class="bi bi-suit-heart-fill" style="font-size: 25px; color: #FF5C00;"></i>');
	                } else {
	                    $("#heart").html('<i class="bi bi-suit-heart" style="font-size: 25px; color: #FF5C00;"></i>');
	                }
	            },
	            error: function(xhr, status, error) {
	                console.error("AJAX 오류: ", error);
	                alert("AJAX 오류 발생. 콘솔을 확인하세요.");
	            }
	        });
	    });
		
	});
	</script>

</body>
</html>
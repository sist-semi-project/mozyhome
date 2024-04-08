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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>Insert title here</title>
<style type="text/css">
.imgdiv {
	position: absolute;
	width: 577px;
	height: 577px;
	left: 363px;
	top: 120px;
	background: #D9D9D9;
	
}

.imgdiv .imgsub {
	position: relative;
	margin-top: 24px;
	width: 124px;
	height: 124px; 
	background : #D9D9D9;
	float: left;
	margin-right: 24px;
	background: #D9D9D9;
}

.imgdiv .imgmain{
	width: 577px;
	height: 577px;
}

.btndiv{
	position: absolute;
	left: 1020px; 
	top: 613px; 
	width: 600px;
	height: 84px;

}

.btndiv .heart, .btndiv .cart{
	position: relative;
	box-sizing: border-box; 
	width: 84px; 
	height: 84px; 
	border: 1px solid #000000;
	background-color: #ffffff;
	margin-right: 24px;
}

.btndiv .buynow{
	position: relative;
	box-sizing: border-box; 
	
	width: 336px; 
	height: 84px; 
	line-height: 84px;
	font-size: 20px;
	background-color: #FF5C00;
	color: #ffffff;
	margin-right: 24px;
	border: none;
}

.infodiv{
	position: absolute;
	left: 1020px;
	top: 120px;
	width: 550px;
	height: 458px;
}

hr{
	height: 1px;
	background-color: #000000;
	border: none;
}

.infobtn{
 	background: none;
    border: none;
    cursor: pointer;
    font-size: inherit;
    text-decoration: none;
    padding: 0; 
    margin: 0;
}
</style>
<script type="text/javascript">
</script>
</head>

<%
   String pro_num=request.getParameter("pro_num");
   String loginok=(String)session.getAttribute("loginok");
   String mem_id=(String)session.getAttribute("mem_id");
   //아이디에 해당하는 멤버 시퀀스
   MemberDao mdao=new MemberDao();
   String num=mdao.getNum(mem_id);
   
   //해당상품에대한 데이타
   ProductDao pdao=new ProductDao();
   ProductDto dto=pdao.getAllProduct(pro_num);
   
   NumberFormat nf=NumberFormat.getCurrencyInstance();
%>

<body>
<form action=""  id="form1">

		<!-- 상품이미지 -->
		<div class="imgdiv">
			<img class="imgmain" alt="" src="/mozyhome/image/sofa/greensofa1.jpg">

			<img class="imgsub" alt="" src="/mozyhome/image/sofa/greensofa2.jpg" onclick="" >
			<img class="imgsub" alt="" src="/mozyhome/image/sofa/greensofa3.jpg">
			<img class="imgsub" alt="" src="/mozyhome/image/sofa/greensofa4.jpg">
		</div>
		
		<!-- 상품정보 -->
		<div class="infodiv">
			<h4><%=dto.getPro_name() %></h4>
			<h4><%=nf.format(dto.getPro_price())%></h4>
			<h4>price <%=dto.getPro_price() %></h4>
			<h4>Quantity<input type="number" min="1" max="99" value="1"
			step="1" name="cnt" id="quantity" onchange="updateTotalPrice()">  </h4>
			<h4>사이즈
			 	<select style="width: 300px;" >
					<option value="option1" selected="selected">-[필수]옵션을 선택해 주세요-</option>
					<option value="option2"></option>
					<option value="option3"></option>			
				</select>
			</h4>
			
			<hr>
			
		<!-- total 비용 -->	
		<h4 id="totalPrice">총 상품금액 <%=nf.format(dto.getPro_price()) %></h4>
			
		<script type="text/javascript">
			function updateTotalPrice(){
				var quantity = parseInt(document.getElementById("quantity").value);
				var unitPrice = <%=dto.getPro_price()%>;
				var totalPrice = quantity * unitPrice;
				document.getElementById("totalPrice").innerHTML = "총 상품금액(수량)"+totalPrice;
			}
		</script>
			
	
		
		</div>
		
		<!-- 장바구니, 위시리스트, buynow 버튼 -->
		<div class="btndiv">
		
			<button name="heart" class="heart">
				<i class="bi bi-suit-heart-fill" style="font-size: 25px; color: #FF5C00;"></i>
			</button>
			
			<button name="cart" class="cart">
				<i class="bi bi-cart" style="font-size: 25px;"></i>
			</button>
			
			<button name="buynow" class="buynow">
				BUY NOW
			</button>
			
			<button class="infobtn">DESCRIPTION</button> 
			<div><%=dto.getPro_explain() %></div> <br>
			<button class="infobtn">PRODUCT DETAIL</button> 
			<div><%=dto.getPro_explain() %></div> <br>
			<button class="infobtn">SHOPPING GUIDE</button>
			<div><%=dto.getPro_explain() %></div> <br>
		</div>
	</form>
	
	<!-- 장바구니 -->
	 <script type="text/javascript">
    $("#cart").click(function(){
    	var login="<%=loginok%>";
    	
    	if(login=="null"){
    		alert("먼저 로그인을 해주세요");
    		return;
    	}
    	
    	
    	//form태그 가져오기
    	var cartdata=$("#form1").serialize();
    	//alert(cartdata);
    	
    	//insert
    	$.ajax({
    		type:"post",
    		dataType:"html",
    		data:cartdata,
    		url:"product/detailprocess.jsp",
    		success:function(){
    			
    			//alert("success");
    			
    			var a=confirm("장바구니에 저장하였습니다\n장바구니로 이동하려면 [확인]을 눌러주세요");
    			
    			if(a){
    				location.href="index.jsp?main=product/mycart.jsp";
    			}
    		}
    	})
    })
    
    $(".infobtn").click(function(){
    	
    	
    })
    
    </script>
	
</body>
</html>
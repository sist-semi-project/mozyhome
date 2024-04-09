<%@page import="java.text.DecimalFormat"%>
<%@page import="data.dto.WishlistDto"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ProductDao"%>
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

<title>상품리스트</title>
<style type="text/css">
	body{
	 	font-family: "Noto Sans KR";
	}
	
	.goDetail{
		text-decoration: none;
		color:black;
	}
</style>

<script type="text/javascript">
	$(function(){
		$("a.goDetail").click(function(){
			var pronum=$(this).attr("pronum");
			alert(pronum);
			
			// 디테일 페이지로 이동
			//location.href="index.jsp?main=product/상품상세.jsp?pronum="+pronum;
		});
		
	});
</script>
</head>
<%
	String cate_num=request.getParameter("cate_num");

	ProductDao pdao=new ProductDao();
	List<ProductDto> list=pdao.getAllProduct(cate_num);

	NumberFormat nf=new DecimalFormat("#,###.##원");
%>
<body>
<div style="margin-top:110px;">
	가구>테이블>테스트
	
</div>
<div style="margin: 100px 100px;">
	<table style="width:800px;">
		<tr>
		<%
			int line=0;
			for(ProductDto pdto:list){%>
				<td style="padding-left: 15px; padding-bottom: 60px;">
					<a pronum="<%=pdto.getPro_num()%>" style="cursor: pointer;" class="goDetail">
						<img src="<%=pdto.getPro_main_img()%>" style="width:340px;">
						<font><%=pdto.getPro_name() %></font> <br>
						<font><%=nf.format(pdto.getPro_price()) %></font> <br>
						<div style="color:#aaa;">
							<i class="bi bi-heart"></i> <%=pdto.getWishCount() %>
							<i class="bi bi-chat-left" style="margin-left:15px;"></i> <%=pdto.getReviewCount()%>
						</div>
						
					</a>
					
				</td>
				<%
					// 한 줄에 출력되는 상품 개수 설정
					if((line+1)%4==0){%>
						</tr><tr>
					<%}
					line++;
				%>
			<%}
		%>
		</tr>
	
		
	</table>
</div>

</body>
</html>
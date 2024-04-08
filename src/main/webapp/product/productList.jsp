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
</head>
<%
	String cate_num=request.getParameter("cate_num");

	ProductDao pdao=new ProductDao();
	List<ProductDto> list=pdao.getAllProduct(cate_num);
	
	NumberFormat nf=NumberFormat.getCurrencyInstance();
%>
<body>
<div>
	<%= %>
	<table style="width:800px;">
		<tr>
		<%
			int line=0;
			for(ProductDto pdto:list){%>
				<td>
					<img src="../image/productSave/<%=pdto.getPro_main_img()%>" style="width:340px;">
					<font><%=pdto.getPro_name() %></font>
					<font><%=nf.format(pdto.getPro_price()) %></font> <br>
					<!-- 위시리스트, 리뷰 카운트 나중에 추가 0408 -->
					<i class="bi bi-heart"></i> 
					<i class="bi bi-chat-left"></i>
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
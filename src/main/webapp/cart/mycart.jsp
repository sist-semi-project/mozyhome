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

</head>
<%
String id=(String)session.getAttribute("myid");
CartDao cdao=new CartDao();
List<HashMap<String,String>> list=cdao.getCartList(id);
NumberFormat nf=NumberFormat.getInstance();
%>
<body>
	<!-- 장바구니 header -->
	<div>
		<h5>장바구니</h5>
		<hr width="500px">
	</div>
	
	<label></label>
	<!-- 장바구니 button -->
	<div>
		<button class="btn1" id="btn1">선택상품 구매</button>
		<button class="btn2" id="btn2">전체상품 구매</button>
		<button class="btn3" id="btn3">선택삭제</button>
		<button class="btn4" id="btn4">전체삭제</button>
	</div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<<<<<<< HEAD

=======
>>>>>>> master
<link
	href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<<<<<<< HEAD
<title>Insert title here</title>
<link rel="stylesheet" href="./header/header.css"/>
=======
<link rel="stylesheet" href="../header/header.css"/>
<title>mozyhome</title>
<style type="text/css">
	div.title{
		width:100%;
		font-size: 20px;
		font-family: 'Noto Sans KR';
		text-align: center;
		text-decoration: none;
		color: black;
	}
	
	div.main{
		font-size: 14pt;
		font-family: 'Noto Sans KR';
		border: 0px groove purple;
		text-decoration: none;
		color:black;
	}
	
	div.footer{
	
	}

</style>
>>>>>>> master

</head>

<%
	String main = "/layout/main.jsp";
	
	if (request.getParameter("main") != null) {
		main = request.getParameter("main");
	}
%>
<body>
<<<<<<< HEAD
	<div class="menu">
=======
	<div class="layout title">
>>>>>>> master
		<jsp:include page="header/header3.jsp"></jsp:include>
	</div>
	<div class="layout main">
		<jsp:include page="<%=main %>"></jsp:include>
	</div>
<<<<<<< HEAD
	<div class="">
=======
	<div class="layout footer">
>>>>>>> master
		<jsp:include page="layout/footer.jsp"></jsp:include>
	</div>
</body>
</html>
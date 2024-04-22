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
<link rel="stylesheet" href="../header/header.css"/>
<title>mozyhome</title>
<style type="text/css">
	div.title{
		width:100%;
		height:50px;
		line-height:80px;
		font-size: 20px;
		font-family: 'Noto Sans KR';
		text-align: center;
		top:90px;
	}
	
	div.main{
		height:2000px;
		font-size: 14pt;
		font-family: 'Noto Sans KR';
		border: 0px groove purple;
	}
	
	div.footer{
	
	}

</style>

</head>
<body>

<%
	String main = "/layout/main.jsp";
	
	if (request.getParameter("main") != null) {
		main = request.getParameter("main");
	}
%>
<body>
	<div class="layout title">
		<jsp:include page="header/header3.jsp"></jsp:include>
	</div>
	<div class="layout main">
		<jsp:include page="<%=main%>"></jsp:include>
	</div>
	<div class="layout footer">
		<jsp:include page="layout/footer.jsp"></jsp:include>
	</div>
</body>
</html>
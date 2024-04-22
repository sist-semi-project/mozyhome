<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link
	href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>Insert title here</title>
<link rel="stylesheet" href="./header/header.css"/>

</head>
<body>

<%
String main = "/layout/main.jsp";

if (request.getParameter("main") != null) {
	main = request.getParameter("main");
}
%>
<body>
	<div class="menu">
		<jsp:include page="header/header3.jsp"></jsp:include>
	</div>
	<div class="main">
		<jsp:include page="<%=main%>"></jsp:include>
	</div>
	<div class="">
		<jsp:include page="layout/footer.jsp"></jsp:include>
	</div>
</body>
</html>
<%@page import="data.dao.MemberDao"%>
<%@page import="data.dto.OrderDto"%>
<%@page import="data.dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>주문완료</title>
</head>
<body>
<%
String mem_id = (String) session.getAttribute("mem_id"); 

//MemberDao 인스턴스 생성
MemberDao memberDao = new MemberDao();

String memName = memberDao.getName(mem_id);
System.out.println(memName);

String orderNumber = request.getParameter("orderNumber");
OrderDao dao=new OrderDao();
OrderDto dto=dao.getOneData(orderNumber);
%>
<h2><%=memName %>님의 주문이 완료되었습니다.</h2>

<p>주문 번호: <%=dto.getOrder_num() %></p>
<p>결제금액: <%=dto.getOrder_total_payment() %></p>
<p>받는 사람: <%=dto.getOrder_name() %></p>
<p>주소: <%=dto.getOrder_addr() %></p>
<p>연락처: <%=dto.getOrder_hp() %></p>
<p>배송요청: <%=dto.getOrder_delivery_request() %></p>
</body>
</html>
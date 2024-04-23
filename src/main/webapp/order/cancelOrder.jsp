<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="data.dao.OrderDao"%>

<%
    String orderNumber = request.getParameter("orderNumber");
    OrderDao orderDao = new OrderDao();
    boolean success = orderDao.updateOrderStatus(orderNumber, "취소신청");
%>

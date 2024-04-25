<%@page import="data.dao.CartDao"%>
<%@page import="data.dao.WishlistDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String cart_num=request.getParameter("cart_num");
System.out.println(cart_num);
CartDao dao=new CartDao();
dao.deleteCartNum(cart_num);
%>
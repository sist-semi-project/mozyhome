<%@page import="data.dao.CartDao"%>
<%@page import="data.dto.CartDto"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("utf-8");
	
	String size=request.getParameter("size");
	String shopnum=request.getParameter("shopnum");
	String num=request.getParameter("num");
	int cnt= Integer.parseInt(request.getParameter("cnt"));
   
	CartDao dao=new CartDao();
	CartDto dto=new CartDto();
   
	dao.insertCart(dto);
%>

<%@page import="data.dto.MemberDto"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="data.dao.CartDao"%>
<%@page import="data.dto.CartDto"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("utf-8");
	
	String cart_size=request.getParameter("size");
	String cart_color=request.getParameter("color");
	int pro_num=Integer.parseInt(request.getParameter("pro_num"));
	int mem_num=Integer.parseInt(request.getParameter("mem_num"));
	int cnt= Integer.parseInt(request.getParameter("cnt"));
	
	CartDao cdao=new CartDao();
	CartDto cdto=new CartDto();
	
	cdto.setCart_size(cart_size);
	cdto.setCart_color(cart_color);
	cdto.setPro_num(pro_num);
	cdto.setMem_num(mem_num);
	cdto.setCart_su(cnt);
   
	cdao.insertCart(cdto);
%>

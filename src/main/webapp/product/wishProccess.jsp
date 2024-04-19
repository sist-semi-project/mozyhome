<%@page import="data.dao.WishlistDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("utf-8");
	
	String  existwish = request.getParameter("existwish");
	String  pro_num = request.getParameter("pro_num");
	String  mem_num = request.getParameter("mem_num");
		WishlistDao wdao=new WishlistDao();
	if("true".equals(existwish))
	{
		wdao.deleteWishlist2(pro_num, mem_num);
	}
	else if("false".equals(existwish))
	{
		wdao.insertWishlist(mem_num, pro_num);
	}
			
%>
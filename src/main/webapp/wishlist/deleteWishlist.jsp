<%@page import="data.dao.WishlistDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
	WishlistDao wdao=new WishlistDao();
	String ditems=request.getParameter("ditems");

	String []ditem=ditems.split(",");
	
	for(String wish_num:ditem){
		wdao.deleteWishlist(wish_num);
	}
%>
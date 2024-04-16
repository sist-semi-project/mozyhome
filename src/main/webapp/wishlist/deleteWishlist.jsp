<%@page import="data.dao.wishlistDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%
	wishlistDao wdao=new wishlistDao();
	String ditems=request.getParameter("ditem");

	String []ditem=ditems.split(",");
	//System.out.println(ditem);
	
	for(String wish_num:ditem){
		wdao.deleteWishlist(wish_num);
	}	
%>
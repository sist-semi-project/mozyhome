<%@page import="org.json.simple.JSONObject"%>
<%@page import="data.dao.WishlistDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("utf-8");
	

	String  pro_num = request.getParameter("pro_num");
	String  mem_num = request.getParameter("mem_num");
		WishlistDao wdao=new WishlistDao();
		boolean flag =  wdao.checkWishlist(mem_num, pro_num);
		
		JSONObject ob  = new JSONObject();
		
	if(flag)
	{
		wdao.deleteWishlist2(pro_num, mem_num);
		ob.put("status",false);
	}
	else
	{
		wdao.insertWishlist(mem_num, pro_num);
		ob.put("status",true);
	}
	
	
response.setContentType("application/json");
response.setCharacterEncoding("UTF-8");
response.getWriter().write(ob.toString());
%>
<%@page import="data.dao.memberDao"%>
<%@page import="org.json.simple.JSONObject"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("mem_id");
memberDao dao = new memberDao();
  int count = dao.idCheck(id);

JSONObject ob = new JSONObject();
  ob.put("count",count);
%>
<%=ob.toString()%>

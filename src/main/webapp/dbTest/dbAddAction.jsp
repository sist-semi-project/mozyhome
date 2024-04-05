<%@page import="data.dto.dbTestDto"%>
<%@page import="data.dao.dbTestDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	request.setCharacterEncoding("utf-8");

	String content=request.getParameter("content");

	dbTestDto dto=new dbTestDto();
	dto.setContent(content);
	
	dbTestDao dao=new dbTestDao();
	dao.insertDbTest(dto);
	
	response.sendRedirect("../dbTest/dbAddForm.jsp");
	

%>
<body>

</body>
</html>
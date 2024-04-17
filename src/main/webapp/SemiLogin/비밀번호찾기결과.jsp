<%@page import="data.dao.memberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<%
 request.setCharacterEncoding("UTF-8");
	String name = request.getParameter("mem_name");
    String id = request.getParameter("mem_id");     
    String email = request.getParameter("mem_email");
     
memberDao dao = new memberDao();
 String pass = dao.findPw(name,id,email); //비밀번호를 디비에서 가져옴..실패시 널
 
%>
<body>
<form name="idsearch" method="post">
      <%
       if (pass != null) {
      %>
      
      <div class = "container">
      	<div class = "found-success">
	      <h4>회원님의 비밀번호는 </h4>  
	      <div class ="found-id"> <%=pass%></div>
	      <h4>  입니다 </h4>
	     </div>
	     <div class = "found-login">
 		    <input type="button" id="btnLogin" value="로그인" onClick ="location.href='로그인.jsp'"/>
       	</div>
       </div>
      <%
  } else {
 %>
        <div class = "container">
      	<div class = "found-fail">
	      <h4>  등록된 정보가 없습니다 </h4>  
	     </div>
	     <div class = "found-login">
 		    <input type="button" id="btnback" value="다시 찾기" onClick="history.back()"/>
 		    <input type="button" id="btnjoin" value="회원가입" onClick="joinin()"/>
       	</div>
       </div>
       
<div class = "adcontainer">
	<a href="#" ><img src = "../images/casead.png" /></a>                
</div>
       
       <%
  }
 %> 
      </form>
</body>
</html>
<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f2f2f2;
    margin: 0;
    padding: 0;
    box-sizing: border-box;
  }
  
  .container {
    max-width: 500px;
    margin: 50px auto;
    background-color: #fff;
    border-radius: 5px;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }
  
 h2 {
    text-align: center;
    font-size: 24px;
    font-weight: 700;
    letter-spacing: 5px;
    color: #222;
}
  
  .found-success, .found-fail {
    text-align: center;
    margin-bottom: 20px;
  }
  
  .found-id {
    font-size: 24px;
    font-weight: bold;
    color: #007bff;
    margin-top: 10px;
  }
  
  .found-login {
    text-align: center;
  }
  
  .found-login input[type="button"] {
	background-color: #FF5C00;
    color: #fff;
    border: 1px solid;
    padding: 10px 20px;
    border-radius: 5px;
    cursor: pointer;
    margin-right: 10px;
  }
  
  .found-login input[type="button"]:hover {
  	border: 1px solid;
    background-color:  #fff;
    border-color: #FF5C00;
    color: #FF5C00;
  }
  
</style>
</head>
<%
request.setCharacterEncoding("utf-8");

     String name = request.getParameter("mem_name");
     String email = request.getParameter("mem_email");
     
     MemberDao dao = new MemberDao();
 	String mem_id = dao.findId(name, email); //아이디를 디비에서 가져옴..실패시 널
 	
 	System.out.println(name);
 	System.out.println(email);
 
%>
<body>
 <form name="idsearch" method="post">
 <div class = "container">
 <h2>MOZYHOME</h2>
      <%
       if (mem_id != null) {
      %>
      
      	<div class = "found-success">
	      <h4>  회원님의 아이디는 </h4>  
	      <div class ="found-id"><%=mem_id%></div>
	      <h4>  입니다 </h4>
	     </div>
	     <div class = "found-login">
 		    <input type="button" id="btnLogin" value="로그인" onClick="location.href='index.jsp?main=SemiLogin/Login.jsp'"/>
       	</div>
       </div>
      <%
  } else {
 %>
        <div class = "container">
      	<div class = "found-fail">
	      <h4>  등록된 정보가 없습니다 </h4>  
	     </div>
       </div>
       <div class = "found-login">
 		    <input type="button" id="btnback" value="다시 찾기" onClick="history.back()"/>
 		    <input type="button" id="btnjoin" value="회원가입" onClick="location.href='index.jsp?main=SemiLogin/RegisterMain.jsp'"/>
       	</div> 
       <%
  }
 %> 
      </form>

</body>
</html>
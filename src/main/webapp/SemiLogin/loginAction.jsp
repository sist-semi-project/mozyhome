<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>Insert title here</title>
</head>
<body>
<%
  String id=request.getParameter("mem_id");
  String pass=request.getParameter("mem_password");
  String cbsave=request.getParameter("cbsave");  //체크안하면 null

  MemberDao dao=new MemberDao();
  boolean b=dao.isIdPass(id, pass);

  
  //아이디비번 맞으면 세션3개저장  로그인메인
  if(b){
	  session.setMaxInactiveInterval(60*60*8); //8시간..생략시 30분
	  
	  session.setAttribute("loginok", "yes");
	  session.setAttribute("myid", id);
	  
	  String userName = (String) session.getAttribute("myid");
	  
	  %>
	  <script type="text/javascript">
	// 페이지가 로드될 때 실행되는 함수
	window.onload = function() {
	    var loginLink = document.querySelector('.header__nav-top-level-link[data-name="Login"]');
	    if (loginLink) {
	        loginLink.textContent = 'Logout';
	        // 클래스를 변경합니다.
	        loginLink.classList.remove('layout-statelogoff');
	        loginLink.classList.add('layout-statelogon');
	        // 로그인 페이지 링크를 로그아웃 처리할 수 있도록 변경합니다.
	        loginLink.setAttribute('data-name', 'Logout');
	        loginLink.href = 'index.jsp?main=SemiLogin/Logout.jsp';
	        
	        alert("<%= userName %>님 환영합니다!");
            // 사용자를 index.jsp 페이지로 리다이렉트합니다.
            window.location.href = './index.jsp';
	    }
	};
	</script>
	  <%
	  response.sendRedirect("../index.jsp?main=SemiLogin/loginMain.jsp");
  }else{
	  %>
	  <script type="text/javascript">
	    alert("아이디 또는 비번이 맞지않습니다");
	    history.back();
	  </script>
  <%}
%>
</body>
</html>
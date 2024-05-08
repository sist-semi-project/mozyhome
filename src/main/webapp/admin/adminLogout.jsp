<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-05-03
  Time: 오전 1:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // 현재 세션을 가져옵니다.
    HttpSession session2 = request.getSession(false);
//    HttpSession session = request.getSession(false); // false: 새 세션을 생성하지 않음
    if (session2 != null) {
        session.invalidate(); // 세션 무효화
    }

    response.sendRedirect("/admin/adminLogin.jsp"); // 로그인 페이지로 리다이렉션
%>

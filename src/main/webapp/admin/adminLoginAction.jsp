<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="javax.servlet.*,javax.servlet.http.*"%>
<%
    // 관리자 계정 정보
    String adminId = "admin";
    String adminPassword = "qwer1234";

    // 입력된 아이디와 비밀번호 가져오기
    String inputAdminId = request.getParameter("admin_id");
    String inputAdminPassword = request.getParameter("admin_password");

    // 입력된 아이디와 비밀번호가 관리자 계정과 일치하는지 확인
    if (adminId.equals(inputAdminId) && adminPassword.equals(inputAdminPassword)) {
        // 아이디와 비밀번호가 일치하면 대시보드 페이지로 이동
        response.sendRedirect("dashboard.jsp");
    } else { %>

<script type="text/javascript">
    alert("정보가 일치하지않습니다.");
    // 아이디 또는 비밀번호가 일치하지 않을 경우, 로그인 페이지로 다시 이동 또는 에러 메시지 출력
    // 예시: response.sendRedirect("adminLogin.jsp?error=1");
</script>
<%}
%>

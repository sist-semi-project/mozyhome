<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 삭제 처리</title>
</head>
<body>
<%
// 회원 삭제를 위해 DAO 호출
MemberDao dao = new MemberDao();
String mem_id=request.getParameter("myid");
boolean success = dao.deleteMember(mem_id); // 회원 삭제 메서드 호출

if(success) {
    // 회원 삭제에 성공한 경우
    out.print("회원 삭제 성공");
} else {
    // 회원 삭제에 실패한 경우
    out.print("회원 삭제 실패");
}
%>
</body>
</html>

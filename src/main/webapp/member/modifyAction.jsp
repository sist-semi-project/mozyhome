<%@page import="data.dto.MemberDto"%>
<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
request.setCharacterEncoding("utf-8");
//클라이언트로부터 전달받은 회원 정보 가져오기
String memberId = request.getParameter("member_id");
String password = request.getParameter("passwd");
String name = request.getParameter("name");
String nickname = request.getParameter("nickname");
String zipcode = request.getParameter("zipcode");
String address = request.getParameter("address");
String detailAddress = request.getParameter("detail_address");
String hp = request.getParameter("hp");

//수정할 회원 정보 객체 생성
MemberDto member = new MemberDto();
member.setMem_id(memberId);
member.setMem_password(password);
member.setMem_name(name);
member.setMem_nickname(nickname);
member.setMem_zipcode(zipcode);
member.setMem_address(address);
member.setMem_address_detail(detailAddress);
member.setMem_hp(hp);

//회원 정보 수정을 위해 DAO 호출
MemberDao dao = new MemberDao();
boolean success = dao.updateMember(member);


if(success) {
    // 회원 정보 수정에 성공한 경우
    out.print("회원정보 수정 성공");
} else {
    // 회원 정보 수정에 실패한 경우
    out.print("회원정보 수정 실패");
}
%>
</body>
</html>
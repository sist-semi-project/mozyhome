<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dao.MemberDao"%>
<%@page import="java.sql.Date"%>
<%@page import="data.dto.MemberDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("mem_id");
String pass = request.getParameter("mem_password");
String name = request.getParameter("mem_name");
String nickname = request.getParameter("mem_nickname");
String hp = request.getParameter("mem_hp");
String postcode = request.getParameter("mem_zipcode");
String addr = request.getParameter("mem_address");
String addrDetail = request.getParameter("mem_address_detail");
String email = request.getParameter("mem_email");
String birthday = request.getParameter("mem_birth");
String gender = request.getParameter("mem_gender");
String is_active = request.getParameter("mem_is_active");

MemberDto dto = new MemberDto();

dto.setMem_id(id);
dto.setMem_password(pass);
dto.setMem_name(name);
dto.setMem_nickname(nickname);
dto.setMem_hp(hp);
dto.setMem_zipcode(postcode);
dto.setMem_address(addr);
dto.setMem_address_detail(addrDetail);
dto.setMem_email(email);
dto.setMem_birth(birthday);
dto.setMem_gender(gender);
dto.setMem_is_active(is_active);

MemberDao dao = new MemberDao();

dao.insertMember(dto);

%>
<script type="text/javascript">

alert("모지홈 가입을 환영합니다!");

window.location.href="index.jsp?main=SemiLogin/Login.jsp";

</script>
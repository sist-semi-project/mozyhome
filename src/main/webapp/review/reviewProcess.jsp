<%@page import="data.dao.MemberDao"%>
<%@page import="data.dto.MemberDto"%>
<%@page import="data.dto.ReviewDto"%>
<%@page import="data.dao.ReviewDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
request.setCharacterEncoding("utf-8");

String loginok = (String) session.getAttribute("loginok");
String mem_id = (String) session.getAttribute("mem_id"); 
int pro_num=Integer.parseInt( request.getParameter("pro_num"));

ReviewDao rdao=new ReviewDao();

int mem_num= rdao.getNum(mem_id);


String realPath=getServletContext().getRealPath("image/reviewSave");

int uploadSize=1024*1024*10;

MultipartRequest multi=null;

multi=new MultipartRequest(request,realPath,uploadSize,"utf-8",new DefaultFileRenamePolicy());

int rating=Integer.parseInt(multi.getParameter("rating"));
String content=multi.getParameter("content");
String content_subject=multi.getParameter("content_subject");
String photoname=multi.getFilesystemName("photo"); 


//dto에 저장
ReviewDto rdto=new ReviewDto();

rdto.setMem_num(mem_num);
rdto.setPro_num(pro_num);
rdto.setReview_content(content);
rdto.setReview_pyung(rating);
rdto.setReview_subject(content_subject);
rdto.setReview_image(photoname);

//사진선택을 안하면 기존의 사진으로 저장


rdao.insertReview(rdto);



//방명록 목록으로 이동(수정했던 페이지로 이동)
response.sendRedirect("index.jsp?main=reviewForm.jsp&pro_num="+pro_num);

%>
</body>
</html>
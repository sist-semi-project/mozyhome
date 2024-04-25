<%@page import="com.amazonaws.auth.AWSStaticCredentialsProvider"%>
<%@page import="com.amazonaws.services.s3.AmazonS3"%>
<%@page import="com.amazonaws.services.s3.AmazonS3ClientBuilder"%>
<%@page import="com.amazonaws.auth.BasicAWSCredentials"%>
<%@page import="db.AwsConnect"%>
<%@page import="java.io.File"%>
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
AwsConnect aws = new AwsConnect();
String region = "ap-northeast-2";
String bucketName = "mozy-bucket";
String accessKeyID = aws.getAccessKey();
String secretAccessKey = aws.getSecretKey();

request.setCharacterEncoding("utf-8");

String realPath=getServletContext().getRealPath("image/reviewSave");
ReviewDao rdao=new ReviewDao();

int uploadSize=1024*1024*10;

MultipartRequest multi=null;

multi=new MultipartRequest(request,realPath,uploadSize,"utf-8",new DefaultFileRenamePolicy());

// AWS S3 클라이언트 설정
BasicAWSCredentials awsCreds = new BasicAWSCredentials(accessKeyID, secretAccessKey);
AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
        .withCredentials(new AWSStaticCredentialsProvider(awsCreds))
        .withRegion(region) // 예: Regions.US_EAST_1
        .build();

int rating=Integer.parseInt(multi.getParameter("rating"));
String content=multi.getParameter("content");
String content_subject=multi.getParameter("content_subject");

String photoUrl = rdao.uploadFileToS3(multi, "photo", s3Client,bucketName );
/* String photoname=multi.getFilesystemName("photo");  */
String pro_numStr= multi.getParameter("pro_num");
String mem_numStr= multi.getParameter("mem_num");

int pro_num=Integer.parseInt(pro_numStr);
int mem_num=Integer.parseInt(mem_numStr);


String loginok = (String) session.getAttribute("loginok");
String mem_id = (String) session.getAttribute("mem_id"); 



System.out.println(rating);
System.out.println(content);
System.out.println(content_subject);
System.out.println(photoUrl);
System.out.println(pro_num);
System.out.println(mem_num);
//dto에 저장
ReviewDto rdto=new ReviewDto();

rdto.setMem_num(mem_num);
rdto.setPro_num(pro_num);
rdto.setReview_content(content);
rdto.setReview_pyung(rating);
rdto.setReview_subject(content_subject);
rdto.setReview_image(photoUrl);

//사진선택을 안하면 기존의 사진으로 저장
rdao.insertReview(rdto);

//방명록 목록으로 이동(수정했던 페이지로 이동)
response.sendRedirect("reviewForm.jsp?pro_num="+pro_num);

%>
</body>
</html>
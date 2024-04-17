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

<h2>리뷰작성 폼</h2>

<div class ="star_rating">
  <span class="star on" value ="1"> </span>
  <span class="star" value="2"> </span>
  <span class="star" value="3"> </span>
  <span class="star" value="4"> </span>
  <span class="star" value="5"> </span>
</div>

<textarea class="star_box" placeholder="리뷰 내용을 작성해주세요." ></textarea>

<input type="submit" class="btn02" value="리뷰 등록"/>

</body>
</html>
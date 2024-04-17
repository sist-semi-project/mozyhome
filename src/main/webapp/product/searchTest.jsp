<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>

<title>Insert title here</title>
<script type="text/javascript">
	$(function(){
		$("#search").click(function(){
			var keyword=$("#keyword").val();
			//alert(keyword);
			location.href="../product/searchList.jsp?search="+keyword;
		});
		
		document.getElementById('keyword').addEventListener('keypress', function(event) {
            // 엔터 키가 눌렸는지 확인
            if (event.keyCode === 13) {
                event.preventDefault(); // 폼 제출을 방지
                document.getElementById('search').click(); // '사이즈 추가' 버튼 클릭 이벤트 발생
            }
        });
	});

</script>
</head>

<body>
<form action="searchList.jsp" method="post">
	<input type="text" id="keyword">
	<button type="button" id="search">검색</button>
</form>
</body>
</html>
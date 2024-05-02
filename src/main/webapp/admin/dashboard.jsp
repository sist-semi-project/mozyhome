<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="kr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
		href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
		rel="stylesheet">
<link
		href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap"
		rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link rel="stylesheet" href="dashStyle.css">

<title>Admin Dashboard</title>
<style>
	body {
		display: flex;
		height: 1250px;
		background-color: #f8f9fa;
		font-family: 'Noto Sans KR', sans-serif;
	}

	.sidebar {
		text-align: center; /* 텍스트를 가운데 정렬합니다. */
	}

	.logo {
		display: inline-block; /* 이미지를 인라인 블록 요소로 설정합니다. */
		margin-bottom: 20px; /* 이미지 아래 여백을 추가합니다. */
	}

</style>

</head>
<body>
<jsp:include page="sidebar.jsp"/>

</body>

</html>
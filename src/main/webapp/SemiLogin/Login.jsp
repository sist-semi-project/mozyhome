<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<script src = "https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<title>Insert title here</title>
<script type="text/javascript">


</script>
</head>
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f8f9fa;
}

.align {
	max-width: 500px;
	height: 400px;
	margin: 0 auto;
	padding: 40px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h2 {
	text-align: center;
	font-size: 24px;
	font-weight: 700;
	letter-spacing: 5px;
	color: #222;

}

input[type="text"], input[type="password"] {
	background-color: rgb(255, 255, 255);
	border-bottom-color: rgb(224, 224, 224);
	border-left-style: none;
	border-right-style: none;
	border-top-style: none;
	cursor: text;
	font-family: Pretendard, "Noto Sans KR", "Apple SD Gothic Neo",
		"Malgun Gothic", sans-serif;
	font-weight: 500;
	height: 45px;
	font-size: 14px;
	outline-width: 0px;
	width: 400px;
}

}
.text-id {
	color: red;
	font-size: 14px;
	margin-top: 5px;
}

#btnLogin {
	width: 100%;
	height: 60px;
	padding: 10px;
	background-color: #ff5c00;
	border: none;
	border-radius: 4px;
	color: #fff;
	cursor: pointer;
	transition: background-color 0.3s;
}
</style>
<body>



	<form action="loginAction.jsp" name="form_log" method="post"
		class="align">
		<h2>MOZYHOME</h2>
		<br>
		<!-- 아이디 입력 -->
		<div class="d-inline-flex align-items-center">
			<label class="id ePlaceholder" title="아이디"> <input
				type="text" id="mem_id" name="mem_id" placeholder="아이디"
				required="required">
			</label>
		</div>
		<br>
		<br>
		<!-- 비밀번호 입력 -->
		<div class="d-inline-flex align-items-center">
			<label class="password ePlaceholder" title="비밀번호"> <input
				type="password" id="mem_password" name="mem_password"
				placeholder="비밀번호" required="required">
			</label>
		</div>
		<br>
		<br>
		<br>
		<div class="links text-dark" style="text-align: center;">
			<input type="submit" id="btnLogin" value="로그인">
		</div>
		<br>
		<div class="links text-dark" style="text-align: center;">
			<a href="IdFind.jsp" class="text-decoration-none"
				style="color: black;">아이디 찾기</a> | <a href="pwFind.jsp"
				class="text-decoration-none" style="color: black;">비밀번호 찾기</a> | <a
				href="RegisterMain.jsp" class="text-decoration-none" style="color: black;">회원가입</a>
		</div>
		<div class="button-login" align ="center" >
                <a id="kakao-login-btn" >
    <img src="//k.kakaocdn.net/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="%" height ="50px" />
    </a>
            </div>

	</form>
	
</body>
</html>
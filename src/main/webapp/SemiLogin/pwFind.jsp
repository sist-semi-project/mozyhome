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
<title>Insert title here</title>
<style>
body {
	font-family: 'Noto Sans KR', sans-serif;
	background-color: #f8f9fa;
}

.align {
	max-width: 500px;
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
	line-height: 27px;
}

label {
	font-weight: bold;
	color: #343a40;
}

.align {
	max-width: 500px;
	height: 500px; /* 추가된 부분 */
	margin: 0 auto;
	padding: 40px;
	background-color: #fff;
	border-radius: 8px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

input[type="text"], input[type="password"] {
	width: 100%;
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #ced4da;
	border-radius: 4px;
}

.text-id {
	color: red;
	font-size: 14px;
	margin-top: 5px;
}

#btnSearch, #btnCancel {
	width: 100px; /* 너비를 100픽셀로 설정 */
	padding: 10px 20px; /* 위아래 10픽셀, 좌우 20픽셀의 여백 추가 */
	background-color: #ff5c00;
	border: none;
	border-radius: 4px;
	color: #fff;
	cursor: pointer;
	transition: background-color 0.3s;
}
</style>
<script type="text/javascript">
	function pw_search() {
		var frm = document.pwfindscreen;
		
		if (frm.mem_name.value.length < 1) {
			alert("이름을 입력해주세요");
			return;
		}
		
		if (frm.mem_id.value.legth < 1) {
			alert("아이디를 입력해주세요");
			return;
		}

		if (frm.mem_email.value.indexOf('@') == -1 || frm.mem_email.value.indexOf('.com') == -1) {
		    alert("이메일 형식에 맞게 작성해주세요.");
		    return;
		}
		
		frm.method = "post";
		frm.action = "pwFindResult.jsp"; // 넘어간 화면
		frm.submit();

/* 		// 서버로 데이터 전송
		$.ajax({
			type : "POST",
			url : "sendVerificationEmail.jsp", // 이메일 인증을 보낼 JSP 파일 경로
			data : {
				name : name,
				id : id,
				email : email
			},
			success : function(response) {
				alert("이메일로 인증 링크가 전송되었습니다. 이메일을 확인해주세요.");
			},
			error : function(xhr, status, error) {
				alert("이메일 전송 중 오류가 발생했습니다. 다시 시도해주세요.");
			}
		}); */
	}
</script>
</head>
<body>
	<form name="pwfindscreen" method="POST" class="align">
		<h2>비밀번호 찾기</h2>
		<br>
		<br>
		<div class="search-title"></div>
		<section class="form-search">
			<div class="find-name">
				<label>이름</label> <input type="text" name="mem_name" id="mem_name" class="btn-name"
					placeholder="등록한 이름"> <br>
			</div>
			<div class="find-id">
				<label>아이디</label> <input type="text" 
					name="mem_id" id="mem_id" class="btn-id" placeholder="아이디 입력">
			</div>
			<div class="find-email">
				<label>이메일</label> <input type="text" 
					name="mem_email" id="mem_id" class="btn-email" placeholder="이메일 입력">
			</div>
		</section>
		<div align="center">
			<input type="button" id="btnSearch" name="enter" value="찾기"
				onClick="pw_search()"> <input type="button" id="btnCancel"
				name="cancle" value="취소" onClick="location.href='Login.jsp'">

		</div>
	</form>

</body>
</html>

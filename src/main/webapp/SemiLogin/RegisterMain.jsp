<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap"
	rel="stylesheet">
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<title>사용자 등록</title>
<style type="text/css">
.container {
	margin-left: auto;
	margin-right: auto;
}

.container {
	position: relative;
	padding-left: 15px;
	padding-right: 15px;
}

.hr-join {
	margin: 10px 0 40px;
	height: 2px;
	background-color: #cecece;
	border: 0 none;
	color: #cecece;
}

.ttl-join h3 {
	margin: 0;
	font-size: 1.17em;
	font-weight: bold;
}

body, body * {
	box-sizing: border-box;
}

body {
	font-family: Pretendard, 'Noto Sans KR', 'Apple SD Gothic Neo',
		'Malgun Gothic', sans-serif;
}

h3 {
	font-size: 1.17em;
	margin-block-start: 1em;
	margin-block-end: 1em;
	margin-inline-start: 0px;
	margin-inline-end: 0px;
	font-weight: bold;
	unicode-bidi: isolate;
}

.ttl-join {
	display: flex;
	align-items: center;
}

.ttl-join .required-span {
	float: right;
}

.required-span {
	margin-left: auto;
}

.section:first-child {
	margin: 80px 0 100px;
}

.required {
	color: #c00;
	vertical-align: middle;
}

.buttons .btn-primary {
	min-width: 150px;
}

h1.page-title {
	text-align: center;
	font-size: 24px;
	font-weight: 700;
	letter-spacing: 5px;
	color: #222;
	line-height: 27px;
	padding-top: 75px;
}

.page-title {
	padding-bottom: 35px !important;
}

.page-title-sub {
	display: block;
	margin-bottom: 35px;
	text-align: center;
}

.btn-orange {
	background-color: #FF5C00;
	border-color: #FF5C00;
	color: white;
}

.btn-orange:hover {
	background-color: #fff;
	border-color: #FF5C00;
	color: #FF5C00;
}

.password_info {
	flex: none;
	padding: 0 5px;
}

.how_secure {
	display: none;
	padding: 4px 6px 3px 6px;
	border-radius: 10px;
	background: rgba(255, 168, 0, .12);
	font-size: 11px;
	font-weight: 700;
	line-height: 13px;
	letter-spacing: -.4px;
	color: #ffa41c;
	vertical-align: middle;
}

em {
	font-style: normal;
}

.btn_show {
	margin-left: 4px;
	vertical-align: middle;
}

button {
	border-radius: 0;
	border: none;
	background: 0 0;
	-webkit-appearance: none;
	appearance: none;
	outline: 0;
	text-decoration: none;
	cursor: pointer;
	-webkit-text-size-adjust: none;
}

.blind {
	position: absolute;
	clip: rect(0, 0, 0, 0);
	width: 1px;
	height: 1px;
	margin: -1px;
	overflow: hidden;
}

.btn_show.hide::before {
	background-position: -256px -264px;
	background-repeat: no-repeat;
	width: 30px;
	height: 30px;
}

.btn_show::before {
	background-position: -256px -296px;
	background-repeat: no-repeat;
	width: 30px;
	height: 30px;
	display: inline-block;
	vertical-align: top;
	content: '';
}

.btn_show.hide::before, .btn_show::before {
	background-image:
		url(https://ssl.pstatic.net/static/nid/join/m_sp_06_realname_48b1e603.png);
	background-size: 372px 326px;
	background-repeat: no-repeat;
}
</style>

<script type="text/javascript">
	$(function() {
		//아이디 중복체크
		$("#btnIdCheck").click(function() {

			var mem_id = $("#mem_id").val();

			$.ajax({
				type : "get",
				url : "idCheck.jsp",
				dataType : "json",
				data : {
					"mem_id" : mem_id
				},
				success : function(res) {
					if (res.count == 1) {
						alert("이미 가입된 아이디입니다.\n");
						$("span.idsuccess").text("not ok!!");
						$("#mem_id").val("");
					} else {
						alert("사용 가능한 아이디입니다.");
						$("span.idsuccess").text("ok!!");
					}
				}
			});
		});

		$("#btnNicknameCheck").click(function() {

			var mem_nickname = $("#mem_nickname").val();

			$.ajax({
				type : "get",
				url : "nicknameCheck.jsp",
				dataType : "json",
				data : {
					"mem_nickname" : mem_nickname
				},
				success : function(res) {
					if (res.count == 1) {
						alert("이미 사용중인 닉네임입니다.\n");
						$("span.nicknamesuccess").text("not ok!!");
					} else {
						alert("사용 가능한 닉네임입니다.");
						$("span.nicknamesuccess").text("ok!!");
					}
				}
			});
		});

		$("#selemail").change(function() {
			var email = $(this).val();
			if (email != "-") {
				$("#email2").val(email);
			} else {
				$("#email2").val("");
			}
		});
	})

	function check(f) {
		if (f.pass.value != f.pass2.value) {
			alert("비밀번호가 일치하지 않습니다.");
			//초기화
			f.pass.value = "";
			f.pass2.value = "";
			pass.focus();
			return false; //action 호출하지 않음.
		}
	}
</script>
</head>
<h1 class="page-title">mozyhome</h1>

<div class="page-title-sub">모지홈 멤버에 가입하시면 더욱 다양한 혜택을 받으실 수 있습니다.</div>


<body>
	<div class="container">
		<form id="signupForm" action="MainAction.jsp" method="post"
			onsubmit="return validateForm(event)">
			<div class="row">

				<!--  고객 입력사항 { -->
				<div class="section">
					<div class="ttl-join">
						<h3 class="">고객 입력사항</h3>
						<span class="required-span"><span class="required">*</span>
							필수입력사항</span>
					</div>
					<hr class="hr-join">

					<div class="form-group row">
						<label for="id" class="col-sm-2 col-form-label">아이디<span
							class="required">*</span></label>
						<div class="col-sm-6">
							<div class="input-group">
								<input type="text" name="mem_id" id="mem_id" maxlength="16"
									class="form-control" onblur="validateId()">
								<button type="button" class="btn btn-outline-info btn-orange"
									id="btnIdCheck">중복체크</button>
							</div>
						</div>
					</div>

					<div class="form-group row">
						<label for="pass" class="col-sm-2 col-form-label">비밀번호<span
							class="required">*</span></label>
						<div class="col-sm-5">
							<div class="input-group">
								<input type="password" name="mem_password" id="mem_password"
									class="form-control" onblur="validatePass()">
								<div class="input-group-append">
									<button type="button" class="btn_show">
										<span class="blind">비밀번호 숨기기</span>
									</button>
								</div>
							</div>
							<div class="password_info">
								<em class="how_secure" id="secureLevel"></em>
							</div>
						</div>
					</div>


					<div class="form-group row">
						<label for="pass2" class="col-sm-2 col-form-label">비밀번호 확인<span
							class="required">*</span></label>
						<div class="col-sm-5">
							<div class="input-group">
								<input type="password" name="mem_password2" id="mem_password2"
									class="form-control" onblur="validatePass2()">
							</div>
						</div>
					</div>

					<div class="form-group row">
						<label for="nickname" class="col-sm-2 col-form-label">닉네임<span
							class="required">*</span></label>
						<div class="col-sm-6">
							<div class="input-group">
								<input type="text" name="mem_nickname" id="mem_nickname"
									maxlength="8" class="form-control">
								<button type="button" class="btn btn-outline-info btn-orange"
									id="btnNicknameCheck">중복체크</button>
							</div>
						</div>
					</div>

					<div class="form-group row">
						<label for="birthday" class="col-sm-2 col-form-label">생년월일<span
							class="required">*</span></label>
						<div class="col-sm-5">
							<div class="input-group">
								<input type="text" name="mem_birth" id="mem_birth"
									class="form-control" placeholder="ex)20010203"
									onblur="validateBirthday()">
							</div>
						</div>
					</div>

					<div class="form-group">
						<div>
							<span id="idError" style="color: red;"></span>
						</div>
						<div>
							<span id="passError" style="color: red;"></span>
						</div>
						<div>
							<span id="pass2Error" style="color: red;"></span>
						</div>
						<div>
							<span id="passError" style="color: red;"></span>
						</div>
						<div>
							<span id="birthdateError" style="color: red;"></span>
						</div>
					</div>

				</div>

				<!-- } 고객 입력사항 -->


				<!-- 입력사항 구분 칸 -->


				<!--  주소지 입력사항 { -->
				<div class="ttl-join">
					<h3 class="">주소지 입력사항</h3>
					<span class="required-span"><span class="required">*</span>
						필수입력사항</span>
				</div>
				<hr class="hr-join">

				<div class="form-group row">
					<label for="name" class="col-sm-2 col-form-label">이름<span
						class="required">*</span></label>
					<div class="col-sm-5">
						<div class="input-group">
							<input type="text" name="mem_name" id="mem_name"
								class="form-control" onblur="validateName()">
						</div>
					</div>
				</div>

				<div class="form-group row">
					<label for="mem_zipcode" class="col-sm-2 col-form-label">주소<span
						class="required">*</span></label>
					<div class="col-sm-5">
						<div class="input-group">
							<input type="text" name="mem_zipcode" id="mem_zipcode"
								placeholder="우편번호" class="form-control">
							<button type="button" onclick="sample6_execDaumPostcode()"
								class="btn btn-outline-info btn-orange">우편번호 찾기</button>
						</div>
					</div>
				</div>

				<div class="form-group row">
					<label for="mem_address" class="col-sm-2 col-form-label"></label>
					<div class="col-sm-5">
						<div class="input-group">
							<input type="text" name="mem_address" id="mem_address"
								placeholder="주소" class="form-control" onblur="validateAddr()">
						</div>
					</div>
				</div>
				<div class="form-group row">
					<label for="mem_address_detail" class="col-sm-2 col-form-label"></label>
					<div class="col-sm-5">
						<div class="input-group">
							<input type="text" name="mem_address_detail"
								id="mem_address_detail" placeholder="상세 주소" class="form-control"
								onblur="validateAddr()">
						</div>
					</div>
				</div>



				<div class="form-group row">
					<label for="hp" class="col-sm-2 col-form-label">휴대전화<span
						class="required">*</span></label>
					<div class="col-sm-5">
						<div class="input-group">
							<input type="text" name="mem_hp" id="mem_hp" class="form-control"
								onblur="validateHp()">
						</div>
					</div>
				</div>

				<div class="form-group row">
					<label for="email" class="col-sm-2 col-form-label">이메일<span
						class="required">*</span></label>
					<div class="col-sm-5">
						<div class="input-group">
							<input type="text" name="mem_email" id="mem_email"
								class="form-control" onblur="validateEmail()">
						</div>
					</div>
				</div>

				<div class="form-group row">
					<label class="col-sm-2 col-form-label">성별</label>
					<div class="col-sm-10">
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="mem_gender"
								id="male" value="남자"> <label class="form-check-label"
								for="male">남자</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="mem_gender"
								id="female" value="여자"> <label class="form-check-label"
								for="female">여자</label>
						</div>
						<div class="form-check form-check-inline">
							<input class="form-check-input" type="radio" name="mem_gender"
								id="notspecified" value="선택안함"> <label
								class="form-check-label" for="notspecified">선택안함</label>
						</div>
					</div>
				</div>
				<input type="hidden" id="mem_is_active" name="mem_is_active"
					value="N">

			</div>

			<div class="form-group">
				<div>
					<span id="nameError" style="color: red;"></span>
				</div>
				<div>
					<span id="addressError" style="color: red;"></span>
				</div>
				<div>
					<span id="addrDetailError" style="color: red"></span>
				</div>
				<div>
					<span id="phoneError" style="color: red;"></span>
				</div>
				<div>
					<span id="emailError" style="color: red;"></span>
				</div>
			</div>
			<br> <br>
			<!-- } 주소지 입력사항 -->
			<div class="form-group" align="center">
				<button type="submit" class="btn btn-outline-info btn-orange"
					style="width: 150px; height: 50px;" value="가입">가입하기</button>
			</div>
		</form>
	</div>

	<script src="validation.js"></script>
</body>

</html>

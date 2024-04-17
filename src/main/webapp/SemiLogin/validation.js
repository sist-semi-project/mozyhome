	// 주소 api
	function sample6_execDaumPostcode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            
	            var addr = ''; // 주소 변수
	            var extraAddr = ''; // 참고항목 변수

	            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }

	            // 참고항목 조합
	            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                extraAddr += data.bname;
	            }
	            if(data.buildingName !== '' && data.apartment === 'Y'){
	                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	            }
	            // 주소와 참고항목을 합쳐서 최종 주소로 설정
	            var fullAddress = addr + (extraAddr !== '' ? ' ' + extraAddr :'');

	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('mem_zipcode').value = data.zonecode;
	            document.getElementById("mem_address").value = fullAddress;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("mem_address_detail").focus();
	        }
	    }).open();
	}
	
	//비밀번호 숨기기/보여주기 아이콘
	function togglePassword() {
    const passwordField = document.getElementById('mem_password');
    const toggleIcon = document.querySelector('#togglePassword i');

    if (passwordField.type === 'password') {
        passwordField.type = 'text';
        toggleIcon.classList.remove('bi-eye-slash');
        toggleIcon.classList.add('bi-eye');
    } else {
        passwordField.type = 'password';
        toggleIcon.classList.remove('bi-eye');
        toggleIcon.classList.add('bi-eye-slash');
    }
}
	
	// 아이디 유효성 검사
function validateId() {
    const id = document.getElementById('mem_id').value;
    const idError = document.getElementById('idError');
    const idField = document.getElementById('mem_id');
    
    if (id.trim() === '') {
        idError.textContent = '아이디: 필수 정보입니다.';
        idField.style.border = '1px solid red'; // 빨간 테두리 생성
    } else if (!/^[a-zA-Z0-9]{4,16}$/.test(id)) {
        idError.textContent = '아이디: 4~16글자의 영문자와 숫자로 이루어져야 합니다.';
        idField.style.border = '1px solid red'; // 빨간 테두리 생성
    } else {
        idError.textContent = '';
        idField.style.border = ''; // 테두리 초기화
    }
}

	// 비밀번호 유효성 검사
function validatePass() {
    const pass = document.getElementById('mem_password').value;
    const passError = document.getElementById('passError');
    const passField = document.getElementById('mem_password');

    if (pass.trim() === '') {
        passError.textContent = '비밀번호: 필수 정보입니다.';
        passField.style.border = '1px solid red'; // 빨간 테두리 생성
    } else if (!/^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$/.test(pass)) {
        passError.textContent = '비밀번호: 영 소문자, 숫자, 특수문자를 포함하여 6글자 이상이어야 합니다.';
        passField.style.border = '1px solid red'; // 빨간 테두리 생성
    } else {
        passError.textContent = '';
        passField.style.border = ''; // 테두리 초기화
    }
}

//비밀번호 확인 에러
function validatePass2() {
    const pass = document.getElementById('mem_password').value;
    const pass2 = document.getElementById('mem_password2').value;
    const pass2Error = document.getElementById('pass2Error');
    const passField = document.getElementById('mem_password');

    if (pass !== pass2) {
        pass2Error.textContent = '비밀번호 확인: 일치하지 않습니다.';
        
    } else {
        pass2Error.textContent = '';
    }
    
    if(pass.trim()===''){
		  passField.focus();
	}
}

	// 이름 유효성 검사
function validateName() {
    const name = document.getElementById('mem_name').value;
    const nameError = document.getElementById('nameError');
    const nameField = document.getElementById('mem_name');

    if (name.trim() === '') {
        nameError.textContent = '이름: 필수 정보입니다.';
        nameField.style.border = '1px solid red'; // 빨간 테두리 생성
    } else {
        nameError.textContent = '';
        nameField.style.border = ''; // 테두리 초기화
    }
}

// 전화번호 유효성 검사
function validateHp() {
    const hp = document.getElementById('mem_hp').value;
    const phoneError = document.getElementById('phoneError');
    const hpField = document.getElementById('mem_hp');

    if (hp.trim() === '') {
        phoneError.textContent = '휴대전화번호: 필수 정보입니다.';
        hpField.style.border = '1px solid red'; // 빨간 테두리 생성
    } else if (!/^\d{3}-\d{3,4}-\d{4}$/.test(hp)) {
        phoneError.textContent = '휴대전화번호: XXX-XXXX-XXXX 형식으로 입력해야 합니다.';
        hpField.style.border = '1px solid red'; // 빨간 테두리 생성
    } else {
        phoneError.textContent = '';
        hpField.style.border = ''; // 테두리 초기화
    }
}

function validateAddr() {
    const addr = document.getElementById('mem_address').value;
    const addrDetail = document.getElementById('mem_address_detail').value;
    const addressError = document.getElementById('addressError');
    const addrDetailError = document.getElementById('addrDetailError');
    const addrField = document.getElementById('mem_address');
    const addrDetailField = document.getElementById('mem_address_detail');

    if (addr.trim() === '') {
        addressError.textContent = '주소: 필수 정보입니다.';
        addrField.style.border = '1px solid red'; // 빨간 테두리 생성
    } else {
        addressError.textContent = '';
        addrField.style.border = ''; // 테두리 초기화
    }

    if(addrDetail.trim()===''){
        addrDetailError.textContent='상세 주소: 필수 정보입니다.';
        addrDetailField.style.border = '1px solid red'; // 빨간 테두리 생성
    }else{
        addrDetailError.textContent='';
        addrDetailField.style.border = ''; // 테두리 초기화
    }
}

// 생년월일 유효성 검사
function validateBirthday() {
    const birthday = document.getElementById('mem_birth').value;
    const birthdateError = document.getElementById('birthdateError');
    const birthdayField = document.getElementById('mem_birth');

    if (birthday.trim() === '') {
        birthdateError.textContent = '생년월일: 필수 정보입니다.';
        birthdayField.style.border = '1px solid red'; // 빨간 테두리 생성
    } else if (!/^[0-9]{8}$/.test(birthday)) {
        birthdateError.textContent = '생년월일: 8자리 숫자로 입력해야 합니다.';
        birthdayField.style.border = '1px solid red'; // 빨간 테두리 생성
    } else {
        birthdateError.textContent = '';
        birthdayField.style.border = ''; // 테두리 초기화
    }
}

// 이메일 유효성 검사
function validateEmail() {
    const email = document.getElementById('mem_email').value;
    const emailError = document.getElementById('emailError');
    const emailField = document.getElementById('mem_email');

    if (email.trim() === '') {
        emailError.textContent = '이메일: 필수 정보입니다.';
        emailField.style.border = '1px solid red'; // 빨간 테두리 생성
    } else if (!/\S+@\S+\.\S+/.test(email)) {
        emailError.textContent = '이메일: 형식을 올바르게 작성해주세요.';
        emailField.style.border = '1px solid red'; // 빨간 테두리 생성
    } else {
        emailError.textContent = '';
        emailField.style.border = ''; // 테두리 초기화
    }
}
	// onsubmit 유효성 검사 충족하지 못한 유효성 검사 에러 전부 나옴
function validateForm(event) {
    event.preventDefault();
    let isValid = true;

    validateId();
    validatePass();
    validateHp();
    validateAddr();
    validateName();
    validateBirthday();
    validateEmail();

    const id = document.getElementById('mem_id').value;
    const pass = document.getElementById('mem_password').value;
    const hp = document.getElementById('mem_hp').value;
    const name = document.getElementById('mem_name').value;
    const addr = document.getElementById('mem_address').value;
    const addrDetail = document.getElementById('mem_address_detail').value;
    const birthday = document.getElementById('mem_birth').value;
    const email = document.getElementById('mem_email').value;

    if (!/^[a-zA-Z0-9]{4,16}$/.test(id) || id.trim()==='' || pass.trim()==='' || hp.trim()==='' ||
    	email.trim()==='' || birthday.trim() === '' || name.trim()==='' ||
        !/^(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$/.test(pass) ||
        !/^\d{3}-\d{3,4}-\d{4}$/.test(hp) ||
        addr.trim() === '' || addrDetail.trim()==='' ||
        birthday.trim().length !== 8 || 
        !/\S+@\S+\.\S+/.test(email)) {
        isValid = false;
    }

    if (isValid) {
        document.getElementById('signupForm').submit();
    }
}
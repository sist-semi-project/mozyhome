<%@page import="java.util.StringTokenizer"%>
<%@page import="data.dto.MemberDto"%>
<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
a {
    text-decoration: none !important;
    color: #000;
}
form {
    margin: 0;
    padding: 0;
}
#body {
    background-color: #fff;
}

#body-begin {
    clear: both;
    height: 1px;
}

#body-end {
    clear: both;
    height: 200px;
}
.sub_container {
    max-width: 800px;
    padding: 0 20px;
    margin: 0 auto;
    box-sizing: border-box;
}

h1.page-title {
    text-align: center;
    font-size: 24px;
    font-weight: 700;
    letter-spacing: 5px;
    color: #222;
    line-height: 27px;
    padding-top: 75px;
    padding-bottom: 60px;
}
#mobile{
    margin-left: 4px;
}

.justify {
    width: max-content;
    margin: 0 auto;
    display: flex;
    gap: 1.2rem;
    align-items: center;
    justify-content: center;
    padding: 2rem 0;
}

.justify .fix,.justify .cancle,.justify .delete {
    border: 1px solid #C7C7C7;
    box-sizing: border-box;
    flex: 1 1 0%;
    padding: 3px 13px;
    text-align: center;
    font-size: 1.0rem;
    font-weight: 500;
    line-height: 2rem;
}

.justify .delete {
    color: #C7C7C7;
}

.justify .cancle {
    color: #141414;
    border: 1px solid #EA6000;
}

.justify .fix {
    background: #EA6000;
    color: white;
    border: 1px solid #EA6000;
}
.member_edit {
    padding: 0 1.6rem 3rem;
}

.member_edit .edit_wrap {
    display: flex;
    gap: 2rem;
    flex-direction: column;
    margin-bottom: 2rem;
}

.member_edit .edit_row {
    display: flex;
    flex-direction: column;
    gap: 0.4rem;
    width: 100%;
}
.member_edit .edit_row dd {
    width: 100%;
}
.member_edit .edit_row .label {

    color: #141414;
    font-weight: 600;
}
.member_edit .edit_row input[type="text"],.member_edit .edit_row input[type="password"] {
    border: 0;
    border-bottom: 1px solid #D8D8D8;
    width: 100%;
    box-sizing: border-box;

    padding: 0.8rem 0.4rem;
}
inputTypeText {
    height: 19px;
    padding: 3px 0 0 9px;
    border: 1px solid #d5d5d5;
}
.member_edit .edit_row.call select,.member_edit .edit_row.call input {
    text-align: center;
    flex: 1;
    font-size: 1.1rem;
    color: #141414;
}
.member_edit .edit_row.call dd {
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 12px;
}
.member_edit .edit_row.call dd select {
    border: 0;
    border-bottom: 1px solid #D8D8D8;
    padding: 0.8rem 0.4rem;
    height: auto;
}
#btn_search_rzipcode {
    border: 1px solid #d8d8d8;
    border-radius: 8px;
    padding: 8px 20px;
    color: #616161;
    background: #d8d8d8;
    height: auto;
    font-size: 14px;
    font-weight: 500;
    line-height: 27	px;
    width: max-content;
    white-space: nowrap;
    margin: 0;
}
.address_box {
    display: flex;
    gap: 5px;
}
</style>
<!-- 다음 우편번호 서비스 API 스크립트 로드 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script type="text/javascript">
//다음 우편번호 서비스를 실행하는 함수
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = ''; // 주소 변수 초기화

            if (data.userSelectedType === 'R') { // 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }
            
         	// 우편번호와 주소를 해당 필드에 설정
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
         	// 상세 주소 입력란에 포커스 설정
            document.getElementById("detailAddress").focus();
            document.getElementById("detailAddress").value = "";
        }
    }).open();
}

// 회원 정보 수정 함수
function memberEditAction() {
    // 입력된 정보 가져오기
    var memberId = document.getElementById('member_id').value;
    var password = document.getElementById('passwd').value;
    var confirmPassword = document.getElementById('passwd_confirm').value;
    var name = document.getElementById('name').value;
    var nickname = document.getElementById('nickname').value;
    var zipcode = document.getElementById('postcode').value;
    var address = document.getElementById('address').value;
    var detailAddress = document.getElementById('detailAddress').value;
    var hp1 = document.getElementById('mobile1').value;
    var hp2 = document.getElementById('mobile2').value;
    var hp3 = document.getElementById('mobile3').value;
    var hp = hp1 + "-" + hp2 + "-" + hp3;
    
    // 비밀번호와 비밀번호 확인 값이 일치하는지 확인
    if (password !== confirmPassword) {
        alert('비밀번호와 비밀번호 확인이 일치하지 않습니다.');
        return;
    }
    
    // 수정할 회원 정보를 JSON 형태로 생성
    var memberInfo = {
        member_id: memberId,
        passwd: password,
        name: name,
        nickname: nickname,
        zipcode: zipcode,
        address: address,
        detail_address: detailAddress,
        hp: hp
    };

    // AJAX를 사용하여 서버로 회원 정보 전송
    $.ajax({
        url: "index.jsp?main=member/modifyAction.jsp",
        type: "POST",
        data: memberInfo,
        success: function(response) {
            // 성공적으로 응답을 받았을 때 수행할 동작
            alert("회원 정보가 수정되었습니다.");
            location.reload();
        },
        error: function(xhr, status, error) {
            // 요청이 실패했을 때 수행할 동작
            alert("회원 정보 수정에 실패했습니다.");
            console.error(xhr, status, error);
        }
    });
}

// 회원 탈퇴 함수
function memberDelAction() {
	var memberId = document.getElementById('member_id').value;
    // 확인 다이얼로그 표시
    if (confirm("정말로 회원을 탈퇴하시겠습니까?")) {
        // AJAX를 사용하여 서버로 회원 삭제 요청 전송
        $.ajax({
            url: "index.jsp?main=member/deleteAction.jsp",
            type: "POST",
            data: { mem_id: memberId },
            success: function(response) {
                // 성공적으로 응답을 받았을 때 수행할 동작
                alert("회원 탈퇴가 완료되었습니다.");
                window.location.href = "index.jsp";
            },
            error: function(xhr, status, error) {
                // 요청이 실패했을 때 수행할 동작
                alert("회원 탈퇴에 실패했습니다.");
                console.error(xhr, status, error);
            }
        });
    } else {
        // 취소를 선택한 경우 아무 동작도 수행하지 않음
        return;
    }
}
</script>
<%
String mem_id = (String) session.getAttribute("myid");  

MemberDao dao = new MemberDao();
MemberDto dto = dao.getMemberInfo(mem_id);

%>
</head>
<body>
<div id="body">
<div id="body-begin"></div>
	<div class="sub_container">
    <h1 class="page-title">회원 정보 수정</h1>
    <form id="editForm" name="editForm" action="#" method="post">
    	<div class="member_edit">
    	
    	<div class="edit_wrap ">
    	
    	<dl class="edit_row ">
			<dt class="label">아이디</dt>
		    <dd>
		        <input id="member_id" name="member_id" class="inputTypeText" readonly="readonly" value="<%=dto.getMem_id() %>" type="text"/>                    
		    </dd>
		</dl>
		
		<dl class="edit_row">
			<dt class="label">새 비밀번호</dt>
			<dd>
		    	<input id="passwd" name="pass" autocomplete="off" maxlength="16" type="password" />                    
		    </dd>
		</dl>
		
		<dl class="edit_row ">
			<dt class="label">새 비밀번호 확인</dt>
			<dd>
				<input id="passwd_confirm" name="pass_confirm" autocomplete="off" maxlength="16" type="password"  />
			</dd>
        </dl>
    	
    	<dl class="edit_row ">
			<dt class="label" id="">이름</dt>
            <dd>
            	<input id="name" name="name" maxlength="30" value="<%=dto.getMem_name()%>" type="text" />
            </dd>
        </dl>
        
        <dl class="edit_row ">
			<dt class="label" id="">닉네임</dt>
            <dd>
            	<input id="nickname" name="nickname" maxlength="30" value="<%=dto.getMem_nickname()%>" type="text" />
            </dd>
        </dl>
    	
    	<dl class="edit_row ">
			<dt class="label">주소 <img src="http://img.echosting.cafe24.com/skin/base_ko_KR/order/ico_required.gif" class="displaynone" alt="필수"></dt>
            <dd>
            	
	            <div class="address_box">
		            <input id="postcode" name="zipcode" class="inputTypeText" size="6" maxlength="6" readonly type="text" value="<%=dto.getMem_zipcode()%>"/>                                                        
		            <a href="#none" id="btn_search_rzipcode" onclick="execDaumPostcode()">주소검색</a>
		        </div>
	            <input id="address" name="addr" class="inputTypeText" size="40" readonly="1" type="text" value="<%=dto.getMem_address()%>" /> <Br>	        
				<input id="detailAddress" name="address_detail" class="inputTypeText" size="40" type="text" value="<%=dto.getMem_address_detail()%>"/> 
			</dd>
		</dl>
        <%
      	//하이픈(-)을 구분자로 분리
        StringTokenizer st = new StringTokenizer(dto.getMem_hp(),"-");
        String hp1=st.nextToken();
        String hp2=st.nextToken();
        String hp3=st.nextToken();
        %>
    	<dl class="edit_row call">
			<dt class="label">휴대전화 <img src="http://img.echosting.cafe24.com/skin/base_ko_KR/order/ico_required.gif" alt="필수"></dt>
			<dd>
				<select id="mobile1" name="hp1">
				<%
                	String [] strHp={"010","011","012","013"};
                    for(int i=0;i<strHp.length;i++){
                		if(hp1.equals(strHp[i])){
                		%>
                			<option value="<%=strHp[i]%>" selected="selected"><%=strHp[i] %></option>
                	    <% }else
                	    {%>
                			<option value="<%=strHp[i]%>"><%=strHp[i] %></option>
                	  <%}
                   }
                %>
				</select>-
				<input id="mobile2" name="hp2" maxlength="4" type="text" value="<%=hp2%>"/>-
				<input id="mobile3" name="hp3" maxlength="4" type="text" value="<%=hp3%>"/>
			</dd>
        </dl>
    	</div>
    	
    	<div class=" justify">
            <a href="#none" class="delete btn_radius" onclick="memberDelAction()">탈퇴</a>
            <a href="index.jsp?main=member/mypage.jsp" class="cancle btn_radius">취소</a>
            <a href="#none" class="fix btn_radius" onclick="memberEditAction()">수정</a>
        </div>
    	
    	</div>
    </form>
    </div>
<div id="body-end"></div>
</div>
</body>
</html>
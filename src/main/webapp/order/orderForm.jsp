<%@page import="data.dto.CartDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 양식</title>
<!-- 다음 우편번호 서비스 API 스크립트 로드 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
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
            }
        }).open();
    }
	
 	// 결제 수단에 따라 은행 정보 입력란을 표시하거나 숨기는 함수
    function showBankInfo() {
        var paymentMethod = document.querySelector('input[name="payment_method"]:checked').value;

        var bankInfoDiv = document.getElementById("bankInfo");
        if (paymentMethod === "bank_transfer") {
        	// 무통장입금 선택 시 은행 정보 입력란 표시
            bankInfoDiv.style.display = "block";
        } else {
        	// 신용카드 선택 시 은행 정보 입력란 숨김
            bankInfoDiv.style.display = "none";
        }
    }
</script>
</head>
<body>
<h2>주문/결제</h2>

<% 
	// mem_num 파라미터로부터 회원 번호를 가져옴
    String memNum = request.getParameter("mem_num");
%>
<!-- 주문 정보를 입력받는 폼 -->
<form action="orderAction.jsp" method="post">  
    <h3>배송지</h3>
    회원번호: <input type="text" name="mem_num" required><br>
    받는 사람: <input type="text" name="order_name" required><br>
    휴대폰: <input type="text" name="order_hp" required><br>
    <!-- 우편번호 찾기 기능 -->
    <input type="text" id="postcode" name="order_zipcode" placeholder="우편번호" readonly required>
    <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
    <input type="text" id="address" name="order_addr" placeholder="주소" readonly required><br>
    <input type="text" id="detailAddress" name="order_address_detail" placeholder="상세주소" required><br>
    
    배송메세지: <textarea name="order_delivery_request"></textarea><br>
    
    <h3>주문상품</h3>
    <%
        // OrderDao를 사용하여 회원의 장바구니에 담긴 상품 정보를 가져옴
        OrderDao orderDao = new OrderDao();
        List<CartDto> cartItems = orderDao.getCartItemsByMember(memNum);
        
        // 가져온 상품 정보를 화면에 표시
        for (CartDto cartItem : cartItems) {
    %>
        <div>
            상품명: <%= cartItem.getPro_name() %><br>
            사이즈: <%= cartItem.getCart_size() %><br>
            색상: <%= cartItem.getCart_color() %><br>
            수량: <%= cartItem.getCart_su() %><br><br>
        </div>
    <%
        }
    %>
    
    
    <h3>결제 수단</h3>
    <input type="radio" name="payment_method" value="credit_card" onclick="showBankInfo()" required>신용카드<br>
    <input type="radio" name="payment_method" value="bank_transfer" onclick="showBankInfo()" required>무통장입금<br>
    
    <!-- 무통장입금 선택 시 보이는 입금 정보 입력란 -->
    <div id="bankInfo" style="display: none;">
         입금은행: 
    <select name="bank_name">
        <option value="">은행 선택</option>
        <option value="KB국민은행">KB국민은행 10987654321098 주식회사 모지홈</option>
        <option value="카카오뱅크">카카오뱅크 123456789101112 주식회사 모지홈</option>

        <!-- 기타 은행 추가 가능 -->
    </select><br>
        입금자명: <input type="text" name="depositor_name"><br>
    </div>
    
    <button type="submit">주문하기</button>
    
</form>

</body>
</html>
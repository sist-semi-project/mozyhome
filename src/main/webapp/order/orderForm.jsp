<%@page import="data.dto.ProductDto"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="data.dto.MemberDto"%>
<%@page import="data.dao.MemberDao"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="data.dao.CartDao"%>
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
String mem_id = (String) session.getAttribute("mem_id");  

MemberDao memberDao = new MemberDao();
MemberDto memberDto = memberDao.getMemberInfo(mem_id);

// 구매방법 여부
Boolean directPurchase = (Boolean) session.getAttribute("directPurchase"); //바로구매 ture, 장바구니 false

NumberFormat nf = NumberFormat.getInstance();
	
%>
<!-- 주문 정보를 입력받는 폼 -->
<form action="orderAction.jsp" method="post">  

	<h3>주문상품</h3>
    	<%  
    	String pro_main_img = "";// 상품 이미지
    	String pro_size = "";// 사이즈
    	String pro_color = "";// 색
    	String pro_su = "";// 수량
    	String pro_price = "";// 가격
    	String pro_name = "";// 상품명
    	String pro_num = "";// 상품 번호
    	
    	int totalProductPrice = 0; // 총 상품금액 	
	    int deliveryFee = 3000; // 배송비 설정
	    int finalPayment = 0; // 최종 결제 금액(총 상품금액 + 배송비)
	 	
    	if (directPurchase != null && directPurchase) {
		    // 제품 상세페이지에서 바로 구매하는 경우의 처리
    		
    		pro_num = request.getParameter("pro_num");
		    pro_su = request.getParameter("cnt"); 
    		pro_color = request.getParameter("color"); 
    		pro_size = request.getParameter("size");
    		
    		//해당상품에대한 데이터
    		ProductDao pdao = new ProductDao();
    		ProductDto pdto = pdao.getProduct(pro_num);
    		pro_main_img = pdto.getPro_main_img(); 
    		pro_name = pdto.getPro_name(); 
    		int price = pdto.getPro_price(); 

    		// 총 상품금액 계산 (상품 가격 * 수량)
			totalProductPrice = price * Integer.parseInt(pro_su);
			
%>
    		
    		<div style="overflow: hidden; margin-bottom: 20px;">
		    <div style="float: left; margin-right: 10px;">
		        <img src="<%=pro_main_img%>" width="100" height="100" style="border: 1px solid #ccc;">
		    </div>
		    <div style="float: left;">
		        <div><%=pro_name%></div>
		        <div>[옵션: <%=pro_size %>]</div>
		        <div>[옵션: <%=pro_color %>]</div>
		        <div>수량: <%=pro_su %></div>
		        <div>가격: <%=totalProductPrice %>원</div>
		    </div>
		</div>
		<%
    		
		} else {
		    // 장바구니에서 구매하는 경우의 처리
			CartDao cdao=new CartDao();
			List<HashMap<String,String>> list=cdao.getCartList(mem_id);
			
			for(int i=0; i<list.size(); i++ ){
				HashMap<String,String> map=list.get(i);
				pro_su = map.get("cart_su"); // 주문상세테이블에 들어갈 수???
				pro_num = map.get("pro_num"); // 주문상세테이블에 들어갈 상품 번호???
    	%>
	    <div style="overflow: hidden; margin-bottom: 20px;">
		    <div style="float: left; margin-right: 10px;">
		        <img src="<%=map.get("pro_main_img")%>" width="100" height="100" style="border: 1px solid #ccc;">
		    </div>
		    <div style="float: left;">
		        <div><%=map.get("pro_name") %></div>
		        <div>[옵션: <%=map.get("cart_size") %>]</div>
		        <div>[옵션: <%=map.get("cart_color") %>]</div>
		        <div>수량: <%=map.get("cart_su") %></div>
		        <div>가격: <%=map.get("pro_price") %>원</div>
		    </div>
		</div>

    	<%	
	    	}
			
			// 총 상품금액 계산
		    for (HashMap<String, String> map : list) {
		        int price = Integer.parseInt(map.get("pro_price"));
		        int quantity = Integer.parseInt(map.get("cart_su"));
		        totalProductPrice += (price * quantity);
		    }
			
		}
	
		%>
		
	<input type="hidden" name="pro_su" value="<%= pro_su %>">
	<input type="hidden" name="pro_num" value="<%= pro_num %>">
	<input type="hidden" name="pro_size" value="<%= pro_size %>">
	<input type="hidden" name="pro_color" value="<%= pro_color %>">

    <h3>배송지</h3>
    받는 사람: <input type="text" name="receiver_name" required><br>
    휴대폰: <input type="text" name="receiver_hp" required><br>
    <!-- 우편번호 찾기 기능 -->
    <input type="text" id="postcode" name="receiver_zipcode" placeholder="우편번호" readonly required>
    <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
    <input type="text" id="address" name="receiver_addr" placeholder="주소" readonly required><br>
    <input type="text" id="detailAddress" name="receiver_address_detail" placeholder="상세주소" required><br>
    배송메세지: <textarea name="order_delivery_request"></textarea><br>

    <h3>결제 정보</h3>
	
	<%
	
	// 총 상품금액이 100원 초과일 경우 무료배송
    if(totalProductPrice > 100){
    	deliveryFee = 0;
    }
    
    // 최종 결제 금액 계산
	finalPayment = totalProductPrice + deliveryFee;
	
	%>
	총 상품금액: <%= nf.format(totalProductPrice) %>원<br>
	배송비: <%= nf.format(deliveryFee) %>원<br>
	최종 결제금액: <%= nf.format(finalPayment) %>원<br>

    <input type="hidden" name="deliveryFee" value="<%= deliveryFee %>">
	<input type="hidden" name="finalPayment" value="<%= finalPayment %>">
	
    <h3>결제 수단</h3>
	<input type="radio" id="creditCard" name="payment_method" value="credit_card" onclick="showBankInfo()" required>
	<label for="creditCard">신용카드</label><br>
	<input type="radio" id="bankTransfer" name="payment_method" value="bank_transfer" onclick="showBankInfo()" required>
	<label for="bankTransfer">무통장입금</label><br>
	
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
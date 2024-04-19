<%@page import="data.dao.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="data.dao.OrderDetailDao"%>
<%@page import="data.dto.OrderDetailDto"%>
<%@page import="java.util.Date"%>
<%@page import="data.dao.OrderDao"%>
<%@page import="data.dto.OrderDto"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
//문자 인코딩 설정
request.setCharacterEncoding("utf-8");

//세션에서 회원 아이디 가져오기
String mem_id=(String)session.getAttribute("mem_id");

// MemberDao 인스턴스 생성
MemberDao memberDao = new MemberDao();

// 회원 번호 가져오기
String memNum = memberDao.getNum(mem_id); // dragon으로 id 임시 설정

String orderStatus = ""; // 주문상태 변수 선언

// 주문 정보 파라미터 받기
String orderName = request.getParameter("receiver_name"); // 받는 분 이름
String orderHp = request.getParameter("receiver_hp");  // 받는 분 연락처 
String orderDeliveryRequest = request.getParameter("order_delivery_request"); // 배송요청사항
String orderAddress = request.getParameter("receiver_zipcode") + " " + request.getParameter("receiver_addr") + " " +request.getParameter("receiver_address_detail"); // 받는 분 주소
String paymentMethod = request.getParameter("payment_method"); // 결제수단
int deliveryFee = Integer.parseInt(request.getParameter("deliveryFee")); // 배송비
int finalPayment = Integer.parseInt(request.getParameter("finalPayment")); // 최종 결제 금액
String proNum = request.getParameter("pro_num"); // 상품 번호
int proSu = Integer.parseInt(request.getParameter("pro_su")); // 상품 수

// 주문 번호 생성(날짜+순번)
SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
String today = sdf.format(new Date());
OrderDao Orderdao = new OrderDao();
int todayOrderCount = Orderdao.getOrderCountForToday() + 1;
String newOrderNumber = today + String.format("%04d", todayOrderCount);

if (paymentMethod.equals("credit_card")) { 
	// 카드 결제 처리
%>
<!-- 포트원 결제 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<script>
	IMP.init('imp30782762'); // IAMPORT 결제 모듈 초기화

	IMP.request_pay({ // 결제 요청
		pg : "html5_inicis.INIpayTest",
		pay_method : "card", // 결제 수단
		merchant_uid : "<%=newOrderNumber%>", // 주문번호
		name : "주문명:결제테스트", // 주문명
		amount : <%=finalPayment%>, // 결제 금액
		//구매자 정보 ↓
		buyer_email : "gildong@gmail.com",
		buyer_name : "홍길동",
		buyer_tel : "010-4242-4242",
		buyer_addr : "서울특별시 강남구 신사동",
		buyer_postcode : "01181"
	}, function(rsp) {
		// 결제 결과 콜백 함수
		if (rsp.success) { // 결제 성공 시 로직
            <%
            orderStatus = "결제완료";
            //OrderDto 객체 생성 및 데이터 설정
            OrderDto orderDto = new OrderDto();
            orderDto.setOrder_num(newOrderNumber);
            orderDto.setMem_num(memNum);
            orderDto.setOrder_status(orderStatus);
            orderDto.setOrder_delivery_request(orderDeliveryRequest);
            orderDto.setOrder_addr(orderAddress);
            orderDto.setOrder_name(orderName);
            orderDto.setOrder_hp(orderHp);
            orderDto.setOrder_delivery_fee(deliveryFee);
            orderDto.setOrder_total_payment(finalPayment);

            //DAO를 이용한 데이터베이스 저장
            Orderdao.insertOrder(orderDto);
            
            //주문 상세(OrderDetailDto) 정보 저장
            OrderDetailDto orderDetailDto = new OrderDetailDto();
            orderDetailDto.setMem_num(memNum);
            orderDetailDto.setPro_num(proNum);
            orderDetailDto.setOrder_num(newOrderNumber);
            orderDetailDto.setOrder_detail_su(proSu);

            OrderDetailDao orderDetailDao = new OrderDetailDao();
            orderDetailDao.insertOrder(orderDetailDto);
            %>
            // 결제 성공 후 리다이렉트
            location.href="orderComplete.jsp?orderNumber=<%= newOrderNumber %>";
        } else { // 결제 실패 시
        	 console.log(rsp); 
        	 alert(rsp.error_msg); 
        }
	});
</script>
<%

} else if (paymentMethod.equals("bank_transfer")) {
	// 무통장입금 결제 처리
	orderStatus = "입금대기";
	
	// 주문 정보 저장
	OrderDto orderDto = new OrderDto();
    orderDto.setOrder_num(newOrderNumber);
    orderDto.setMem_num(memNum);
    orderDto.setOrder_status(orderStatus);
    orderDto.setOrder_delivery_request(orderDeliveryRequest);
    orderDto.setOrder_addr(orderAddress);
    orderDto.setOrder_name(orderName);
    orderDto.setOrder_hp(orderHp);
    orderDto.setOrder_delivery_fee(deliveryFee);
    orderDto.setOrder_total_payment(finalPayment);
	
	Orderdao.insertOrder(orderDto);
	
	// 주문 상세 정보 저장
	OrderDetailDto orderDetailDto = new OrderDetailDto();
	orderDetailDto.setMem_num(memNum);
    orderDetailDto.setPro_num(proNum);
    orderDetailDto.setOrder_num(newOrderNumber);
    orderDetailDto.setOrder_detail_su(proSu);
	
	OrderDetailDao orderDetailDao = new OrderDetailDao();
	orderDetailDao.insertOrder(orderDetailDto);
	
	response.sendRedirect("orderComplete.jsp?orderNumber=" + newOrderNumber); // 주문 완료 페이지로 리다이렉트
}
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="data.dao.OrderDetailDao"%>
<%@page import="data.dto.OrderDetailDto"%>
<%@page import="java.util.Date"%>
<%@page import="data.dao.OrderDao"%>
<%@page import="data.dto.OrderDto"%>
<%@page import="java.text.SimpleDateFormat"%>

<%
request.setCharacterEncoding("utf-8");

String orderStatus = ""; // 주문상태 변수 선언
	
// 주문 정보 파라미터 받기
String memNum = request.getParameter("mem_num"); // 회원번호
String orderName = request.getParameter("order_name"); // 받는 분 이름
String orderHp = request.getParameter("order_hp");  // 받는 분 연락처 
String orderDeliveryRequest = request.getParameter("order_delivery_request"); // 배송요청사항
String orderAddress = request.getParameter("order_zipcode") + " " + request.getParameter("order_addr") + " " +request.getParameter("order_address_detail"); // 받는 분 주소
String paymentMethod = request.getParameter("payment_method"); // 결제수단

//임시 설정
int orderDeliveryFee = 0; // 배송비
int orderTotalPayment = 100; // 총 결제 금액
int orderDetailSu = 3; // 수량
String proNum = "2"; // 상품번호

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
		amount : <%=orderTotalPayment%>, // 결제 금액
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
            orderDto.setOrderNum(newOrderNumber);
            orderDto.setMemNum(memNum);
            orderDto.setOrderStatus(orderStatus);
            orderDto.setOrderDeliveryRequest(orderDeliveryRequest);
            orderDto.setOrderAddr(orderAddress);
            orderDto.setOrderName(orderName);
            orderDto.setOrderHp(orderHp);
            orderDto.setOrderDeliveryFee(orderDeliveryFee);
            orderDto.setOrderTotalPayment(orderTotalPayment);

            //DAO를 이용한 데이터베이스 저장
            Orderdao.insertOrder(orderDto);
            
            //주문 상세(OrderDetailDto) 정보 저장
            OrderDetailDto orderDetailDto = new OrderDetailDto();
            orderDetailDto.setMemNum(memNum);
            orderDetailDto.setProNum(proNum);
            orderDetailDto.setOrderNum(newOrderNumber);
            orderDetailDto.setOrderDetailSu(orderDetailSu);

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
	orderDto.setOrderNum(newOrderNumber);
	orderDto.setMemNum(memNum);
	orderDto.setOrderStatus(orderStatus);
	orderDto.setOrderDeliveryRequest(orderDeliveryRequest);
	orderDto.setOrderAddr(orderAddress);
	orderDto.setOrderName(orderName);
	orderDto.setOrderHp(orderHp);
	orderDto.setOrderDeliveryFee(orderDeliveryFee);
	orderDto.setOrderTotalPayment(orderTotalPayment);
	
	Orderdao.insertOrder(orderDto);
	
	// 주문 상세 정보 저장
	OrderDetailDto orderDetailDto = new OrderDetailDto();
	orderDetailDto.setMemNum(memNum);
	orderDetailDto.setProNum(proNum);
	orderDetailDto.setOrderNum(newOrderNumber);
	orderDetailDto.setOrderDetailSu(orderDetailSu);
	
	OrderDetailDao orderDetailDao = new OrderDetailDao();
	orderDetailDao.insertOrder(orderDetailDto);
	
	response.sendRedirect("orderComplete.jsp?orderNumber=" + newOrderNumber); // 주문 완료 페이지로 리다이렉트
}
%>
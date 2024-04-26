<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="data.dao.ProductDao"%>
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

//회원 아이디
String mem_id=(String)session.getAttribute("myid");

Boolean directPurchase = (Boolean) session.getAttribute("directPurchase"); //바로구매 ture, 장바구니 false

//회원 번호
MemberDao memberDao = new MemberDao();
String memNum = memberDao.getNum(mem_id);

// 주문 정보 파라미터 받기
String orderName = request.getParameter("receiver_name"); // 받는 분 이름
String orderHp = request.getParameter("receiver_hp");  // 받는 분 연락처 
String orderDeliveryRequest = request.getParameter("order_delivery_request"); // 배송요청사항
String orderAddress = request.getParameter("receiver_zipcode") + " " + request.getParameter("receiver_addr") + " " +request.getParameter("receiver_address_detail"); // 받는 분 주소
String paymentMethod = request.getParameter("payment_method"); // 결제수단
int deliveryFee = Integer.parseInt(request.getParameter("deliveryFee")); // 배송비
int finalPayment = Integer.parseInt(request.getParameter("finalPayment")); // 최종 결제 금액
String proNum = "";
int proSu =0;
String proColor ="";
String proSize = "";

//String proNum = request.getParameter("pro_num"); // 상품 번호
//int proSu = Integer.parseInt(request.getParameter("pro_su")); // 상품 수
//String proColor = request.getParameter("pro_color"); // 상품 색
//String proSize = request.getParameter("pro_size"); // 상품 사이즈

String orderStatus = ""; // 주문상태 변수 선언



//주문 가능 여부
ProductDao productDao = new ProductDao();
ProductDto productDto = productDao.getProduct(proNum);
int stockQuantity = productDto.getPro_stock(); // 재고량



if (proSu <= stockQuantity) {
 	// 주문 가능한 경우: 재고량이 충분한 경우
 	boolean increase = false;
	productDao.updateStockQuantity(proNum, proSu, increase);
 
} else {
 	// 주문 불가능한 경우: 재고량이 부족한 경우
	out.println("<script>");
    out.println("alert('재고량이 부족하여 주문할 수 없습니다.');");
    out.println("location.href='orderList.jsp';");
    out.println("</script>");
    return;
}




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
            if (directPurchase != null && directPurchase) {
            	// 제품 상세페이지에서 바로 구매하는 경우의 처리
            	
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
	            orderDetailDto.setOrder_size(proSize);
	            orderDetailDto.setOrder_color(proColor);
	            orderDetailDto.setOrder_detail_su(proSu);
	
	            OrderDetailDao orderDetailDao = new OrderDetailDao();
	            orderDetailDao.insertOrder(orderDetailDto);
  
            } else {
            	// 장바구니에서 구매하는 경우의 처리
            	List<HashMap<String,String>> cartItems = (List<HashMap<String,String>>) session.getAttribute("cartItems");
            	
            	// 가져온 상품 리스트를 이용하여 필요한 작업 수행
    			if (cartItems != null) {
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
    			    for (HashMap<String,String> map : cartItems) {
    			    	int pro_su = Integer.parseInt(map.get("cart_su"));			        
    			        String pro_num = map.get("pro_num");
    			        String pro_color = map.get("cart_color");
    			        String pro_size = map.get("cart_size");
    			        
    			        //out.println("상품 수량: " + pro_su + ", 상품 번호: " + pro_num + ", 색상: " + pro_color + ", 사이즈: " + pro_size + "<br>");
    			    	
    			     	// 주문 상세 정보 저장
    			    	OrderDetailDto orderDetailDto = new OrderDetailDto();
    			    	orderDetailDto.setMem_num(memNum);
    			        orderDetailDto.setPro_num(pro_num);
    			        orderDetailDto.setOrder_num(newOrderNumber);
    			        orderDetailDto.setOrder_size(pro_size);
    			        orderDetailDto.setOrder_color(pro_color);
    			        orderDetailDto.setOrder_detail_su(pro_su);
    			    	
    			    	OrderDetailDao orderDetailDao = new OrderDetailDao();
    			    	orderDetailDao.insertOrder(orderDetailDto);
    			    
    			    
    			    }
    			}
            	
            	
            	
            	
            }
        	    
            
            
            
            %>
            // 결제 성공 후 리다이렉트

			location.href="index.jsp?main=order/orderComplete.jsp?orderNumber=<%= newOrderNumber %>";
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
	
	if (directPurchase != null && directPurchase) {
	    // 제품 상세페이지에서 바로 구매하는 경우의 처리
	    
	    proNum = request.getParameter("pro_num"); // 상품 번호
		proSu = Integer.parseInt(request.getParameter("pro_su")); // 상품 수
		proColor = request.getParameter("pro_color"); // 상품 색
		proSize = request.getParameter("pro_size"); // 상품 사이즈
	    
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
	    orderDetailDto.setOrder_size(proSize);
	    orderDetailDto.setOrder_color(proColor);
	    orderDetailDto.setOrder_detail_su(proSu);
		
		OrderDetailDao orderDetailDao = new OrderDetailDao();
		orderDetailDao.insertOrder(orderDetailDto);
	}else {
		// 장바구니에서 구매하는 경우의 처리
		List<HashMap<String,String>> cartItems = (List<HashMap<String,String>>) session.getAttribute("cartItems");
		
			// 가져온 상품 리스트를 이용하여 필요한 작업 수행
			if (cartItems != null) {
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
			    for (HashMap<String,String> map : cartItems) {
			    	int pro_su = Integer.parseInt(map.get("cart_su"));			        
			        String pro_num = map.get("pro_num");
			        String pro_color = map.get("cart_color");
			        String pro_size = map.get("cart_size");
			        
			        //out.println("상품 수량: " + pro_su + ", 상품 번호: " + pro_num + ", 색상: " + pro_color + ", 사이즈: " + pro_size + "<br>");
			    	
			     	// 주문 상세 정보 저장
			    	OrderDetailDto orderDetailDto = new OrderDetailDto();
			    	orderDetailDto.setMem_num(memNum);
			        orderDetailDto.setPro_num(pro_num);
			        orderDetailDto.setOrder_num(newOrderNumber);
			        orderDetailDto.setOrder_size(pro_size);
			        orderDetailDto.setOrder_color(pro_color);
			        orderDetailDto.setOrder_detail_su(pro_su);
			    	
			    	OrderDetailDao orderDetailDao = new OrderDetailDao();
			    	orderDetailDao.insertOrder(orderDetailDto);
			    
			    
			    }
			}
	}
	
%>
<script>
location.href="index.jsp?main=order/orderComplete.jsp?orderNumber=<%= newOrderNumber %>";
</script>

<%
}
%>
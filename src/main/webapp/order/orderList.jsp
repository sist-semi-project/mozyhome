<%@page import="data.dto.OrderDetailDto"%>
<%@page import="data.dao.OrderDetailDao"%>
<%@page import="data.dto.MemberDto"%>
<%@page import="data.dao.MemberDao"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="data.dto.OrderDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>
<title>주문 목록</title>
<style type="text/css">

.displaynone {
    display: none;
}

.center {
    text-align: center;
}

.order_list {
    padding: 40px 16px 0;
    background: transparent;
}

.order_table {
    display: block;
    width: 100%;
}

.order_tbody {
    row-gap: 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}

.order_tr {
    display: block;
    width: 100%;
}

.order_td {
    width: 100%;
    display: block;
}

.order_top {
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin-bottom: 8px;
}

.order_top .order_date {
    font-size: 14px;
    font-weight: 700;
    line-height: 17px;
    color: #141414;
}

.order_top .order_detail {
    display: flex;
    align-items: center;
    justify-content: center;
    column-gap: 4px;
    font-size: 12px;
    font-weight: 500;
    line-height: 14px;
    color: #333;
}

.order_top .order_detail > span {
    display: inline-block;
    margin-top: 2px;
}

.order_body {
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    justify-content: flex-start;
    padding: 4px 16px;
    border-radius: 4px;
    border: 1px solid #ECECEC;
    box-sizing: border-box;
    background: white;
    width: 100%;
}

.order_body .order_id {
    font-size: 12px;
    line-height: 14px;
    color: #333;
    width: 100%;
    padding: 12px 0;
    text-align: left;
}

.order_body .body_main {
    border-bottom: 1px solid #ECECEC;
    border-top: 1px solid #ECECEC;
    column-gap: 16px;
    padding: 12px 0;
    display: flex;
    align-items: flex-start;
    justify-content: flex-start;
    width: 100%;
}

.order_body .body_main img {
    width: 76px;
    height: 76px;
}

.order_body .body_main .info {
    display: flex;
    flex-direction: column;
    flex: 1 1 0%;
    align-items: flex-start;
    justify-content: center;
    text-align: left;
}

.body_main .info .product_name {
    font-size: 13px;
    font-weight: 400;
    line-height: 21px;
    color: #333;
    margin-bottom: 4px;
}

.body_main .info .product_option {
    width: 70%;
    font-size: 12px;
    line-height: 14px;
    color: #929292;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    padding-bottom: 12px;
}

.body_main .info .price {
    display: flex;
    align-items: center;
    justify-content: flex-start;
    column-gap: 21px;
}

.body_main .info .price p {
    position: relative;
    font-size: 14px;
    font-weight: 500;
    line-height: 17px;
    color: #616161;
}

.body_main .info .price p:first-child::after {
    content: '';
    position: absolute;
    display: block;
    width: 1px;
    height: 12px;
    top: 2px;
    right: -10px;
    background: #C7C7C7;
}

.order_foot {
    padding: 13px 0;
    width: 100%;
    display: flex;
    align-items: center;
    justify-content: space-between;
}

.order_foot .order_status {
    font-size: 14px;
    font-weight: 600;
    line-height: 17px;
    color: #EA6000;
}

.order_foot .order_update {
    display: flex;
    align-items: center;
    justify-content: flex-end;
    column-gap: 12px;
}

.order_foot .order_update a {
    font-size: 12px;
    line-height: 14px;
    color: #929292;
    text-decoration: underline;
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

page-title {
    text-align: center;
    font-size: 24px;
    font-weight: 700;
    letter-spacing: 5px;
    color: #222;
    line-height: 27px;
    padding-top: 75px;
    padding-bottom: 60px;
}
</style>
</head>
<body>
<div id="body">
	<div id="body-begin"></div>
	<div class="sub_container">
		<h1 class="page-title">ORDER LIST</h1>
		<div class="order_history">
			<section class="orders_wrap">
				<div class="xans-element- xans-myshop xans-myshop-orderhistorylistitem ec-base-table typeList">
					<div class="order_list ">
						<table class="order_table">
							<thead style="display: none;">
								<tr>
									<th scope="col">주문일자<br>[주문번호]</th>
						            <th scope="col">이미지</th>
						            <th scope="col">상품정보</th>
						            <th scope="col">수량</th>
						            <th scope="col">상품구매금액</th>
						            <th scope="col">주문처리상태</th>
						            <th scope="col">취소/교환/반품</th>
					       		</tr>
					       	</thead>
					       	<tbody class="center order_tbody ">
					       		<% 
						            String mem_id = (String) session.getAttribute("mem_id"); 
					       			
						       		MemberDao memberDao = new MemberDao();
						       		MemberDto memberDto = memberDao.getMemberInfo(mem_id);
					       			
						       		String mem_num = memberDto.getMem_num();
						       		
					                // 주문 목록을 가져오는 부분
					                OrderDao orderDao = new OrderDao();
					                List<OrderDto> orderList = orderDao.getOrdersByMember(mem_num);
					                
					                
					                
					                // 각 주문을 테이블에 표시
					                for (OrderDto order : orderList) {
					                	
					                	String order_num = order.getOrder_num();
					                	
					                	OrderDetailDao orderDetailDao = new OrderDetailDao();
					                	OrderDetailDto orderDetailDto = orderDetailDao.getOrderDetailsByMember(order_num);
					                	System.out.println("주문번호"+order_num);
					                	System.out.println(orderDetailDto.getMem_num());
					                	
					            %>
					       		<tr class="order_tr xans-record-">
									<td class="order_td">
				                    	<div class="order_top">
				                                    <p class="order_date"><%= new SimpleDateFormat("yyyy-MM-dd").format(order.getOrder_date()) %></p>
				                                    <a href="#" class="order_detail">
				                                        <span>상세보기</span>
				                                        <svg width="18" height="18" viewbox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7.05002 12.95L6.52502 12.425L9.97502 8.975L6.52502 5.525L7.05002 5L11.025 8.975L7.05002 12.95Z" fill="black"></path></svg></a>
				                        </div>
				                        <div class="order_body">
				                            <a href="#" class="order_id">주문번호 : <%= order_num %></a>
				                            <div class="body_main">
				                                <a href="/product/detail.html?product_no=14801&cate_no=1"><img src="https://via.placeholder.com/150" onerror="this.src='//img.echosting.cafe24.com/thumb/img_product_small.gif';" alt=""></a>
				                                <div class="info">
				                                    <p class="product_name">미니 손잡이 와인쿨러</p>
				                                    <p class="product_option">[5-6주 제작 기간이 소요됩니다. 확인 후 구매 부탁드립니다. : 1]</p>
				                                    <div class="price">
				                                        <p>&#8361;<%= order.getOrder_total_payment() %></p>
				                                        <p><%= orderDetailDto.getOrder_detail_su()%>개</p>
				                                    </div>
				                                </div>
				                            </div>
				                            <div class="order_foot">
				                                <p class="order_status"><%= order.getOrder_status() %></p>
				                                <div class="order_update ">
				                                	<% 
					                                    if (order.getOrder_status().equals("입금대기")) { 
					                                %>
				                                		<a href="#" class="btnNormal">취소신청</a>
				                                	<% } else if (order.getOrder_status().equals("배송중")) { %>	
				                                		<a href="#" class="btnNormal">배송조회</a>
				                                	<% } else if (order.getOrder_status().equals("배송완료")) { %>
					                                	<a href="#" class="btnNormal">구매후기</a>
	                                				<% } %>
				                                </div>
				                            </div>
				                        </div>
				                    </td>
				            	</tr>
				            	<% } %>
					       	</tbody>
						</table>
					</div>
				</div>
			</section>
		</div>
	</div>
	<div id="body-end"></div>
</div>





</body>
</html>
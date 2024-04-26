<%@page import="java.util.List"%>
<%@page import="data.dto.OrderDetailDto"%>
<%@page import="data.dao.OrderDetailDao"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="data.dao.ProductDao"%>
<%@page import="data.dto.OrderDto"%>
<%@page import="data.dao.OrderDao"%>
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
.xans-myshop-orderhistorydetail .orderArea:first-child .title {
    margin-top: 0;
}

.boardView {
    border-top: 1px solid #616161;
    border-bottom: 1px solid #616161;
}
.boardView table {
    width: 100%;
    table-layout: fixed;
    color: #353535;
    line-height: 1.5;
}

.boardView tr {
    display: flex;
}
.boardView th {
    display: flex;
    align-items: center;

    color: #616161;
    width: 97px;
    padding: 12px 0 12px 10px;
    font-weight: 500;
    text-align: left;
    border-top: 1px solid #e9e9e9;
    background-color: #F5F5F5;
}

.boardView td {

    color: #616161;
    flex: 1;
    padding: 12px;
    border-top: 1px solid #e9e9e9;
}
.boardView tbody tr:first-child th, .boardView tbody tr:first-child td {
    border-top: 0;
}

.boardView img {
    vertical-align: middle;
}
.ec-base-table .message {
    padding: 7rem 0;
    text-align: center;
    font-size: 1.4rem;
    font-weight: 400;
    color: #616161;
    margin: 16px;
    background-color: #F5F5F5;
    border-radius: 8px;
}
.typeList {
    border-radius: 4px;
    border: 1px solid #D8D8D8;
}
.order_title {
    display: flex;
    justify-content: space-between;
    padding: 16px;
    background-color: #F5F5F5;
    border-radius: 4px 4px 0 0;
    font-size: 12px;
    font-weight: 400;
    color: #929292;
}
.order_title > p:nth-child(2) {
    color: #141414;
}
.boardList {
    width: 100%;
    table-layout: fixed;
    margin: 0 0 1px;
    color: #353535;
    line-height: 1.5;
}
.boardList th {
    padding: 11px 0 9px;
    border-left: 1px solid #e9e9e9;
    font-weight: normal;
    background: #fbfafa;
}
.boardList th:first-child {
    border-left: 0;
}
.boardList td {
    text-align: left;
    vertical-align: middle;
    word-wrap: break-word;
}
.boardList .name {
    font-size: 14px;
    font-weight: 500;
    color: #333;
}
.boardList .option {
    margin-top: 4px;
    font-size: 12px;
    font-weight: 400;
    color: #929292;
}
.boardList .price_info {
    display: flex;
    gap: 20px;
    font-size: 14px;
    font-weight: 500;
    color: #616161;
    margin-top: 12px;
}

.boardList .price_info > li {
    position: relative;
}

.boardList .price_info > li::after {
    content: "";
    display: block;
    position: absolute;
    top: 50%;
    right: -10px;
    transform: translate(0,-50%);
    width: 1px;
    height: 75%;
    background-color: #C7C7C7;
}
.boardList tbody tr {
    width: 100%;
    box-sizing: border-box;
    padding: 16px;
    display: flex;
    gap: 16px;
    border-bottom: 1px solid #D8D8D8;
}
.center {
    text-align: center;
}
.left {
    text-align: left;
}
.boardList .thumb {
    width: 92px;
}
.xans-myshop-orderhistorydetail {
    padding: 0 16px;
}

.xans-myshop-orderhistorydetail .title {
    margin: 28px 0 12px;
}

.xans-myshop-orderhistorydetail .title h3 {
    font-size: 1.6rem;
    font-weight: 700;
    color: #141414;
}
html,body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,code,form,fieldset,legend,input,textarea,p,blockquote,th,td,img {
    margin: 0;
    padding: 0;
    color: #353535;
}
div {
    display: block;
    unicode-bidi: isolate;
}
h3 {
    display: block;
    font-size: 1.17em;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    font-weight: bold;
    unicode-bidi: isolate;
}
</style>
<% 
	String mem_id = (String) session.getAttribute("myid");
	MemberDao mdao = new MemberDao();
	MemberDto mdto = mdao.getMemberInfo(mem_id);	       			
	
	String order_num = request.getParameter("order_num");
	OrderDao odao = new OrderDao();
	OrderDto odto = odao.getOneData(order_num);
	
    
	OrderDetailDao odtdao = new OrderDetailDao();
	OrderDetailDto odtdto = odtdao.getOrderDetailsByMember(order_num);
	String pro_num = odtdto.getPro_num();	
	ProductDao productDao = new ProductDao();
	ProductDto pdto = productDao.getProduct(pro_num);
	// ProductDao 인스턴스 생성
    

    // getProduct 메서드를 사용하여 상품 정보 가져오기
%>
</head>
<body>
<div id="body">
<div id="body-begin"></div>
<div class="sub_container">
	<h1 class="page-title">주문정보</h1>
	<form id="detailForm" name="detailForm" action="#" method="POST">
	<div class="xans-myshop-orderhistorydetail">
	<!-- 주문정보 -->
	<div class="orderArea">
		<div class="title">
        	
		</div>

       <div class="boardView">
           <table border="0">
               <tbody>
						<tr>
						<th scope="row">주문번호</th>
							<td><%=odto.getOrder_num() %></td>
						</tr>
						
						<tr>
						<th scope="row">주문일자</th>
							<td><%=odto.getOrder_date()%></td>
						</tr>
						                        
						<tr>
						<th scope="row">주문자</th>
							<td><span class="authssl_order_name"><%=mdto.getMem_name() %></span></td>
						</tr>
				
						<tr>
						<th scope="row">주문처리상태</th>
							<td><%=odto.getOrder_status()%></td>
						</tr>
				</tbody>
			</table>
		</div>
    </div>
    
    
    <!-- 주문 상품 정보 -->
	<div class="orderArea order_item">
    	<div class="title">

        </div>

        <div class="ec-base-table typeList">
            <div class="order_title">
                <p>주문번호: <%=odto.getOrder_num() %></p>
                <p><%=odto.getOrder_status()%></p>
            </div>
            <table border="0" class=" boardList">
            <%
            
         	// OrderDetailDao 인스턴스 생성
            OrderDetailDao orderDetailDao = new OrderDetailDao();
            
         	// getOrderDetails 메서드를 사용하여 주문 목록 가져오기
            List<OrderDetailDto> orderDetails = orderDetailDao.getOrderDetails(order_num);
            
         	// 주문 목록을 화면에 출력
            if (orderDetails != null && !orderDetails.isEmpty()) {
            	for (OrderDetailDto orderDetail : orderDetails) {
            		
            		// 각 주문 상세 정보에서 상품 번호를 가져옴
                    String p_num = orderDetail.getPro_num();
            		//System.out.println("상품 번호: " + p_num);
            		
            		// ProductDao 인스턴스 생성
                    ProductDao pDao = new ProductDao();

                    // getProduct 메서드를 사용하여 상품 정보 가져오기
                    ProductDto pDto = pDao.getProduct(p_num);
                    
                    //System.out.println("상품 번호: " + p_num + "상품명: " + pDto.getPro_name()+"상품 가격: "+ pDto.getPro_price());
            %>
            	<rowsgroup><row style="width: 79px"></row><row style="width: auto"></row></rowsgroup>
				<tbody class="center">
				<tr class="xans-record-">
					<td class="thumb">
						<a href="index.jsp?main=product/detailpage.jsp?pro_num=<%=p_num %>"><img src="<%=pDto.getPro_main_img()%>"></a>
		            </td>
					<td class="left">
					    <strong class="name"><%= pDto.getPro_name() %></strong>
					    <div class="option ">[옵션: <%=orderDetail.getOrder_color()%>: <%=orderDetail.getOrder_size()%>]</div>
						<ul class="price_info">
							<li class=""><strong>&#8361;<%=pDto.getPro_price()%></strong></li>
							<li><%=orderDetail.getOrder_detail_su()%>개</li>
						</ul>
					</td>
				</tr>
				</tbody>
				<%
            	}
            }
            %>
            <!--  
				<rowsgroup><row style="width: 79px"></row><row style="width: auto"></row></rowsgroup>
				<tbody class="center">
				<tr class="xans-record-">
					<td class="thumb">
						<a href="index.jsp?main=product/detailpage.jsp?pro_num=<%=pro_num %>"><img src="<%=pdto.getPro_main_img()%>"></a>
		            </td>
					<td class="left">
					    <strong class="name"><%= pdto.getPro_name() %></strong>
					    <div class="option ">[옵션: <%=odtdto.getOrder_color()%>: <%=odtdto.getOrder_size()%>]</div>
						<ul class="price_info">
							<li class=""><strong>&#8361;<%=pdto.getPro_price()%></strong></li>
							<li><%=odtdto.getOrder_detail_su()%>개</li>
						</ul>
					</td>
				</tr>
				</tbody>
				-->
			</table>
		</div>

    </div>
    <!-- 배송지정보 -->
<div class="orderArea">
            <div class="title">

            </div>
            <div class="boardView">
                <table border="0">
                    <tbody>
<tr>
<th scope="row">받으시는분</th>
                            <td><span class="authssl_delivery_name"><%=odto.getOrder_name() %></span></td>
                        </tr>

<tr>
<th scope="row">배송지</th>
                            <td><span class="authssl_delivery_rzipcode"><%=odto.getOrder_addr() %></span></td>
                        </tr>


<tr>
<th scope="row">휴대전화</th>
                            <td><span class="authssl_delivery_rphone_2"><%=odto.getOrder_hp() %></span></td>
                        </tr>
<tr>
<th scope="row">배송메시지</th>
                            <td><span class="authssl_delivery_message"><%=odto.getOrder_delivery_request() %></span></td>
                        </tr>

</tbody>
</table>
</div>
        </div>
        </div>
	</form>
</div>
<div id="body-end"></div>
</div>
</body>
</html>
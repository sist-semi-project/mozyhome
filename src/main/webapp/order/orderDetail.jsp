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
<% 
	String mem_id = (String) session.getAttribute("mem_id");
	MemberDao mdao = new MemberDao();
	MemberDto mdto = mdao.getMemberInfo(mem_id);//임시설정		       			
	
	String order_num = request.getParameter("order_num");
	OrderDao odao = new OrderDao();
	OrderDto odto = odao.getOneData(order_num);

	OrderDetailDao odtdao = new OrderDetailDao();
	OrderDetailDto odtdto = odtdao.getOrderDetailsByMember(order_num);
	String pro_num = odtdto.getPro_num();
	ProductDao pdao = new ProductDao();
	ProductDto pdto = pdao.getProduct(pro_num); 
%>
</head>
<body>
<div id="body">
<div id="body-begin"></div>

	<h1 class="page-title">ORDER INFO</h1>
	<form id="detailForm" name="detailForm" action="#" method="POST">
	<!-- 주문정보 -->
	<div class="orderArea">
		<div class="title">
        	<h3>주문정보</h3>
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
        	<h3>주문상품</h3>
        </div>

        <div class="ec-base-table typeList">
            <div class="order_title">
                <p>주문번호: <%=odto.getOrder_num() %></p>
                <p><%=odto.getOrder_status()%></p>
            </div>
            <table border="0" class=" boardList">
			<rowsgroup><row style="width: 79px"></row><row style="width: auto"></row></rowsgroup>
			<tbody class="xans-element- xans-myshop xans-myshop-orderhistorydetailbasic center">
			<tr class="xans-record-">
			<td class="thumb">
				<a href="/product/detail.html?product_no=8582&cate_no=1057"><img src="<%=pdto.getPro_main_img()%>"></a>
            </td>
			<td class="left">
			    <strong class="name"><a href = "index.jsp?main=product/detailpage.jsp?pro_num=<%=pro_num %>" class="ec-product-name" ><%= pdto.getPro_name() %></a></strong>
			    <div class="option ">[옵션: <%=odtdto.getOrder_color()%>: <%=odtdto.getOrder_size()%>]</div>
				<ul class="price_info">
				<li class="">
				<strong>&#8361;<%=odto.getOrder_total_payment()%></strong>
				    <div class="displaynone">
				</div>
				</li>
				<li><%=odto.getOrder_status()%>개</li>
				</ul>
			</td>
			</tr>
			</tbody>
			</table>
		</div>

    </div>
    <!-- 배송지정보 -->
<div class="orderArea">
            <div class="title">
                <h3>배송지정보</h3>
            </div>
            <div class="boardView">
                <table border="0" summary="">
<caption>
                        배송지정보
                    </caption>
                    <tbody>
<tr>
<th scope="row">받으시는분</th>
                            <td><span class="authssl_delivery_name"><%=odto.getOrder_name() %></span></td>
                        </tr>

<tr>
<th scope="row">우편번호</th>
                            <td><span class="authssl_delivery_rzipcode"><%=odto.getOrder_addr() %></span></td>
                        </tr>
<tr>
<th scope="row">주소</th>
                            <td><span class="authssl_delivery_raddr">*****</span></td>
                        </tr>
<tr class="displaynone">
<th scope="row">도시</th>
                            <td></td>
                        </tr>
<tr class="displaynone">
<th scope="row">주/지방</th>
                            <td></td>
                        </tr>

<tr>
<th scope="row">휴대전화</th>
                            <td><span class="authssl_delivery_rphone_2"><%=odto.getOrder_addr() %></span></td>
                        </tr>
<tr>
<th scope="row">배송메시지</th>
                            <td><span class="authssl_delivery_message"><%=odto.getOrder_delivery_request() %></span></td>
                        </tr>

</tbody>
</table>
</div>
        </div>
	</form>
<div id="body-end"></div>
</div>
</body>
</html>
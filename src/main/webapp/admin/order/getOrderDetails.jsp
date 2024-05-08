<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="data.dao.OrderDao" %>
<%@ page import="data.dto.OrderDto" %>
<%@ page import="data.dao.OrderDetailDao" %>
<%@ page import="data.dto.OrderDetailDto" %>
<%@ page import="java.util.List" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-04-25
  Time: 오전 10:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm");

    String orderNum = request.getParameter("orderNum");

    OrderDao dao = new OrderDao();
    OrderDetailDao detailDao = new OrderDetailDao();

    OrderDto dto = dao.getOrderDetailForAdmin(orderNum);
    List<OrderDetailDto> odList = detailDao.getAllOrderDetail(orderNum);

    JSONObject orderDetails = new JSONObject();

    //--  주문시간, 주문번호, 주문자명, 받는사람(배송지명), 주문금액,배송메세지,배송주소,배송지전화번호, 주문상태 from order_info
    orderDetails.put("order_date",sdf.format(dto.getOrder_date()));
    orderDetails.put("order_num", dto.getOrder_num());
    orderDetails.put("customer_name", dto.getMem_name());
    orderDetails.put("receiver_name", dto.getOrder_name());
    orderDetails.put("total_payment", dto.getOrder_total_payment());
    orderDetails.put("delivery_request", dto.getOrder_delivery_request());
    orderDetails.put("order_addr", dto.getOrder_addr());
    orderDetails.put("order_hp", dto.getOrder_hp());
    orderDetails.put("order_status", dto.getOrder_status());

    // 주문 상품 목록을 JSONArray로 관리
    JSONArray products = new JSONArray();

    for (OrderDetailDto odDto : odList) {
        JSONObject product = new JSONObject();

        //-상품명,상품가격, 사이즈옵션, 색상옵션, 개수  from order_detail (여러개)
        product.put("pro_name", odDto.getPro_name());
        product.put("pro_price", odDto.getPro_price());
        product.put("pro_size", odDto.getOrder_size());
        product.put("pro_color", odDto.getOrder_color());
        product.put("pro_count",odDto.getOrder_detail_su());
        product.put("pro_main_img",odDto.getPro_main_image());

        products.add(product);
    }
    orderDetails.put("products", products);

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(orderDetails.toString());

%>

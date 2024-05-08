<%@ page import="data.dao.OrderDao" %>
<%@ page import="org.json.simple.JSONObject" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-04-24
  Time: 오후 5:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    OrderDao dao = new OrderDao();
    int totalUpdated = 0;

    String orderStatus = request.getParameter("selectedStatus");
    String[] selectedOrders = request.getParameterValues("selectedOrders");

    String convertStatus="";


    if (orderStatus.equals("waiting_for_payment")) {
        convertStatus = "입금대기";
    } else if (orderStatus.equals("payment_completed")) {
        convertStatus = "결제완료";
    } else if (orderStatus.equals("shipping")) {
        convertStatus = "배송중";
    } else if (orderStatus.equals("delivered")) {
        convertStatus = "배송완료";
    } else if (orderStatus.equals("order_cancelled")) {
        convertStatus = "주문취소";
    }
    totalUpdated = dao.updateOrderStatus(orderStatus, selectedOrders);

    JSONObject ob = new JSONObject();
    if (totalUpdated > 0) {
        ob.put("updateCount", totalUpdated);
        ob.put("order_status", convertStatus);
        ob.put("is_update", true);
    } else {
        ob.put("is_update", false);
    }
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(ob.toString());

%>
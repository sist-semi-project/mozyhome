<%@ page import="data.dao.ProductDao" %>
<%@ page import="org.json.simple.JSONObject" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-04-26
  Time: 오전 3:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    ProductDao dao = new ProductDao();
    int totalUpdated = 0;

    String saleStatus = request.getParameter("selectedStatus");
    String[] selectedProducts = request.getParameterValues("selectedProducts");

    String convertStatus="";

    if (saleStatus.equals("on_sale")) {
        convertStatus = "판매중";
    } else if (saleStatus.equals("out_of_stock")) {
        convertStatus = "품절";
    } else if (saleStatus.equals("discontinued")) {
        convertStatus = "단종";
    }

    totalUpdated = dao.updateSaleStatus(saleStatus, selectedProducts);

    JSONObject ob = new JSONObject();
    if (totalUpdated > 0) {
        ob.put("updateCount", totalUpdated);
        ob.put("sale_satus", convertStatus);
        ob.put("is_update", true);
    } else {
        ob.put("is_update", false);
    }
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(ob.toString());

%>

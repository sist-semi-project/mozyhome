<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="data.dao.ProductDao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String num = request.getParameter("num");
    ProductDao dao = new ProductDao();


    JSONObject ob = new JSONObject();

    if (dao.deleteProduct(num)>0) {
        ob.put("success", "true");
        ob.put("delete_product_id", num);
    } else {
        ob.put("success", "false");
    }

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(ob.toString());

%>
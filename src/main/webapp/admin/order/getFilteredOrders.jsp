<%@ page import="data.dto.OrderDto" %>
<%@ page import="data.dao.OrderDao" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="oracle.jdbc.driver.json.ErrorMessagesJson_ja" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.*" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-04-24
  Time: 오후 12:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    OrderDao dao = new OrderDao();
    SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
    NumberFormat format = NumberFormat.getInstance(Locale.KOREA);

    //page, 검색타입, 검색어, 날짜
    int selectedPage = Integer.parseInt(request.getParameter("page"))-1;
    String searchType = request.getParameter("searchType"); // orderer_name, product_name, order_num
    String searchText = request.getParameter("searchText");
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");

    Map<String, Object> sqlParams = new HashMap<>();

    sqlParams.put("page", selectedPage);
    sqlParams.put("startDate", startDate);
    sqlParams.put("endDate", endDate);
    sqlParams.put("searchType", searchType);
    sqlParams.put("searchText", searchText);

    List<OrderDto> list = new ArrayList<OrderDto>();
    list = dao.getFilteredOrders(sqlParams);

    JSONArray arr = new JSONArray();

    for (OrderDto dto : list) {
        JSONObject ob=new JSONObject();
        ob.put("order_date", sdf.format(dto.getOrder_date()));
        ob.put("order_num", dto.getOrder_num());
        ob.put("product_name", dto.getPro_name());
        ob.put("orderer_name", dto.getMem_name());
        ob.put("payment_amount", format.format(dto.getOrder_total_payment()));
        ob.put("order_status", dto.getOrder_status());

        arr.add(ob);
    }
    JSONObject finalob = new JSONObject();
    finalob.put("orders", arr);
    if (list.size() > 0) {
        finalob.put("result_count", list.get(0).getTotalCount());
    } else {
        finalob.put("result_count", 0);
    }

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(finalob.toString());


%>


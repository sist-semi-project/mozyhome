<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="data.dao.ProductDao" %>
<%@ page import="data.dto.ProductDto" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.*" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-04-16
  Time: 오후 4:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    ProductDao dao = new ProductDao();
    SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
    NumberFormat format = NumberFormat.getInstance(Locale.KOREA);

    int selectedPage = Integer.parseInt(request.getParameter("page"));
    int pageSize = Integer.parseInt(request.getParameter("pageSize"));

    int startIndex = (selectedPage-1)*pageSize;


    List<ProductDto> list = new ArrayList<ProductDto>();
    list = dao.getAllProductPagingForAdmin(startIndex,pageSize);

    JSONArray arr =new JSONArray();

    for(ProductDto dto:list)
    {
        JSONObject ob=new JSONObject();

        ob.put("pro_num", dto.getPro_num());
        ob.put("parent_cate_num", dao.getCategoryName(dto.getParent_cate_num()));
        ob.put("cate_num", dao.getCategoryName(dto.getCate_num()));
        ob.put("pro_name", dto.getPro_name());
        ob.put("pro_price", format.format(dto.getPro_price()));
        ob.put("pro_stock", dto.getPro_stock());
        ob.put("pro_sale_status", dto.getPro_sale_status());
        ob.put("pro_main_img", dto.getPro_main_img());
        ob.put("pro_create_date", sdf.format(dto.getPro_create_date()));
        ob.put("pro_sale_volume", dto.getPro_sale_volume());

        arr.add(ob);
    }
    JSONObject finalob = new JSONObject();
    finalob.put("products", arr);
    if (list.size() > 0) {
        finalob.put("result_count", list.get(0).getTotalCount());
    } else {
        finalob.put("result_count", 0);
    }


    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(finalob.toString());

%>
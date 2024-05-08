<%@ page import="data.dto.ProductDto" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="data.dao.ProductDao" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-04-22
  Time: 오전 9:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");
    NumberFormat format = NumberFormat.getInstance(Locale.KOREA);

    String productId = request.getParameter("productId");
    ProductDao dao = new ProductDao();
    ProductDto dto = dao.getOneProductDetail(productId);


    JSONObject ob=new JSONObject();

    ob.put("pro_num", dto.getPro_num());
    ob.put("parent_cate_num", dao.getCategoryName(dto.getParent_cate_num()));
    ob.put("cate_num", dao.getCategoryName(dto.getCate_num()));
    ob.put("pro_name", dto.getPro_name());
    ob.put("pro_explain", dto.getPro_explain());
    ob.put("pro_size", dto.getPro_size());
    ob.put("pro_color", dto.getPro_color());
    ob.put("pro_price", format.format(dto.getPro_price()));
    ob.put("pro_stock", dto.getPro_stock());
    ob.put("pro_sale_status", dto.getPro_sale_status());
    ob.put("pro_main_img", dto.getPro_main_img());
    ob.put("pro_sub_img1", dto.getPro_sub_img1());
    ob.put("pro_sub_img2", dto.getPro_sub_img2());
    ob.put("pro_sub_img3", dto.getPro_sub_img3());
    ob.put("pro_sub_img4", dto.getPro_sub_img4());
    ob.put("pro_sub_img5", dto.getPro_sub_img5());
    ob.put("pro_create_date", sdf.format(dto.getPro_create_date()));
    ob.put("pro_sale_volume", dto.getPro_sale_volume());
    ob.put("pro_wishlist_count", dto.getWishCount());
    ob.put("pro_review_count", dto.getReviewCount());

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(ob.toString());
%>

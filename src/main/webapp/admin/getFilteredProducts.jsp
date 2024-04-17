<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="data.dao.ProductDao" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="data.dto.ProductDto" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.*" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-04-15
  Time: 오전 10:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    ProductDao dao = new ProductDao();
    SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
    NumberFormat format = NumberFormat.getInstance(Locale.KOREA);



    //page, 판매상태, 메인카테고리, 하위카테고리, 시작일, 끝일, 상품명 검색
    int selectedPage = Integer.parseInt(request.getParameter("page"))-1;
    String[] salesStatus = request.getParameterValues("salesStatus");
    String[] mainCategory = request.getParameterValues("mainCategory");
    String[] subCategory = request.getParameterValues("subCategory");
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");
    String productName = request.getParameter("productName");


    Map<String, Object> sqlParams = new HashMap<>();


    sqlParams.put("page", selectedPage);
    if (salesStatus != null) {
        sqlParams.put("salesStatus", salesStatus);
    } else {
        sqlParams.put("salesStatus", new String[]{"판매중","품절","단종"});
    }

    if (mainCategory != null && subCategory != null) {
        sqlParams.put("mainCategory", ProductDao.getCategoryCodes(mainCategory));
        sqlParams.put("subCategory", ProductDao.getCategoryCodes(subCategory));
    } else if (mainCategory == null && subCategory == null) {
        sqlParams.put("mainCategory", new String[]{"1", "2", "3", "4", "5"});
        sqlParams.put("subCategory", new String[]{"11", "12", "21", "22", "31", "32", "41", "42", "51"});
    } else if (mainCategory != null && subCategory == null) {
        sqlParams.put("mainCategory", ProductDao.getCategoryCodes(mainCategory));
        sqlParams.put("subCategory", new String[]{"999"});
    }else{
        sqlParams.put("subCategory", ProductDao.getCategoryCodes(subCategory));
        sqlParams.put("mainCategory", new String[]{"999"});
    }

    sqlParams.put("startDate", startDate);
    sqlParams.put("endDate", endDate);
    sqlParams.put("productName", productName);

 /*   System.out.println("params:"+sqlParams);
    dao.testjson(sqlParams);*/

    List<ProductDto> list = new ArrayList<ProductDto>();
    list = dao.getFilteredProducts(sqlParams);

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

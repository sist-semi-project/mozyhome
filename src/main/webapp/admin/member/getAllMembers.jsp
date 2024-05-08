<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="data.dao.ProductDao" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="data.dto.ProductDto" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="data.dao.MemberDao" %>
<%@ page import="java.util.List" %>
<%@ page import="data.dto.MemberDto" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-04-22
  Time: 오후 5:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    MemberDao dao = new MemberDao();
    SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");

    int selectedPage = Integer.parseInt(request.getParameter("page"));
    int pageSize = Integer.parseInt(request.getParameter("pageSize"));

    int startIndex = (selectedPage-1)*pageSize;


    List<MemberDto> list = new ArrayList<MemberDto>();
    list = dao.getAllMemberPagingForAdmin(startIndex,pageSize);

    JSONArray arr =new JSONArray();
//회원번호/이름/아이디/닉네임/이메일/성별/가입일/탈퇴여부/구매/관리
    for(MemberDto dto:list)
    {
        JSONObject ob=new JSONObject();

        ob.put("mem_num", dto.getMem_num());
        ob.put("mem_name", dto.getMem_name());
        ob.put("mem_id", dto.getMem_id());
        ob.put("mem_nickname", dto.getMem_nickname());
        ob.put("mem_email", dto.getMem_email());
        ob.put("mem_gender", dto.getMem_gender());
        ob.put("mem_gaipday", sdf.format(dto.getMem_gaipday()));
        ob.put("mem_is_active", dto.getMem_is_active().equals("Y"));
        ob.put("mem_buyCount", dto.getBuyCount());

        arr.add(ob);
    }
    JSONObject finalob = new JSONObject();
    finalob.put("members", arr);
    if (list.size() > 0) {
        finalob.put("result_count", list.get(0).getTotalCount());
    } else {
        finalob.put("result_count", 0);
    }


    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(finalob.toString());

%>
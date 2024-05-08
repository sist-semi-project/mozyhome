<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="data.dao.MemberDao" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="data.dto.MemberDto" %>
<%@ page import="org.json.simple.JSONObject" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-04-23
  Time: 오후 4:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss");

    String memberId = request.getParameter("memberId");
    MemberDao dao = new MemberDao();
    MemberDto dto = dao.getOneMemberDetail(memberId);

    JSONObject ob=new JSONObject();

    ob.put("mem_name", dto.getMem_name());
    ob.put("mem_id", dto.getMem_id());
    ob.put("mem_nickname", dto.getMem_nickname());
    ob.put("mem_gender", dto.getMem_gender());
    ob.put("mem_birth", dto.getMem_birth());
    ob.put("mem_hp", dto.getMem_hp());
    ob.put("mem_email", dto.getMem_email());
    ob.put("mem_zipcode", dto.getMem_zipcode());
    ob.put("mem_address", dto.getMem_address());
    ob.put("mem_address_detail", dto.getMem_address_detail());
    ob.put("buy_count", dto.getBuyCount());
    ob.put("review_count", dto.getReviewCount());
    ob.put("mem_gaipday", sdf.format(dto.getMem_gaipday()));

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(ob.toString());
%>

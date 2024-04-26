<%@ page import="data.dao.MemberDao" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="data.dto.MemberDto" %>
<%@ page import="java.util.*" %>
<%@ page import="org.json.simple.JSONArray" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-04-23
  Time: 오전 11:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
    MemberDao dao = new MemberDao();
    SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");

    //page, 회원상태, 검색타입, 검색어, 날짜
    int selectedPage = Integer.parseInt(request.getParameter("page"))-1;
    String[] memberStatus = request.getParameterValues("memberStatus");
    String searchType = request.getParameter("searchType"); // id,name,nickname,email
    String searchText = request.getParameter("searchText");
    String startDate = request.getParameter("startDate");
    String endDate = request.getParameter("endDate");

    Map<String, Object> sqlParams = new HashMap<>();

    sqlParams.put("page", selectedPage);

    if (memberStatus != null) {
        sqlParams.put("memberStatus", memberStatus);
    }else{
        sqlParams.put("memberStatus", new String[]{"Y", "N"});
    }

    sqlParams.put("startDate", startDate);
    sqlParams.put("endDate", endDate);
    sqlParams.put("searchType", searchType);
    sqlParams.put("searchText", searchText);

    List<MemberDto> list = new ArrayList<MemberDto>();
    list = dao.getFilteredMembers(sqlParams);

    JSONArray arr = new JSONArray();

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

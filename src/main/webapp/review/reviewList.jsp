<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>

<title>Insert title here</title>
</head>
<%
	//리뷰 리스트 db에서 가져오기
	
	//String pro_num=(String)session.getAttribute("pro_num");
	String pro_num="210";

	ReviewDao rdao=new ReviewDao();
	List<HashMap<String,String>> list= rdao.getReview(pro_num);
	
	//페이지 번호 버튼
	int totalCount=rdao.getTotalCount(pro_num);
	int perPage=5;
	int perBlock=5;
	int startNum;
	int startPage;
	int endPage;
	int currentPage;
	int totalPage;
	int no;
	
	//현재페이지 읽는데 단 null일경우는 1페이지로 준다
	if(request.getParameter("currentPage")==null)
		currentPage=1;
	else
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	
	//총페이지수 구하기
	totalPage=totalCount/perPage+(totalCount%perPage==0?0:1);
	
	//각블럭당 보여질 시작페이지
	startPage=(currentPage-1)/perBlock*perBlock+1;
	endPage=startPage+perBlock-1;
	
	//마지막 페이지
	if(endPage>totalPage)
		endPage=totalPage;
	
	//각페이지에서 보여질 시작번호
	startNum=(currentPage-1)*perPage;
	
	//각페이지당 출력할 시작번호
	startNum=(currentPage-1)*perPage;
		
%>
<body>

<!-- 리뷰 리스트 목차 -->
<h4>REVIEW</h4>
	<div>
		<table>
			<tr>
				<th>NO</th>
				<th>SUBJECT</th>
				<th>NAME</th>
				<th>DATE</th>
				<th>SCORE</th>
			</tr>
			
			<!-- 리뷰 리스트 출력 -->
				<%for(int i=0; i<list.size();i++)
				{
					HashMap<String,String> map=list.get(i);
				%>
			<tr>
				<td><%= i+1 %></td>
				<td><%=map.get("review_subject") %></td>
				<td><%=map.get("review_pyung") %></td>
				<td><%=map.get("mem_id") %></td>
				<td><%=map.get("review_writeday") %></td>
			</tr>
			<%}
				%>
		</table>
	</div>
	<div>
	 <ul>
	 	<li><a class="page_next" href="index.jsp"></a></li>
	 	<li></li>
	 	<li></li>
	 	<li></li>
	 	<li></li>
	 </ul>
	</div>
</body>
</html>
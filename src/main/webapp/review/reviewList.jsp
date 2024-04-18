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

	ReviewDao dao=new ReviewDao();
	//List<HashMap<String,String>> list= dao.getReview(pro_num);
	
	//페이지 번호 버튼
	int totalCount=dao.getTotalCount(pro_num);
	int perPage=5;
	int perBtn=5;
	
	int startBtnNum=totalCount/perPage+(totalCount%perPage==0?0:1); //총 페이지 나누기 perpage에 나머지가 있을때 btn 1+
	int currentPage;
	
	//currentPage에 값 미리 할당해놓기
	if(request.getParameter("currentPage")==null)
		currentPage=1;
	else
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	
	int startPageNum=perPage*currentPage+1;

	List<HashMap<String,String>>list=dao.getReview(pro_num, startPageNum, perPage);
	
	
	
	
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
				<td>
				<%
				String review_Pyung_str = map.get("review_pyung");
			    int review_Pyung = 0;
			    try {
			        review_Pyung = Integer.parseInt(review_Pyung_str);
			    } catch (NumberFormatException e) {
			        // 변환에 실패한 경우 기본값인 0으로 설정
			    }
			    
			    int starCount = review_Pyung;

			    // 별 출력
			    for (int j = 0; j < starCount; j++) {
			        out.print("★");
			    }
				%>
				</td>
				<td><%=map.get("review_subject") %></td>
				<td><%=map.get("mem_id") %></td>
				<td><%=map.get("review_writeday") %></td>
			</tr>
			<%}
				%>
		</table>
	</div>
	
	<div>
	<form action="">
	 <ul>

	 	<li><a>1</a></li>
	 	<li><a>2</a></li>
	 	<li><a>3</a></li>
	 	<li><a>4</a></li>
	 	<li><a>5</a></li>

	 </ul>
	 </form>
	</div>
</body>
</html>
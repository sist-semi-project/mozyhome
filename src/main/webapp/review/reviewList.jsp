<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<script src="https://code.jquery.com/jquery-3.7.0.js"></script>

<title>Insert title here</title>
 <link rel="stylesheet" href="./review/reviewCss.css">
</head>
<%
//리뷰 리스트 db에서 가져오기

String pro_num=(String)session .getAttribute("pro_num");


ReviewDao rdao = new ReviewDao();

//페이지 번호 버튼
System.out.println(pro_num);
int totalCount = rdao.getTotalCount(pro_num); //리스트 숫자
System.out.println(totalCount);
int perPage = 5; //한 페이지의 리스트 숫자
int perBlock = 5; //버튼 한줄의 숫자

int totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1); //총 페이지 나누기 perpage에 나머지가 있을때 btn 1+ (totalPage)
int currentPage;

//currentPage에 값 미리 할당해놓기
if (request.getParameter("currentPage") == null)
	currentPage = 1;
else
	currentPage = Integer.parseInt(request.getParameter("currentPage"));

int startPage = (currentPage - 1) / perBlock * perBlock + 1; // 버튼 한줄의 시작 숫자

int startList = (currentPage - 1) * perPage;

List<HashMap<String, String>> list = rdao.getReview(pro_num, startList, perPage); //버튼 한줄의 시작숫자부터 5개의 리스트 목록

int endPage = startPage + perBlock -1 ; //버튼 한줄의 마지막 숫자

if(endPage>totalPage)
	endPage=totalPage; //총페이지가 23일경우 마지막블럭은 끝페이지가 25가 아니라 23
%>
<body>

<!-- 리뷰 리스트 목차 ------------------------------------------>
<div id="reviewList">
	<h4>REVIEW</h4>
	<div id="list">
		<table id="listTable">
			<tr>
				<th>NO</th>
				<th>RATING</th>
				<th>SUBJECT</th>
				<th>NAME</th>
				<th>DATE</th>
			</tr>

			<!--리뷰 리스트 출력 ------------------------------------------->
			<%
			int count = (currentPage - 1) * perPage + 1; // count 변수 초기화
			for (int i = 0; i < list.size(); i++) {
				HashMap<String, String> map = list.get(i);
			%>
			<tr class="has-details">
				<td><%=count++%></td>
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
						 %><span class="star">★</span><%
					}
					%>
				</td>
				<td><%=map.get("review_subject")%></td>
				<td><%=map.get("mem_id")%></td>
				<td><%=map.get("review_writeday")%></td>
			</tr>
			<tr class="hidden">
				<td colspan="5"><%=map.get("review_content")%> <%=map.get("review_image")%></td>
			</tr>
			

			<%
			}
			%>
		</table>

	</div>

		<div class="reviewBtnDiv">
			<button onclick="location.href='index.jsp?main=review/reviewForm.jsp?pro_num=<%=pro_num %>'" class="reviewBtn">WRITE</button>
			<button onclick="location.href='reviewPage.jsp'" class="reviewBtn">LIST</button>
		</div>

	<!-- 페이지 번호 출력 ---------------------------------------------------------------->
		<div class="pageNumList">
			<ul class="pagination justify-content-center">
				<%
				// 이전 페이지로 이동 링크
				if (startPage > 1) {
				%>
				<li class=""><a class="pageNum"
					href="index.jsp?main=review/reviewList.jsp?currentPage=<%=startPage - 1%>"
					style="color: black;"> <i class="bi bi-arrow-left"></i>
				</a></li>
				<%
				}

				// 페이지 번호 출력
				for (int pp = startPage; pp <= endPage; pp++) {
				%>
				<li class="">
				<a
					class="<%=(pp == currentPage) ? "active" : ""%> pageNum"
					href="index.jsp?main=review/reviewList.jsp?currentPage=<%=pp%>"> <%=pp%>
				</a></li>
				<%
				}

				// 다음 페이지로 이동 링크
				if (endPage < totalPage) {
				%>
				<li class=""><a class="pageNum"
					href="index.jsp?main=review/reviewList.jsp?currentPage=<%=endPage+1%>"
					style="color: black;"> <i class="bi bi-arrow-right"></i>
				</a></li>
				<%
				}
				%>
			</ul>
		</div>
	</div>

<script type="text/javascript">
	document.addEventListener("DOMContentLoaded", function() {
		  // 상위 tr 요소를 클릭할 때마다 하위 tr 요소를 숨기거나 보이게 함
		  var parentTrs = document.querySelectorAll('tr.has-details');
		  parentTrs.forEach(function(parentTr) {
		    parentTr.addEventListener('click', function() {
		      var detailsTr = this.nextElementSibling;
		      detailsTr.classList.toggle('hidden');
		    });
		  });
		});
</script>
</body>
</html>
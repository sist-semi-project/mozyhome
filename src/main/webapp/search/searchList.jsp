<%@page import="java.util.ArrayList"%>
<%@page import="data.dao.ProductListDao"%>
<%@page import="data.dto.CategoryDto"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="data.dto.WishlistDto"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="data.dto.ProductDto"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.ProductDao"%>
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

<title>검색리스트</title>
<style type="text/css">
	body{
	 	text-decoration: none !important;
		color:black !important;
	}
	
	a, .goDetail{
		text-decoration: none !important;
		color:black !important;
		cursor: pointer;
	}
	
	.sort{
		font-size: 14px !important;
		color:#aaa !important;
		border-color: white !important;
	}
	
	/* 페이징 디자인 */
	body > div.layout.main > div > ul > li > a{
		color: black !important;
	}
	
	.page-link {
	  color: black !important;
	  background-color: white;
	  
	}
	.page-item.active .page-link {
		 z-index: 1 !important;
		 color: white !important;
		 background-color: #FF5C00;
		 border-color: #FF5C00;
	}
	.page-link:focus, .page-link:hover {
		  background-color: #eee; 
		  color:black;
	}
</style>

<script type="text/javascript">
	$(function(){
		
		// 상품 클릭 시 상품상세로 이동
		$("a.goDetail").click(function(){
			var pronum=$(this).attr("pronum");
			//alert(pronum);
			
			// 디테일 페이지로 이동 #review
			location.href="index.jsp?main=product/detailpage.jsp?pro_num="+pronum;
		});
		
		// 정렬 콤보박스 클릭 시
		$("select[name=sort]").change(function(){
			var sort=$(this).val();
			//alert(sort);
		});
		
	});
</script>
</head>
<%
	request.setCharacterEncoding("utf-8");
	//0415 로그인 세션
	//session.setAttribute("mem_id","dragon");
	//session.setAttribute("loginok","yes");	
	String loginok=(String)session.getAttribute("loginok");
	String myid=(String)session.getAttribute("myid");
	//System.out.println(myid);
	
	// 검색한 단어 받아오기
	String search=request.getParameter("search");

	// 0413 정렬 번호 받아오기
	String sort=request.getParameter("sort");
	//System.out.println("sort값:"+sort);
	
	// 상품리스트 dao 불러오기
	ProductListDao pldao=new ProductListDao();
	
	// 화폐 단위 정의
	NumberFormat nf=new DecimalFormat("#,###.##원");

	List<ProductDto> list = new ArrayList<ProductDto>();
	
	// * 페이징 ----------------------------------------------------------------------
	// 전체 개수
	int totalCount=pldao.getSearchTotalCount(search);	
	
	int perPage=16; // 한페이지당 보여질 글의 개수
	int perBlock=5; // 한블럭당 보여질 페이지 개수
	int startNum; // db에서 가져올 글의 시작 번호(mysql은 첫글이 0번, oracle은 1번)
	int startPage; // 각 블럭마다 보여질 시작페이지
	int endPage; // 각 블럭마다 보여질 끝페이지
	int currentPage; // 현재페이지
	int totalPage; // 총 페이지 수.
	int no; // 각 페이지당 출력할 시작번호 (필수 아님)
		
	// 현재 페이지를 읽는데 단, null일 경우는 1페이지로 준다.
	if(request.getParameter("currentPage")==null){
		currentPage=1;
	} else{
		currentPage=Integer.parseInt(request.getParameter("currentPage")); // 계산을 위해 형변환
	}		
		
	// 총 페이지 수 구한다
	totalPage=totalCount/perPage+(totalCount%perPage==0?0:1);
		
	// 각 블럭 당 보여질 시작페이지
	startPage=(currentPage-1)/perBlock*perBlock+1;
	endPage=startPage+perBlock-1;
		
	// 총 페이지가 23일 경우 마지막 블럭은 25가 아닌 23
	if(endPage>totalPage){
		endPage=totalPage;
	}
		
	// 각 페이지에서 보여질 시작번호
	startNum=(currentPage-1)*perPage;
		
	// 각 페이지당 출력할 시작 번호 구하기
	no=totalCount-(currentPage-1)*perPage;
	
	// 페이지에서 보여질 글만 가져오기
	if ("1".equals(sort)) {
		list = pldao.NEWgetSearchPagingList(search, startNum, perPage);

	} else if ("2".equals(sort)) {
		list = pldao.NAMEgetSearchPagingList(search, startNum, perPage);

	} else if ("3".equals(sort)) {
		//System.out.println("실행확인3");
		list = pldao.RPRICEgetSearchPagingList(search, startNum, perPage);

	} else if ("4".equals(sort)) {
		list = pldao.HPRICEgetSearchPagingList(search, startNum, perPage);

	} else if ("5".equals(sort)) {
		list = pldao.REVIEWgetSearchPagingList(search, startNum, perPage);

	} else {
		//System.out.println("실행확인 default");
		list = pldao.getSearchPagingList(search, startNum, perPage);
	}
	// --------------------------------------------------------------------------
%>
<body>
<div style="margin:0 auto; width:1400px">
	<table>
		<div style="margin:100px 0px 10px 15px; float:left;">
		총 <b><%=totalCount %></b>개의 상품
			
			<div style="margin: -28px 0px 0px 1290px;">			
				<select name="sort" class="form-select form-select sort" style="width:100px;" onchange="window.open(value,'_self');">
					<option value="index.jsp?main=search/searchList.jsp?search=<%=search%>&sort=1" <%="1".equals(sort)?"selected='selected'":""%>>신상품</option>
					<option value="index.jsp?main=search/searchList.jsp?search=<%=search%>&sort=2" <%="2".equals(sort)?"selected='selected'":""%>>상품명</option>
					<option value="index.jsp?main=search/searchList.jsp?search=<%=search%>&sort=3" <%="3".equals(sort)?"selected='selected'":""%>>낮은가격</option>
					<option value="index.jsp?main=search/searchList.jsp?search=<%=search%>&sort=4" <%="4".equals(sort)?"selected='selected'":""%>>높은가격</option>
					<option value="index.jsp?main=search/searchList.jsp?search=<%=search%>&sort=5" <%="5".equals(sort)?"selected='selected'":""%>>리뷰순</option>
				</select>
				
			</div>	
		</div> 
		
		<!-- 상품 출력 -->
		<tr class="list">
		<%
				int line=0;
				
				for(ProductDto pdto:list){%>
					<td style="padding: 0px 10px 60px;">
						<a pronum="<%=pdto.getPro_num()%>" class="goDetail">
							<img src="<%=pdto.getPro_main_img()%>" style="width:340px; padding-bottom: 8px;"> <br>
							<span style="padding-bottom:50px; font-weight: bold;"><%=pdto.getPro_name() %></span> <br>
							<%
								// 품절 표시
								if(pdto.getPro_sale_status().equals("품절")){%>
									<span class="proPrice" style="color: #aaa; text-decoration: line-through;"><%=nf.format(pdto.getPro_price()) %></span><span style="background: black; color: white; font-size:13px; margin-left: 8px; text-align: center;">&nbsp;&nbsp;SOLD OUT&nbsp;&nbsp;</span></div> <br>
								<%} else{%>
									<span class="proPrice"><%=nf.format(pdto.getPro_price()) %></span> <br>
								<%}
							
							%>							

							<div style="color:#aaa; padding-top: 3px;">
							<%
								// 위시리스트 하트 아이콘 출력 - 해당 아이디로 위시리스트 등록되어있으면 하트아이콘 채우기
								// 0415 'pdto.getMem_id()!=null' 추후 삭제 예정
								if(loginok!=null && pdto.getMem_id()!=null && pdto.getMem_id().equals(myid)){%>	
									<i class="bi bi-suit-heart-fill" style="color: #FF5C00;"></i> <%=pdto.getWishCount() %>
								<%} else{%>
									<i class="bi bi-suit-heart"></i> <%=pdto.getWishCount() %>
								<%}
							%>
								<i class="bi bi-chat-left" style="margin-left:15px;"></i> <%=pdto.getReviewCount()%>
							</div>	
						</a>
					</td>
				
				<%
					// 한 줄에 출력되는 상품 개수 설정
					if((line+1)%4==0){%>
						</tr><tr>
					<%}
					line++;
				%>

			<%}	
				
		%>
		</tr>
	</table>
	
	<!-- 페이지 번호 출력 -->
	<ul class="pagination justify-content-center" style="margin-top: 90px;">
		<%
			if(sort!=null){
				// 이전
				if(startPage>1){%>
					<li class="page-item">
						<a class="page-link" href="index.jsp?main=search/searchList.jsp?search=<%=search %>&currentPage=<%=startPage-1%>&sort=<%=sort %>" style="color:black;" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a>
					</li>
				<%}
			
				for(int pp=startPage; pp<=endPage; pp++){
					if(pp==currentPage){%>
						<li class="page-item active">
							<a class="page-link" href="index.jsp?main=search/searchList.jsp?search=<%=search %>&currentPage=<%=pp%>&sort=<%=sort %>"><%=pp %></a>
						</li>
					<%} else{%>
						<li class="page-item">
							<a class="page-link" href="index.jsp?main=search/searchList.jsp?search=<%=search %>&currentPage=<%=pp%>&sort=<%=sort %>"><%=pp %></a>
						</li>
					<%}
				}
				
				// 다음
				if(endPage<totalPage){%>
					<li class="page-item">
						<a class="page-link" href="index.jsp?main=search/searchList.jsp?search=<%=search %>&currentPage=<%=endPage+1%>&sort=<%=sort %>" style="color:black" aria-label="Next"><span aria-hidden="true">&raquo;</span></a>
					</li>			
				<%}
			} else {
				// 이전
				if(startPage>1){%>
					<li class="page-item">
						<a class="page-link" href="index.jsp?main=search/searchList.jsp?search=<%=search %>&currentPage=<%=startPage-1%>" style="color:black;" aria-label="Previous"><span aria-hidden="true">&#10094;</span></a>
					</li>
				<%}
			
				for(int pp=startPage; pp<=endPage; pp++){
					if(pp==currentPage){%>
						<li class="page-item active">
							<a class="page-link" href="index.jsp?main=search/searchList.jsp?search=<%=search %>currentPage=<%=pp%>"><%=pp %></a>
						</li>
					<%} else{%>
						<li class="page-item">
							<a class="page-link" href="index.jsp?main=search/searchList.jsp?search=<%=search %>&currentPage=<%=pp%>"><%=pp %></a>
						</li>
					<%}
				}
				
				// 다음
				if(endPage<totalPage){%>	
					<li class="page-item">
						<a class="page-link" href="index.jsp?main=search/searchList.jsp?search=<%=search %>&currentPage=<%=endPage+1%>" style="color:black" aria-label="Next"><span aria-hidden="true">&#10095;</span></a>
					</li>			
				<%}
			}
			
		%>
	</ul>
	<!-- 페이지 번호 출력 끝. -->
	
</div>

</body>
</html>

<%@page import="data.dao.ProductListDao2"%>
<%@page import="data.dto.CategoryDto"%>
<%@page import="data.dao.ProductListDao"%>
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

<title>상품리스트</title>
<style type="text/css">
	body{
	 	font-family: "Noto Sans KR";
	 	font-size: 14px;
	}
	
	a, .goDetail{
		text-decoration: none;
		color:black;
		cursor: pointer;
	}
	
	.sort{
		color:#aaa;
		border-color: white;
		font-size: 14px;
	}
	
	/* 페이징 디자인 */
	.page-link {
	  color: black; 
	  background-color: white;
	  
	}
	.page-item.active .page-link {
		 z-index: 1;
		 color: white;
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
		$("a.goDetail").click(function(){
			var pronum=$(this).attr("pronum");
			alert(pronum);
			
			// 디테일 페이지로 이동
			//location.href="index.jsp?main=product/상품상세.jsp?pronum="+pronum;
		});
		
		$("a.pCate").click(function(){
			var pCatenum=$(this).attr("pCateNum");
			//alert(pCatenum);
			
			location.href="../product/productList.jsp?cate_num="+pCatenum;
		});
		
		$("a.cate").click(function(){
			var cateNum=$(this).attr("cateNum");
			//alert(cateNum);
			
			//location.href="index.jsp?main=product/productList.jsp?cate_num="+cateNum;
			location.href="../product/productList.jsp?cate_num="+cateNum;
		});
		
	});
</script>
</head>
<%
	String cate_num=request.getParameter("cate_num");
	String pcate_num=request.getParameter("pcate_num");
	
	
	ProductListDao pldao=new ProductListDao();
	//ProductListDao2 pldao=new ProductListDao2();
	
	//List<ProductDto> list=pdao.getAllProduct(cate_num); 
	//List<ProductDto> list=pldao.getAllParentsProduct(cate_num); // 부모카테고리 출력 0409집
	
	CategoryDto cdto=pldao.getCategory(cate_num);
	CategoryDto pcdto=pldao.getParentCategory(cate_num);
	
	NumberFormat nf=new DecimalFormat("#,###.##원");
	
	// * 페이지 ----------------------------------------------------------------------
	// 전체 개수
	int totalCount=pldao.getTotalCount(cate_num);
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
	// (총 글 개수)/(한페이지당 보여질 개수)로 나눔 (7/5=1)
	// 나머지가 1이라도 있으면 무조건 1페이지 추가(1+1=2페이지 추가)
	totalPage=totalCount/perPage+(totalCount%perPage==0?0:1);
		
	// 각 블럭 당 보여질 시작페이지
	// perBlock=5일 경우 현재 페이지가 1~5일 경우 시작페이지가 1, 끝페이지는 5
	// 현재가 13페이지일 경우엔 시작이 11 끝은 15
	startPage=(currentPage-1)/perBlock*perBlock+1;
	endPage=startPage+perBlock-1;
		
	// 총 페이지가 23일 경우 마지막 블럭은 25가 아닌 23
	if(endPage>totalPage){
		endPage=totalPage;
	}
		
	// 각 페이지에서 보여질 시작번호
	// 1페이지:0, 2페이지:5, 3페이지:10...
	startNum=(currentPage-1)*perPage;
		
	// 각 페이지당 출력할 시작 번호 구하기
	// ex. 총 글 개수가 23, 1페이지는:23 2페이지는:18, 3페이지는:13..
	no=totalCount-(currentPage-1)*perPage;
		
	// 페이지에서 보여질 글만 가져오기
	List<ProductDto> list=pldao.getPagingList(cate_num, startNum, perPage);	
	// --------------------------------------------------------------------------

%>
<body>

<div style="margin:50px 100px; width:1400px">
	<table>
		<div style="margin:100px 0px 10px 15px; float:left;">
			<div style="margin: -28px 0px 0px 1330px;">
				<select name="sort" class="form-select form-select sort" style="width:98px;">
					<option value="신상품">신상품</option>
					<option value="상품명">상품명</option>
					<option value="낮은가격">낮은가격</option>
					<option value="높은가격">높은가격</option>
					<option value="리뷰순">리뷰순</option>
				</select>
			</div>	
		</div> 
		
		<!-- 상품 출력 -->
		<tr class="list">
		<%
			int line=0;
				
			for(int i=0; i<list.size(); i++){
				ProductDto pdto=list.get(i);
			%>		
			<td style="padding: 0px 10px 60px;">
				<a pronum="<%=pdto.getPro_num()%>" class="goDetail">
					<img src="<%=pdto.getPro_main_img()%>" style="width:340px;">
					<b style="padding-top: 60px;"><%=pdto.getPro_name() %></b> <br>
					<font class="proPrice"><%=nf.format(pdto.getPro_price()) %></font> <br>
					<div style="color:#aaa;">
						<i class="bi bi-heart"></i> <%=pdto.getWishCount() %>
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
			// 이전
			if(startPage>1){%>
				<li class="page-item">
					<a class="page-link" href="productList.jsp?cate_num=<%=cate_num %>&currentPage=<%=startPage-1%>" style="color:black;" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a>
				</li>
			<%}
		
			for(int pp=startPage; pp<=endPage; pp++){
				if(pp==currentPage){%>
					<li class="page-item active">
						<a class="page-link" href="productList.jsp?cate_num=<%=cate_num %>&currentPage=<%=pp%>"><%=pp %></a>
					</li>
				<%} else{%>
					<li class="page-item">
						<a class="page-link" href="productList.jsp?cate_num=<%=cate_num %>&currentPage=<%=pp%>"><%=pp %></a>
					</li>
				<%}
			}
			
			// 다음
			if(endPage<totalPage){%>
				<li class="page-item">
					<a class="page-link" href="productList.jsp?cate_num=<%=cate_num %>&currentPage=<%=endPage+1%>" style="color:black" aria-label="Next"><span aria-hidden="true">&raquo;</span></a>
				</li>			
			<%}
		%>
	</ul>
	<!-- 페이지 번호 출력 끝. -->
	
</div>

</body>
</html>
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
		// 상품 클릭 시 상품상세로 이동
		$("a.goDetail").click(function(){
			var pronum=$(this).attr("pronum");
			//alert(pronum);
			
			// 디테일 페이지로 이동 #review
			location.href="../product/detailpage.jsp?pro_num="+pronum;
		});
		
		// 부모카테고리 클릭 시
		$("a.pCate").click(function(){
			var pCatenum=$(this).attr("pCateNum");
			//alert(pCatenum);
			
			//location.href="index.jsp?main=product/productList.jsp?cate_num="+pCatenum;
			location.href="../product/productList.jsp?cate_num="+pCatenum;
		});
		
		// 자식카테고리 클릭 시
		$("a.cate").click(function(){
			var cateNum=$(this).attr("cateNum");
			//alert(cateNum);
			
			//location.href="index.jsp?main=product/productList.jsp?cate_num="+cateNum;
			location.href="../product/productList.jsp?cate_num="+cateNum;
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
	// 카테고리 번호 받아오기
	String cate_num=request.getParameter("cate_num");

	// 0413 정렬 번호 받아오기
	String sort=request.getParameter("sort");
	//System.out.println("sort값:"+sort);
	
	// 상품리스트 dao 불러오기
	ProductListDao pldao=new ProductListDao();
	
	// 부모/자식카테고리 이름 얻어오기
	CategoryDto cdto=pldao.getCategory(cate_num);
	CategoryDto pcdto=pldao.getParentCategory(cate_num);
	
	// 화폐 단위 정의
	NumberFormat nf=new DecimalFormat("#,###.##원");
	
	// 카테고리 번호가 부모카테고리번호일 시 true 반환
	boolean flag=pldao.isParentCateCheck(cate_num);
	//System.out.println("======== 부모카테고리 여부: "+flag+" ========");
	
	// list 선언
	List<ProductDto> list = new ArrayList<ProductDto>();
	
	// * 페이징 ----------------------------------------------------------------------
	// 전체 개수
	int totalCount;
	
	if(flag){
		// 부모카테고리 번호일 시
		totalCount=pldao.getParentTotalCount(cate_num);
	} else {
		totalCount=pldao.getTotalCount(cate_num);
	}
			
	int perPage=20; // 한페이지당 보여질 글의 개수
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
	if ("1".equals(sort)){
		if(flag){
			list=pldao.NEWgetParentPagingList(cate_num, startNum, perPage);
		} else{
			list=pldao.NEWgetPagingList(cate_num, startNum, perPage);
		}
	} else if("2".equals(sort)){
		if(flag){
			list=pldao.NAMEgetParentPagingList(cate_num, startNum, perPage);
		} else{
			list=pldao.NAMEgetPagingList(cate_num, startNum, perPage);
		}
	} else if("3".equals(sort)){
		//System.out.println("실행확인3");
		if(flag){
			list=pldao.RPRICEgetParentPagingList(cate_num, startNum, perPage);
		} else{
			list=pldao.RPRICEgetPagingList(cate_num, startNum, perPage);
		}
	} else if("4".equals(sort)){
		if(flag){
			list=pldao.HPRICEgetParentPagingList(cate_num, startNum, perPage);
		} else{
			list=pldao.HPRICEgetPagingList(cate_num, startNum, perPage);
		}
	} else if("5".equals(sort)){
		if(flag){
			list=pldao.REVIEWGetParentPagingList(cate_num, startNum, perPage);
		} else{
			list=pldao.REVIEWgetPagingList(cate_num, startNum, perPage);
		}
	} else {
		//System.out.println("실행확인 default");
		if(flag){
			list=pldao.getParentPagingList(cate_num, startNum, perPage);
		} else{
			list=pldao.getPagingList(cate_num, startNum, perPage);
		}
	}
	// --------------------------------------------------------------------------		
%>
<body>
<div style="margin:50px 100px; width:1400px">
	<table>
		<div style="margin:100px 0px 10px 15px; float:left;">
			<a class="pCate" pCateNum="<%=pcdto.getCate_num() %>"><%=pcdto.getCate_name() %></a> 
			<a class="cate" cateNum="<%=cate_num%>"><%=cdto.getCate_name().equals(pcdto.getCate_name())?"":" > "+cdto.getCate_name() %> </a>
			
			<div style="margin: -28px 0px 0px 1320px;">
				<select name="sort" class="form-select form-select sort" style="width:100px;" onchange="window.open(value,'_self');">
					<option value="../product/productList.jsp?cate_num=<%=cate_num%>&sort=1" <%="1".equals(sort)?"selected='selected'":""%>>신상품</option>
					<option value="../product/productList.jsp?cate_num=<%=cate_num%>&sort=2" <%="2".equals(sort)?"selected='selected'":""%>>상품명</option>
					<option value="../product/productList.jsp?cate_num=<%=cate_num%>&sort=3" <%="3".equals(sort)?"selected='selected'":""%>>낮은가격</option>
					<option value="../product/productList.jsp?cate_num=<%=cate_num%>&sort=4" <%="4".equals(sort)?"selected='selected'":""%>>높은가격</option>
					<option value="../product/productList.jsp?cate_num=<%=cate_num%>&sort=5" <%="5".equals(sort)?"selected='selected'":""%>>리뷰순</option>
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
							<span class="proPrice"><%=nf.format(pdto.getPro_price()) %></span> <br>
							<div style="color:#aaa; padding-top: 3px;">
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
			if(sort!=null){
				// 정렬 값이 있을 경우
				
				// 이전
				if(startPage>1){%>
					<li class="page-item">
						<a class="page-link" href="productList.jsp?cate_num=<%=cate_num %>&currentPage=<%=startPage-1%>&sort=<%=sort %>" style="color:black;" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a>
					</li>
				<%}
			
				for(int pp=startPage; pp<=endPage; pp++){
					if(pp==currentPage){%>
						<li class="page-item active">
							<a class="page-link" href="productList.jsp?cate_num=<%=cate_num %>&currentPage=<%=pp%>&sort=<%=sort %>"><%=pp %></a>
						</li>
					<%} else{%>
						<li class="page-item">
							<a class="page-link" href="productList.jsp?cate_num=<%=cate_num %>&currentPage=<%=pp%>&sort=<%=sort %>"><%=pp %></a>
						</li>
					<%}
				}
				
				// 다음
				if(endPage<totalPage){%>
					<li class="page-item">
						<a class="page-link" href="productList.jsp?cate_num=<%=cate_num %>&currentPage=<%=endPage+1%>&sort=<%=sort %>" style="color:black" aria-label="Next"><span aria-hidden="true">&raquo;</span></a>
					</li>			
				<%}
			} else {
				// 정렬 값이 없을 경우
				
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
			}
			
		%>
	</ul>
	<!-- 페이지 번호 출력 끝. -->
	
</div>

</body>
</html>
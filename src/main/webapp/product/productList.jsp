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
		$("a.goDetail").click(function(){
			var pronum=$(this).attr("pronum");
			alert(pronum);
			
			// 디테일 페이지로 이동
			//location.href="index.jsp?main=product/상품상세.jsp?pronum="+pronum;
		});
		
		$("a.pCate").click(function(){
			var pCatenum=$(this).attr("pCateNum");
			//alert(pCatenum);
			
			location.href="../product/productList.jsp?cate_num="+pCatenum
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
	//String pcate_num=request.getParameter("pcate_num");
	
	ProductListDao pldao=new ProductListDao();
	List<ProductDto> list=pldao.getAllProduct(cate_num); 
	List<ProductDto> plist=pldao.getAllParentsProduct(cate_num);
	
	// 카테고리 이름 얻어오기
	CategoryDto cdto=pldao.getCategory(cate_num);
	CategoryDto pcdto=pldao.getParentCategory(cate_num);
	
	NumberFormat nf=new DecimalFormat("#,###.##원");
	
	boolean flag=pldao.isParentCateCheck(cate_num);
	System.out.println(flag+"====================================================");

	
	
%>
<body>

<div style="margin:50px 100px; width:1400px">
	<table>
		<div style="margin:100px 0px 10px 15px; float:left;">
			<a class="pCate" pCateNum="<%=pcdto.getCate_num() %>"><%=pcdto.getCate_name() %></a> 
			<a class="cate" cateNum="<%=cate_num%>"><%=cdto.getCate_name().equals(pcdto.getCate_name())?"":" > "+cdto.getCate_name() %> </a>
			
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
			if(flag){
				int line=0;
				for(int i=0; i<plist.size(); i++){
					ProductDto pdto=plist.get(i);
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
			} else{
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
				
			}
			
		%>
		</tr>
	</table>
	
</div>

</body>
</html>
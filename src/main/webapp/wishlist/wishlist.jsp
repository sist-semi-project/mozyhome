<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.NumberFormat"%>
<%@page import="data.dto.WishlistDto"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="data.dao.WishlistDao"%>
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

<title>위시리스트</title>
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
	
	#del{
		text-decoration: underline;
		cursor: pointer;
	}
	
	input{
		/*accent-color:#FF5C00;*/
		accent-color:black;
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
		  background-color: #FF5C00; 
		  color:white;
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
		
		// 전체선택 클릭 시 모든 체크값 전달
		$(".allCheck").click(function(){
			var chk=$(this).is(":checked");
			//console.log(chk);
			
			$(".allDel").prop("checked", chk);	
		});
		
		// 선택상품삭제 클릭 시 선택상품 삭제
		$("#del").click(function(){
			var len=$(".allDel:checked").length;
			//alert(len);
			
			if(len==0){
				alert("상품을 선택해주세요.");
			} else{
				var ask=confirm("선택하신 상품을 삭제하시겠습니까?");
				
				if(ask){
					var ditem="";
					$(".allDel:checked").each(function(idx){
						ditem+=$(this).val()+",";
					});
					
					ditem=ditem.substring(0,ditem.length-1);
					//console.log(ditem);
					//location.href="../wishlist/deleteWishlist.jsp?ditems="+ditem;

					$.ajax({
						type:"get",
						url:"../wishlist/deleteWishlist.jsp",
						traditional: true,
						dataType:"html",
						data:{"ditems":ditem},
						success:function(){
							alert("관심상품이 삭제되었습니다.");
							location.reload();
						}						
					});	
				}	
			}
			
		});		
	});

</script>
</head>
<%
	//0415 로그인 세션
	//session.setAttribute("myid","dragon");
	//session.setAttribute("loginok","");	
	String loginok=(String)session.getAttribute("loginok");
	String mem_id=(String)session.getAttribute("myid");
	
	WishlistDao wdao=new WishlistDao();

	// 화폐 단위 정의
	NumberFormat nf=new DecimalFormat("#,###.##원");
	
	// * 페이징 ----------------------------------------------------------------------
	// 전체 개수
	int totalCount = wdao.getWishCount(mem_id);

	int perPage = 6; // 한페이지당 보여질 글의 개수
	int perBlock = 1; // 한블럭당 보여질 페이지 개수
	int startNum; // db에서 가져올 글의 시작 번호(mysql은 첫글이 0번, oracle은 1번)
	int startPage; // 각 블럭마다 보여질 시작페이지
	int endPage; // 각 블럭마다 보여질 끝페이지
	int currentPage; // 현재페이지
	int totalPage; // 총 페이지 수.
	int no; // 각 페이지당 출력할 시작번호 (필수 아님)

	// 현재 페이지를 읽는데 단, null일 경우는 1페이지로 준다.
	if (request.getParameter("currentPage") == null) {
		currentPage = 1;
	} else {
		currentPage = Integer.parseInt(request.getParameter("currentPage")); // 계산을 위해 형변환
	}

	// 총 페이지 수 구한다
	totalPage = totalCount / perPage + (totalCount % perPage == 0 ? 0 : 1);

	// 각 블럭 당 보여질 시작페이지
	startPage = (currentPage - 1) / perBlock * perBlock + 1;
	endPage = startPage + perBlock - 1;

	// 총 페이지가 23일 경우 마지막 블럭은 25가 아닌 23
	if (endPage > totalPage) {
		endPage = totalPage;
	}

	// 각 페이지에서 보여질 시작번호
	startNum = (currentPage - 1) * perPage;

	// 각 페이지당 출력할 시작 번호 구하기
	no = totalCount - (currentPage - 1) * perPage;

	// 페이지에서 보여질 글만 가져오기
	List<HashMap<String, String>> list=wdao.getPagingWishlist(mem_id, startNum, perPage);
	// --------------------------------------------------------------------------
%>
<body>
<%
	// 로그인이 되어있을 때 위시리스트 접근 가능
	if(loginok!=null && totalCount>0){%>

		<div style="margin:50px 300px; width:600px">
			<h3 style="padding: 75px;" align="center">WISH LIST</h3>
			<table align="center" class="table">
			<div style="padding: 8px;">
				<label><input type="checkbox" class="form-check allCheck" style="margin-right:5px; float: left;"> 전체선택</label>
			</div>
				
				<%
				for(int i=0; i<list.size(); i++){
					HashMap<String, String> map=list.get(i);
					int pro_price=Integer.parseInt(map.get("pro_price")); // 가격이 String으로 넘어왔으므로 형변환
							
					%>
						<tr style="vertical-align: middle;">
								
							<div>
								<td width="10px" align="center" >
									<input type="checkbox" class="form-check allDel" value="<%=map.get("wish_num")%>">
								</td>
													
								<td width="150px" style="text-align: center;">			
									<a pronum="<%=map.get("pro_num")%>" class="goDetail">
										<img alt="" src="<%=map.get("pro_main_img")%>" style="width:125px"> 
									</a>								
								</td>
										
								<td>
									<a pronum="<%=map.get("pro_num")%>" class="goDetail">
										<div>
											<b><%=map.get("pro_name") %></b> <br>
											<%=nf.format(pro_price) %>
										</div>
									</a>
								</td>
							</div>					
						</tr>					
					<%}	
				%>
		
			</table>
			<div id="del">
				선택상품삭제
			</div>
			
			<!-- 페이지 번호 출력 -->
			<ul class="pagination justify-content-center" style="margin-top: 90px;">
			<%
				// 이전
				if (startPage > 1) {
				%>
				<li class="page-item"><a class="page-link"
					href="wishlist.jsp?&currentPage=<%=startPage - 1%>"style="color: black;" aria-label="Previous"><spanaria-hidden="true">&#10094;</span></a></li>
				<%
				}
	
				// 다음
				if (endPage < totalPage) {
				%>
					<li class="page-item"><a class="page-link"
						href="wishlist.jsp?currentPage=<%=endPage + 1%>"style="color: black" aria-label="Next"><span aria-hidden="true">&#10095;</span></a>
					</li>
				<%
				}
			%>
		</ul>
		<!-- 페이지 번호 출력 끝. -->

		</div>
		
		<%

	} else if(loginok==null) {
		%><h4>로그인페이지로 전달</h4><%
		//response.sendRedirect("../로그인페이지로 전달");
	} else {%>
		<div style="margin:50px 300px; width:600px">
			<h3 style="padding: 75px;" align="center">WISH LIST</h3>
			<div style="padding: 90px; font-size: 16px;" align="center">
				<span style="font-size: 14px; color: #616161;">관심상품이 없습니다.</span> <br>
				<div style="margin-top: 20px;"><a href="../product/productList.jsp?cate_num=1" style="color: white; background: #FF5C00; padding: 4px 35px; border-radius: 5px;">쇼핑하러가기</a></div>
			</div>
		</div>
	<%}



	
%>
</body>
</html>
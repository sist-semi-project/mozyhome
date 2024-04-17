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
	 	font-size: 13px;
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
					location.href="../wishlist/deleteWishlist.jsp?ditems="+ditem;
					
					/*
					$.ajax({
						type:"get",
						url:"wishlist/deleteWishlist.jsp",
						traditional:true,
						dataType:"html",
						data:{"ditem":ditem},
						success:function(){
							alert("관심상품이 삭제되었습니다.");
							location.reload();
						}						
					});	*/
				}	
			}
			
		});
		
		
	});

</script>
</head>
<%
	//0415 로그인 세션
	session.setAttribute("mem_id","dragon");
	session.setAttribute("loginok","");	
	String loginok=(String)session.getAttribute("loginok");
	String myid=(String)session.getAttribute("mem_id");
	//System.out.println(myid);
	
	WishlistDao wdao=new WishlistDao();
	List<HashMap<String, String>> list=wdao.getWishlist(myid);
	
	// 화폐 단위 정의
	NumberFormat nf=new DecimalFormat("#,###.##원");
%>
<body>
<%
	// 로그인이 되어있을 때 위시리스트 접근 가능
	if(loginok!=null){%>
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
											<input type="checkbox" class="allDel" value="<%=map.get("wish_num")%>">
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

		</div>
		
		<%

	} else {
		// 로그인 페이지로 전달
		//response.sendRedirect("../로그인페이지로 전달");
	}



	
%>
</body>
</html>
<%@page import="data.dao.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap"
	rel="stylesheet">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<title>별점</title>
<style type="text/css">
.rating_box {
	display: flex;
}

.rating {
	position: relative;
	color: #ddd;
	font-size: 30px;
	text-align: center;
}

.rating input {
	position: absolute;
	left: 0;
	right: 0;
	width: 100%;
	height: 100%;
	opacity: 0;
	cursor: pointer;
}

.rating_star {
	width: 0;
	color: #ffc107;
	position: absolute;
	left: 0;
	right: 0;
	overflow: hidden;
	pointer-events: none;
}

.bi-image-alt{
	color: #FF5C00;
	font-size: 20pt;
}

.submit{
	background-color: #FF5C00;
	color: white;
	border: 0px;
}

#review{
	font-family: "Noto Sans KR";
	font-size: 24px; 
}

.review_div{
	width: 1920 px;
	
}

#showimg{
	width: 100px;
	height: 100px;
	
}

.camera {
	font-size: 100px;
}
</style>

<script type="text/javascript">
//사진 출력 함수
	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $("#showimg").attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
</script>
</head>
<%
	String pro_num="210";
	//String pro_num = request.getParameter("pro_num");
	
	String loginok = "yes";
	String mem_id= "dragon";
	
	ReviewDao rdao=new ReviewDao();
	
	int mem_num=rdao.getNum(mem_id);

	//String loginok = (String) session.getAttribute("loginok");
	//String mem_id = (String) session.getAttribute("mem_id"); 
%>

<body>
	<div class="review_div">
	
		<!-- ReviewForm --> 
		<form action="reviewProcess.jsp" method="post" enctype="multipart/form-data">
		
		<input type="hidden" name="pro_num" value="<%=pro_num%>">
		<input type="hidden" name="mem_num" value="<%=mem_num%>">
		
		<div id="review">REVIEW</div>
		
		<p>최근 구매한 제품이 마음에 드시나요? 다른 사람들과 구매 경험을 공유해보세요!</p>
		
			<!-- 별점 -->
			<div class="rating_box">
				<div class="rating">
					<span class="star" data-value="1">★</span> 
					<span class="star" data-value="2">★</span> 
					<span class="star" data-value="3">★</span>
					<span class="star" data-value="4">★</span> 
					<span class="star" data-value="5">★</span> 
					<input type="hidden" name="rating" value="0">
				</div>
			</div>

			<!-- 선택 리뷰 작성 폼 
			<dl class="">
				<dt class="">사용성</dt>
				<dd class="">
					<div class="">
						<input type="radio" class=""
							id="choice1" name="" value=""
							data-category="" checked="checked"> <label
							class="" for="choice1">쉬워요</label>
					</div>
					<div class="">
						<input type="radio" class=""
							id="choice2" name="" value=""
							data-category=""> <label
							class="" for="choice2">보통이에요</label>
					</div>
					<div class="">
						<input type="radio" class=""
							id="choice3" name="" value=""
							data-category=""> <label
							class="" for="choice3">다소
							어려워요</label>
					</div>
				</dd>
			</dl>
-->

			<p></p>

			<!-- 리뷰 작성 -->
			<h4>상품평 제목*</h4>
			<textarea style="width: 500px; height: 100px;"
				name="content_subject" class="form-control" required="required"></textarea>
		
			<h4>상품평*</h4>
			<textarea style="width: 500px; height: 100px;"
				name="content" class="form-control" required="required"></textarea>
		
		<!-- 사진 파일 선택 -->
			<i class="bi bi-image-alt camera" ></i> 
			<input type="file" name="photo" id="photo"
				style="visibility: hidden;" onchange="readURL(this)">
				
			<img id="showimg" >
				
			<button type="submit" class="submit"
			>등록</button>
			<button onclick="reviewList.jsp" type="submit" class="submit"
			>취소</button>
			
			
		</form>

		<!-- 이미지미리보기 -->
	</div>

	<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    console.log("페이지 로드 완료");
    
    //별점 메서드
    const stars = document.querySelectorAll('.star');
    const rating_input = document.querySelector('input[name="rating"]');
  
    if (!stars || !rating_input) {
        console.error("요소를 찾을 수 없음");
        return; //요소를 찾지 못한 경우 코드 실행 중단
    }
  
    console.log("요소 참조 완료");
  
    //별점 클릭할 때
    stars.forEach(star => {
        star.addEventListener('click', () => {
            console.log("별점 클릭 이벤트 발생");
            const value = parseInt(star.getAttribute('data-value'));
            rating_input.value = value;
            updateRating(value);
        });
    });
  
    function updateRating(value) {
        console.log("별점 업데이트:", value);
        stars.forEach(star => {
            const starValue = parseInt(star.getAttribute('data-value'));
            if (starValue <= value) {
                star.style.color = '#FF5C00'; <!--클릭된 별보다 작거나 같은 별에 대해 색상 변경-->
            } else {
                star.style.color = '#ddd'; <!--클릭된 별보다 큰 별에 대해 색상 변경-->
            }
        });
    }
    
    //리뷰 등록(submit) 버튼 함수
<%--     $(function(){
    	$(".submit").click(function(){
    		var pro_num=<%=pro_num%>
    		location.href = "review/reviewProcess.jsp?pro_num=" + pro_num;
    	})
    })  --%>
    
    //사진 아이콘 클릭 함수
    $(function(){
        $("i.camera").click(function(){
            $("#photo").trigger("click");
        });
    });

  //사진 출력 함수
	function readURL(input) {
	    if (input.files && input.files[0]) {
	        var reader = new FileReader();
	        reader.onload = function (e) {
	            $("#showimg").attr('src', e.target.result);
	        }
	        reader.readAsDataURL(input.files[0]);
	    }
	}
   
});
</script>
</body>
</html>
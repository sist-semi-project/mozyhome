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
<style type="text/css">
	.modal{
            position:absolute;
            display:none;
            
            justify-content: center;
            top:0;
            left:0;

            width:100%;
            height:100%;

            

            background-color: rgba(0,0,0,0.4);
        }
        
        .modal_body{
            position:absolute;
            top:50%; //모달을 화면가운데 놓기위함. 
        

            width:400px;  //모달의 가로크기 
            height:600px; //모달의 세로크기 

            padding:40px;  

            text-align: center;

            background-color: rgb(255,255,255); //모달창 배경색 흰색
            border-radius:10px; //테두리 
            box-shadow:0 2px 3px 0 rgba(34,36,38,0.15); //테두리 그림자 

            transform:translateY(-50%); //모듈창열었을때 위치설정 가운데로 
        }
	
</style>
<script type="text/javascript">
	$(function(){
		$("#search").click(function(){
			var keyword=$("#keyword").val();
			//alert(keyword);
			if(keyword==""){
				alert("검색어를 입력해주세요");
			} else{
				location.href="../product/searchList.jsp?search="+keyword;	
			}
			
		});
		
		document.getElementById('keyword').addEventListener('keypress', function(event) {
            // 엔터 키가 눌렸는지 확인
            if (event.keyCode === 13) {
                event.preventDefault(); // 폼 제출을 방지
                document.getElementById('search').click(); // '사이즈 추가' 버튼 클릭 이벤트 발생
            }
        });
	});

</script>
</head>

<body>
	<div class="modal">
        <div class="modal_body">
        	
            <input type="text" id="keyword">
			<i class="bi bi-search" id="search"></i>
			<div class="close-area"><i class="bi bi-x-lg"></i></div>
        </div>
    </div>
    <button class="btn-open-modal">Modal열기</button>
    
    <script>
        const modal = document.querySelector('.modal');
        const btnOpenModal=document.querySelector('.btn-open-modal');
        
        const closeBtn = modal.querySelector(".close-area")
        closeBtn.addEventListener("click", e => {
            modal.style.display = "none"
        })

        btnOpenModal.addEventListener("click", ()=>{
            modal.style.display="flex";
        });
        
        window.addEventListener("keyup", e => {
		    if(modal.style.display === "flex" && e.key === "Escape") {
		        modal.style.display = "none"
		    }
		})
    </script>
</body>
</html>
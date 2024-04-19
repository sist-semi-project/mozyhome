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

<title>검색 토글 테스트</title>
<style type="text/css">
/* 검색 토글창 디자인 시작 */
	body {
		background: gray;
		height: 3000px;
		font-family: 'Noto Sans KR';
	}
	
	#search {
	    width: 100%;
	    height: 20rem;
	    position: absolute;
	    display: none;
	    background-color: #F9F8F6;
	    z-index: 1;
	    justify-content: center; /* 수평 가운데 정렬 */
	    align-items: center; /* 수직 가운데 정렬 */
	    display: flex; /* 부모 요소를 플렉스 박스로 설정합니다. */    
	}

	#search input {
	    width: 30%;
	    height: 30px;
	    font-size: 15px;
	    border: none;
	    outline: none;
	    background-color: #F9F8F6;
	    border-bottom: 1px black solid;
	    margin-bottom: 10px;
	    flex-direction: column;
	    text-indent: 3px;
	}
	
	#enter {
	    font-size: 18px;
	    border: none;   
	    width: 50px;
	    height: 30px;
	    border-radius: 15px;
	    background-color: #F9F8F6;
	    color: black;
	    cursor: pointer;
	    margin-bottom: 10px;
	}

	#close {
	    position: absolute;
	    top: 0;
	    right: 0;
	    margin: 10px;
	    color: black;
	}
/* 검색 토글창 디자인 끝 */
</style>
<script type="text/javascript">
	$(function() {
		$("#search").hide();
		
		$("#searchIcon").click(function() {
			var keyword = $("#keyword").val();
			//alert(keyword);
			if(keyword==""){
				alert("검색어를 입력해주세요");
			} else{
				location.href="../search/searchList.jsp?search="+keyword;	
			}
		});

		document.getElementById('keyword').addEventListener('keypress',function(event) {
			// 엔터 키가 눌렸는지 확인
			if (event.keyCode === 13) {
				event.preventDefault(); // 폼 제출을 방지
				document.getElementById('searchIcon').click(); // '사이즈 추가' 버튼 클릭 이벤트 발생
			}
		});	
		
		$("#close").click(function(){
			//alert("click");
			$("#search").hide();
		})
		
	});
	
	function openSetting(){
	    /* if(document.getElementById('search').style.display==='block'){
	        document.getElementById('search').style.display='none';
	    }else{
	        document.getElementById('search').style.display='block';
	    } */
	    
	    $("#search").slideToggle(225);
	}
</script>
</head>

<body>
	<button onclick="openSetting()"><i class="bi bi-search"></i></button>
    
    <div id="search">
        <input type="text" id="keyword" placeholder="SEARCH">
        <button type="button" id="enter">
        	<img alt="" src="../image/staticImage/serachicon_bs.png" id="searchIcon" width="22px">
        </button>
        
        <span id="close"><i class="bi bi-x-lg"></i></span>
    </div>
</body>
</html>
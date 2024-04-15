<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap" rel="stylesheet">
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
</style>
</head>

<body>
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
  
<script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    console.log("페이지 로드 완료");
    
    const stars = document.querySelectorAll('.star');
    const rating_input = document.querySelector('input[name="rating"]');
  
    if (!stars || !rating_input) {
        console.error("요소를 찾을 수 없음");
        return; // 요소를 찾지 못한 경우 코드 실행 중단
    }
  
    console.log("요소 참조 완료");
  
    // 별점 클릭할 때
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
                star.style.color = '#ffc107'; // 클릭된 별보다 작거나 같은 별에 대해 색상 변경
            } else {
                star.style.color = '#ddd'; // 클릭된 별보다 큰 별에 대해 색상 변경
            }
        });
    }
});
</script>
</body>
</html>
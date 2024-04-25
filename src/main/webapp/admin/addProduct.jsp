<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap"
          rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <title>상품 등록 페이지</title>
    <style>
        /* 파일 입력 필드 숨기기 */
        .fileInput {
            display: none;
        }

        /* 이미지 아이콘 스타일 */
        .imageIcon {
            cursor: pointer;
            border: 1px solid #ddd;
            margin: 5px;
            height: 100px;
            width: 100px;
            background-repeat: no-repeat;
            background-position: center center;
            background-size: cover;
        }
        /* 이미지 아이콘을 한 줄에 나열하기 위한 컨테이너 스타일 */
        .imageIconContainer {
            display: flex; /* 플렉스박스를 사용하여 아이콘들을 행으로 배치 */
            justify-content: start; /* 아이콘들을 컨테이너의 시작점으로 정렬 */
            flex-wrap: nowrap; /* 모든 아이콘을 한 줄에 나열 */
        }
        #priceDisplay {
            margin-left: 10px;
        }
    </style>


    <script>
        // 대분류 카테고리가 변경될 때 호출될 함수
        function updateSubCategories() {
            var mainCategory = document.getElementById("mainCategory").value;
            var subCategory = document.getElementById("subCategory");
            subCategory.options.length = 0; // 소분류 옵션 초기화

            if(mainCategory == "1") {
                // 거실
                subCategory.options.add(new Option("소파", "11"));
                subCategory.options.add(new Option("테이블", "12"));
            } else if(mainCategory == "2") {
                // 주방
                subCategory.options.add(new Option("식탁", "21"));
                subCategory.options.add(new Option("의자", "22"));
            } else if(mainCategory == "3") {
                // 침실
                subCategory.options.add(new Option("침대", "31"));
                subCategory.options.add(new Option("옷장", "32"));
            } else if(mainCategory == "4") {
                // 조명
                subCategory.options.add(new Option("단스탠드", "41"));
                subCategory.options.add(new Option("장스탠드", "42"));
            } else if (mainCategory == "5") {
                subCategory.options.add(new Option("기타","51"));
            }
        }
        // 파일 선택 후 미리보기 함수
        function previewImage(fileInputId, imageIconId) {
            var fileInput = document.getElementById(fileInputId);
            var imageIcon = document.getElementById(imageIconId);

            fileInput.addEventListener("change", function() {
                var file = this.files[0];
                if (file) {
                    var reader = new FileReader();
                    reader.onload = function(e) {
                        // 아이콘을 선택된 이미지로 변경
                        imageIcon.style.backgroundImage = 'url(' + e.target.result + ')';
                    };
                    reader.readAsDataURL(file);
                }
            });

            // 숨겨진 파일 입력 필드를 클릭하여 파일 선택기를 열음
            fileInput.click();
        }

        document.addEventListener('DOMContentLoaded', function() {

            var productForm = document.getElementById('productForm');
            var colorTagsContainer = document.getElementById('colorTags');
            var sizeTagsContainer = document.getElementById('sizeTags');
            var colorsTagInput = document.getElementById('colors');
            var sizesTagInput = document.getElementById('sizes');

            // 색상 추가 함수
            document.getElementById('addColor').addEventListener('click', function() {
                var colorInput = document.getElementById('colorInput');
                if (colorInput.value.trim() !== '') {
                    var tag = createTag(colorInput.value, colorTagsContainer);
                    colorInput.value = ''; // 입력 필드 초기화
                }
            });

            // 사이즈 추가 함수
            document.getElementById('addSize').addEventListener('click', function() {
                var sizeInput = document.getElementById('sizeInput');
                if (sizeInput.value.trim() !== '') {
                    var tag = createTag(sizeInput.value, sizeTagsContainer);
                    sizeInput.value = ''; // 입력 필드 초기화
                }
            });

            // 태그 생성 함수
            function createTag(text, container) {
                var tag = document.createElement('div');
                tag.textContent = text;
                tag.style.display = 'inline-block';
                tag.style.margin = '2px';
                tag.style.padding = '2px 5px';
                tag.style.border = '1px solid #ddd';
                tag.style.borderRadius = '5px';

                var closeBtn = document.createElement('span');
                closeBtn.textContent = 'x';
                closeBtn.style.marginLeft = '5px';
                closeBtn.style.cursor = 'pointer';
                closeBtn.onclick = function() {
                    tag.remove();
                };

                tag.appendChild(closeBtn);
                container.appendChild(tag);
            }
            // 색상 입력 필드에 keypress 이벤트 리스너 추가(엔터 입력시 태그 추가)
            document.getElementById('colorInput').addEventListener('keypress', function(event) {
                if (event.keyCode === 13) {
                    event.preventDefault(); // 폼 제출을 방지
                    document.getElementById('addColor').click(); // '색상 추가' 버튼 클릭 이벤트 발생
                }
            });

            document.getElementById('sizeInput').addEventListener('keypress', function(event) {
                // 엔터 키가 눌렸는지 확인
                if (event.keyCode === 13) {
                    event.preventDefault(); // 폼 제출을 방지
                    document.getElementById('addSize').click(); // '사이즈 추가' 버튼 클릭 이벤트 발생
                }
            });


            // 폼 제출 이벤트
            productForm.addEventListener('submit', function(e) {
                e.preventDefault(); // 폼의 기본 제출 이벤트를 방지

                // 색상 태그들을 문자열로 변환
                var colorTags = Array.from(colorTagsContainer.children).map(function(tag) {
                    return tag.textContent.slice(0, -1); // 'x' 제거
                });
                colorsTagInput.value = colorTags.join(',');


                // 사이즈 태그들을 문자열로 변환
                var sizeTags = Array.from(sizeTagsContainer.children).map(function(tag) {
                    return tag.textContent.slice(0, -1); // 'x' 제거
                });
                sizesTagInput.value = sizeTags.join(',');

                // 이제 폼을 제출할 수 있음
                this.submit(); // 폼 제출
            });

            // 가격 입력 필드에 대한 이벤트 리스너 추가
            document.getElementById('priceInput').addEventListener('input', function() {
                var inputVal = this.value;

                // 원화 포맷으로 변환
                var formattedPrice = formatPriceToKRW(inputVal);

                // 결과 표시
                document.getElementById('priceDisplay').innerText = formattedPrice;
            });

            function formatPriceToKRW(price) {
                if (!price) return '';

                // 억 단위, 만 단위, 그 이하로 나누기
                var billions = Math.floor(price / 100000000); // 억 단위
                var millions = Math.floor((price % 100000000) / 10000); // 만 단위
                var rest = price % 10000; // 그 이하

                // 결과 문자열 포맷팅
                var result = '';
                if (billions > 0) result += billions + '억 ';
                if (millions > 0) result += millions + '만 ';
                if (rest > 0) result += rest;
                result += '원';

                return result;
            }
        });


    </script>
</head>
<body>

<div style="display: flex;">
    <%@ include file="dashboard.jsp" %>
    <form action="./addProductAction.jsp" method="post" enctype="multipart/form-data" id="productForm" style="width: 50%;">
	<h2>상품 등록</h2>
    <div>
        <label>대분류 카테고리:</label>
        <select id="mainCategory" name="mainCategory" onchange="updateSubCategories()">
            <option value="1" selected>거실</option>
            <option value="2">주방</option>
            <option value="3">침실</option>
            <option value="4">조명</option>
            <option value="5">기타</option>
        </select>
    </div>
    <div>
        <label>소분류 카테고리:</label>
        <select id="subCategory" name="subCategory">
            <!-- 자바스크립트를 통해 동적으로 옵션이 추가됩니다. -->
            <option value="11" selected>소파</option>
            <option value="12">테이블</option>
        </select>
    </div>
    <div>
        <label>상품명:</label>
        <input type="text" name="product_name" required>
    </div>
    <div>
        <label>상품 설명:</label>
        <textarea name="product_description" rows="4" cols="50"></textarea>
    </div>
    <!-- 색상 옵션 입력 -->
    <div>
        <label>색상 옵션:</label>
        <input type="text" id="colorInput" name="colorOption">
        <button type="button" id="addColor">색상 추가</button>
        <!-- 색상 태그를 표시할 컨테이너 -->
        <div id="colorTags"></div>
    </div>
    <!-- 사이즈 옵션 입력 -->
    <div>
        <label>사이즈 옵션:</label>
        <input type="text" id="sizeInput" name="sizeOption">
        <button type="button" id="addSize">사이즈 추가</button>
        <!-- 사이즈 태그를 표시할 컨테이너 -->
        <div id="sizeTags"></div>
    </div>


    <div>
        <label>재고:</label>
        <input type="number" name="stock" value="0" min="0">
    </div>
    <div>
        <label>가격:</label>
        <input type="number" id="priceInput"  name="price" required>
        <span id="priceDisplay"></span>
    </div>
    <div class="imageIconContainer">
        <!-- 이미지 아이콘과 숨겨진 파일 입력 필드 -->
        <div id="icon1" class="imageIcon" onclick="previewImage('main_image', 'icon1')" style="background-image: url('../image/staticImage/icon_mainimage.png');"></div>
        <input type="file" id="main_image" name="main_image" accept="image/*" class="fileInput">

        <!-- 나머지 아이콘 및 입력 필드도 비슷한 방식으로 추가 -->
        <!-- 예: 서브 이미지 1 -->
        <div id="icon2" class="imageIcon" onclick="previewImage('sub_image1', 'icon2')" style="background-image: url('../image/staticImage/icon_subimage.png');"></div>
        <input type="file" id="sub_image1" name="sub_image1" accept="image/*" class="fileInput">
        <div id="icon3" class="imageIcon" onclick="previewImage('sub_image2', 'icon3')" style="background-image: url('../image/staticImage/icon_subimage.png');"></div>
        <input type="file" id="sub_image2" name="sub_image2" accept="image/*" class="fileInput">
        <div id="icon4" class="imageIcon" onclick="previewImage('sub_image3', 'icon4')" style="background-image: url('../image/staticImage/icon_subimage.png');"></div>
        <input type="file" id="sub_image3" name="sub_image3" accept="image/*" class="fileInput">
        <div id="icon5" class="imageIcon" onclick="previewImage('sub_image4', 'icon5')" style="background-image: url('../image/staticImage/icon_subimage.png');"></div>
        <input type="file" id="sub_image4" name="sub_image4" accept="image/*" class="fileInput">
        <div id="icon6" class="imageIcon" onclick="previewImage('sub_image5', 'icon6')" style="background-image: url('../image/staticImage/icon_subimage.png');"></div>
        <input type="file" id="sub_image5" name="sub_image5" accept="image/*" class="fileInput">

        <!-- 태그값 전송을 위한 히든필드 -->
        <input type="hidden" name="colors" id="colors">
        <input type="hidden" name="sizes" id="sizes">
    </div>
    <div>
        <label>판매 상태:</label>
        <select name="sale_status">
            <option value="on_sale" selected>판매중</option>
            <option value="out_of_stock">품절</option>
            <option value="discontinued">단종</option>
        </select>
    </div>
    <button type="submit">상품 등록</button>
</form>
</div>
</body>
</html>

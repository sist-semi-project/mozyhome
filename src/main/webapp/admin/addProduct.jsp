<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <title>상품 등록 페이지</title>
    <style>
        body {
            display: flex;
            height: 1250px;
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        /* 파일 입력 필드 숨기기 */
        .fileInput {
            display: none;
        }

        /* 이미지 아이콘 스타일 */
        .imageIcon {
            cursor: pointer;
            border: 1px solid #ddd;
            margin: 5px;
            height: 110px;
            width: 110px;
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

        .container {
            background: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin: 0px 0px;
            width: 33%;

        }

        .form-label {
            font-weight: bold;
        }

        .form-control, .form-select {
            border-radius: 0.25rem;
        }

        .input-group button {
            border-radius: 0.25rem;
        }

        .tag-container div {
            display: inline-block;
            background: #e9ecef;
            padding: 2px 8px;
            margin: 2px;
            font-size: 14px;
            border-radius: 15px;
        }

        .image-upload-container {
            display: flex;
            gap: 10px;
            padding-top: 10px;
        }
        .imageIconContainer {
            display: flex; /* 플렉스박스를 사용하여 아이콘들을 행으로 배치 */
            justify-content: start; /* 아이콘들을 컨테이너의 시작점으로 정렬 */
            flex-wrap: nowrap; /* 모든 아이콘을 한 줄에 나열 */
            flex-direction: column;
        }
        .imageIconRow {
            display: flex;
            justify-content: start;
            flex-wrap: nowrap; /* 한 줄에 표시 */
            margin-bottom: 10px; /* 각 줄 사이에 마진 추가 */
        }

        .image-upload-container div {
            width: 100px;
            height: 100px;
            background: #ddd;
            display: flex;
            justify-content: center;
            align-items: center;
            border: 1px solid #ccc;
            cursor: pointer;
        }

        .image-upload-container input[type="file"] {
            display: none;
        }
        .input-group.align-items-center {
            display: flex;
            align-items: center;
        }

        .input-group .form-label {
            flex-grow: 0;
            flex-shrink: 0;
            margin-right: 10px;
            text-align: center;
            white-space: nowrap;

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
                alert("상품등록이 완료되었습니다.")
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
<jsp:include page="sidebar.jsp"/>
<div class="content">
    <div class="header" style="margin-bottom: -25px;">상품등록</div>
    <div class="container mt-5">
        <form id="productForm" action="./addProductAction.jsp" method="post" enctype="multipart/form-data">
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="mainCategory" class="form-label">상위 카테고리</label>
                    <select id="mainCategory" name="mainCategory" class="form-select" onchange="updateSubCategories()">
                        <option value="1">거실</option>
                        <option value="2">주방</option>
                        <option value="3">침실</option>
                        <option value="4">조명</option>
                        <option value="5">기타</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label for="subCategory" class="form-label">하위 카테고리</label>
                    <select id="subCategory" name="subCategory" class="form-select">
                        <!-- 자바스크립트를 통해 동적으로 옵션이 추가됩니다. -->
                        <option value="11" selected>소파</option>
                        <option value="12">테이블</option>
                    </select>
                </div>
            </div>

            <div class="mb-3">
                <label for="product_name" class="form-label">상품명</label>
                <input type="text" id="product_name" name="product_name" required class="form-control">
            </div>

            <div class="mb-3">
                <label for="product_description" class="form-label">상품 설명</label>
                <textarea id="product_description" name="product_description" rows="4" class="form-control"></textarea>
            </div>

            <div class="mb-3">

                <div class="input-group align-items-center">
                    <label for="colorInput" class="form-label" style="margin-right: 23px; text-align: center;" > 색상 옵션</label>
                    <input type="text" id="colorInput" name="colorOption" class="form-control" placeholder="추가할 색상 입력 후 엔터">
                    <button type="button" id="addColor" class="btn btn-outline-secondary" style="display: none">색상 추가</button>
                </div>
                <div id="colorTags" class="tag-container mt-2"></div>
            </div>

            <div class="mb-3">
                <div class="input-group align-items-center">
                    <label for="colorInput" class="form-label" style="margin-right: 10px; text-align: center;" >사이즈 옵션</label>
                    <input type="text" id="sizeInput" name="sizeOption" class="form-control" placeholder="추가할 사이즈 입력 후 엔터">
                    <button type="button" id="addSize" class="btn btn-outline-secondary" style="display: none">사이즈 추가</button>
                </div>
                <div id="sizeTags" class="tag-container mt-2"></div>
            </div>

            <div class="mb-3">
                <label for="stock" class="form-label">재고</label>
                <input type="number" id="stock" name="stock" value="0" min="0" class="form-control">
            </div>

            <div class="mb-3">
                <label for="priceInput" class="form-label">가격</label>
                <input type="number" id="priceInput" name="price" required class="form-control">
                <div id="priceDisplay" class="form-text"></div>
            </div>

            <div class="mb-3">
                <label for="sale_status" class="form-label">판매 상태</label>
                <select id="sale_status" name="sale_status" class="form-select">
                    <option value="on_sale">판매중</option>
                    <option value="out_of_stock">품절</option>
                    <option value="discontinued">단종</option>
                </select>
            </div>

            <div class="mb-3">
                <label class="form-label">상품 이미지</label>
                <div class="imageIconContainer">
                    <div class="imageIconRow">
                        <div id="icon1" class="imageIcon" onclick="previewImage('main_image', 'icon1')" style="background-image: url('../image/staticImage/icon_mainimage.png'); background-size: cover"></div>
                        <input type="file" id="main_image" name="main_image" accept="image/*" class="fileInput">
                        <div id="icon2" class="imageIcon" onclick="previewImage('sub_image1', 'icon2')" style="background-image: url('../image/staticImage/icon_subimage.png');"></div>
                        <input type="file" id="sub_image1" name="sub_image1" accept="image/*" class="fileInput">
                        <div id="icon3" class="imageIcon" onclick="previewImage('sub_image2', 'icon3')" style="background-image: url('../image/staticImage/icon_subimage.png');"></div>
                    </div>
                    <div class="imageIconRow">
                        <input type="file" id="sub_image2" name="sub_image2" accept="image/*" class="fileInput">
                        <div id="icon4" class="imageIcon" onclick="previewImage('sub_image3', 'icon4')" style="background-image: url('../image/staticImage/icon_subimage.png');"></div>
                        <input type="file" id="sub_image3" name="sub_image3" accept="image/*" class="fileInput">
                        <div id="icon5" class="imageIcon" onclick="previewImage('sub_image4', 'icon5')" style="background-image: url('../image/staticImage/icon_subimage.png');"></div>
                        <input type="file" id="sub_image4" name="sub_image4" accept="image/*" class="fileInput">
                        <div id="icon6" class="imageIcon" onclick="previewImage('sub_image5', 'icon6')" style="background-image: url('../image/staticImage/icon_subimage.png');"></div>
                        <input type="file" id="sub_image5" name="sub_image5" accept="image/*" class="fileInput">
                    </div>

                    <!-- 태그값 전송을 위한 히든필드 -->
                    <input type="hidden" name="colors" id="colors">
                    <input type="hidden" name="sizes" id="sizes">
                </div>
            </div>

            <button type="submit" class="btn btn-dark">상품 등록</button>
        </form>
    </div>

</div>
</body>
</html>

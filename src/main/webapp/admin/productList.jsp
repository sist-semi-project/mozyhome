<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="data.dao.ProductDao" %>
<%@ page import="data.dto.ProductDto" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.time.LocalDate" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-04-09
  Time: 오후 2:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <title>Product List for Admin</title>
    <style>
        body {
            display: flex;
            height: 1100px;
            background-color: #f8f9fa;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .header {
            font-size: 24px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #ccc;
        }
        .categoryName{
            margin-left: 3px;
            margin-right: 5px;
        }
        table {
            width: 100%;
            margin-top: 20px;
        }
        th, td {
            text-align: center;
            vertical-align: middle;
            padding: 8px;
            border-bottom: 1px solid #ddd;
            font-size: 16px;
        }
        th {
            background-color: #f0f0f0;
        }
        form {
            margin-bottom: 20px;
            background: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            width: 92%;
        }
        .form-group {
            margin-bottom: 10px;
        }
        .pagination{
            margin-right: 14%;
        }
        .pagination .page-item a {
            color: black; /* 텍스트 색상 검정으로 변경 */
            background-color: #f5f5f5; /* 배경색을 페이지의 배경색과 동일하게 설정 */
        }
        .pagination .page-item.active a {
            color: white; /* 활성 페이지 텍스트 색상을 흰색으로 변경 */
            background-color: #0d6efd; /* 활성 페이지 배경색을 부트스트랩 기본 파란색으로 설정 */
        }
        .pagination .page-item {
            border: none; /* 테두리 제거 */
        }

        .pagination .page-item + .page-item {
            margin-left: 0; /* 좌측 간격 제거 */
        }

        .pagination .page-link {
            color: black; /* 텍스트 색상 검정으로 변경 */
            background-color: #f5f5f5; /* 배경색을 페이지의 배경색과 동일하게 설정 */
            border: none; /* 페이지 링크의 테두리 제거 */
        }

        .pagination .page-item.active a {
            color: white; /* 활성 페이지 텍스트 색상을 흰색으로 변경 */
            background-color: #0d6efd; /* 활성 페이지 배경색을 부트스트랩 기본 파란색으로 설정 */
        }
        /**/
        /* 페이지 링크 기본 스타일 */
        .pagination .page-link {
            color: black; /* 텍스트 색상을 검정색으로 설정 */
            background-color: #f5f5f5; /* 배경색 설정 */
            border: none; /* 기본 테두리 제거 */
            cursor: pointer; /* 마우스 오버 시 커서를 손가락 모양으로 변경 */
        }

        /* 활성 페이지 스타일 */
        .pagination .page-item.active .page-link {
            font-weight: bold; /* 텍스트를 굵게 */
            color: #000000;
            background-color: transparent; /* 배경색 제거 */
            border: 1px solid lightgray; /* 연한 회색 테두리 추가 */
        }

        /* 페이지 링크 호버 스타일 */
        .pagination .page-link:hover {
            background-color: #e9ecef; /* 호버 시 배경색 변경 */
        }
        .icon-button {
            background: none;
            border: none;
            color: #0d6efd; /* 버튼 색상을 부트스트랩 기본 파란색으로 설정 */
            cursor: pointer;
            padding: 5px; /* 적당한 패딩을 추가 */
        }

        .icon-button:hover {
            color: #0056b3; /* 호버 시 색상 변경 */
        }
        /* 이미지 아이콘 스타일 */

        .imageIcon {
            cursor: pointer;
            border: 1px solid #ddd;
            margin: 5px;
            width: 31%; /* 너비를 컨테이너의 33%로 설정 */
            background-repeat: no-repeat !important;
            background-position: center center !important;
            background-size: contain !important;
            position: relative; /* 패딩을 기반으로 높이 설정을 위해 필요 */
            padding-top: 28%; /* 가로 너비에 대한 33%를 높이로 설정 */
            box-sizing: border-box; /* 패딩과 테두리가 너비에 포함되도록 설정 */
        }
        /* 이미지 아이콘을 한 줄에 나열하기 위한 컨테이너 스타일 */
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

        #priceDisplay {
            margin-left: 10px;
        }
        /* 파일 입력 필드 숨기기 */
        .fileInput {
            display: none;
        }
        .dateInput{
            width: 131px;
            height: 34px;
            padding: 0 9px;
        }
        #filter-tags{
            max-width: 630px;
        }
        .filter-tag {
            padding: 8px 12px;
            margin: 5px;
            display: inline-flex;
            align-items: center;
            font-size: 14px;
            color: #FFFFFF; /* White */
            border-radius: 20px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        /* 판매 상태별 색상 설정 */
        #selling-tag {
            /*background-color: #198754;*/
            background-color: #28a745;
        }

        #soldout-tag {
            /*background-color: #dc3545;*/
            background-color: #dc3545;
        }

        #discontinued-tag {
            /*background-color: #6c757d;*/
            background-color: #6c757d;
        }

        .maincategory-tag {
            background-color: #34495E;
        }

        /* 하위 카테고리별 색상 설정 */
        .subcategory-tag {
            background-color: #999999;
        }

        /* 각 하위 카테고리별 구체적 색상은 필요시 추가 가능 */

        .remove-tag {

            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 21px;
            height: 21px;
            background-color: #060606;
            color: #FFFFFF;
            font-size: 11px; /* 텍스트 크기 */
            border-radius: 50%; /* 동그라미 형태 */
            border: none; /* 테두리 없음 */
            cursor: pointer; /* 마우스 오버시 커서 변경 */
            margin-left: 5px;
        }

        .filter-tag:hover {
            opacity: 0.85;
        }
        #editSizeInput, #editColorInput{
            margin-bottom: 4px;
        }
        #editProductForm > div.form-group > label{
            margin-bottom: 2px;
        }
        .btn-cancel {
            background-color: #f8f9fa; /* 부트스트랩의 btn-light 배경색 */
            color: #212529; /* btn-light의 기본 글자색 */
            border: 1px solid #dee2e6; /* 경계선 추가 */
        }
        .form-group .btn {
            margin-right: 10px; /* 버튼 간 간격 조정 */
        }
        .product-name{
            font-weight: 700;
        }
        .product-price{
            text-align: right;
            padding-right: 30px;
        }

        .product-details img {
            max-width: 100%;
            height: auto;
            display: block;
            margin-bottom: 10px;
        }

        .product-details div {
            margin-top: 20px;
        }

        .main-image, .sub-image {
            width: 100px;  /* Consistent image size */
            margin-right: 5px;  /* Spacing between sub-images */
        }

        .sub-image {
            display: inline-block; /* Align images in a row */
        }

        .table-bordered td {
            vertical-align: middle; /* Align table content */
        }

        .modal-xl {
            max-width: 90%; /* Increase modal width for better layout */
        }
        .modal-dialog-centered-view {
            max-width: 60%;  /* Adjusted modal width */
            margin: 0 auto;
        }

        .table-bordered th, .table-bordered td {
            vertical-align: middle;  /* Align table content vertically */
            white-space: nowrap;  /* Prevent wrapping in table headers and first column */
        }

        .table-bordered td {
            word-wrap: break-word;  /* Allows words to break and wrap onto the next line */
            /*max-width: 0;*/  /* Enables overflow to be handled gracefully */
            overflow: hidden;  /* Hide overflowed content */
            text-overflow: ellipsis;  /* Add an ellipsis to clipped text */
        }

        /* Specific style for product description to allow vertical expansion */
        td.product-description {
            white-space: normal;  /* Allow wrapping */
            vertical-align: top;  /* Align text to the top */
        }
        .detail-view{
            width: 60%;
            margin-left: 20%;
        }

        /* Specific style for the first column of the table */
        .table-bordered td:first-child {
            background-color: #f4fdfc; /* Light grey background for better readability */
            font-weight: bold; /* Optional: Make text bold to emphasize titles */
        }
        .table-bordered td:nth-child(2) {
            text-align: left;
        }
        .input_component {
            display: inline-block;
            position: relative;
            height: 34px;
            box-sizing: border-box;
            border: solid 1px;
            border-color: rgb(221, 221, 221);
        }
        #btnSubmit {
            margin: 0;
            padding: 0;
            font-size: 13px;
            cursor: pointer;
            display: inline-block;
            width: 56px;
            height: 34px;
            background-color: #000000;
            border: 0;
            color: #fff;
        }
        #searchText{
            margin: 0;
            padding: 0;
            font-size: 13px;
            width: 199px;
            height: 32px;
            padding: 0 12px;
            border: 0;
            box-sizing: border-box;
            background-color: rgb(255, 255, 255);
            color: rgb(51, 51, 51);
        }
        .btn-date{
            margin-left: 4px;
            border: none;
            background-color: #5b4e4e;
            height: 33px;
            color: white;
        }
        .batch-action-container {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            margin: 9px 0;
            width: 27%;
        }

        .select_control, .btn {
            flex: 0 0 auto;
        }

        .select_control {
            margin-right: 10px;
        }


        .batch-action-container > label {
            white-space: nowrap;
            flex: 0 1 15%;
            margin-right: 10px;
            font-weight: 1000;

        }

        .status_select_control {
            width: 20%; /* Adjust according to your layout */
            display: block;
            padding: 3.5px 0px;
            font-size: 1rem;
            font-weight: 400;
            line-height: 1.5;
            color: black;
            -moz-appearance: none;
            background-color: white;
            background-clip: padding-box;
            border-radius: 5px;
            transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
            margin-right: 5px;

        }

        .btn {
            flex: 0 1 29%; /* Allows button to shrink if necessary */
        }
        #btnStatus{
            background-color: #3d3d3d;
            padding: 4px 13px;
            border-style: none;
        }

    </style>
    <%
        String adminID = (String) session.getAttribute("adminID");
        if (adminID == null) {
    %>

    <script type="text/javascript">
        alert("접근권한이 없습니다.");
        window.location.href = "/admin/adminLogin.jsp"; // 리디렉션을 JavaScript에서 처리
    </script>
    <%}
        ProductDao dao = new ProductDao();
        List<ProductDto> list = dao.getAllProductForAdmin();
        SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
        NumberFormat format = NumberFormat.getInstance(Locale.KOREA);

    %>


    <script>
        $(document).ready(function () {
            var pageSize = 6;  // 페이지당 상품 수
            var totalRecords = <%=list.size()%>;
            const totalPages = Math.ceil(totalRecords / pageSize);

            function getProducts(page = 1) {
                $.ajax({
                    url:'getAllProducts.jsp',
                    type:'get',
                    dataType: 'json',
                    traditional: true,
                    data:{
                        page: page,
                        pageSize: pageSize,
                    },

                    success: function (res) {
                        console.log({"res":res, "function":"getProducts()"});
                        updateDefaultTable(res);
                        updateDefaultPagination(page, totalPages);
                    }
                });
            }

            function fetchProducts(page = 1) {
                $.ajax({
                    url:'getFilteredProducts.jsp',
                    type:'get',
                    dataType: 'json',
                    traditional: true,
                    data:{
                        page: page,
                        salesStatus: $('input[name="salesStatus"]:checked').map(function(){ return this.value; }).get(),
                        mainCategory: $('input[name="mainCategory"]:checked').map(function(){ return this.value; }).get(),
                        subCategory: $('input[name="subCategory"]:checked').map(function(){ return this.value; }).get(),
                        startDate: $('input[name="startDate"]').val(),
                        endDate: $('input[name="endDate"]').val(),
                        productName: $('input[name="productName"]').val()
                    },

                    success: function (res) {
                        console.log({"res":res, "function":"fetchProducts()"});
                        updateTable(res);
                        filteredPagination(page,Math.ceil(res.result_count / pageSize));
                    }
                });
            }
            function updateDefaultTable(data) {
                let tableBody = $('#productTable tbody');
                tableBody.empty(); // 기존 테이블 내용 삭제
                $.each(data.products, function(i, product) {
                    var row = '<tr data-product-id="' + product.pro_num + '">' +
                        '<td><input type="checkbox" class="delete-checkbox" data-num="' + product.pro_num + '"/></td>' +
                        '<td>' + product.pro_num + '</td>' +
                        '<td class="product-category">' + product.parent_cate_num + ' > ' + product.cate_num + '</td>' +
                        '<td class="product-name">' + product.pro_name + '</td>' +
                        '<td class="product-price">' + product.pro_price + '원</td>' +
                        '<td class="product-stock">' + product.pro_stock + '개</td>' +
                        '<td class="product-status">' + product.pro_sale_status + '</td>' +
                        '<td class="product-image"><img src="' + product.pro_main_img + '" alt="대표이미지" style="width: 100px;"></td>' +
                        '<td>' + product.pro_create_date + '</td>' +
                        '<td class="product-volume">' + product.pro_sale_volume + '</td>' +
                        '<td>' +
                        '<button data-num="'+product.pro_num + '" class="view-button icon-button"><i class="fa-solid fa-eye" style="color: #000000;"></i></button>' +
                        '<button data-num="'+product.pro_num + '" class="edit-button icon-button"><i class="fa-regular fa-pen-to-square" style="color: #001eff;"></i></button>' +
                        '<button data-num="'+product.pro_num + '" class="delete-button icon-button"><i class="fa-solid fa-trash-can" style="color: #ab1726;"></i></button>' +
                        '</td>' +
                        '</tr>';
                    tableBody.append(row);
                });
                $('#result-count').text('총 ' + data.result_count + '개');
            }


            function updateTable(data) {
                let tableBody = $('#productTable tbody');
                tableBody.empty(); // 기존 테이블 내용 삭제
                $.each(data.products, function(i, product) {
                    var row = '<tr data-product-id="' + product.pro_num + '">' +
                        '<td><input type="checkbox" class="delete-checkbox" data-num="' + product.pro_num + '"/></td>' +
                        '<td>' + product.pro_num + '</td>' +
                        '<td class="product-category">' + product.parent_cate_num + ' > ' + product.cate_num + '</td>' +
                        '<td class="product-name">' + product.pro_name + '</td>' +
                        '<td class="product-price">' + product.pro_price + '원</td>' +
                        '<td class="product-stock">' + product.pro_stock + '개</td>' +
                        '<td class="product-status">' + product.pro_sale_status + '</td>' +
                        '<td class="product-image"><img src="' + product.pro_main_img + '" alt="대표이미지" style="width: 100px;"></td>' +
                        '<td>' + product.pro_create_date + '</td>' +
                        '<td>' + product.pro_sale_volume + '</td>' +
                        '<td>' +
                        '<button data-num="'+product.pro_num + '" class="view-button icon-button"><i class="fa-solid fa-eye" style="color: #000000;"></i></button>' +
                        '<button data-num="'+product.pro_num + '" class="edit-button icon-button"><i class="fa-regular fa-pen-to-square" style="color: #001eff;"></i></button>' +
                        '<button data-num="'+product.pro_num + '" class="delete-button icon-button"><i class="fa-solid fa-trash-can" style="color: #ab1726;"></i></button>' +
                        '</td>' +
                        '</tr>';

                    tableBody.append(row);
                });
                $('#result-count').text('총 ' + data.result_count + '개');
            }

            function updateDefaultPagination(currentPage, totalPages) {
                var pagination = $('.pagination');
                pagination.empty();

                var pageGroup = Math.ceil(currentPage / 5); // 현재 페이지 그룹 계산 (1~5, 6~10 ...)
                var startPage = (pageGroup - 1) * 5 + 1; // 그룹의 시작 페이지 번호
                var endPage = Math.min(totalPages, pageGroup * 5); // 그룹의 마지막 페이지 번호

                for (var i = startPage; i <= endPage; i++) {
                    var activeClass = currentPage === i ? 'active' : '';
                    var pageItem = '<li class="page-item ' + activeClass + '"><a class="page-link default-page-link" href="#" data-page="' + i + '">' + i + '</a></li>';
                    pagination.append(pageItem);
                }

                if (startPage > 1) {
                    pagination.prepend('<li class="page-item"><a class="page-link default-page-link" href="#" data-page="' + (startPage - 5) + '"> &#10094;</a></li>');
                }

                if (endPage < totalPages) {
                    pagination.append('<li class="page-item"><a class="page-link default-page-link" href="#" data-page="' + (endPage + 1) + '"> &#10095;</a></li>');
                }
            }
            function filteredPagination(currentPage, totalPages) {
                var pagination = $('.pagination');
                pagination.empty();

                var pageGroup = Math.ceil(currentPage / 5); // 현재 페이지 그룹 계산 (1~5, 6~10 ...)
                var startPage = (pageGroup - 1) * 5 + 1; // 그룹의 시작 페이지 번호
                var endPage = Math.min(totalPages, pageGroup * 5); // 그룹의 마지막 페이지 번호

                for (var i = startPage; i <= endPage; i++) {
                    var activeClass = currentPage === i ? 'active' : '';
                    var pageItem = '<li class="page-item ' + activeClass + '"><a class="page-link filtered-page-link" href="#" data-filterpage="' + i + '">' + i + '</a></li>';
                    pagination.append(pageItem);
                }

                if (startPage > 1) {
                    pagination.prepend('<li class="page-item"><a class="page-link filtered-page-link" href="#" data-filterpage="' + (startPage - 5) + '">&#10094;</a></li>');
                }

                if (endPage < totalPages) {
                    pagination.append('<li class="page-item"><a class="page-link filtered-page-link" href="#" data-filterpage="' + (endPage + 1) + '">&#10095;</a></li>');
                }
            }

            // 폼 서브밋 이벤트 핸들러
            $('.search-form').on('submit', function(e) {
                e.preventDefault(); // 폼 기본 제출 방지
                fetchProducts();
            });

            $('.search-form').on('change','input[type="checkbox"]', function(e) {
                e.preventDefault(); // 폼 기본 제출 방지
                fetchProducts();
                updateTags();
            });


            $(document).on('click', '.default-page-link', function(e) {
                e.preventDefault();
                var pageNum = $(this).data('page');
                getProducts(pageNum);
            });
            $(document).on('click', '.filtered-page-link', function(e) {
                e.preventDefault();
                var pageNum = $(this).data('filterpage');
                fetchProducts(pageNum);
            });

            $(document).on('click', '.delete-button', function(e) {
                if (confirm("정말 삭제하시겠습니까?")) {

                    var $thisButton = $(this);

                    const num = $thisButton.data("num");
                    console.log({num});


                    $.ajax({
                        type: "post",
                        url:"deleteProduct.jsp",
                        dataType: "json",
                        data:{num},
                        success: function (res) {
                            if (res.success == "true") {
                                console.log(res);
                                $thisButton.closest("tr").remove();
                            }else{
                                console.error("delete failed");
                            }


                        },
                    })

                } else {
                    return;
                }
            });
            $("#selectAll").click(function () {
                $(".delete-checkbox").prop('checked', this.checked);
            });

            // 수정 버튼 클릭시 모달 띄우기
            $(document).on('click', '.edit-button', function() {

                var productId = $(this).data('num'); // 상품 ID를 가져옴
                // AJAX 요청을 통해 상품의 상세 정보를 가져옴
                $.ajax({
                    url: 'getProductDetailsForEdit.jsp', // 상품 정보를 불러올 서버의 주소
                    type: 'GET',
                    data: { productId: productId },
                    dataType: 'json',
                    success: function(product) {
                        // 모달의 입력 필드에 데이터 채우기
                        $('#editProductId').val(product.pro_num);
                        $('#editMainCategory').val(product.parent_cate_num);
                        updateSubCategories();
                        setTimeout(function() {  // 지연을 통해 하위 카테고리 목록이 업데이트된 후 실행
                            $('#editSubCategory').val(product.cate_num); // 하위 카테고리 선택
                        }, 100);
                        $('#editProductName').val(product.pro_name);
                        $('#editProductDescription').val(product.pro_explain);

                        $('#editPriceInput').val(product.pro_price);
                        $('#icon1').css('background', 'url(' + product.pro_main_img + ')');
                        $('#icon2').css('background', 'url(' + product.pro_sub_img1 + ')');
                        $('#icon3').css('background', 'url(' + product.pro_sub_img2 + ')');
                        $('#icon4').css('background', 'url(' + product.pro_sub_img3 + ')');
                        $('#icon5').css('background', 'url(' + product.pro_sub_img4 + ')');
                        $('#icon6').css('background', 'url(' + product.pro_sub_img5 + ')');

                        // 원화 포맷으로 변환
                        setTimeout(function() {
                            var formattedPrice = formatPriceToKRW($('#editPriceInput').val());
                            document.getElementById('priceDisplay').innerText = formattedPrice;
                        }, 100);

                        $('#editStockInput').val(product.pro_stock);
                        $('#editSaleStatus').val(product.pro_sale_status);

                        // 색상 태그 반영
                        var colors = product.pro_color.split(',');
                        $('#colorTags').empty(); // 기존 태그 제거
                        colors.forEach(function(color) {
                            addTag(color, $('#colorTags'),'#EBEBEB','#1F1F1F','#6A6A6A','#F1F1F1'); // 색상 태그 추가
                        });

                        // 사이즈 태그 반영
                        var sizes = product.pro_size.split(',');
                        $('#sizeTags').empty(); // 기존 태그 제거
                        sizes.forEach(function(size) {
                            addTag(size, $('#sizeTags'),'#EBEBEB','#1F1F1F','#6A6A6A','#F1F1F1'); // 사이즈 태그 추가
                        });

                        console.log({product,"modalShow":true});

                        // 모달 표시
                        $('#editProductModal').modal('show');
                    }
                });
            });

            // 수정 양식 제출 처리
            $('#editProductForm').on('submit', function(e) {
                e.preventDefault(); // 기본 제출 이벤트 방지
                var formData = new FormData();

                var colorTagsContainer = document.getElementById('colorTags');
                var sizeTagsContainer = document.getElementById('sizeTags');

                // 수정폼에서 새로 추가된(교체된) 이미지 파일만 추가
                ['main_image', 'sub_image1', 'sub_image2', 'sub_image3', 'sub_image4', 'sub_image5']
                    .forEach(function(id) {
                        var input = document.getElementById(id);
                        if (input.files[0]) {
                            formData.append(id, input.files[0]); // 파일이 있으면 추가
                        }
                    });

                // 색상 태그들을 문자열로 변환
                var colorTags = Array.from(colorTagsContainer.children).map(function(tag) {
                    return tag.textContent.slice(0, -1); // 'x' 제거
                });
                var editColorTag = colorTags.join(',');

                // 사이즈 태그들을 문자열로 변환
                var sizeTags = Array.from(sizeTagsContainer.children).map(function(tag) {
                    return tag.textContent.slice(0, -1); // 'x' 제거
                });
                var editSizeTags = sizeTags.join(',');

                // FormData에 텍스트 데이터 추가
                formData.append('productId', $('#editProductId').val());
                formData.append('mainCategory', $('#editMainCategory').val());
                formData.append('subCategory', $('#editSubCategory').val());
                formData.append('product_name', $('#editProductName').val());
                formData.append('product_description', $('#editProductDescription').val());
                formData.append('stock', $('#editStockInput').val());
                formData.append('price', $('#editPriceInput').val());
                formData.append('sale_status', $('#editSaleStatus').val());
                formData.append('colors', editColorTag);  // 색상 태그 문자열
                formData.append('sizes', editSizeTags);  // 사이즈 태그 문자열

                // 수정 데이터를 서버로 전송
                $.ajax({
                    url: 'updateProductAction.jsp', // 수정 처리할 서버의 주소
                    type: 'POST',
                    data: formData,
                    processData: false,  // 데이터를 쿼리 스트링으로 변환하지 않도록 함
                    contentType: false,  // 컨텐츠 타입 헤더를 multipart/form-data로 설정
                    success: function(product) {
                        console.log({product});
                        // 수정상품의 카테고리,상품명,가격,재고량,판매상태,메인이미지만 변경
                        updateProductRow(product);
                        $('#editProductModal').modal('hide'); // 모달 숨기기
                    }
                });
            });

            //상품 상세정보 모달
            $(document).on('click', '.view-button', function() {
                var productId = $(this).data('num');
                console.log({productId});
                $.ajax({
                    url: 'getProductDetails.jsp',
                    type: 'GET',
                    data: { productId: productId },
                    success: function(product) {
                        console.log({product});
                        var detailsTable = $('#productDetailsTable');
                        detailsTable.empty();
                        var subImagesHtml = '';
                        [product.pro_sub_img1, product.pro_sub_img2, product.pro_sub_img3, product.pro_sub_img4, product.pro_sub_img5].forEach(function(img) {
                            if (img) {
                                subImagesHtml += '<img src="' + img + '" alt="서브 이미지" class="sub-image">';
                            }
                        });


                        detailsTable.append(
                            '<tr><td><strong>카테고리</strong></td><td>' + product.parent_cate_num + ' > ' + product.cate_num + '</td></tr>' +
                            '<tr><td><strong>상품명</strong></td><td>' + product.pro_name + '</td></tr>' +
                            '<tr><td><strong>상품 설명</strong></td><td class="product-description">' + product.pro_explain + '</td></tr>' +
                            '<tr><td><strong>가격</strong></td><td>' + product.pro_price + '원</td></tr>' +
                            '<tr><td><strong>재고</strong></td><td>' + product.pro_stock + '</td></tr>' +
                            '<tr><td><strong>판매상태</strong></td><td>' + product.pro_sale_status + '</td></tr>' +
                            '<tr><td><strong>메인 이미지</strong></td><td><img src="' + product.pro_main_img + '" alt="메인 이미지" class="main-image"></td></tr>' +
                            '<tr><td><strong>서브 이미지</strong></td><td>' + subImagesHtml + '</td></tr>' +
                            '<tr><td><strong>등록일</strong></td><td>' + product.pro_create_date + '</td></tr>' +
                            '<tr><td><strong>판매량</strong></td><td>' + product.pro_sale_volume + '개</td></tr>' +
                            '<tr><td><strong>사이즈</strong></td><td>' + product.pro_size + '</td></tr>' +
                            '<tr><td><strong>색상</strong></td><td>' + product.pro_color + '</td></tr>' +
                            '<tr><td><strong>찜 개수</strong></td><td>' + product.pro_wishlist_count + '개</td></tr>' +
                            '<tr><td><strong>리뷰 개수</strong></td><td>' + product.pro_review_count + '개</td></tr>'
                        );
                        $('#productDetailsModal').modal('show');
                    }
                });
            });


            function updateTags() {
                $('#filter-tags').empty();
                $('input[type="checkbox"]:checked').each(function() {
                    var label = $('label[for="' + $(this).attr('id') + '"]').text();
                    var categoryLabel = $(this).closest('.form-group').find('label').first();
                    var categoryId = categoryLabel.attr('id');
                    var tagClass = categoryId + "-tag";
                    var tagID = $(this).attr('id') + "-tag";

                    var tag = $('<span class="filter-tag ' + tagClass + '" id='+tagID+'>' + label + '<button class="remove-tag" data-target-id="' + $(this).attr('id') + '">&times;</button></span>');
                    $('#filter-tags').append(tag);
                });

                // 태그 제거 버튼 이벤트 핸들러
                $('.remove-tag').click(function() {
                    var targetId = $(this).data('target-id');
                    $('#' + targetId).prop('checked', false).change(); // 체크박스의 선택 해제 및 이벤트 트리거
                });
            }

            //초기 실행
            getProducts();

        });

        // 상위 카테고리가 변경될 때 호출될 함수
        function updateSubCategories() {
            var mainCategory = document.getElementById("editMainCategory").value;
            var subCategory = document.getElementById("editSubCategory");
            subCategory.options.length = 0; // 하위 옵션 초기화

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

        document.addEventListener('DOMContentLoaded', function() {

            var editProductForm = document.getElementById('editProductForm');
            var colorTagsContainer = document.getElementById('colorTags');
            var sizeTagsContainer = document.getElementById('sizeTags');
            var colorsTagInput = document.getElementById('colors');
            var sizesTagInput = document.getElementById('sizes');

            // 색상 추가 함수
            document.getElementById('addColor').addEventListener('click', function() {
                var editColorInput = document.getElementById('editColorInput');
                if (editColorInput.value.trim() !== '') {
                    var tag = createTag(editColorInput.value, colorTagsContainer);
                    editColorInput.value = ''; // 입력 필드 초기화
                }
            });

            // 사이즈 추가 함수
            document.getElementById('addSize').addEventListener('click', function() {
                var editSizeInput = document.getElementById('editSizeInput');
                if (editSizeInput.value.trim() !== '') {
                    var tag = createTag(editSizeInput.value, sizeTagsContainer);
                    editSizeInput.value = ''; // 입력 필드 초기화
                }
            });

            // 태그 생성 함수
            function createTag(text, container) {
                var tag = document.createElement('div');
                tag.textContent = text;
                tag.style.display = 'inline-flex';
                tag.style.margin = '5px';
                tag.style.padding = '4px 8px 4px 15px';
                tag.style.border = '0px solid #ddd';
                tag.style.borderRadius = '20px';
                tag.style.alignItems = 'center';
                tag.style.fontStyle = '10px';
                tag.style.color = '#1F1F1F';
                tag.style.backgroundColor = '#EBEBEB';

                var closeBtn = document.createElement('span');
                closeBtn.innerHTML = '&times;';
                closeBtn.style.marginLeft = '9px';
                closeBtn.style.cursor = 'pointer';

                closeBtn.style.display = 'inline-flex';
                closeBtn.style.alignItems = 'center';
                closeBtn.style.justifyContent = 'center';
                closeBtn.style.width = '17px';
                closeBtn.style.height = '17px';
                closeBtn.style.backgroundColor = '#6A6A6A';
                closeBtn.style.color = '#F1F1F1';
                closeBtn.style.fontSize = '11px';
                closeBtn.style.borderRadius = '50%';
                closeBtn.style.border = 'none';
                closeBtn.onclick = function() {
                    tag.remove();
                };

                tag.appendChild(closeBtn);
                container.appendChild(tag);
            }
            // 색상 입력 필드에 keypress 이벤트 리스너 추가(엔터 입력시 태그 추가)
            document.getElementById('editColorInput').addEventListener('keypress', function(event) {
                if (event.keyCode === 13) {
                    event.preventDefault(); // 폼 제출을 방지
                    document.getElementById('addColor').click(); // '색상 추가' 버튼 클릭 이벤트 발생
                }
            });

            document.getElementById('editSizeInput').addEventListener('keypress', function(event) {
                if (event.keyCode === 13) {
                    event.preventDefault(); // 폼 제출을 방지
                    document.getElementById('addSize').click(); // '사이즈 추가' 버튼 클릭 이벤트 발생
                }
            });


            // 가격 입력 필드에 대한 이벤트 리스너 추가
            document.getElementById('editPriceInput').addEventListener('input', function() {
                var inputVal = this.value;

                // 원화 포맷으로 변환
                var formattedPrice = formatPriceToKRW(inputVal);

                // 결과 표시
                document.getElementById('priceDisplay').innerText = formattedPrice;
            });

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

        // 수정폼 불러올때 색상,사이즈 태그처리 함수
        function addTag(text, container,bgColor,color,xbgColor,xcolor) {
            var tag = document.createElement('div');
            tag.textContent = text;
            tag.className = 'tag';
            tag.style.display = 'inline-flex';
            tag.style.margin = '2px';
            tag.style.padding = '4px 8px 4px 15px';
            tag.style.border = '0px solid #ddd';
            tag.style.borderRadius = '20px';
            tag.style.alignItems = 'center';
            tag.style.fontStyle = '10px';
            tag.style.color = color;
            tag.style.backgroundColor = bgColor;

            var closeBtn = document.createElement('span');
            closeBtn.innerHTML = '&times;';
            closeBtn.style.marginLeft = '9px';
            closeBtn.style.cursor = 'pointer';

            closeBtn.style.display = 'inline-flex';
            closeBtn.style.alignItems = 'center';
            closeBtn.style.justifyContent = 'center';
            closeBtn.style.width = '17px';
            closeBtn.style.height = '17px';
            closeBtn.style.backgroundColor = xbgColor;
            closeBtn.style.color = xcolor;
            closeBtn.style.fontSize = '11px';
            closeBtn.style.borderRadius = '50%';
            closeBtn.style.border = 'none';

            closeBtn.onclick = function() {
                tag.remove();
            };

            tag.appendChild(closeBtn);
            container.append(tag);
        }

        //수정 상품데이터 update
        function updateProductRow(product) {
            // 행 찾기
            var row = $('#productTable').find('tr[data-product-id="' + product.pro_num + '"]');

            // 각 필드 업데이트
            row.find('.product-name').text(product.pro_name);
            row.find('.product-price').text(product.pro_price + '원');
            row.find('.product-stock').text(product.pro_stock);
            row.find('.product-status').text(product.pro_sale_status);
            row.find('.product-image img').attr('src', product.pro_main_img);
            row.find('.product-category').text(product.parent_cate_num + ' > ' + product.cate_num);
        }
        function setDates(range) {
            const startDate = document.getElementById('startDate');
            const endDate = document.getElementById('endDate');
            const today = new Date();
            const tomorrow = new Date(today.getFullYear(), today.getMonth(), today.getDate() + 1);

            if (range === 'today') {
                startDate.value = formatDate(today);
                endDate.value = formatDate(tomorrow);
            } else if (range === 'week') {
                const oneWeekAgo = new Date(today.getFullYear(), today.getMonth(), today.getDate() - 7);
                startDate.value = formatDate(oneWeekAgo);
                endDate.value = formatDate(tomorrow);
            } else if (range === 'month') {
                const oneMonthAgo = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
                startDate.value = formatDate(oneMonthAgo);
                endDate.value = formatDate(tomorrow);
            } else if (range === 'threeMonth') {
                const threeMonthAgo = new Date(today.getFullYear(), today.getMonth() - 3, today.getDate());
                startDate.value = formatDate(threeMonthAgo);
                endDate.value = formatDate(tomorrow);
            }
        }

        function formatDate(date) {
            const d = new Date(date);
            let month = '' + (d.getMonth() + 1),
                day = '' + d.getDate(),
                year = d.getFullYear();

            if (month.length < 2)
                month = '0' + month;
            if (day.length < 2)
                day = '0' + day;

            return [year, month, day].join('-');
        }
        function updateSaleStatus() {
            var selectedStatus = document.getElementById('statusChangeSelect').value;
            var selectedProducts = [];

            document.querySelectorAll('.delete-checkbox:checked').forEach(function(checkbox) {
                selectedProducts.push(checkbox.getAttribute('data-num'));
            });
            console.log({selectedStatus,selectedProducts});

            if (selectedProducts.length > 0) {
                console.log({selectedStatus,selectedProducts});
                $.ajax({
                    url: 'updateSaleStates.jsp',
                    type: 'GET',
                    data: { selectedProducts: selectedProducts,selectedStatus:selectedStatus },
                    dataType: 'json',
                    traditional:true,
                    success: function(product) {
                        console.log({product});
                        if (product.is_update) {
                            // 반복문을 사용하여 모든 선택된 주문에 대해 상태 업데이트
                            selectedProducts.forEach(function(proNum) {
                                // data-order-id 속성을 사용하여 특정 주문의 테이블 행을 찾음
                                var productRow = $('tr[data-product-id="' + proNum + '"]');
                                // 테이블 행 내의 주문상태 셀을 찾아 상태를 업데이트
                                productRow.find('td').eq(6).text(product.sale_satus);
                            });
                            alert('판매 상태가 업데이트 되었습니다.');
                        } else {
                            alert('판매 상태 업데이트에 실패했습니다.');
                        }

                    }
                });
            } else {
                alert('선택된 항목이 없습니다.');
            }
        }



    </script>

</head>



<body>
<jsp:include page="sidebar.jsp"/>
<div class="content">
    <!-- 수정 양식 모달 -->
    <div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editProductModalLabel">상품 수정</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" style="background-color: white; border-style: none;">
                        <span aria-hidden="true" style="font-size: 19px">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="editProductForm" action="">
                        <input type="hidden" id="editProductId" name="productId">
                        <!--상위 카테고리 -->
                        <div class="form-group">
                            <label for="editMainCategory">상위 카테고리:</label>
                            <select name="editMainCategory" id="editMainCategory" onchange="updateSubCategories()">
                                <option value="1">거실</option>
                                <option value="2">주방</option>
                                <option value="3">침실</option>
                                <option value="4">조명</option>
                                <option value="5">기타</option>
                            </select>
                        </div>

                        <!--하위 카테고리 -->
                        <div class="form-group">
                            <label for="editSubCategory">하위 카테고리:</label>
                            <select name="editSubCategory" id="editSubCategory" >
                                <option value="11">소파</option>
                                <option value="12">테이블</option>
                            </select>
                        </div>

                        <!--판매 상태-->
                        <div class="form-group">
                            <label for="editSaleStatus">판매 상태:</label>
                            <select name="editSaleStatus" id="editSaleStatus">
                                <option value="on_sale">판매중</option>
                                <option value="out_of_stock">품절</option>
                                <option value="discontinued">단종</option>
                            </select>
                        </div>

                        <!--상품명 -->
                        <div class="form-group">
                            <label for="editProductName">상품명:</label>
                            <input type="text" class="form-control" id="editProductName" name="editProductName" required>
                        </div>

                        <!--상품 설명 -->
                        <div class="form-group">
                            <label for="editProductDescription">상품 설명:</label>
                            <textarea name="product_description" class="form-control" id="editProductDescription" name="editProductDescription" rows="4" cols="50"></textarea>
                        </div>

                        <!--색상 옵션 -->
                        <div class="form-group">
                            <label for="editColorInput">색상 옵션:</label>
                            <input type="text" class="form-control" id="editColorInput" name="editColor" placeholder="추가할 색상 입력 후 엔터" >
                            <button type="button" id="addColor" style="display: none">색상 추가</button>
                            <!-- 사이즈 태그를 표시할 컨테이너 -->
                            <div id="colorTags"></div>
                        </div>

                        <!--사이즈 옵션 -->
                        <div class="form-group">
                            <label for="editSizeInput">사이즈 옵션:</label>
                            <input type="text" class="form-control" id="editSizeInput" name="editSize" placeholder="추가할 사이즈 입력 후 엔터" >
                            <button type="button" id="addSize" style="display: none">사이즈 추가</button>
                            <!-- 사이즈 태그를 표시할 컨테이너 -->
                            <div id="sizeTags"></div>
                        </div>

                        <!--재고  -->
                        <div class="form-group">
                            <label for="editStockInput">재고:</label>
                            <input type="number" class="form-control" id="editStockInput" name="editStock" min="0" required>
                        </div>

                        <!--가격  -->
                        <div class="form-group">
                            <label for="editPriceInput">가격:</label>
                            <input type="number" class="form-control" id="editPriceInput" name="editPrice" min="0" required>
                            <span id="priceDisplay"></span>
                        </div>

                        <div class="form-group imageIconContainer">
                            <div class="imageIconRow">
                                <div id="icon1" class="imageIcon" onclick="previewImage('main_image', 'icon1')" style="background-image: url('../image/staticImage/icon_mainimage.png');"></div>
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
                        <div class="form-group" style="text-align: right; padding-top: 10px;">
                            <button type="button" class="btn btn-light btn-cancel" data-bs-dismiss="modal">취소</button>
                            <button type="submit" class="btn btn-dark">저장하기</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>


    <div class="header">상품목록</div>
    <form action="" method="get" class="search-form">
        <div class="form-group">
            <label id="salestatus">판매상태:</label>
            <input type="checkbox" id="selling" name="salesStatus" value="판매중"><label for="selling" class="categoryName">판매중</label>
            <input type="checkbox" id="soldout" name="salesStatus" value="품절"><label for="soldout" class="categoryName">품절</label>
            <input type="checkbox" id="discontinued" name="salesStatus" value="단종"><label for="discontinued" class="categoryName">단종</label>
        </div>
        <div class="form-group">
            <label id="maincategory">상위 카테고리:</label>
            <input type="checkbox" id="livingroom" name="mainCategory" value="거실"><label for="livingroom" class="categoryName">거실</label>
            <input type="checkbox" id="kitchen" name="mainCategory" value="주방"><label for="kitchen" class="categoryName">주방</label>
            <input type="checkbox" id="bedroom" name="mainCategory" value="침실"><label for="bedroom" class="categoryName">침실</label>
            <input type="checkbox" id="lighting" name="mainCategory" value="조명"><label for="lighting" class="categoryName">램프</label>
            <input type="checkbox" id="others" name="mainCategory" value="기타"><label for="others" class="categoryName">기타</label>
        </div>
        <div class="form-group">
            <label id="subcategory">하위 카테고리:</label>
            <input type="checkbox" id="sofa" name="subCategory" value="소파"><label for="sofa" class="categoryName">소파</label>
            <input type="checkbox" id="table" name="subCategory" value="테이블"><label for="table" class="categoryName">테이블</label>
            <input type="checkbox" id="diningtable" name="subCategory" value="식탁"><label for="diningtable" class="categoryName">식탁</label>
            <input type="checkbox" id="chair" name="subCategory" value="의자"><label for="chair" class="categoryName">의자</label>
            <input type="checkbox" id="bed" name="subCategory" value="침대"><label for="bed" class="categoryName">침대</label>
            <input type="checkbox" id="closet" name="subCategory" value="옷장"><label for="closet" class="categoryName">옷장</label>
            <input type="checkbox" id="longstand" name="subCategory" value="장스탠드"><label for="longstand" class="categoryName">장스탠드</label>
            <input type="checkbox" id="shortstand" name="subCategory" value="단스탠드"><label for="shortstand" class="categoryName">단스탠드</label>
        </div>
        <div class="form-group">
            <label>등록일:</label>
            <input class="dateInput" type="date" name="startDate" id="startDate" placeholder="hihi">  ~
            <input class="dateInput"type="date" name="endDate" id="endDate" value="<%= java.time.LocalDate.now().plusDays(1).toString() %>">
            <button type="button" class="btn-date" onclick="setDates('today')" style="margin-left: 4px">당일</button><button type="button" class="btn-date" onclick="setDates('week')">1주일</button><button type="button" class="btn-date" onclick="setDates('month')">1개월</button><button type="button" class="btn-date" onclick="setDates('threeMonth')">3개월</button>



        </div>
        <div class="form-group">
            <label>상품명:</label>
            <div class="input_component"><input type="text" id="searchText" name="productName" placeholder="검색어 입력" style="width: 200px;"></div><button type="submit" id="btnSubmit">검색</button>
        </div>
        <div class="form-group">
            <div id="filter-tags"></div>
        </div>
    </form>
    <div><h6 id="result-count">총 <%=list.size()%>개</h6></div>
    <table class="table table-hover" id="productTable" style="width: 1500px" >
        <thead>
        <tr style="background-color: #e6f7ff">
            <th style="background-color: #e6f7ff"><input type="checkbox" id="selectAll"/></th>
            <th style="background-color: #e6f7ff">상품번호</th>
            <th style="background-color: #e6f7ff">카테고리</th>
            <th style="background-color: #e6f7ff">상품명</th>
            <th style="background-color: #e6f7ff">가격</th>
            <th style="background-color: #e6f7ff">재고</th>
            <th style="background-color: #e6f7ff">판매상태</th>
            <th style="background-color: #e6f7ff">대표 이미지</th>
            <th style="background-color: #e6f7ff">등록일시</th>
            <th style="background-color: #e6f7ff">판매량</th>
            <th style="background-color: #e6f7ff">관리</th>
        </tr>
        </thead>
        <tbody>
        <%--테이블 값이 채워질 공간--%>
        </tbody>
    </table>
    <div class="batch-action-container">
        <label for="statusChangeSelect" style="font-size: 18px;">선택한 항목 </label>
        <select id="statusChangeSelect" class="status_select_control" style="border: 1px solid">
            <option value="on_sale">판매중</option>
            <option value="out_of_stock">품절</option>
            <option value="discontinued">단종</option>
        </select>
        <button type="button" onclick="updateSaleStatus()" class="btn btn-primary" id="btnStatus">판매상태 변경</button>
    </div>

    <nav aria-label="Page navigation example">
        <ul class="pagination justify-content-center">
            <!-- 페이징 공간 -->
        </ul>
    </nav>

    <%--상품 상세정보 모달창--%>
    <div class="modal fade" id="productDetailsModal" tabindex="-1" aria-labelledby="productDetailsModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered-view" style="max-width: 60%;">
            <div class="modal-content detail-view">
                <div class="modal-header">
                    <h5 class="modal-title" id="productDetailsModalLabel">상품 상세정보</h5>
                    <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" style="background-color: white; border-style: none;">
                        <span aria-hidden="true" style="font-size: 19px">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <table class="table table-bordered">
                        <tbody id="productDetailsTable">
                        <%--상품 정보 공간--%>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-dark" data-bs-dismiss="modal" style="padding: 6px 26px">닫기</button>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>

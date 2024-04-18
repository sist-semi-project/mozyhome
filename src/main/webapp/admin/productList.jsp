<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="data.dao.ProductDao" %>
<%@ page import="data.dto.ProductDto" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %><%--
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
    <title>Product List for Admin</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            padding: 20px;
            background-color: #f5f5f5;
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
            padding: 8px;
            border-bottom: 1px solid #ddd;
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
        }
        .form-group {
            margin-bottom: 10px;
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

    </style>
    <%
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
                    var row = '<tr>' +
                        '<td><input type="checkbox" class="delete-checkbox" data-num="' + product.pro_num + '"/></td>' +
                        '<td>' + product.pro_num + '</td>' +
                        '<td>' + product.parent_cate_num + ' > ' + product.cate_num + '</td>' +
                        '<td>' + product.pro_name + '</td>' +
                        '<td>' + product.pro_price + '원</td>' +
                        '<td>' + product.pro_stock + '</td>' +
                        '<td>' + product.pro_sale_status + '</td>' +
                        '<td><img src="' + product.pro_main_img + '" alt="대표이미지" style="width: 100px;"></td>' +
                        '<td>' + product.pro_create_date + '</td>' +
                        '<td>' + product.pro_sale_volume + '</td>' +
                        '<td>' +
                        '<button data-num="'+product.pro_num + '" class="edit-button icon-button"><i class="fa-regular fa-pen-to-square" style="color: #001eff;"></i></button>' +
                        '<button data-num="'+product.pro_num + '" class="delete-button icon-button"><i class="fa-solid fa-trash-can" style="color: #ab1726;"></i></button>' +
                        '</td>' +
                        '</tr>';
                    tableBody.append(row);
                    $('#result-count').text('총 ' + data.result_count + '개');
                });
            }


            function updateTable(data) {
                let tableBody = $('#productTable tbody');
                let result = $('#result-count');
                tableBody.empty(); // 기존 테이블 내용 삭제
                $.each(data.products, function(i, product) {
                    var row = '<tr>' +
                        '<td><input type="checkbox" class="delete-checkbox" data-num="' + product.pro_num + '"/></td>' +
                        '<td>' + product.pro_num + '</td>' +
                        '<td>' + product.parent_cate_num + ' > ' + product.cate_num + '</td>' +
                        '<td>' + product.pro_name + '</td>' +
                        '<td>' + product.pro_price + '원</td>' +
                        '<td>' + product.pro_stock + '</td>' +
                        '<td>' + product.pro_sale_status + '</td>' +
                        '<td><img src="' + product.pro_main_img + '" alt="대표이미지" style="width: 100px;"></td>' +
                        '<td>' + product.pro_create_date + '</td>' +
                        '<td>' + product.pro_sale_volume + '</td>' +
                        '<td>' +
                        '<button data-num="'+product.pro_num + '" class="edit-button icon-button"><i class="fa-regular fa-pen-to-square" style="color: #001eff;"></i></button>' +
                        '<button data-num="'+product.pro_num + '" class="delete-button icon-button"><i class="fa-solid fa-trash-can" style="color: #ab1726;"></i></button>' +
                        '</td>' +
                        '</tr>';

                    tableBody.append(row);
                    $('#result-count').text('총 ' + data.result_count + '개');
                });
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
                    pagination.prepend('<li class="page-item"><a class="page-link filtered-page-link" href="#" data-filterpage="' + (startPage - 5) + '">&#8249;</a></li>');
                }

                if (endPage < totalPages) {
                    pagination.append('<li class="page-item"><a class="page-link filtered-page-link" href="#" data-filterpage="' + (endPage + 1) + '">&#8250;</a></li>');
                }
            }

            // 폼 서브밋 이벤트 핸들러
            $('.search-form').on('submit', function(e) {
                e.preventDefault(); // 폼 기본 제출 방지
                fetchProducts();
            });

/*            // 페이지 네비게이션 핸들러
            $('.pagination').on('click', 'a', function(e) {
                e.preventDefault();
                var pageNum = $(this).attr('data-page');
                fetchProducts(pageNum);
            });*/
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
                        url:"./deleteProduct.jsp",
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

            //초기 실행
            getProducts();

        });

    </script>

</head>
<body>
<div class="header">상품목록</div>
<form action="" method="get" class="search-form">
    <div class="form-group">
        <label>판매상태:</label>
        <input type="checkbox" name="salesStatus" value="판매중"><span class="categoryName">판매중</span>
        <input type="checkbox" name="salesStatus" value="품절"><span class="categoryName">품절</span>
        <input type="checkbox" name="salesStatus" value="단종"><span class="categoryName">단종</span>
    </div>
    <div class="form-group">
        <label>상위 카테고리:</label>
        <input type="checkbox" name="mainCategory" value="거실"><span class="categoryName">거실</span>
        <input type="checkbox" name="mainCategory" value="주방"><span class="categoryName">주방</span>
        <input type="checkbox" name="mainCategory" value="침실"><span class="categoryName">침실</span>
        <input type="checkbox" name="mainCategory" value="조명"><span class="categoryName">램프</span>
        <input type="checkbox" name="mainCategory" value="기타"><span class="categoryName">기타</span>
    </div>
    <div class="form-group">
        <label>하위 카테고리:</label>
        <input type="checkbox" name="subCategory" value="소파"><span class="categoryName">소파</span>
        <input type="checkbox" name="subCategory" value="테이블"><span class="categoryName">테이블</span>
        <input type="checkbox" name="subCategory" value="식탁"><span class="categoryName">식탁</span>
        <input type="checkbox" name="subCategory" value="의자"><span class="categoryName">의자</span>
        <input type="checkbox" name="subCategory" value="침대"><span class="categoryName">침대</span>
        <input type="checkbox" name="subCategory" value="옷장"><span class="categoryName">옷장</span>
        <input type="checkbox" name="subCategory" value="장스탠드"><span class="categoryName">장스탠드</span>
        <input type="checkbox" name="subCategory" value="단스탠드"><span class="categoryName">단스탠드</span>

    </div>
    <div class="form-group">
        <label>등록일:</label>
        <input type="date" name="startDate">  ~
        <input type="date" name="endDate">
    </div>
    <div class="form-group">
        <label>상품명:</label>
        <input type="text" name="productName">
        <button type="submit">검색</button>
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
        <th style="background-color: #e6f7ff">재고량</th>
        <th style="background-color: #e6f7ff">판매상태</th>
        <th style="background-color: #e6f7ff">대표 이미지</th>
        <th style="background-color: #e6f7ff">등록일시</th>
        <th style="background-color: #e6f7ff">판매량</th>
        <th style="background-color: #e6f7ff">관리</th>
    </tr>
    </thead>
    <tbody>
<%--    <%
        for (int i = 0; i < list.size(); i++) {
    %>
    <tr>
        <td><input type="checkbox" class="delete-checkbox" data-num="<%=list.get(i).getPro_num()%>"/></td>
        <td><%=list.get(i).getPro_num()%></td>
        <td><%=dao.getCategoryName(list.get(i).getParent_cate_num())%> > <%=dao.getCategoryName(list.get(i).getCate_num())%></td>
        <td><%=list.get(i).getPro_name()%></td>
        <td><%=format.format(list.get(i).getPro_price())%>원</td>
        <td><%=list.get(i).getPro_stock()%></td>
        <td><%=list.get(i).getPro_sale_status()%></td>
        <td><img src="<%=list.get(i).getPro_main_img()%>" alt="대표이미지" style="width: 100px;"></td>
        <td><%=sdf.format(list.get(i).getPro_create_date())%></td>
        <td><%=list.get(i).getPro_sale_volume()%></td>
        <td>
            <button onclick="location.href='editProduct.jsp?productId=<%=list.get(i).getPro_num()%>'"><i class="bi bi-trash"></i></button>

        </td>
    </tr>
    <%}%>--%>
    </tbody>
</table>

<nav aria-label="Page navigation example">
    <ul class="pagination justify-content-center">
        <!-- 페이지 번호가 동적으로 삽입됩니다 -->
    </ul>
</nav>


</body>
</html>

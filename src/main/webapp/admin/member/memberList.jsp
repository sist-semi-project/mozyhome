<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="data.dao.MemberDao" %>
<%@ page import="data.dto.MemberDto" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Dongle&family=Gaegu&family=Nanum+Pen+Script&family=Noto+Sans+KR:wght@100..900&family=Noto+Serif+KR&display=swap"
          rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <title>Member List for Admin</title>
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
        .input_component {
            display: inline-block;
            position: relative;
            height: 34px;
            box-sizing: border-box;
            border: solid 1px;
            border-color: black;
        }
        .select_component {
            display: inline-block;
            position: relative;
            height: 34px;
            box-sizing: border-box;
            border: solid 1px;
            border-color: black;
        }
        .select_control{
            display: block;
            width: 100%;
            padding: 3.5px 0px;
            font-size: 15px;
            font-weight: 400;
            line-height: 1.5;
            color: black;
            -moz-appearance: none;
            background-color: white;
            background-clip: padding-box;
            border: 0;
            border-radius: 5px;
            transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
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

        td.address-description {
            white-space: normal;
            vertical-align: top;
        }
        .detail-view{
            width: 41%;
            margin-left: 25%;
            margin-top: 10%;
        }

        /* Specific style for the first column of the table */
        .table-bordered td:first-child {
            background-color: #f4fdfc; /* Light grey background for better readability */
            font-weight: 600;
        }
        .table-bordered td:nth-child(2) {
            text-align: left;
        }

        .btn-detail-view {
            background-color: #4a4a4b;
            color: white;
            border: none;
            padding: 9px 10px;
            font-size: 14px;
            font-weight: bold;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: background-color 0.3s ease;
        }

        .btn-detail-view:hover, .btn-detail-view:focus {
            background-color: #556777;
            cursor: pointer;
        }

        .btn-detail-view:active {
            background-color: #2a5c8a;
            box-shadow: inset 0 2px 4px rgba(0, 0, 0, 0.2);
        }
        .btn-date{
            margin-left: 4px;
            border: none;
            background-color: #5b4e4e;
            height: 33px;
            color: white;
        }
        .member_id{
            font-weight: 700;
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

        MemberDao dao = new MemberDao();
        int memberCount = dao.getMemberCount();
        SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
    %>
    <script>
        $(document).ready(function () {
            var pageSize = 8;  // 페이지당 회원 수
            var totalRecords = <%=memberCount%>;
            const totalPages = Math.ceil(totalRecords / pageSize);

            function getMembers(page = 1) {
                $.ajax({
                    url: 'getAllMembers.jsp',
                    type: 'get',
                    dataType: 'json',
                    traditional: true,
                    data: {
                        page: page,
                        pageSize: pageSize,
                    },
                    success: function (res) {
                        console.log({"res":res, "function":"getMembers()"});
                        updateTable(res);
                        updateDefaultPagination(page, totalPages);
                    }
                });
            }

            function fetchMembers(page = 1) {
                var searchType = $('#searchType').val();
                var searchText = $('#searchText').val();
                console.log({page,searchType,searchText,"status":$('input[name="memberStatus"]:checked').map(function(){ return this.value; }).get()})
                $.ajax({
                    url: 'getFilteredMembers.jsp',
                    type: 'get',
                    dataType: 'json',
                    traditional: true,
                    data: {
                        page: page,
                        memberStatus: $('input[name="memberStatus"]:checked').map(function(){ return this.value; }).get(),
                        searchType: searchType,
                        searchText: searchText,
                        startDate: $('input[name="startDate"]').val(),
                        endDate: $('input[name="endDate"]').val()
                    },
                    success: function (res) {
                        console.log({"res":res, "function":"fetchMembers()"});
                        updateTable(res);
                        filteredPagination(page, Math.ceil(res.result_count / pageSize));
                    }
                });
            }

            function updateTable(data) {
                let tableBody = $('#memberTable tbody');
                tableBody.empty();
                $.each(data.members, function(i, member) {
                    var row = '<tr data-member-id="' + member.mem_num + '">' +
                        '<td><input type="checkbox" class="delete-checkbox" data-num="' + member.mem_num + '"/></td>' +
                        '<td>' + member.mem_num + '</td>' +
                        '<td>' + member.mem_name + '</td>' +
                        '<td class="member_id">' + member.mem_id + '</td>' +
                        '<td>' + member.mem_nickname + '</td>' +
                        '<td>' + member.mem_email + '</td>' +
                        '<td>' + member.mem_gender + '</td>' +
                        '<td>' + member.mem_gaipday + '</td>' +
                        '<td>' + (member.mem_is_active ? "가입" : "탈퇴") + '</td>' +
                        '<td>' + member.mem_buyCount + '건</td>' +
                        '<td>' +
                        '<button data-num="' + member.mem_num + '" class="view-button btn-detail-view">상세보기</button>' +
                        '</td>' +
                        '</tr>';
                    tableBody.append(row);
                });
                $('#result-count').text('총 ' + data.result_count + '명');
            }

            function updateDefaultPagination(currentPage, totalPages) {
                var pagination = $('.pagination');
                pagination.empty();

                var pageGroup = Math.ceil(currentPage / 5);
                var startPage = (pageGroup - 1) * 5 + 1;
                var endPage = Math.min(totalPages, pageGroup * 5);

                for (var i = startPage; i <= endPage; i++) {
                    var activeClass = currentPage === i ? 'active' : '';
                    var pageItem = '<li class="page-item ' + activeClass + '"><a class="page-link default-page-link" href="#" data-page="' + i + '">' + i + '</a></li>';
                    pagination.append(pageItem);
                }

                if (startPage > 1) {
                    pagination.prepend('<li class="page-item"><a class="page-link default-page-link" href="#" data-page="' + (startPage - 5) + '">&#10094;</a></li>');
                }

                if (endPage < totalPages) {
                    pagination.append('<li class="page-item"><a class="page-link default-page-link" href="#" data-page="' + (endPage + 1) + '">&#10095;</a></li>');
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
                fetchMembers();
            });
            $('.search-form').on('change','input[type="checkbox"]', function(e) {
                e.preventDefault(); // 폼 기본 제출 방지
                fetchMembers();
            });

            $(document).on('click', '.default-page-link', function(e) {
                e.preventDefault();
                var pageNum = $(this).data('page');
                getMembers(pageNum);
            });

            $(document).on('click', '.filtered-page-link', function(e) {
                e.preventDefault();
                var pageNum = $(this).data('filterpage');
                fetchMembers(pageNum);
            });

            $("#selectAll").click(function () {
                $(".delete-checkbox").prop('checked', this.checked);
            });


            $(document).on('click', '.view-button', function() {
                var memberId = $(this).data('num');
                $.ajax({
                    url: 'getMemberDetail.jsp',
                    type: 'GET',
                    data: { memberId: memberId },
                    dataType: 'json',
                    success: function(member) {
                        var detailsTable = $('#memberDetailsTable');
                        detailsTable.empty(); // Clear previous content
                        detailsTable.append(
                            '<tr><td><strong>이름</strong></td><td>' + member.mem_name + '</td></tr>' +
                            '<tr><td><strong>아이디</strong></td><td>' + member.mem_id + '</td></tr>' +
                            '<tr><td><strong>닉네임</strong></td><td>' + member.mem_nickname + '</td></tr>' +
                            '<tr><td><strong>성별</strong></td><td>' + member.mem_gender + '</td></tr>' +
                            '<tr><td><strong>생일</strong></td><td>' + member.mem_birth + '</td></tr>' +
                            '<tr><td><strong>전화번호</strong></td><td>' + member.mem_hp + '</td></tr>' +
                            '<tr><td><strong>이메일</strong></td><td>' + member.mem_email + '</td></tr>' +
                            '<tr><td><strong>주소</strong></td><td class="address-description">(' + member.mem_zipcode + ') ' + member.mem_address + ' ' + member.mem_address_detail + '</td></tr>' +
                            '<tr><td><strong>구매</strong></td><td>' + member.buy_count + '건</td></tr>' +
                            '<tr><td><strong>리뷰</strong></td><td>' + member.review_count + '건</td></tr>' +
                            '<tr><td><strong>가입일</strong></td><td>' + member.mem_gaipday + '</td></tr>'
                        );
                        $('#viewModal').modal('show');
                    }
                });
            });


            // 초기 실행
            getMembers();
        });

        // 가입일 및 탈퇴일 설정 함수
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
            } else if (range === 'threemonth') {
                const oneMonthAgo = new Date(today.getFullYear(), today.getMonth() - 3, today.getDate());
                startDate.value = formatDate(oneMonthAgo);
                endDate.value = formatDate(tomorrow);
            }
        }

        function formatDate(date) {
            const d = new Date(date);
            let month = '' + (d.getMonth() + 1),
                day = '' + d.getDate(),
                year = d.getFullYear();

            if (month.length < 2) month = '0' + month;
            if (day.length < 2) day = '0' + day;

            return [year, month, day].join('-');
        }
    </script>
</head>
<body>
<jsp:include page="../sidebar.jsp"/>
<div class="content">
<div class="header">회원 목록</div>
<form action="" method="get" class="search-form">
    <div class="form-group">
        <label id="memberstatus">회원 상태:</label>
        <input type="checkbox" id="joined" name="memberStatus" value="Y"><label for="joined" class="categoryName">가입</label>
        <input type="checkbox" id="left" name="memberStatus" value="N"><label for="left" class="categoryName">탈퇴</label>
    </div>
    <div class="form-group">
        <label>가입일:</label>
        <input class="dateInput" type="date" name="startDate" id="startDate"> ~
        <input class="dateInput" type="date" name="endDate" id="endDate" value="<%= LocalDate.now().toString() %>">
        <button type="button" class="btn-date" onclick="setDates('today')" >당일</button><button type="button" class="btn-date" onclick="setDates('week')" >1주일</button><button type="button" class="btn-date" onclick="setDates('month')" >1개월</button><button type="button" class="btn-date" onclick="setDates('threemonth')" >3개월</button>
    </div>
    <div class="form-group">
        <div class="select_component">
        <select id="searchType" class="select_control" style="width: auto; display: inline-block;">
            <option value="id" selected>아이디</option>
            <option value="name">이름</option>
            <option value="nickname">닉네임</option>
            <option value="email">이메일</option>
        </select></div>
        <div class="input_component"><input type="text" id="searchText" name="searchText" placeholder="검색어 입력" style="width: 200px;"></div><button type="submit" id="btnSubmit">검색</button>

    </div>

</form>
<div><h6 id="result-count">총 <%=memberCount%>명</h6></div>
<table class="table table-hover" id="memberTable" style="width: 1500px">
    <thead>
    <tr>
        <th style="background-color: #e6f7ff"><input type="checkbox" id="selectAll"/></th>
        <th style="background-color: #e6f7ff">회원번호</th>
        <th style="background-color: #e6f7ff">이름</th>
        <th style="background-color: #e6f7ff">아이디</th>
        <th style="background-color: #e6f7ff">닉네임</th>
        <th style="background-color: #e6f7ff">이메일</th>
        <th style="background-color: #e6f7ff">성별</th>
        <th style="background-color: #e6f7ff">가입일</th>
        <th style="background-color: #e6f7ff">탈퇴여부</th>
        <th style="background-color: #e6f7ff">구매</th>
        <th style="background-color: #e6f7ff">관리</th>
    </tr>
    </thead>
    <tbody>
    <%--회원정보 ajax--%>
    </tbody>
</table>
<nav aria-label="Page navigation">
    <ul class="pagination justify-content-center">
        <%--페이징 ajax--%>
    </ul>
</nav>

<!-- 상세 정보 모달 -->
<div class="modal fade" id="viewModal" tabindex="-1" aria-labelledby="viewModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered-view">
        <div class="modal-content detail-view">
            <div class="modal-header">
                <h5 class="modal-title" id="viewModalLabel">회원 상세 정보</h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close" style="background-color: white; border-style: none;">
                    <span aria-hidden="true" style="font-size: 19px">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table table-bordered">
                    <tbody id="memberDetailsTable">
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


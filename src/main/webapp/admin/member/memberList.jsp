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
    <script src="https://code.jquery.com/jquery-3.7.0.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <title>Member List for Admin</title>
    <style>
        /* CSS 코드는 상품 목록 페이지와 동일하므로, 필요에 따라 적절히 조정하세요. */
    </style>
    <%
        MemberDao dao = new MemberDao();
        List<MemberDto> list = dao.getAllMembersForAdmin();
        SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
    %>
    <script>
        $(document).ready(function () {
            var pageSize = 10;  // 페이지당 회원 수
            var totalRecords = <%=list.size()%>;
            const totalPages = Math.ceil(totalRecords / pageSize);

            function getMembers(page = 1) {
                $.ajax({
                    url: 'getAllMembers.jsp',
                    type: 'get',
                    dataType: 'json',
                    data: {
                        page: page,
                        pageSize: pageSize,
                    },
                    success: function (res) {
                        updateTable(res);
                        updatePagination(page, totalPages);
                    }
                });
            }

            function fetchMembers(page = 1) {
                var searchType = $('#searchType').val();
                var searchText = $('#searchText').val();
                $.ajax({
                    url: 'getFilteredMembers.jsp',
                    type: 'get',
                    dataType: 'json',
                    data: {
                        page: page,
                        memberStatus: $('input[name="memberStatus"]:checked').map(function(){ return this.value; }).get(),
                        searchType: searchType,
                        searchText: searchText
                    },
                    success: function (res) {
                        updateTable(res);
                        updatePagination(page, Math.ceil(res.result_count / pageSize));
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
                        '<td>' + member.name + '</td>' +
                        '<td>' + member.id + '</td>' +
                        '<td>' + member.nickname + '</td>' +
                        '<td>' + member.birthday + '</td>' +
                        '<td>' + member.email + '</td>' +
                        '<td>' + member.gender + '</td>' +
                        '<td>' + member.join_date + '</td>' +
                        '<td>' + (member.is_deleted ? "탈퇴" : "가입") + '</td>' +
                        '<td>' +
                        '<button data-num="' + member.mem_num + '" class="view-button btn btn-info">보기</button>' +
                        '<button data-num="' + member.mem_num + '" class="edit-button btn btn-primary">수정</button>' +
                        '</td>' +
                        '</tr>';
                    tableBody.append(row);
                });
                $('#result-count').text('총 ' + data.result_count + '명');
            }

            function updatePagination(currentPage, totalPages) {
                var pagination = $('.pagination');
                pagination.empty();
                var pageGroup = Math.ceil(currentPage / 5);
                var startPage = (pageGroup - 1) * 5 + 1;
                var endPage = Math.min(totalPages, pageGroup * 5);

                for (var i = startPage; i <= endPage; i++) {
                    var activeClass = currentPage === i ? 'active' : '';
                    var pageItem = '<li class="page-item ' + activeClass + '"><a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>';
                    pagination.append(pageItem);
                }

                if (startPage > 1) {
                    pagination.prepend('<li class="page-item"><a class="page-link" href="#" data-page="' + (startPage - 5) + '">&#10094;</a></li>');
                }

                if (endPage < totalPages) {
                    pagination.append('<li class="page-item"><a class="page-link" href="#" data-page="' + (endPage + 1) + '">&#10095;</a></li>');
                }
            }

            // 폼 서브밋 이벤트 핸들러
            $('.search-form').on('submit', function(e) {
                e.preventDefault(); // 폼 기본 제출 방지
                fetchMembers();
            });

            $(document).on('click', '.page-link', function(e) {
                e.preventDefault();
                var pageNum = $(this).data('page');
                getMembers(pageNum);
            });

            // 수정 및 보기 모달 열기 이벤트
            $(document).on('click', '.edit-button', function() {
                var memberId = $(this).data('num');
                // AJAX 요청을 통해 회원의 상세 정보를 가져옴
                $.ajax({
                    url: 'getMemberDetails.jsp',
                    type: 'GET',
                    data: { memberId: memberId },
                    dataType: 'json',
                    success: function(member) {
                        $('#editMemberId').val(member.mem_num);
                        $('#editName').val(member.name);
                        $('#editEmail').val(member.email);
                        $('#editModal').modal('show');
                    }
                });
            });

            $(document).on('click', '.view-button', function() {
                var memberId = $(this).data('num');
                // AJAX 요청을 통해 회원의 상세 정보를 가져옴
                $.ajax({
                    url: 'getMemberDetails.jsp',
                    type: 'GET',
                    data: { memberId: memberId },
                    dataType: 'json',
                    success: function(member) {
                        var detailsTable = $('#memberDetailsTable');
                        detailsTable.empty();  // Clear previous entries
                        detailsTable.append(
                            '<tr><td><strong>이름</strong></td><td>' + member.name + '</td></tr>' +
                            '<tr><td><strong>아이디</strong></td><td>' + member.id + '</td></tr>' +
                            '<tr><td><strong>닉네임</strong></td><td>' + member.nickname + '</td></tr>' +
                            '<tr><td><strong>이메일</strong></td><td>' + member.email + '</td></tr>' +
                            '<tr><td><strong>성별</strong></td><td>' + member.gender + '</td></tr>' +
                            '<tr><td><strong>가입일</strong></td><td>' + member.join_date + '</td></tr>' +
                            '<tr><td><strong>생일</strong></td><td>' + member.birthday + '</td></tr>' +
                            '<tr><td><strong>탈퇴 여부</strong></td><td>' + (member.is_deleted ? "예" : "아니오") + '</td></tr>'
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

            if (range === 'today') {
                startDate.value = endDate.value = formatDate(today);
            } else if (range === 'week') {
                const oneWeekAgo = new Date(today.getFullYear(), today.getMonth(), today.getDate() - 7);
                startDate.value = formatDate(oneWeekAgo);
                endDate.value = formatDate(today);
            } else if (range === 'month') {
                const oneMonthAgo = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
                startDate.value = formatDate(oneMonthAgo);
                endDate.value = formatDate(today);
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
<div class="header">회원 목록</div>
<form action="" method="get" class="search-form">
    <div class="form-group">
        <label id="memberstatus">회원 상태:</label>
        <input type="checkbox" id="all" name="memberStatus" value="전체" checked><label for="all" class="categoryName">전체</label>
        <input type="checkbox" id="joined" name="memberStatus" value="가입"><label for="joined" class="categoryName">가입</label>
        <input type="checkbox" id="left" name="memberStatus" value="탈퇴"><label for="left" class="categoryName">탈퇴</label>
    </div>
    <div class="form-group">
        <select id="searchType" class="form-control" style="width: auto; display: inline-block;">
            <option value="id">아이디</option>
            <option value="name">이름</option>
            <option value="nickname">닉네임</option>
            <option value="email">이메일</option>
        </select>
        <input type="text" id="searchText" name="searchText" placeholder="검색어 입력" style="width: 200px;">
        <button type="submit" class="btn btn-primary">검색</button>
    </div>
    <div class="form-group">
        <label>가입일:</label>
        <input class="dateInput" type="date" name="startDate" id="startDate"> ~
        <input class="dateInput" type="date" name="endDate" id="endDate">
        <button type="button" onclick="setDates('today')" class="btn btn-secondary">당일</button>
        <button type="button" onclick="setDates('week')" class="btn btn-secondary">1주일</button>
        <button type="button" onclick="setDates('month')" class="btn btn-secondary">1개월</button>
    </div>
</form>
<div><h6 id="result-count">총 <%=list.size()%>명</h6></div>
<table class="table table-hover" id="memberTable" style="width: 1500px">
    <thead>
    <tr>
        <th><input type="checkbox" id="selectAll"/></th>
        <th>회원번호</th>
        <th>이름</th>
        <th>아이디</th>
        <th>닉네임</th>
        <th>생일</th>
        <th>이메일</th>
        <th>성별</th>
        <th>가입일</th>
        <th>탈퇴여부</th>
        <th>관리</th>
    </tr>
    </thead>
    <tbody>
    <!-- 회원 데이터는 서버에서 동적으로 로딩 -->
    </tbody>
</table>
<nav aria-label="Page navigation">
    <ul class="pagination justify-content-center">
        <!-- 페이지 번호가 동적으로 삽입됩니다 -->
    </ul>
</nav>

<!-- 수정 양식 모달 -->
<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">회원 정보 수정</h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editMemberForm" action="">
                    <input type="hidden" id="editMemberId" name="memberId">
                    <!-- 회원 정보 필드 -->
                    <div class="form-group">
                        <label for="editName">이름:</label>
                        <input type="text" class="form-control" id="editName" name="editName" required>
                    </div>
                    <div class="form-group">
                        <label for="editEmail">이메일:</label>
                        <input type="email" class="form-control" id="editEmail" name="editEmail" required>
                    </div>
                    <div class="form-group" style="text-align: right;">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                        <button type="submit" class="btn btn-primary">저장</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- 상세 정보 모달 -->
<div class="modal fade" id="viewModal" tabindex="-1" aria-labelledby="viewModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="viewModalLabel">회원 상세 정보</h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <table class="table">
                    <tbody id="memberDetailsTable">
                    <!-- 회원 상세 정보는 서버에서 동적으로 로딩 -->
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

</body>
</html>


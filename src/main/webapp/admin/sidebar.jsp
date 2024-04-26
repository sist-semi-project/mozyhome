<style>
    /*sidebar */

    .sidebar {
        background-color: #343a40;
        width: 235px;
        padding: 20px;
        min-height: 100vh;
    }

    .content {
        flex-grow: 1;
        padding: 20px;
        background-color: #f5f5f5;
        width: calc(100vw - 235px);
    }

    .logo {
        width: 150px;
        margin: 20px auto;
        display: block;
    }

    .menu-item a, .submenu a {
        color: #ffffff;
        text-decoration: none;
        padding: 10px 20px;
        display: block;
    }

    .menu-item a:hover, .submenu a:hover {
        background-color: #495057;
    }

    .header {
        font-size: 24px;
        margin-bottom: 20px;
        padding-bottom: 10px;
        border-bottom: 1px solid #ccc;
    }
    .menu-item {
        display: block;
        color: black;
        text-decoration: none;
        border-radius: 5px;
        font-size: 20px;
        border-bottom: 1px solid #495057;
        padding-bottom: 10px;
        margin-bottom: 10px;
    }
    li{
        list-style: none;
    }

    .btn-logout {
        display: block;
        width: calc(100% - 40px);
        margin: 20px;
        background-color: #dc3545;
        color: white;
        border: none;
        padding: 10px 20px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        margin-left: 34px;

    }

    .btn-logout:hover {
        background-color: #c82333;
    }
</style>

<div class="sidebar">
    <img src="/image/staticImage/logo2.png" class="logo" alt="쇼핑몰 로고">
    <ul class="menu">
        <li class="menu-item"><a href="#"  style="font-size: 25px; line-height: 24px;"><i class="fa-solid fa-cart-shopping"  style="margin-right: 5px;"></i>상품<span
                class=""></span></a>
            <ul class="">
                <li><a href="/admin/addProduct.jsp">상품등록</a></li>
                <li><a href="/admin/productList.jsp">상품관리</a></li>
            </ul>
        </li>
        <li class="menu-item"><a href="#"  style="font-size: 25px; line-height: 24px;"><i class="fas fa-users" style="margin-right: 5px;"></i>회원<span
                class=""></span></a>
            <ul class="">
                <li><a href="/admin/member/memberList.jsp">회원관리</a></li>

            </ul></li>
        <li class="menu-item"><a href="#"  style="font-size: 25px; line-height: 24px;"><i class="fas fa-shopping-basket" style="margin-right: 5px;"></i>주문<span
                class=""></span></a>
            <ul class="">
                <li><a href="/admin/order/orderList.jsp">주문관리</a></li>

            </ul></li>
    </ul>

    <button type="button" onclick="location.href='adminLogin.jsp'" class="btn btn-logout"><i class="fa-solid fa-arrow-right-from-bracket" style="color: #ffffff;"></i>     로그아웃</button>

</div>
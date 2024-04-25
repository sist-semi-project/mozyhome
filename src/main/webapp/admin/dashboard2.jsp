<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html lang="en" style="height: auto;"><head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Starter</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&amp;display=fallback">
  <!-- Font Awesome Icons -->
  <link rel="stylesheet" href="plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="dist/css/adminlte.min.css">
  
  <style type="text/css">
  
  .wrapper {
    position: relative;
}

.wrapper, body, html {
    min-height: 100%;
}

*, ::after, ::before {
    box-sizing: border-box;
}

body {
    margin: 0;
    font-family: "Source Sans Pro", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #212529;
    text-align: left;
    background-color: #fff;
}

.navbar-white {
    background-color: #fff;
    color: #1f2d3d;
}

.navbar-light {
    background-color: #f8f9fa;
}

.main-header {
    border-bottom: 1px solid #dee2e6;
    z-index: 1034;
}

.navbar-expand {
    flex-flow: row nowrap;
    justify-content: flex-start;
}

.navbar {
    position: relative;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    justify-content: space-between;
    padding: .5rem .5rem;
}

.navbar-expand .navbar-nav {
    flex-direction: row;
}

.navbar-nav {
    display: flex;
    flex-direction: column;
    padding-left: 0;
    margin-bottom: 0;
    list-style: none;
}

dl, ol, ul {
    margin-top: 0;
    margin-bottom: 1rem;
}

.main-header .navbar-nav .nav-item {
    margin: 0;
}

.navbar-light .navbar-nav .nav-link {
    color: rgba(0, 0, 0, .5);
}

.navbar-expand .navbar-nav .nav-link {
    padding-right: 1rem;
    padding-left: 1rem;
}

.main-header .nav-link {
    height: 2.5rem;
    position: relative;
}

.navbar-nav .nav-link {
    padding-right: 0;
    padding-left: 0;
}

.nav-link {
    display: block;
    padding: .5rem 1rem;
}

[role=button] {
    cursor: pointer;
}

a {
    color: #007bff;
    text-decoration: none;
    background-color: transparent;
}

.fa, .fas {
    font-weight: 900;
}

.fa, .far, .fas {
    font-family: "Font Awesome 5 Free";
}

.fa, .fab, .fad, .fal, .far, .fas {
    -moz-osx-font-smoothing: grayscale;
    -webkit-font-smoothing: antialiased;
    display: inline-block;
    font-style: normal;
    font-variant: normal;
    text-rendering: auto;
    line-height: 1;
}

.fa-bars:before {
    content: "\f0c9";
}

body:not(.layout-fixed) .main-sidebar {
    height: inherit;
    min-height: 100%;
    position: absolute;
    top: 0;
}

.elevation-4 {
    box-shadow: 0 14px 28px rgba(0, 0, 0, .25), 0 10px 10px rgba(0, 0, 0, .22) !important;
}

[class*=sidebar-dark-] {
    background-color: #343a40;
}

.main-sidebar {
    height: 100vh;
    overflow-y: hidden;
    z-index: 1038;
}

.main-sidebar, .main-sidebar::before {
    transition: margin-left .3s ease-in-out, width .3s ease-in-out;
    width: 250px;
}

article, aside, figcaption, figure, footer, header, hgroup, main, nav, section {
    display: block;
}

[class*=sidebar-dark] .brand-link, [class*=sidebar-dark] .brand-link .pushmenu {
    color: rgba(255, 255, 255, .8);
}

[class*=sidebar-dark] .brand-link {
    border-bottom: 1px solid #4b545c;
}

.brand-link {
    display: block;
    font-size: 1.25rem;
    line-height: 1.5;
    padding: .8125rem .5rem;
    transition: width .3s ease-in-out;
    white-space: nowrap;
}

a {
    color: #007bff;
    text-decoration: none;
    background-color: transparent;
}

.brand-link .brand-image {
    float: left;
    line-height: .8;
    margin-left: .8rem;
    margin-right: .5rem;
    margin-top: -3px;
    max-height: 33px;
    width: auto;
}

.elevation-3 {
    box-shadow: 0 10px 20px rgba(0, 0, 0, .19), 0 6px 6px rgba(0, 0, 0, .23) !important;
}

.img-circle {
    border-radius: 50%;
}

img {
    vertical-align: middle;
    border-style: none;
}

.main-sidebar .brand-text, .main-sidebar .logo-xl, .main-sidebar .logo-xs, .sidebar .nav-link p, .sidebar .user-panel .info {
    transition: margin-left .3s linear, opacity .3s ease, visibility .3s ease;
}

.font-weight-light {
    font-weight: 300 !important;
}

body:not(.layout-fixed) .main-sidebar .sidebar {
    overflow-y: auto;
}

.sidebar {
    height: calc(100% -(3.5rem + 1px));
    overflow-x: hidden;
    overflow-y: initial;
    padding-bottom: 0;
    padding-left: .5rem;
    padding-right: .5rem;
    padding-top: 0;
    scrollbar-color: #a9a9a9 transparent;
    scrollbar-width: none;
}

.main-sidebar .brand-text, .main-sidebar .logo-xl, .main-sidebar .logo-xs, .sidebar .nav-link p, .sidebar .user-panel .info {
    transition: margin-left .3s linear, opacity .3s ease, visibility .3s ease;
}

.user-panel .info {
    display: inline-block;
    padding: 5px 5px 5px 10px;
}

.user-panel, .user-panel .info {
    overflow: hidden;
    white-space: nowrap;
}

[class*=sidebar-dark-] .sidebar a {
    color: #c2c7d0;
}

.d-block {
    display: block !important;
}

[class*=sidebar-dark] .user-panel {
    border-bottom: 1px solid #4f5962;
}
.user-panel, .user-panel .info {
    overflow: hidden;
    white-space: nowrap;
}
.user-panel {
    position: relative;
}
.pb-3, .py-3 {
    padding-bottom: 1rem !important;
}
.mb-3, .my-3 {
    margin-bottom: 1rem !important;
}
.mt-3, .my-3 {
    margin-top: 1rem !important;
}
.d-flex {
    display: flex !important;
}

.form-inline {
    display: flex;
    flex-flow: row wrap;
    align-items: center;
}

.sidebar .form-inline .input-group {
    width: 100%;
    flex-wrap: nowrap;
}
@media (min-width: 576px) {
    .form-inline .custom-select, .form-inline .input-group {
        width: auto;
    }
    
        .form-inline .form-control {
        display: inline-block;
        width: auto;
        vertical-align: middle;
    }
}
.input-group {
    position: relative;
    display: flex;
    flex-wrap: wrap;
    align-items: stretch;
    width: 100%;
}

.input-group:not(.has-validation)>.custom-file:not(:last-child) .custom-file-label, .input-group:not(.has-validation)>.custom-file:not(:last-child) .custom-file-label::after, .input-group:not(.has-validation)>.custom-select:not(:last-child), .input-group:not(.has-validation)>.form-control:not(:last-child) {
    border-top-right-radius: 0;
    border-bottom-right-radius: 0;
}

[class*=sidebar-dark] .btn-sidebar, [class*=sidebar-dark] .form-control-sidebar {
    background-color: #3f474e;
    border: 1px solid #56606a;
    color: #fff;
}

.input-group>.custom-file, .input-group>.custom-select, .input-group>.form-control, .input-group>.form-control-plaintext {
    position: relative;
    flex: 1 1 auto;
    width: 1%;
    min-width: 0;
    margin-bottom: 0;
}

.form-control {
    display: block;
    width: 100%;
    height: calc(2.25rem + 2px);
    padding: .375rem .75rem;
    font-size: 1rem;
    font-weight: 400;
    line-height: 1.5;
    color: #495057;
    background-color: #fff;
    background-clip: padding-box;
    border: 1px solid #ced4da;
    border-radius: .25rem;
    box-shadow: inset 0 0 0 transparent;
    transition: border-color .15s ease-in-out, box-shadow .15s ease-in-out;
}

[type=search] {
    outline-offset: -2px;
    -webkit-appearance: none;
}

button, input {
    overflow: visible;
}

button, input, optgroup, select, textarea {
    margin: 0;
    font-family: inherit;
    font-size: inherit;
    line-height: inherit;
}

.input-group-append {
    margin-left: -1px;
}
.input-group-append, .input-group-prepend {
    display: flex;
}

.input-group>.input-group-append>.btn{
    border-top-left-radius: 0;
    border-bottom-left-radius: 0;
}

.btn:not(:disabled):not(.disabled) {
    cursor: pointer;
}
[class*=sidebar-dark] .btn-sidebar, [class*=sidebar-dark] .form-control-sidebar {
    background-color: #3f474e;
    border: 1px solid #56606a;
    color: #fff;
}
.input-group-append .btn, .input-group-prepend .btn {
    position: relative;
    z-index: 2;
}

.sidebar-search-results .list-group {
    position: absolute;
    width: 100%;
    z-index: 1039;
}
.list-group {
    display: -ms-flexbox;
    display: flex;
    -ms-flex-direction: column;
    flex-direction: column;
    padding-left: 0;
    margin-bottom: 0;
    border-radius: .25rem;
}

.sidebar-search-results {
    position: relative;
    display: none;
    width: 100%;
}

.sidebar-search-results .list-group>.list-group-item:first-child {
    margin-top: 0;
    border-top: 0;
    border-top-left-radius: 0;
    border-top-right-radius: 0;
}
.sidebar-search-results .list-group>.list-group-item {
    padding: .375rem .75rem;
}
[class*=sidebar-dark-] .sidebar a {
    color: #c2c7d0;
}
[class*=sidebar-dark] .list-group-item {
    background-color: #454d55;
    border-color: #56606a;
    color: #c2c7d0;
}
.list-group-item:last-child {
    border-bottom-right-radius: inherit;
    border-bottom-left-radius: inherit;
}
.list-group-item:first-child {
    border-top-left-radius: inherit;
    border-top-right-radius: inherit;
}
.list-group-item {
    position: relative;
    display: block;
    padding: .75rem 1.25rem;
    background-color: #fff;
    border: 1px solid rgba(0, 0, 0, .125);
}

.text-light {
    color: #f8f9fa !important;
}
b, strong {
    font-weight: bolder;
}

.sidebar-search-results .search-title {
    margin-bottom: -.1rem;
}
.text-light {
    color: #f8f9fa !important;
}
b, strong {
    font-weight: bolder;
}

.mt-2, .my-2 {
    margin-top: .5rem !important;
}

.nav-sidebar {
    position: relative;
}
.flex-column {
    flex-direction: column !important;
}
.nav {
    display: flex;
    flex-wrap: wrap;
    padding-left: 0;
    margin-bottom: 0;
    list-style: none;
}
dl, ol, ul {
    margin-top: 0;
    margin-bottom: 1rem;
}

.nav-sidebar>.nav-item {
    margin-bottom: 0;
}

.sidebar-dark-primary .nav-sidebar>.nav-item>.nav-link.active, .sidebar-light-primary .nav-sidebar>.nav-item>.nav-link.active {
    background-color: #343a40;
    color: #fff;
}

[class*=sidebar-dark-] .nav-sidebar>.nav-item>.nav-link.active {
    color: #fff;
    box-shadow: 0 1px 3px rgba(0, 0, 0, .12), 0 1px 2px rgba(0, 0, 0, .24);
}

.sidebar-mini .main-sidebar .nav-link, .sidebar-mini-md .main-sidebar .nav-link, .sidebar-mini-xs .main-sidebar .nav-link {
    width: calc(250px - .5rem* 2);
    transition: width ease-in-out .3s;
}

.nav-sidebar .nav-item>.nav-link {
    margin-bottom: .2rem;
}

.nav-pills .nav-link.active, .nav-pills .show>.nav-link {
    color: #fff;
    background-color: #007bff;
}

.nav-sidebar>.nav-item .nav-icon.fa, .nav-sidebar>.nav-item .nav-icon.fab, .nav-sidebar>.nav-item .nav-icon.fad, .nav-sidebar>.nav-item .nav-icon.fal, .nav-sidebar>.nav-item .nav-icon.far, .nav-sidebar>.nav-item .nav-icon.fas, .nav-sidebar>.nav-item .nav-icon.ion, .nav-sidebar>.nav-item .nav-icon.svg-inline--fa {
    font-size: 1.1rem;
}

.nav-sidebar>.nav-item .nav-icon {
    margin-left: .05rem;
    font-size: 1.2rem;
    margin-right: .2rem;
    text-align: center;
    width: 1.6rem;
}

.main-sidebar .brand-text, .main-sidebar .logo-xl, .main-sidebar .logo-xs, .sidebar .nav-link p, .sidebar .user-panel .info {
    transition: margin-left .3s linear, opacity .3s ease, visibility .3s ease;
}

.nav-sidebar .nav-link p {
    display: inline;
    margin: 0;
    white-space: normal;
}

.nav-sidebar .menu-is-opening>.nav-link i.right, .nav-sidebar .menu-is-opening>.nav-link svg.right, .nav-sidebar .menu-open>.nav-link i.right, .nav-sidebar .menu-open>.nav-link svg.right {
    -webkit-transform: rotate(-90deg);
    transform: rotate(-90deg);
}

.nav-sidebar .nav-item>.nav-link .right {
    transition: -webkit-transform ease-in-out .3s;
    transition: transform ease-in-out .3s;
    transition: transform ease-in-out .3s, -webkit-transform ease-in-out .3s;
}
.nav-sidebar .nav-link>.right, .nav-sidebar .nav-link>p>.right {
    position: absolute;
    right: 1rem;
    top: .7rem;
}

.fa-angle-left:before {
    content: "\f104";
}

[class*=sidebar-dark-] .nav-sidebar>.nav-item>.nav-treeview {
    background-color: transparent;
}
.nav-sidebar .menu-open>.nav-treeview {
    display: block;
}
.nav-sidebar .nav-treeview {
    display: none;
    list-style: none;
    padding: 0;
}
.nav {
    display: -ms-flexbox;
    display: flex;
    -ms-flex-wrap: wrap;
    flex-wrap: wrap;
    padding-left: 0;
    margin-bottom: 0;
    list-style: none;
}
ol ol, ol ul, ul ol, ul ul {
    margin-bottom: 0;
}
dl, ol, ul {
    margin-top: 0;
    margin-bottom: 1rem;
}

[class*=sidebar-dark-] .nav-treeview>.nav-item>.nav-link.active, [class*=sidebar-dark-] .nav-treeview>.nav-item>.nav-link.active:focus, [class*=sidebar-dark-] .nav-treeview>.nav-item>.nav-link.active:hover {
    background-color: rgba(255, 255, 255, .9);
    color: #343a40;
}
[class*=sidebar-dark-] .nav-treeview>.nav-item>.nav-link {
    color: #c2c7d0;
}
.nav-sidebar .nav-item>.nav-link {
    position: relative;
}
.sidebar-mini .main-sidebar .nav-link, .sidebar-mini-md .main-sidebar .nav-link, .sidebar-mini-xs .main-sidebar .nav-link {
    width: calc(250px - .5rem* 2);
    transition: width ease-in-out .3s;
}
@media (min-width: 992px) {
    .sidebar-mini .nav-sidebar, .sidebar-mini .nav-sidebar .nav-link, .sidebar-mini .nav-sidebar>.nav-header {
        white-space: nowrap;
    }
}
.nav-sidebar .nav-item>.nav-link {
    margin-bottom: .2rem;
}
.nav-pills .nav-link.active, .nav-pills .show>.nav-link {
    color: #fff;
    background-color: #007bff;
}
[class*=sidebar-dark-] .sidebar a {
    color: #c2c7d0;
}
.nav-pills .nav-link {
    color: #6c757d;
}
.nav-pills .nav-link {
    border-radius: .25rem;
}
.nav-link {
    display: block;
    padding: .5rem 1rem;
}

.nav-sidebar .nav-treeview>.nav-item>.nav-link>.nav-icon {
    width: 1.6rem;
}
.nav-sidebar>.nav-item .nav-icon.fa, .nav-sidebar>.nav-item .nav-icon.fab, .nav-sidebar>.nav-item .nav-icon.fad, .nav-sidebar>.nav-item .nav-icon.fal, .nav-sidebar>.nav-item .nav-icon.far, .nav-sidebar>.nav-item .nav-icon.fas, .nav-sidebar>.nav-item .nav-icon.ion, .nav-sidebar>.nav-item .nav-icon.svg-inline--fa {
    font-size: 1.1rem;
}
.nav-sidebar>.nav-item .nav-icon {
    margin-left: .05rem;
    font-size: 1.2rem;
    margin-right: .2rem;
    text-align: center;
    width: 1.6rem;
}

.fa-circle:before {
    content: "\f111";
}

a {
    color: #007bff;
    text-decoration: none;
    background-color: transparent;
}



@media (min-width: 768px) {
    body:not(.sidebar-mini-md):not(.sidebar-mini-xs):not(.layout-top-nav) .content-wrapper, body:not(.sidebar-mini-md):not(.sidebar-mini-xs):not(.layout-top-nav) .main-footer, body:not(.sidebar-mini-md):not(.sidebar-mini-xs):not(.layout-top-nav) .main-header {
        transition: margin-left .3s ease-in-out;
        margin-left: 250px;
    }
}

@media (min-width: 992px) {
    .sidebar-mini .nav-sidebar, .sidebar-mini .nav-sidebar .nav-link, .sidebar-mini .nav-sidebar>.nav-header {
        white-space: nowrap;
    }
    
    .sidebar-mini .nav-sidebar, .sidebar-mini .nav-sidebar .nav-link, .sidebar-mini .nav-sidebar>.nav-header {
        white-space: nowrap;
}

body:not(.layout-fixed) .main-sidebar .sidebar {
    overflow-y: auto;
}
.sidebar {
    height: calc(100% -(3.5rem + 1px));
    overflow-x: hidden;
    overflow-y: initial;
    padding-bottom: 0;
    padding-left: .5rem;
    padding-right: .5rem;
    padding-top: 0;
    scrollbar-color: #a9a9a9 transparent;
    scrollbar-width: none;
}

.wrapper .content-wrapper {
    min-height: calc(100vh - calc(3.5rem + 1px) - calc(3.5rem + 1px));
}
.content-wrapper {
    height: 100%;
}
.content-wrapper {
    background-color: #f4f6f9;
}

@media (min-width: 768px) {
    body:not(.sidebar-mini-md):not(.sidebar-mini-xs):not(.layout-top-nav) .content-wrapper, body:not(.sidebar-mini-md):not(.sidebar-mini-xs):not(.layout-top-nav) .main-footer, body:not(.sidebar-mini-md):not(.sidebar-mini-xs):not(.layout-top-nav) .main-header {
        transition: margin-left .3s ease-in-out;
        margin-left: 250px;
    }
}
.main-footer {
    background-color: #fff;
    border-top: 1px solid #dee2e6;
    color: #869099;
    padding: 1rem;
}
article, aside, figcaption, figure, footer, header, hgroup, main, nav, section {
    display: block;
}
  
  </style>
  </head>
<body class="sidebar-mini" style="height: auto;">
<div class="wrapper">

  <!-- Navbar -->
  <nav class="main-header navbar navbar-expand navbar-white navbar-light">
    <!-- Left navbar links -->
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
      </li>
      
      
    </ul>

    
    
  </nav>
  

  <!-- Main Sidebar Container -->
  <aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="index3.html" class="brand-link">
      <img src="dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light">AdminLTE 3</span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block">Alexander Pierce</a>
        </div>
      </div>

      
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">

          <li class="nav-item">
            <a href="#" class="nav-link active">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Starter Pages
              </p>
            </a>
          </li>
           <li class="nav-item">
            <a href="#" class="nav-link active">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Starter Pages
              </p>
            </a>
          </li>
           <li class="nav-item">
            <a href="#" class="nav-link active">
              <i class="nav-icon fas fa-tachometer-alt"></i>
              <p>
                Starter Pages
              </p>
            </a>
          </li>
          
          
        </ul>
      </nav>
      
    </div>
    
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper" style="min-height: 529px;">
    <div class="content">
      <div class="container-fluid">
        <div class="row">
          
          <!-- /.col-md-6 -->
          
          <!-- /.col-md-6 -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark" style="display: none;">
    <!-- Control sidebar content goes here -->
    <div class="p-3">
      <h5>Title</h5>
      <p>Sidebar content</p>
    </div>
  </aside>
  <!-- /.control-sidebar -->
  <footer class="main-footer">
    <strong>Copyright © 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong></footer>
<div id="sidebar-overlay"></div></div>




<!-- jQuery -->
<script src="plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="dist/js/adminlte.min.js"></script>


</body></html>
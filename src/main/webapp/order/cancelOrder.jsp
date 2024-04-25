<%@page import="data.dao.ProductDao"%>
<%@page import="data.dto.OrderDetailDto"%>
<%@page import="data.dao.OrderDetailDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="data.dao.OrderDao"%>

<%
    String orderNumber = request.getParameter("orderNumber");
    OrderDao orderDao = new OrderDao();
    boolean success = orderDao.updateOrderStatus(orderNumber, "취소신청");
    OrderDetailDao orderDetailDao = new OrderDetailDao();
    OrderDetailDto orderDetailDto = orderDetailDao.getOrderDetailsByMember(orderNumber);
    String proNum = orderDetailDto.getPro_num();
    int proSu = orderDetailDto.getOrder_detail_su();
    boolean increase = true;
    ProductDao productDao = new ProductDao();
    productDao.updateStockQuantity(proNum, proSu, increase);
%>

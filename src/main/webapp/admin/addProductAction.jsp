<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="data.dto.ProductDto" %>
<%@ page import="data.dao.ProductDao" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-03-28
  Time: 오전 11:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    String saveDirectory = "/productSave"; // 저장 폴더명
    int maxPostSize = 10 * 1024 * 1024; // 최대 10MB

    // 서버에 파일 저장 경로 확인
    String applicationPath = getServletConfig().getServletContext().getRealPath("");
    String uploadFilePath = applicationPath + File.separator + saveDirectory;

    // 디렉토리가 존재하지 않으면 생성
    File fileSaveDir = new File(uploadFilePath);
    if (!fileSaveDir.exists()) {
        fileSaveDir.mkdirs();
    }

    // 파일 업로드 처리
    MultipartRequest multiReq = new MultipartRequest(request, uploadFilePath, maxPostSize,"utf-8",new DefaultFileRenamePolicy());

    // 요청 파라미터 받기
    String mainCategory = multiReq.getParameter("mainCategory");
    String subCategory = multiReq.getParameter("subCategory");
    String productName = multiReq.getParameter("product_name");
    String productDescription = multiReq.getParameter("product_description");
    int stock = Integer.parseInt(multiReq.getParameter("stock"));
    int price = Integer.parseInt(multiReq.getParameter("price"));
    String saleStatus = multiReq.getParameter("sale_status");
    String mainImage = multiReq.getFilesystemName("main_image");
    String sub_image1 = multiReq.getFilesystemName("sub_image1");
    String sub_image2 = multiReq.getFilesystemName("sub_image2");
    String sub_image3 = multiReq.getFilesystemName("sub_image3");
    String sub_image4 = multiReq.getFilesystemName("sub_image4");
    String sub_image5 = multiReq.getFilesystemName("sub_image5");


    ProductDao dao = new ProductDao();
    ProductDto dto = new ProductDto();

    //카테고리,상품명,상품설명,재고수량,가격,판매상태, 메인이미지1,서브이미지1~5
    dto.setCate_num(subCategory);
    dto.setPro_name(productName);
    dto.setPro_explain(productDescription);
    dto.setPro_stock(stock);
    dto.setPro_price(price);
    dto.setPro_sale_status(saleStatus);
    dto.setPro_main_img(mainImage);
    dto.setPro_sub_img1(sub_image1);
    dto.setPro_sub_img2(sub_image2);
    dto.setPro_sub_img3(sub_image3);
    dto.setPro_sub_img4(sub_image4);
    dto.setPro_sub_img5(sub_image5);

    dao.addProduct(dto);

    response.sendRedirect("./addProduct.jsp");

%>
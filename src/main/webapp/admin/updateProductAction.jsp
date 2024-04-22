<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page import="data.dto.ProductDto" %>
<%@ page import="db.AwsConnect" %>
<%@ page import="data.dao.ProductDao" %>
<%@ page import="com.amazonaws.auth.BasicAWSCredentials" %>
<%@ page import="com.amazonaws.auth.AWSStaticCredentialsProvider" %>
<%@ page import="com.amazonaws.services.s3.AmazonS3ClientBuilder" %>
<%@ page import="com.amazonaws.services.s3.AmazonS3" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2024-04-19
  Time: 오전 11:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    NumberFormat format = NumberFormat.getInstance(Locale.KOREA);

    AwsConnect aws = new AwsConnect();
    String region = "ap-northeast-2";
    String bucketName = "mozy-bucket";
    String accessKeyID = aws.getAccessKey();
    String secretAccessKey = aws.getSecretKey();

    ProductDao dao = new ProductDao();
    ProductDto dto = new ProductDto();

    String mainImageUrl = null;
    String subImageUrl1 = null;
    String subImageUrl2 = null;
    String subImageUrl3 = null;
    String subImageUrl4 = null;
    String subImageUrl5 = null;



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


    MultipartRequest multiReq = new MultipartRequest(request, uploadFilePath, maxPostSize, "UTF-8", new DefaultFileRenamePolicy());

    // AWS S3 클라이언트 설정
    BasicAWSCredentials awsCreds = new BasicAWSCredentials(accessKeyID, secretAccessKey);
    AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
            .withCredentials(new AWSStaticCredentialsProvider(awsCreds))
            .withRegion(region)
            .build();


    // 파일 데이터 처리
    File mainImageFile = multiReq.getFile("main_image");
    if (mainImageFile != null) {
        mainImageUrl = dao.updateFileToS3(mainImageFile,s3Client,bucketName);
    }

    File subImageFile1 = multiReq.getFile("sub_image1");
    if (subImageFile1 != null) {
        subImageUrl1 = dao.updateFileToS3(subImageFile1, s3Client, bucketName);
    }

    File subImageFile2 = multiReq.getFile("sub_image2");
    if (subImageFile2 != null) {
        subImageUrl2 = dao.updateFileToS3(subImageFile2, s3Client, bucketName);
    }

    File subImageFile3 = multiReq.getFile("sub_image3");
    if (subImageFile3 != null) {
        subImageUrl3 = dao.updateFileToS3(subImageFile3, s3Client, bucketName);
    }

    File subImageFile4 = multiReq.getFile("sub_image4");
    if (subImageFile4 != null) {
        subImageUrl4 = dao.updateFileToS3(subImageFile4, s3Client, bucketName);
    }

    File subImageFile5 = multiReq.getFile("sub_image5");
    if (subImageFile5 != null) {
        subImageUrl5 = dao.updateFileToS3(subImageFile5, s3Client, bucketName);
    }

    // 요청 파라미터 받기
    String productId = multiReq.getParameter("productId");
    String mainCategory = multiReq.getParameter("mainCategory");
    String subCategory = multiReq.getParameter("subCategory");
    String productName = multiReq.getParameter("product_name");
    String productDescription = multiReq.getParameter("product_description");
    int stock = Integer.parseInt(multiReq.getParameter("stock"));
    int price = Integer.parseInt(multiReq.getParameter("price"));
    String saleStatus = multiReq.getParameter("sale_status");
    String colorsTag = multiReq.getParameter("colors");
    String sizesTag = multiReq.getParameter("sizes");

    dto.setPro_num(productId);
    dto.setParent_cate_num(mainCategory);
    dto.setCate_num(subCategory);
    dto.setPro_name(productName);
    dto.setPro_explain(productDescription);
    dto.setPro_stock(stock);
    dto.setPro_price(price);
    dto.setPro_sale_status(ProductDao.getSaleStatus(saleStatus));
    dto.setPro_color(colorsTag);
    dto.setPro_size(sizesTag);

    //이미지url dto에 설정
    dto.setPro_main_img(mainImageUrl);
    dto.setPro_sub_img1(subImageUrl1);
    dto.setPro_sub_img2(subImageUrl2);
    dto.setPro_sub_img3(subImageUrl3);
    dto.setPro_sub_img4(subImageUrl4);
    dto.setPro_sub_img5(subImageUrl5);

    dao.updateProduct(dto); //updateProduct() 호출


    JSONObject ob = new JSONObject();

    ob.put("pro_num", dto.getPro_num());
    ob.put("parent_cate_num", dao.getCategoryName(dto.getParent_cate_num()));
    ob.put("cate_num", dao.getCategoryName(dto.getCate_num()));
    ob.put("pro_name", dto.getPro_name());
    ob.put("pro_price", format.format(dto.getPro_price()));
    ob.put("pro_stock", dto.getPro_stock());
    ob.put("pro_sale_status", dto.getPro_sale_status());
    ob.put("pro_main_img", dao.getMainImage(productId));

    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    response.getWriter().write(ob.toString());
%>
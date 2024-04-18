<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="data.dto.ProductDto" %>
<%@ page import="data.dao.ProductDao" %>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.amazonaws.auth.AWSStaticCredentialsProvider" %>
<%@ page import="com.amazonaws.auth.BasicAWSCredentials" %>
<%@ page import="com.amazonaws.services.s3.AmazonS3ClientBuilder" %>
<%@ page import="com.amazonaws.services.s3.AmazonS3" %>
<%@ page import="com.amazonaws.services.s3.model.ObjectMetadata" %>
<%@ page import="java.io.InputStream" %>
<%@ page import="com.amazonaws.services.s3.model.PutObjectRequest" %>
<%@ page import="db.AwsConnect" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    AwsConnect aws = new AwsConnect();
    String region = "ap-northeast-2";
    String bucketName = "mozy-bucket";
    String accessKeyID = aws.getAccessKey();
    String secretAccessKey = aws.getSecretKey();

    ProductDao dao = new ProductDao();
    ProductDto dto = new ProductDto();


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


    // AWS S3 클라이언트 설정
    BasicAWSCredentials awsCreds = new BasicAWSCredentials(accessKeyID, secretAccessKey);
    AmazonS3 s3Client = AmazonS3ClientBuilder.standard()
            .withCredentials(new AWSStaticCredentialsProvider(awsCreds))
            .withRegion(region) // 예: Regions.US_EAST_1
            .build();



    String mainImageUrl = dao.uploadFileToS3(multiReq, "main_image", s3Client,bucketName );
    String subImageUrl1 = dao.uploadFileToS3(multiReq, "sub_image1", s3Client,bucketName );
    String subImageUrl2 = dao.uploadFileToS3(multiReq, "sub_image2", s3Client,bucketName );
    String subImageUrl3 = dao.uploadFileToS3(multiReq, "sub_image3", s3Client,bucketName );
    String subImageUrl4 = dao.uploadFileToS3(multiReq, "sub_image4", s3Client,bucketName );
    String subImageUrl5 = dao.uploadFileToS3(multiReq, "sub_image5", s3Client,bucketName );
// 주의: 위와 같은 방식으로 서브 이미지에 대해서도 처리

// 반환된 URL을 dto에 설정
    dto.setPro_main_img(mainImageUrl);
    dto.setPro_sub_img1(subImageUrl1);
    dto.setPro_sub_img2(subImageUrl2);
    dto.setPro_sub_img3(subImageUrl3);
    dto.setPro_sub_img4(subImageUrl4);
    dto.setPro_sub_img5(subImageUrl5);
// 서브 이미지에 대해서도 비슷한 방식으로 처리






    // 요청 파라미터 받기
    String mainCategory = multiReq.getParameter("mainCategory");
    String subCategory = multiReq.getParameter("subCategory");
    String productName = multiReq.getParameter("product_name");
    String productDescription = multiReq.getParameter("product_description");
    int stock = Integer.parseInt(multiReq.getParameter("stock"));
    int price = Integer.parseInt(multiReq.getParameter("price"));
    String saleStatus = multiReq.getParameter("sale_status");
    String colorsTag = multiReq.getParameter("colors");
    String sizesTag = multiReq.getParameter("sizes");



    //카테고리,상품명,상품설명,재고수량,가격,판매상태, 메인이미지1,서브이미지1~5
    dto.setCate_num(subCategory);
    dto.setPro_name(productName);
    dto.setPro_explain(productDescription);
    dto.setPro_stock(stock);
    dto.setPro_price(price);
    dto.setPro_sale_status(ProductDao.getSaleStatus(saleStatus));
    dto.setPro_color(colorsTag);
    dto.setPro_size(sizesTag);

    dao.addProduct(dto);
    response.sendRedirect("./addProduct.jsp");

%>
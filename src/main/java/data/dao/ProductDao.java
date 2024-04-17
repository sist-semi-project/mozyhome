package data.dao;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import data.dto.ProductDto;
import db.DbConnect;

import java.util.*;
import com.amazonaws.AmazonServiceException;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.oreilly.servlet.MultipartRequest;
import org.apache.commons.lang3.StringUtils;
import java.sql.SQLException;
import java.util.Vector;
import data.dto.WishlistDto;


public class ProductDao {

	/*fsdjk*/
    DbConnect db = new DbConnect();
	private static final Map<String, String> CATEGORY_MAP = new HashMap<>();
	private static final Map<String, String> R_CATEGORY_MAP = new HashMap<>();
	private static final Map<String, String> SALE_STATUS_MAP = new HashMap<>();

	static {
		CATEGORY_MAP.put("1", "거실");
		CATEGORY_MAP.put("2", "주방");
		CATEGORY_MAP.put("3", "침실");
		CATEGORY_MAP.put("4", "조명");
		CATEGORY_MAP.put("5", "기타");
		CATEGORY_MAP.put("11", "소파");
		CATEGORY_MAP.put("12", "테이블");
		CATEGORY_MAP.put("21", "식탁");
		CATEGORY_MAP.put("22", "의자");
		CATEGORY_MAP.put("31", "침대");
		CATEGORY_MAP.put("32", "옷장");
		CATEGORY_MAP.put("41", "단스탠드");
		CATEGORY_MAP.put("42", "장스탠드");
		CATEGORY_MAP.put("51", "기타");

		R_CATEGORY_MAP.put("거실", "1");
		R_CATEGORY_MAP.put("주방", "2");
		R_CATEGORY_MAP.put("침실", "3");
		R_CATEGORY_MAP.put("조명", "4");
		R_CATEGORY_MAP.put("기타", "5");
		R_CATEGORY_MAP.put("소파", "11");
		R_CATEGORY_MAP.put("테이블", "12");
		R_CATEGORY_MAP.put("식탁", "21");
		R_CATEGORY_MAP.put("의자", "22");
		R_CATEGORY_MAP.put("침대", "31");
		R_CATEGORY_MAP.put("옷장", "32");
		R_CATEGORY_MAP.put("단스탠드", "41");
		R_CATEGORY_MAP.put("장스탠드", "42");

		SALE_STATUS_MAP.put("on_sale","판매중");
		SALE_STATUS_MAP.put("out_of_stock","품절");
		SALE_STATUS_MAP.put("discontinued","단종");
	}


	//insert_product
    public void addProduct(ProductDto dto)
    {
        Connection conn=db.getConnection();
        PreparedStatement pstmt=null;

        //카테고리,상품명,상품설명,재고수량,가격,메인이미지1,서브이미지5,판매상태
        String sql="insert into product(cate_num,pro_name,pro_explain,pro_stock,pro_price,pro_size,pro_color,pro_main_img,pro_sub_img1," +
                "pro_sub_img2,pro_sub_img3,pro_sub_img4,pro_sub_img5,pro_sale_status)  values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        try {
            pstmt=conn.prepareStatement(sql);

            pstmt.setString(1, dto.getCate_num());
            pstmt.setString(2, dto.getPro_name());
            pstmt.setString(3, dto.getPro_explain());
            pstmt.setInt(4, dto.getPro_stock());
            pstmt.setInt(5, dto.getPro_price());
            pstmt.setString(6, dto.getPro_size());
            pstmt.setString(7, dto.getPro_color());
            pstmt.setString(8, dto.getPro_main_img());
            pstmt.setString(9, dto.getPro_sub_img1());
            pstmt.setString(10, dto.getPro_sub_img2());
            pstmt.setString(11, dto.getPro_sub_img3());
            pstmt.setString(12, dto.getPro_sub_img4());
            pstmt.setString(13, dto.getPro_sub_img5());
            pstmt.setString(14,dto.getPro_sale_status());
            pstmt.execute();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }finally {
            db.dbClose(pstmt, conn);
        }
    }

	// 상품 전체 출력
	public List<ProductDto> getAllProduct(){
		List<ProductDto> list=new Vector<ProductDto>();

		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;

		String sql="select * from product order by pro_num";

		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();

			while(rs.next()) {
				ProductDto dto=new ProductDto();

				dto.setPro_num(rs.getString("pro_num"));
				dto.setCate_num(rs.getString("cate_num"));
				dto.setPro_name(rs.getString("pro_name"));
				dto.setPro_explain(rs.getString("pro_explain"));
				dto.setPro_stock(rs.getInt("pro_stock"));
				dto.setPro_price(rs.getInt("pro_price"));
				dto.setPro_size(rs.getString("pro_size"));
				dto.setPro_color(rs.getString("pro_color"));
				dto.setPro_main_img(rs.getString("pro_main_img"));
				dto.setPro_sub_img1(rs.getString("pro_sub_img1"));
				dto.setPro_sub_img2(rs.getString("pro_sub_img2"));
				dto.setPro_sub_img3(rs.getString("pro_sub_img3"));
				dto.setPro_sub_img4(rs.getString("pro_sub_img4"));
				dto.setPro_sub_img5(rs.getString("pro_sub_img5"));
				dto.setPro_create_date(rs.getTimestamp("pro_create_date"));
				dto.setPro_sale_status(rs.getString("pro_sale_status"));

				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}
	
	//	product 정보 상세페이지로 불러올때
	public ProductDto getProduct(String pro_num)
	{
		ProductDto dto=new ProductDto();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from product where pro_num=?";
		
		try {
			
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, pro_num);
			rs=pstmt.executeQuery();
			
			if(rs.next())
			{
				dto.setPro_num(rs.getString("pro_num"));
				dto.setCate_num(rs.getString("cate_num"));
				dto.setPro_name(rs.getString("pro_name"));
				dto.setPro_explain(rs.getString("pro_explain"));
				dto.setPro_stock(rs.getInt("pro_stock"));
				dto.setPro_price(rs.getInt("pro_price"));
				dto.setPro_size(rs.getString("pro_size"));
				dto.setPro_color(rs.getString("pro_color"));
				dto.setPro_main_img(rs.getString("pro_main_img"));
				dto.setPro_sub_img1(rs.getString("pro_sub_img1"));
				dto.setPro_sub_img2(rs.getString("pro_sub_img2"));
				dto.setPro_sub_img3(rs.getString("pro_sub_img3"));
				dto.setPro_sub_img4(rs.getString("pro_sub_img4"));
				dto.setPro_sub_img5(rs.getString("pro_sub_img5"));
				dto.setPro_create_date(rs.getTimestamp("pro_create_date"));
				dto.setPro_sale_status(rs.getString("pro_sale_status"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return dto;
	}

	// 파일 업로드 및 URL 반환 함수 시작
	public String uploadFileToS3(MultipartRequest multiReq, String fileName, AmazonS3 s3Client, String bucketName) {
		File file = multiReq.getFile(fileName);
		if (file != null) {
			String fileKey = "product/" + file.getName(); // S3에서의 파일 경로 및 이름 설정

			try {
				// 파일을 S3 버킷에 업로드
				s3Client.putObject(new PutObjectRequest(bucketName, fileKey, file));

				// 업로드된 파일의 URL 반환
				return s3Client.getUrl(bucketName, fileKey).toString();
			} catch (AmazonServiceException e) {
				System.err.println(e.getErrorMessage());
				return null;
			}
		}
		return null;
	}
	// 파일 업로드 및 URL 반환 함수 끝
	// 관리자용 상품 출력
	public List<ProductDto> getAllProductForAdmin(){
		List<ProductDto> list=new ArrayList<ProductDto>();

		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;

		//상품번호,상위.하위카테고리,상품명,상품가격,재고량,판매상태,메인이미지,등록일,판매량
		String sql = "select p.pro_num,c.parent_cate_num,p.cate_num,p.pro_name,p.pro_price,p.pro_stock,p.pro_sale_status," +
				"p.pro_main_img,p.pro_create_date,ifnull(sum(o.order_detail_su),0) sale_volume from product as p\n" +
				"left join category as c on p.cate_num = c.cate_num \n" +
				"left join order_detail as o on p.pro_num = o.pro_num\n" +
				"group by p.pro_num\n" +
				"order by p.pro_num";

		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();

			while(rs.next()) {
				ProductDto dto=new ProductDto();

				dto.setPro_num(rs.getString("p.pro_num"));
				dto.setParent_cate_num(rs.getString("c.parent_cate_num"));
				dto.setCate_num(rs.getString("p.cate_num"));
				dto.setPro_name(rs.getString("p.pro_name"));
				dto.setPro_stock(rs.getInt("p.pro_stock"));
				dto.setPro_price(rs.getInt("p.pro_price"));
				dto.setPro_main_img(rs.getString("p.pro_main_img"));
				dto.setPro_create_date(rs.getTimestamp("p.pro_create_date"));
				dto.setPro_sale_status(rs.getString("p.pro_sale_status"));
				dto.setPro_sale_volume(rs.getInt("sale_volume"));

				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}

	public List<ProductDto> getAllProductPagingForAdmin(int startIndex,int perPage){
		List<ProductDto> list=new ArrayList<ProductDto>();

		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;

		//상품번호,상위.하위카테고리,상품명,상품가격,재고량,판매상태,메인이미지,등록일,판매량
		String sql = "select p.pro_num,c.parent_cate_num,p.cate_num,p.pro_name,p.pro_price,p.pro_stock,p.pro_sale_status," +
				"p.pro_main_img,p.pro_create_date,ifnull(sum(o.order_detail_su),0) sale_volume, COUNT(*) OVER() AS total_count from product as p\n" +
				"left join category as c on p.cate_num = c.cate_num \n" +
				"left join order_detail as o on p.pro_num = o.pro_num\n" +
				"group by p.pro_num\n" +
				"order by p.pro_num limit ?,?";

		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, startIndex);
			pstmt.setInt(2, perPage);
			rs=pstmt.executeQuery();

			while(rs.next()) {
				ProductDto dto=new ProductDto();

				dto.setPro_num(rs.getString("p.pro_num"));
				dto.setParent_cate_num(rs.getString("c.parent_cate_num"));
				dto.setCate_num(rs.getString("p.cate_num"));
				dto.setPro_name(rs.getString("p.pro_name"));
				dto.setPro_stock(rs.getInt("p.pro_stock"));
				dto.setPro_price(rs.getInt("p.pro_price"));
				dto.setPro_main_img(rs.getString("p.pro_main_img"));
				dto.setPro_create_date(rs.getTimestamp("p.pro_create_date"));
				dto.setPro_sale_status(rs.getString("p.pro_sale_status"));
				dto.setPro_sale_volume(rs.getInt("sale_volume"));
				dto.setTotalCount(rs.getInt("total_count"));

				list.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}

	public String getCategoryName(String categoryId) {
		return CATEGORY_MAP.getOrDefault(categoryId, "NoCategory");
	}
	public String getCategoryID(String[] categoryNames) {

		String category = "";
		for (String categoryName : categoryNames) {
			category+= R_CATEGORY_MAP.get(categoryName)+",";
		}

		return category.substring(0,category.length()-1);
	}

	public static String[] getCategoryCodes(String[] categories) {
		String[] codes = new String[categories.length];
		for (int i = 0; i < categories.length; i++) {
			codes[i] = R_CATEGORY_MAP.get(categories[i]);
		}
		return codes;
	}

	public static String getSaleStatus(String saleStatus) {
		return SALE_STATUS_MAP.getOrDefault(saleStatus, "판매중");
	}


	public List<ProductDto> getFilteredProducts(Map<String, Object> sqlParams) {
		List<ProductDto> list = new ArrayList<>();

		// 페이징기능 변수
		int perPage = 6;
		int page = (Integer)sqlParams.get("page");
		int startIndex = perPage * page;

		//날짜 변수(null값일시 2024-01-05~2024-0715 세팅)
		String startDate = StringUtils.defaultIfBlank((String) sqlParams.get("startDate"), "2024-01-05");
		String endDate = StringUtils.defaultIfBlank((String) sqlParams.get("endDate"), "2024-07-15");


		String productName = "%" + (String) sqlParams.get("productName") + "%";

		// 판매상태, 상위.하위 카테고리 세팅
		String[] salesStatus = (String[]) sqlParams.get("salesStatus");
		String[] mainCategory = (String[]) sqlParams.get("mainCategory");
		String[] subCategory = (String[]) sqlParams.get("subCategory");

		String sql = buildDynamicSql(salesStatus, mainCategory, subCategory);


		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = conn.prepareStatement(sql);

			// 인덱스를 1부터 증가시키며 파라미티값 세팅
			int paramIndex = 1;
			for (String category : subCategory) {
				pstmt.setString(paramIndex++, category);
			}
			pstmt.setString(paramIndex++, startDate);
			pstmt.setString(paramIndex++, endDate);
			for (String status : salesStatus) {
				pstmt.setString(paramIndex++, status);
			}
			pstmt.setString(paramIndex++, productName);


			for (String category : mainCategory) {
				pstmt.setString(paramIndex++, category);
			}
			pstmt.setString(paramIndex++, startDate);
			pstmt.setString(paramIndex++, endDate);
			for (String status : salesStatus) {
				pstmt.setString(paramIndex++, status);
			}
			pstmt.setString(paramIndex++, productName);

			pstmt.setInt(paramIndex++, startIndex);
			pstmt.setInt(paramIndex, perPage);

			rs = pstmt.executeQuery();

			while(rs.next()) {
				ProductDto dto=new ProductDto();

				dto.setPro_num(rs.getString("pro_num"));
				dto.setParent_cate_num(rs.getString("parent_cate_num"));
				dto.setCate_num(rs.getString("cate_num"));
				dto.setPro_name(rs.getString("pro_name"));
				dto.setPro_stock(rs.getInt("pro_stock"));
				dto.setPro_price(rs.getInt("pro_price"));
				dto.setPro_main_img(rs.getString("pro_main_img"));
				dto.setPro_create_date(rs.getTimestamp("pro_create_date"));
				dto.setPro_sale_status(rs.getString("pro_sale_status"));
				dto.setPro_sale_volume(rs.getInt("sale_volume"));
				dto.setTotalCount(rs.getInt("total_count"));

				list.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs,pstmt,conn);
		}

		return list;
	}

	private String buildDynamicSql(String[] salesStatus, String[] mainCategory, String[] subCategory) {
		String sqlTemplate = "SELECT *, COUNT(*) OVER() AS total_count FROM (" +
				"SELECT p.pro_num, c.parent_cate_num, p.cate_num, p.pro_name, p.pro_price, p.pro_stock, p.pro_sale_status, p.pro_main_img, p.pro_create_date, IFNULL(SUM(o.order_detail_su), 0) AS sale_volume " +
				"FROM product AS p " +
				"LEFT JOIN category AS c ON p.cate_num = c.cate_num " +
				"LEFT JOIN order_detail AS o ON p.pro_num = o.pro_num " +
				"WHERE p.cate_num IN (%s) AND (p.pro_create_date BETWEEN ? AND ?) AND p.pro_sale_status IN (%s) AND p.pro_name LIKE ? " +
				"GROUP BY p.pro_num " +
				"UNION " +
				"SELECT p.pro_num, c.parent_cate_num, p.cate_num, p.pro_name, p.pro_price, p.pro_stock, p.pro_sale_status, p.pro_main_img, p.pro_create_date, IFNULL(SUM(o.order_detail_su), 0) AS sale_volume " +
				"FROM product AS p " +
				"LEFT JOIN category AS c ON p.cate_num = c.cate_num " +
				"LEFT JOIN order_detail AS o ON p.pro_num = o.pro_num " +
				"WHERE c.parent_cate_num IN (%s) AND (p.pro_create_date BETWEEN ? AND ?) AND p.pro_sale_status IN (%s) AND p.pro_name LIKE ? " +
				"GROUP BY p.pro_num " +
				") AS combined_result " +
				"ORDER BY pro_num LIMIT ?, ?";

		// 하위카테고리,상위카테고리,판매상태 길이에 따라 문자열 배열 생성후 ","으로 연결(join)
		String subCategoryPlaceholders = String.join(", ", Collections.nCopies(subCategory.length, "?"));
		String mainCategoryPlaceholders = String.join(", ", Collections.nCopies(mainCategory.length, "?"));
		String salesStatusPlaceholders = String.join(", ", Collections.nCopies(salesStatus.length, "?"));

		//
		return String.format(sqlTemplate, subCategoryPlaceholders, salesStatusPlaceholders, mainCategoryPlaceholders, salesStatusPlaceholders);
	}


	//삭제
	public int deleteProduct(String num) {

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		int delCount =0;

		String sql = "delete from product where pro_num=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, num);
			delCount =  pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		return delCount;
	}

}

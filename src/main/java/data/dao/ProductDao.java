package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import java.sql.SQLException;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import data.dto.ProductDto;
import data.dto.WishlistDto;
import db.DbConnect;

public class ProductDao {

    DbConnect db = new DbConnect();
 
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
    
	// 카테고리별 상품 전체 출력 (좋아요 수, 리뷰 수 가져옴)
	public List<ProductDto> getAllProduct(String cate_num){
		List<ProductDto> list=new Vector<ProductDto>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;

		String sql="SELECT p.*, count(distinct w.wish_num) as wishCount, count(distinct r.review_num) as reviewCount"
				+ " FROM product p"
				+ " LEFT JOIN wishlist w ON p.pro_num = w.pro_num"
				+ " LEFT JOIN review r ON p.pro_num = r.pro_num"
				+ " GROUP BY p.pro_num"
				+ " having p.cate_num=?"
				+ " order by pro_num";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, cate_num);
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
				dto.setWishCount(rs.getInt("wishCount"));
				dto.setReviewCount(rs.getInt("reviewCount"));
				
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
	
	


}

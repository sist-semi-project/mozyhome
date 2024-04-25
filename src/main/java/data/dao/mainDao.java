package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.ProductDto;
import data.dto.ReviewDto;
import db.DbConnect;

public class mainDao {
	DbConnect db=new DbConnect();
	
	// new 상품 조회
	public List<ProductDto> getNewProducts() {
		List<ProductDto> nlist = new ArrayList<ProductDto>();

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT *"
				+ " FROM product"
				+ " where pro_sale_status!='단종'"
				+ " order by pro_create_date desc";

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProductDto dto = new ProductDto();

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

				nlist.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return nlist;
	}
	
	// 리뷰 출력
	public List<ReviewDto> getReview() {
		List<ReviewDto> rlist = new ArrayList<ReviewDto>();

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select * from review order by review_writeday desc";

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				ReviewDto dto=new ReviewDto();
				
				dto.setReview_num(rs.getInt("review_num"));
				dto.setMem_num(rs.getInt("mem_num"));
				dto.setPro_num(rs.getInt("pro_num"));
				dto.setReview_pyung(rs.getInt("review_pyung"));
				dto.setReview_subject(rs.getString("review_subject"));
				dto.setReview_content(rs.getString("review_content"));
				dto.setReview_image(rs.getString("review_image"));
				dto.setReview_writeday(rs.getTimestamp("review_writeday"));

				rlist.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return rlist;
	}
}

package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;

import data.dto.CategoryDto;
import data.dto.ProductDto;
import db.DbConnect;

public class ProductListDao {
	DbConnect db = new DbConnect();

	// <<사용안함>> 카테고리별 상품 전체 출력 (좋아요 수, 리뷰 수 가져옴)
	public List<ProductDto> getAllProduct(String cate_num) {
		List<ProductDto> list = new Vector<ProductDto>();

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT p.*, count(distinct w.wish_num) as wishCount, count(distinct r.review_num) as reviewCount"
				+ " FROM product p" + " LEFT JOIN wishlist w ON p.pro_num = w.pro_num"
				+ " LEFT JOIN review r ON p.pro_num = r.pro_num" + " GROUP BY p.pro_num" + " having p.cate_num=?"
				+ " order by pro_num";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cate_num);
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

	// 부모 카테고리별 상품 전체 출력 (좋아요 수, 리뷰 수 가져옴)
	public List<ProductDto> getAllParentsProduct(String pcate_num) {
		List<ProductDto> plist = new Vector<ProductDto>();

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT p.*, count(distinct w.wish_num) as wishCount, count(distinct r.review_num) as reviewCount"
				+ " FROM product p" + " LEFT JOIN wishlist w ON p.pro_num = w.pro_num"
				+ " LEFT JOIN review r ON p.pro_num = r.pro_num"
				+ " GROUP BY p.pro_num"
				+ " having p.cate_num in ("
				+ " select cate_num"
				+ " from category"
				+ " where parent_cate_num=?)"
				+ ")" + " order by pro_num";


		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pcate_num);
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
				dto.setWishCount(rs.getInt("wishCount"));
				dto.setReviewCount(rs.getInt("reviewCount"));

				plist.add(dto);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return plist;
	}

	// 카테고리명 출력
	public CategoryDto getCategory(String cate_num) {
		CategoryDto dto = new CategoryDto();

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select cate_name from category where cate_num=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cate_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto.setCate_name(rs.getString("cate_name"));
				dto.setCate_num(rs.getInt("cate_num"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}

	// 부모 카테고리명 출력
	public CategoryDto getParentCategory(String cate_num) {
		CategoryDto dto = new CategoryDto();

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select *" + " from category" + " where cate_num = (" + " select parent_cate_num"
				+ " from category" + " where cate_num=?);";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cate_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto.setCate_name(rs.getString("cate_name"));
				dto.setCate_num(rs.getInt("cate_num"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}

	// 페이징
	// 1. 전체 개수 반환
	public int getTotalCount(String cate_num) {
		int total = 0;
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "select count(*) from product where cate_num=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cate_num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				total = rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}

		return total;
	}
	// 2. 부분조회
	public List<ProductDto> getPagingList(String cate_num, int startNum, int perPage) {
		List<ProductDto> list = new ArrayList<ProductDto>();

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		if(cate_num.length()==1) {
			String sql = "select p.*, count(distinct w.wish_num) as wishCount, count(distinct r.review_num) as reviewCount from product p"
					+ "left join wishlist w on p.pro_num = w.pro_num "
					+ "left join review r on p.pro_num = r.pro_num "
					+ "left join category c on p.cate_num = c.cate_num "
					+ "where c.parent_cate_num = ? "
					+ "group by p.pro_num order by pro_num desc limit ?,?";
			
			
			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, cate_num);
				pstmt.setInt(2, startNum);
				pstmt.setInt(3, perPage);

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

		} else {
			//String sql = "select * from product order by pro_num desc limit ?,?";
			String sql = "SELECT p.*, count(distinct w.wish_num) as wishCount, count(distinct r.review_num) as reviewCount"
					+ " FROM product p"
					+ " LEFT JOIN wishlist w ON p.pro_num = w.pro_num"
					+ " LEFT JOIN review r ON p.pro_num = r.pro_num" 
					+ " GROUP BY p.pro_num" 
					+ " having p.cate_num=?"
					+ " order by pro_num desc limit ?,?";

			try {
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, cate_num);
				pstmt.setInt(2, startNum);
				pstmt.setInt(3, perPage);

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
	
	
	

}

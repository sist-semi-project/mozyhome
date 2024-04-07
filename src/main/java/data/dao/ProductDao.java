package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.ProductDto;
import db.DbConnect;


public class ProductDao {

	DbConnect db=new DbConnect();
	
	public ProductDto getAllProduct(String pro_num) {
		
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
				dto.setPro_num(rs.getInt("pro_num"));
				dto.setCate_num(rs.getInt("cate_num"));
				dto.setPro_name(rs.getString("pro_name"));
				dto.setPro_explain(rs.getString("pro_explain"));
				dto.setPro_stock(rs.getInt("pro_stock"));
				dto.setPro_price(rs.getInt("pro_price"));
				dto.setPro_main_img(rs.getString("pro_main_img"));
				dto.setPro_sub_img1(rs.getString("pro_sub_img1"));
				dto.setPro_sub_img2(rs.getString("pro_sub_img2"));
				dto.setPro_sub_img3(rs.getString("pro_sub_img3"));
				dto.setPro_sub_img4(rs.getString("pro_sub_img4"));
				dto.setPro_sub_img5(rs.getString("pro_sub_img5"));
				dto.setPro_date(rs.getString("pro_date"));
				dto.setPro_status(rs.getString("pro_status"));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return dto;
	}
	
	
}

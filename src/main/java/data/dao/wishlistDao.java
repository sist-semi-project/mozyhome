package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import db.DbConnect;

public class wishlistDao {
	DbConnect db=new DbConnect();
	
	// 위시리스트 상품 조회
	public List<HashMap<String, String>> getWishlist(String myid){
		List<HashMap<String, String>> list=new ArrayList<HashMap<String,String>>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="SELECT w.wish_num AS wish_num, p.pro_num, p.pro_name, p.pro_price, p.pro_main_img, m.mem_id"
				+ " FROM product p, wishlist w, member m"
				+ " where w.pro_num=p.pro_num and w.mem_num=m.mem_num and m.mem_id=?"
				+ " GROUP BY p.pro_num";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, myid);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, String> map=new HashMap<String, String>();
				
				map.put("wish_num", rs.getString("wish_num"));
				map.put("pro_num", rs.getString("pro_num"));
				map.put("pro_name", rs.getString("pro_name"));
				map.put("pro_price", rs.getString("pro_price"));
				map.put("pro_main_img", rs.getString("pro_main_img"));
				map.put("mem_id", rs.getString("mem_id"));
				
				list.add(map);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return list;
	}
	
	// 위시리스트 삭제
	public void deleteWishlist(String wish_num) {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="delete from wishlist where wish_num=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, wish_num);
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	

}

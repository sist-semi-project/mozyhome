package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import db.DbConnect;

public class WishlistDao {
	DbConnect db=new DbConnect();
	
	// 페이징
	// (1) 위시리스트 상품 전체 개수 반환
	public int getWishCount(String mem_id) {
		int total=0;
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select count(*)"
				+ " from member m, wishlist w"
				+ " where w.mem_num=m.mem_num and m.mem_id=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				total=rs.getInt(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}	
		return total;
	}
	// (2) 위시리스트 상품 부분조회
	public List<HashMap<String, String>> getPagingWishlist(String mem_id, int startNum, int perPage){
		List<HashMap<String, String>> list=new ArrayList<HashMap<String,String>>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="SELECT w.wish_num AS wish_num, p.pro_num, p.pro_name, p.pro_price, p.pro_main_img, m.mem_id"
				+ " FROM product p, wishlist w, member m"
				+ " where w.pro_num=p.pro_num and w.mem_num=m.mem_num and m.mem_id=?"
				+ " GROUP BY p.pro_num"
				+ " order by pro_num desc limit ?,?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			pstmt.setInt(2, startNum);
			pstmt.setInt(3, perPage);
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
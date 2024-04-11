package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import data.dto.CartDto;
import db.DbConnect;

public class CartDao {
	
	DbConnect db=new DbConnect();
	
	public void insertCart(CartDto dto) {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="insert into cart values(null,?,?,?,?,?)";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getMem_num());
			pstmt.setString(2, dto.getCart_size());
			pstmt.setString(3, dto.getCart_color());
			pstmt.setInt(4, dto.getPro_num());
			pstmt.setInt(5, dto.getCart_su());
			
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	public List<HashMap<String, String>> getCartList(String id)
	{
		List<HashMap<String, String>> list=new ArrayList<HashMap<String,String>>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select p.pro_price, p.pro_main_img,c.cart_size,c.cart_color "
				+ "from cart c, product p, member m "
				+ "where c.mem_num=m.mem_num and c.pro_num=p.pro_num and m.mem_id=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				HashMap<String, String> map=new HashMap<String, String>();
				
				map.put("pro_price", rs.getString("pro_price"));
				map.put("pro_main_img", rs.getString("pro_main_img"));
				map.put("pro_size", rs.getString("pro_size"));
				map.put("pro_color", rs.getString("pro_color"));
				map.put("pro_name", rs.getString("pro_name"));
				
				list.add(map);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return list;
	}
}

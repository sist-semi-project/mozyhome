package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.mysql.cj.x.protobuf.MysqlxPrepare.Execute;

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
		
		String sql="select p.pro_name, p.pro_price, p.pro_main_img, c.cart_num, c.cart_size, c.cart_color, c.cart_su, m.mem_num, p.pro_num "
				+ " from cart c, product p, member m "
				+ " where c.mem_num=m.mem_num and c.pro_num=p.pro_num and m.mem_id=? ";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				HashMap<String, String> map=new HashMap<String, String>();
				
				map.put("cart_num" , rs.getString("cart_num"));
				map.put("pro_num" , rs.getString("pro_num"));
				map.put("pro_price", rs.getString("pro_price"));
				map.put("pro_main_img", rs.getString("pro_main_img"));
				map.put("cart_size", rs.getString("cart_size"));
				map.put("cart_color", rs.getString("cart_color"));
				map.put("pro_name", rs.getString("pro_name"));
				map.put("cart_su", rs.getString("cart_su"));
				map.put("mem_num", rs.getString("mem_num"));
				map.put("pro_num", rs.getString("pro_num")); // 2024-04-19 추가

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
	
	public void overlapProDel(String pro_num) {
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="DELETE FROM CART"
				+ " WHERE pro_num IN ("
				+ " SELECT pro_num"
				+ " FROM ("
				+ " SELECT pro_num, ROW_NUMBER() OVER(PARTITION BY pro_num ORDER BY pro_num) AS rn"
				+ " FROM CART"
				+ " ) AS t"
				+ " WHERE t.rn > 1"
				+ " )";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.execute();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	

	public void overlapProInsert() {
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="INSERT INTO CART (pro_num)"
				+ " SELECT '?'"
				+ " FROM dual"
				+ "	 WHERE NOT EXISTS ("
				+ "    SELECT 1"
				+ "    FROM CART"
				+ "    WHERE pro_num = '?'"
				+ ")";
		
	}

	
	public void deleteCartNum(String cart_num) {
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="delete from cart where cart_num=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, cart_num);
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(pstmt, conn);
		}
		
	}

}

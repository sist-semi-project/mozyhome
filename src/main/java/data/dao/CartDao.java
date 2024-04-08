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
		
		String sql="insert into cart values(null,?,?,?)";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getMem_num());
			pstmt.setInt(2, dto.getPro_num());
			pstmt.setInt(3, dto.getCart_su());
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public List<HashMap<Integer, Integer>> getCartList(String id)
	{
		List<HashMap<Integer, Integer>> list=new ArrayList<HashMap<Integer,Integer>>();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select p.pro_price, p.pro_main_img,c.cart_su,c.cart,p.pro_size,p.pro_color "
				+ "from cart c, product p, member m "
				+ "where c.mem_num=m.mem_num and c.pro_num=p.pro_num and m.id=?";
		
		return list;
	}
}

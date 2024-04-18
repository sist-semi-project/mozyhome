package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import data.dto.MemberDto;
import data.dto.ReviewDto;
import db.DbConnect;

public class ReviewDao {
	DbConnect db = new DbConnect(); 
	
	//리뷰 리스트 데이터 출력
	public List<HashMap<String, String>> getReview(String pro_num,int start,int perPage) {
		
		List<HashMap<String, String>> list = new ArrayList<HashMap<String,String>>();
		
		Connection conn= db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql = "select r.review_subject, r.review_image, r.review_pyung, r.review_content, r.review_writeday, m.mem_id "
	            + "from review r "
	            + "join member m on r.mem_num = m.mem_num "
	            + "where r.pro_num=?"
	            + "ORDER BY r.review_num DESC "
	            + "LIMIT ?, ?";
			
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, pro_num);
			pstmt.setInt(2, start); // start 위치
			pstmt.setInt(3, perPage); // 페이지당 출력할 항목 수
			rs=pstmt.executeQuery();
			
			while(rs.next())
			{
				HashMap<String, String> map=new HashMap<String, String>();
				
				map.put("review_subject", rs.getString("review_subject"));
				map.put("review_pyung", rs.getString("review_pyung"));
				map.put("review_content", rs.getString("review_content"));
				map.put("review_writeday", rs.getString("review_writeday"));
				map.put("mem_id", rs.getString("mem_id"));
				map.put("review_image", rs.getString("review_image"));
				
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
	
	//상품 리뷰 갯수 출력
	public int getTotalCount(String pro_num)
	{
		int n=0;
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select count(*) from review where pro_num=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			pstmt.setString(1, pro_num);
			
			if(rs.next())
				n=rs.getInt(1);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return n;
	}
	

}

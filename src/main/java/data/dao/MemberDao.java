package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import data.dto.MemberDto;
import db.DbConnect;

public class MemberDao {
	
	DbConnect db= new DbConnect();
	
	public MemberDto getMember(int mem_num)
	{
		MemberDto dto=new MemberDto();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt= null;
		ResultSet rs=null;
		
		String sql="select * from member where mem_num=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, mem_num);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto.setMem_num(rs.getInt("mem_num"));
				dto.setMem_id(rs.getString("mem_id"));
				dto.setMem_password(rs.getString("mem_password"));
				dto.setMem_name(rs.getString("mem_name"));
				dto.setMem_nickname(rs.getString("mem_nickname"));
				dto.setMem_hp(rs.getString("mem_hp"));
				dto.setMem_zipcode(rs.getString("mem_zipcode"));
				dto.setMem_address(rs.getString("mem_address"));
				dto.setMem_address_detail(rs.getString("mem_address_detail"));
				dto.setMem_email(rs.getString("mem_email"));
				dto.setMem_birth(rs.getTimestamp("mem_birth"));
				dto.setMem_gender(rs.getString("mem_gender"));
				dto.setMem_gaipday(rs.getTimestamp("mem_gaipday"));
				dto.setMem_is_active(rs.getString("mem_is_active"));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}
	
	public String getNum(String id)
	{
		String num="";
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select mem_num from member where mem_id=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			
			if(rs.next())
				num=rs.getString("mem_num");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return num;
	}
}

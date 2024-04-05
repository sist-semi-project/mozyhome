package data.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import data.dto.dbTestDto;
import db.DbConnect;

public class dbTestDao {	
	DbConnect db=new DbConnect();
	
	public void insertDbTest(dbTestDto dto) {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="insert into dbtest values (null,?,now())";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getContent());
			
			pstmt.execute();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
		
	}

}

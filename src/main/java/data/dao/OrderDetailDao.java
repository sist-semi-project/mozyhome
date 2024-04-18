package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import data.dto.OrderDetailDto;
import db.DbConnect;

public class OrderDetailDao {
	DbConnect db = new DbConnect();

	public void insertOrder(OrderDetailDto dto) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;

		String sql = "INSERT INTO order_detail (mem_num, order_num, pro_num, order_detail_su) VALUES (?, ?, ?, ?)";

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getMemNum());
			pstmt.setString(2, dto.getOrderNum());
			pstmt.setString(3, dto.getProNum());
			pstmt.setInt(4, dto.getOrderDetailSu());

			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
}
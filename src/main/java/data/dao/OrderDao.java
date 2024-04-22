package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.CartDto;
import data.dto.OrderDto;
import data.dto.ProductDto;
import db.DbConnect;

public class OrderDao {

	DbConnect db = new DbConnect();
	
	// 해당 날짜의 주문 수를 가져오는 메서드
    public int getOrderCountForToday() {
    	Connection conn = db.getConnection();
    	PreparedStatement pstmt = null;
    	ResultSet rs=null;
    	
        String sql = "SELECT COUNT(*) AS orderCount FROM order_info WHERE DATE(order_date) = CURDATE()";
        int orderCount = 0;
        try {
        	pstmt=conn.prepareStatement(sql);
        	rs=pstmt.executeQuery();
        	if(rs.next()) {
                orderCount = rs.getInt("orderCount");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderCount;
    }

	// 주문 생성
	public void insertOrder(OrderDto dto) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;

		String sql = "INSERT INTO order_info VALUES (?, ?, now(), ?, ?, ?, ?, ?, ?, ?)";

		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getOrder_num());
			pstmt.setString(2, dto.getMem_num());
			pstmt.setString(3, dto.getOrder_status());
			pstmt.setString(4, dto.getOrder_delivery_request());
			pstmt.setString(5, dto.getOrder_addr());
			pstmt.setString(6, dto.getOrder_name());
			pstmt.setString(7, dto.getOrder_hp());
			pstmt.setInt(8, dto.getOrder_delivery_fee());
			pstmt.setInt(9, dto.getOrder_total_payment());
			
			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	// 주문번호에 대한 dto반환
	public OrderDto getOneData(String num){
		OrderDto order=new OrderDto();
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from order_info where order_num=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, num);
			rs=pstmt.executeQuery();
			
			if(rs.next())
			{
				order.setOrder_num(rs.getString("order_num"));
				order.setMem_num(rs.getString("mem_num"));
				order.setOrder_date(rs.getTimestamp("order_date"));
	            order.setOrder_status(rs.getString("order_status"));
	            order.setOrder_delivery_request(rs.getString("order_delivery_request"));
	            order.setOrder_addr(rs.getString("order_addr"));
	            order.setOrder_name(rs.getString("order_name"));
	            order.setOrder_hp(rs.getString("order_hp"));
	            order.setOrder_delivery_fee(rs.getInt("order_delivery_fee"));
	            order.setOrder_total_payment(rs.getInt("order_total_payment"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return order;
	}
    
    // 특정 회원의 주문을 가져오는 메서드
    public List<OrderDto> getOrdersByMember(String memNum) {
        List<OrderDto> orderList = new ArrayList<>();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM order_info WHERE mem_num = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, memNum);
            rs = pstmt.executeQuery();

            // 결과를 OrderDto 객체로 변환하여 리스트에 추가
            while (rs.next()) {
                OrderDto order = new OrderDto();
                order.setOrder_num(rs.getString("order_num"));
				order.setMem_num(rs.getString("mem_num"));
				order.setOrder_date(rs.getTimestamp("order_date"));
	            order.setOrder_status(rs.getString("order_status"));
	            order.setOrder_delivery_request(rs.getString("order_delivery_request"));
	            order.setOrder_addr(rs.getString("order_addr"));
	            order.setOrder_name(rs.getString("order_name"));
	            order.setOrder_hp(rs.getString("order_hp"));
	            order.setOrder_delivery_fee(rs.getInt("order_delivery_fee"));
	            order.setOrder_total_payment(rs.getInt("order_total_payment"));
                orderList.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }

        return orderList;
    }
    
    // 주문 상태 업데이트
    public boolean updateOrderStatus(String orderNumber, String newStatus) {
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;

        String sql = "UPDATE order_info SET order_status = ? WHERE order_num = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, newStatus);
            pstmt.setString(2, orderNumber);
            int rowsAffected = pstmt.executeUpdate();

            // 업데이트가 성공하면 true 반환
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(pstmt, conn);
        }

        // 업데이트가 실패하면 false 반환
        return false;
    }


}
package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.CartDto;
import data.dto.OrderDto;
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
			
			pstmt.setString(1, dto.getOrderNum());
			pstmt.setString(2, dto.getMemNum());
			pstmt.setString(3, dto.getOrderStatus());
			pstmt.setString(4, dto.getOrderDeliveryRequest());
			pstmt.setString(5, dto.getOrderAddr());
			pstmt.setString(6, dto.getOrderName());
			pstmt.setString(7, dto.getOrderHp());
			pstmt.setInt(8, dto.getOrderDeliveryFee());
			pstmt.setInt(9, dto.getOrderTotalPayment());
			
			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	// 주문번호에 대한 dto반환
	public OrderDto getOneData(String num){
		OrderDto dto=new OrderDto();
		
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
				dto.setOrderNum(rs.getString("order_num"));
	            dto.setMemNum(rs.getString("mem_num"));
	            dto.setOrderDate(rs.getTimestamp("order_date"));
	            dto.setOrderStatus(rs.getString("order_status"));
	            dto.setOrderDeliveryRequest(rs.getString("order_delivery_request"));
	            dto.setOrderAddr(rs.getString("order_addr"));
	            dto.setOrderName(rs.getString("order_name"));
	            dto.setOrderHp(rs.getString("order_hp"));
	            dto.setOrderDeliveryFee(rs.getInt("order_delivery_fee"));
	            dto.setOrderTotalPayment(rs.getInt("order_total_payment"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		return dto;
	}
    
    // 특정 회원의 주문을 가져오는 메서드 (삭제 예정)
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
                order.setOrderNum(rs.getString("order_num"));
                order.setMemNum(rs.getString("mem_num"));
                order.setOrderDate(rs.getTimestamp("order_date"));
                order.setOrderStatus(rs.getString("order_status"));
                order.setOrderDeliveryRequest(rs.getString("order_delivery_request"));
                order.setOrderAddr(rs.getString("order_addr"));
                order.setOrderName(rs.getString("order_name"));
                order.setOrderHp(rs.getString("order_hp"));
                order.setOrderDeliveryFee(rs.getInt("order_delivery_fee"));
                order.setOrderTotalPayment(rs.getInt("order_total_payment"));
                orderList.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }

        return orderList;
    }
    
    public List<CartDto> getCartItemsByMember(String memNum) {
        List<CartDto> cartItems = new ArrayList<>();
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = db.getConnection();
            String query = "SELECT pro.pro_name, cart.cart_size, cart.cart_color, cart.cart_su " +
                           "FROM cart " +
                           "JOIN product AS pro ON cart.pro_num = pro.pro_num " +
                           "WHERE cart.mem_num = ?";
            pstmt = conn.prepareStatement(query);
            pstmt.setString(1, memNum);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                String productName = rs.getString("pro_name");
                String size = rs.getString("cart_size");
                String color = rs.getString("cart_color");
                int quantity = rs.getInt("cart_su");

                CartDto cartItem = new CartDto(0, 0, 0, size, color, quantity);
                cartItem.setProName(productName);
                cartItems.add(cartItem);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }

        return cartItems;
    }

}
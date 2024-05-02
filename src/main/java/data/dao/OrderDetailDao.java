package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.OrderDetailDto;
import data.dto.OrderDto;
import db.DbConnect;

public class OrderDetailDao {
	
	DbConnect db = new DbConnect();

	// 주문 상세 생성
	public void insertOrder(OrderDetailDto dto) {
		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;

		String sql = "INSERT INTO order_detail (mem_num, pro_num, order_num, order_size, order_color ,order_detail_su) VALUES (?, ?, ?, ?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getMem_num());
			pstmt.setString(2, dto.getPro_num());
			pstmt.setString(3, dto.getOrder_num());	
			pstmt.setString(4, dto.getOrder_size());	
			pstmt.setString(5, dto.getOrder_color());	
			pstmt.setInt(6, dto.getOrder_detail_su());

			pstmt.execute();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	// 특정 주문번호의 정보를 가져오는 메서드
	public OrderDetailDto getOrderDetailsByMember(String order_num) {
		OrderDetailDto order = null;
		
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "SELECT * FROM order_detail WHERE order_num = ?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, order_num);
            rs = pstmt.executeQuery();

            if (rs.next()) {
            	order = new OrderDetailDto();
                order.setOrder_num(rs.getString("order_num"));
				order.setMem_num(rs.getString("mem_num"));
				order.setPro_num(rs.getString("pro_num"));
				order.setOrder_color(rs.getString("order_size"));	
				order.setOrder_size(rs.getString("order_color"));
				order.setOrder_detail_su(rs.getInt("order_detail_su"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }

        return order;
    }
	
	public List<OrderDetailDto> getOrderDetails(String order_num) {
	    List<OrderDetailDto> orders = new ArrayList<>();
	    
	    Connection conn = db.getConnection();
	    PreparedStatement pstmt = null;
	    ResultSet rs = null;

	    String sql = "SELECT * FROM order_detail WHERE order_num = ?";

	    try {
	        pstmt = conn.prepareStatement(sql);
	        pstmt.setString(1, order_num);
	        rs = pstmt.executeQuery();

	        while (rs.next()) {
	            OrderDetailDto order = new OrderDetailDto();
	            order.setOrder_num(rs.getString("order_num"));
	            order.setMem_num(rs.getString("mem_num"));
	            order.setPro_num(rs.getString("pro_num"));
	            order.setOrder_color(rs.getString("order_size"));  
	            order.setOrder_size(rs.getString("order_color"));
	            order.setOrder_detail_su(rs.getInt("order_detail_su"));
	            orders.add(order);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    } finally {
	        db.dbClose(rs, pstmt, conn);
	    }

	    return orders;
	}


	// 주문번호에 맞는 상품 전부 가져오기(list)
	public List<OrderDetailDto> getAllOrderDetail(String orderNum) {
		List<OrderDetailDto> list = new ArrayList<OrderDetailDto>();

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		//상품명, 사이즈옵션, 색상옵션, 개수
		String sql = "select p.pro_name, p.pro_price,p.pro_main_img, od.order_size, od.order_color, od.order_detail_su\n" +
				"from order_detail as od\n" +
				"left join product as p on p.pro_num = od.pro_num\n" +
				"where od.order_num = ?;";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, orderNum);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				OrderDetailDto dto = new OrderDetailDto();

				dto.setPro_name(rs.getString("p.pro_name"));
				dto.setPro_price(rs.getInt("p.pro_price"));
				dto.setOrder_size(rs.getString("od.order_size"));
				dto.setOrder_color(rs.getString("od.order_color"));
				dto.setOrder_detail_su(rs.getInt("od.order_detail_su"));
				dto.setPro_main_image(rs.getString("p.pro_main_img"));


				list.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return list;
	}

}
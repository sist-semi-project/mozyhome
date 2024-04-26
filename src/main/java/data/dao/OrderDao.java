package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import data.dto.CartDto;
import data.dto.OrderDto;
import data.dto.ProductDto;
import db.DbConnect;
import org.apache.commons.lang3.StringUtils;

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

	public int getOrderCount() {

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int count = 0;

		String sql = "select count(*) as count from order_info;";

		try {
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("count");
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return count;

	}

	public List<OrderDto> getAllOrderPagingForAdmin(int startIndex, int perPage) {
		List<OrderDto> list = new ArrayList<OrderDto>();

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql ="WITH OrderedDetails AS (\n" +
				"    SELECT\n" +
				"        o.order_date,\n" +
				"        o.order_num,\n" +
				"        od.pro_num,\n" +
				"        m.mem_name,\n" +
				"        o.order_name,\n" +
				"        o.order_total_payment,\n" +
				"        o.order_status,\n" +
				"        ROW_NUMBER() OVER (PARTITION BY o.order_num ORDER BY od.pro_num) AS rn,\n" +
				"        COUNT(od.pro_num) OVER (PARTITION BY o.order_num) AS details_count\n" +
				"    FROM\n" +
				"        order_info AS o\n" +
				"    LEFT JOIN\n" +
				"        order_detail AS od ON o.order_num = od.order_num\n" +
				"    LEFT JOIN\n" +
				"        member AS m ON o.mem_num = m.mem_num\n" +
				"),\n" +
				"ProductDetails AS (\n" +
				"    SELECT\n" +
				"        od.order_date,\n" +
				"        od.order_num,\n" +
				"        od.mem_name,\n" +
				"        p.pro_name,\n" +
				"        od.order_name,\n" +
				"        od.order_total_payment,\n" +
				"        od.order_status,\n" +
				"        od.details_count,\n" +
				"        CASE\n" +
				"            WHEN od.details_count > 1 THEN CONCAT(p.pro_name, ' 외 ', od.details_count - 1, ' 건')\n" +
				"            ELSE p.pro_name\n" +
				"        END AS display_pro_name\n" +
				"    FROM\n" +
				"        OrderedDetails AS od\n" +
				"    JOIN\n" +
				"        product AS p ON p.pro_num = od.pro_num\n" +
				"    WHERE\n" +
				"        od.rn = 1\n" +
				")\n" +
				"SELECT\n" +
				"    pd.order_date,\n" +
				"    pd.order_num,\n" +
				"    pd.mem_name,\n" +
				"    pd.display_pro_name,\n" +
				"    pd.order_name,\n" +
				"    pd.order_total_payment,\n" +
				"    pd.order_status,\n" +
				"    COUNT(*) OVER() AS total_count\n" +
				"FROM\n" +
				"    ProductDetails AS pd\n" +
				"order by pd.order_num limit ?,?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, startIndex);
			pstmt.setInt(2, perPage);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				OrderDto dto = new OrderDto();
				//주문일시, 주문번호, 상품명(전부)?,주문자(mem_name), 받는사람(order_name)명, 결제금액, 주문상태, 총컬럼개수

				dto.setOrder_date(rs.getTimestamp("pd.order_date"));
				dto.setOrder_num(rs.getString("pd.order_num"));
				dto.setMem_name(rs.getString("pd.mem_name"));
				dto.setPro_name(rs.getString("pd.display_pro_name"));
				dto.setOrder_name(rs.getString("pd.order_name"));
				dto.setOrder_total_payment(rs.getInt("pd.order_total_payment"));
				dto.setOrder_status(rs.getString("pd.order_status"));
				dto.setTotalCount(rs.getInt("total_count"));

				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}


		return list;
	}
	public List<OrderDto> getFilteredOrders(Map<String, Object> sqlParams) {
		List<OrderDto> list = new ArrayList<>();

		//페이지 변수
		int perPage = 8;
		int page = (Integer)sqlParams.get("page");
		int startIndex = perPage * page;

		//날짜 변수(null값일시 2024-01-05~2024-0715 세팅)
		String startDate = StringUtils.defaultIfBlank((String) sqlParams.get("startDate"), "2024-01-05");
		String endDate = StringUtils.defaultIfBlank((String) sqlParams.get("endDate"), "2024-07-15");

		String searchText = "%" + (String) sqlParams.get("searchText") + "%";
		String searchType = (String) sqlParams.get("searchType");

		String sql = buildDynamicSql(searchType); //orderer_name, product_name, order_num

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			pstmt = conn.prepareStatement(sql);
			// 인덱스를 1부터 증가시키며 파라미티값 세팅
			int paramIndex = 1;
			pstmt.setString(paramIndex++, startDate);
			pstmt.setString(paramIndex++, endDate);
			pstmt.setString(paramIndex++, searchText);
			pstmt.setInt(paramIndex++, startIndex);
			pstmt.setInt(paramIndex, perPage);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				OrderDto dto = new OrderDto();

				dto.setOrder_date(rs.getTimestamp("pd.order_date"));
				dto.setOrder_num(rs.getString("pd.order_num"));
				dto.setMem_name(rs.getString("pd.mem_name"));
				dto.setPro_name(rs.getString("pd.display_pro_name"));
				dto.setOrder_name(rs.getString("pd.order_name"));
				dto.setOrder_total_payment(rs.getInt("pd.order_total_payment"));
				dto.setOrder_status(rs.getString("pd.order_status"));
				dto.setTotalCount(rs.getInt("total_count"));

				list.add(dto);
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}

		return list;
	}

	private String buildDynamicSql(String searchType) {

		String sqlTemplate = "WITH OrderedDetails AS (\n" +
				"    SELECT\n" +
				"        o.order_date,\n" +
				"        o.order_num,\n" +
				"        m.mem_name,\n" +
				"        od.pro_num,\n" +
				"        o.order_name,\n" +
				"        o.order_total_payment,\n" +
				"        o.order_status,\n" +
				"        ROW_NUMBER() OVER (PARTITION BY o.order_num ORDER BY od.pro_num) AS rn,\n" +
				"        COUNT(od.pro_num) OVER (PARTITION BY o.order_num) AS details_count\n" +
				"    FROM\n" +
				"        order_info AS o\n" +
				"    LEFT JOIN\n" +
				"        order_detail AS od ON o.order_num = od.order_num\n" +
				"    LEFT JOIN\n" +
				"        member AS m ON o.mem_num = m.mem_num\n" +
				"),\n" +
				"ProductDetails AS (\n" +
				"    SELECT\n" +
				"        od.order_date,\n" +
				"        od.order_num,\n" +
				"        od.mem_name,\n" +
				"        p.pro_name,\n" +
				"        od.order_name,\n" +
				"        od.order_total_payment,\n" +
				"        od.order_status,\n" +
				"        od.details_count,\n" +
				"        CASE\n" +
				"            WHEN od.details_count > 1 THEN CONCAT(p.pro_name, ' 외 ', od.details_count - 1, ' 건')\n" +
				"            ELSE p.pro_name\n" +
				"        END AS display_pro_name\n" +
				"    FROM\n" +
				"        OrderedDetails AS od\n" +
				"    JOIN\n" +
				"        product AS p ON p.pro_num = od.pro_num\n" +
				"    WHERE\n" +
				"        od.rn = 1\n" +
				")\n" +
				"SELECT\n" +
				"    pd.order_date,\n" +
				"    pd.order_num,\n" +
				"    pd.mem_name,\n" +
				"    pd.display_pro_name,\n" +
				"    pd.order_name,\n" +
				"    pd.order_total_payment,\n" +
				"    pd.order_status,\n" +
				"    COUNT(*) OVER() AS total_count\n" +
				"FROM\n" +
				"    ProductDetails AS pd\n" +
				"where (pd.order_date between ? and ?) and %s like ? \n" +
				"order by pd.order_num limit ?,?;";


		//searchType //orderer_name, product_name, order_num
		if (searchType.equals("orderer_name")) {

			return String.format(sqlTemplate, "pd.mem_name");

		} else if (searchType.equals("product_name")) {

			return String.format(sqlTemplate, "pd.display_pro_name");
		} else if (searchType.equals("order_num")) {

			return String.format(sqlTemplate, "pd.order_num");
		}
		return null;

	}

	//다중 주문상태 변경
	public int updateOrderStatus(String orderStatus, String[] selectedOrders) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int totalUpdated = 0;

		try {
			conn = db.getConnection();

			// 주문 상태에 따라 SQL 문을 설정
			String sql = "";
			if (orderStatus.equals("waiting_for_payment")) {
				sql = "UPDATE order_info SET order_status = '입금대기' WHERE order_num = ?;";
			} else if (orderStatus.equals("payment_completed")) {
				sql = "UPDATE order_info SET order_status = '결제완료' WHERE order_num = ?;";
			} else if (orderStatus.equals("shipping")) {
				sql = "UPDATE order_info SET order_status = '배송중' WHERE order_num = ?;";
			} else if (orderStatus.equals("delivered")) {
				sql = "UPDATE order_info SET order_status = '배송완료' WHERE order_num = ?;";
			} else if (orderStatus.equals("order_cancelled")) {
				sql = "UPDATE order_info SET order_status = '주문취소' WHERE order_num = ?;";
			}

			pstmt = conn.prepareStatement(sql);

			for (String orderNum : selectedOrders) {
				pstmt.setString(1, orderNum);
				int updatedCount = pstmt.executeUpdate();
				if (updatedCount > 0) {
					totalUpdated += updatedCount;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException se) {
					se.printStackTrace();
				}
			}
		}
		return totalUpdated;
	}

	//관리자페이지 주문상세보기 정보를 위한 함수
	public OrderDto getOrderDetailForAdmin(String orderNum) {
		OrderDto dto = new OrderDto();

		Connection conn = db.getConnection();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		//주문시간, 주문번호, 주문자명, 받는사람(배송지명), 주문금액,배송메세지,배송주소,배송지전화번호, 주문상태
		String sql = "select o.order_date, o.order_num, m.mem_name, o.order_name, o.order_total_payment, o.order_delivery_request, o.order_addr,\n" +
				"o.order_hp, o.order_status\n" +
				"from order_info as o\n" +
				"left join member as m on o.mem_num = m.mem_num\n" +
				"where o.order_num = ?;";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, orderNum);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				dto.setOrder_date(rs.getTimestamp("o.order_date"));
				dto.setOrder_num(rs.getString("o.order_num"));
				dto.setMem_name(rs.getString("m.mem_name"));
				dto.setOrder_name(rs.getString("o.order_name"));
				dto.setOrder_total_payment(rs.getInt("o.order_total_payment"));
				dto.setOrder_delivery_request(rs.getString("o.order_delivery_request"));
				dto.setOrder_addr(rs.getString("o.order_addr"));
				dto.setOrder_hp(rs.getString("o.order_hp"));
				dto.setOrder_status(rs.getString("o.order_status"));
				dto.setOrder_num(rs.getString("o.order_num"));
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		return dto;
	}
}
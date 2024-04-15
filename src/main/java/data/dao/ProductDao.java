package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import java.sql.SQLException;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import data.dto.ProductDto;
import data.dto.WishlistDto;
import db.DbConnect;

public class ProductDao {

    DbConnect db = new DbConnect();
 
    //insert_product
    public void addProduct(ProductDto dto)
    {
        Connection conn=db.getConnection();
        PreparedStatement pstmt=null;

        //카테고리,상품명,상품설명,재고수량,가격,메인이미지1,서브이미지5,판매상태
        String sql="insert into product(cate_num,pro_name,pro_explain,pro_stock,pro_price,pro_size,pro_color,pro_main_img,pro_sub_img1," +
                "pro_sub_img2,pro_sub_img3,pro_sub_img4,pro_sub_img5,pro_sale_status)  values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

        try {
            pstmt=conn.prepareStatement(sql);

            pstmt.setString(1, dto.getCate_num());
            pstmt.setString(2, dto.getPro_name());
            pstmt.setString(3, dto.getPro_explain());
            pstmt.setInt(4, dto.getPro_stock());
            pstmt.setInt(5, dto.getPro_price());
            pstmt.setString(6, dto.getPro_size());
            pstmt.setString(7, dto.getPro_color());
            pstmt.setString(8, dto.getPro_main_img());
            pstmt.setString(9, dto.getPro_sub_img1());
            pstmt.setString(10, dto.getPro_sub_img2());
            pstmt.setString(11, dto.getPro_sub_img3());
            pstmt.setString(12, dto.getPro_sub_img4());
            pstmt.setString(13, dto.getPro_sub_img5());
            pstmt.setString(14,dto.getPro_sale_status());
            pstmt.execute();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }finally {
            db.dbClose(pstmt, conn);
        }
    }

}

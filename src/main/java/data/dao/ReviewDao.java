package data.dao;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.amazonaws.AmazonServiceException;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.oreilly.servlet.MultipartRequest;

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
			pstmt.setString(1, pro_num);
			rs=pstmt.executeQuery();
			
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
	
	public void insertReview(ReviewDto dto) {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql="insert into review (mem_num, pro_num, review_pyung, review_subject, review_content, review_image, review_writeday) values (?,?,?,?,?,?,now())";
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setInt(1, dto.getMem_num());
			pstmt.setInt(2, dto.getPro_num());
			pstmt.setInt(3, dto.getReview_pyung());
			pstmt.setString(4, dto.getReview_subject());
			pstmt.setString(5, dto.getReview_content());
			pstmt.setString(6, dto.getReview_image());
			pstmt.execute();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}	
	}

	
	public int getNum(String id)
	{
		int num=0;
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select mem_num from member where mem_id=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs=pstmt.executeQuery();
			
			if(rs.next())
				num=rs.getInt("mem_num");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(rs, pstmt, conn);
		}
		return num;
	}
	// 파일 업로드 및 URL 반환 함수 시작
	public String uploadFileToS3(MultipartRequest multiReq, String fileName, AmazonS3 s3Client, String bucketName) {
		File file = multiReq.getFile(fileName);
		if (file != null) {
			String fileKey = "review/" + file.getName(); // S3에서의 파일 경로 및 이름 설정

			try {
				// 파일을 S3 버킷에 업로드
				s3Client.putObject(new PutObjectRequest(bucketName, fileKey, file));

				// 업로드된 파일의 URL 반환
				return s3Client.getUrl(bucketName, fileKey).toString();
			} catch (AmazonServiceException e) {
				System.err.println(e.getErrorMessage());
				return null;
			}
		}	
		return null;
	}
	
}

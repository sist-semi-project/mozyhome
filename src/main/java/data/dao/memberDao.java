package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.dbTestDto;
import data.dto.memberDto;
import db.DbConnect;

public class memberDao {
	
	DbConnect db = new DbConnect();
	
	public void insertMember(memberDto dto) {
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		
		String sql = "insert into member values (null,?,?,?,?,?,?,?,?,?,?,?,?,now())";

		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, dto.getMem_id());
			pstmt.setString(2, dto.getMem_password());
			pstmt.setString(3, dto.getMem_name());
			pstmt.setString(4, dto.getMem_nickname());
			pstmt.setString(5, dto.getMem_hp());
			pstmt.setString(6, dto.getMem_zipcode());
			pstmt.setString(7, dto.getMem_address());
			pstmt.setString(8, dto.getMem_address_detail());
			pstmt.setString(9, dto.getMem_email());
			pstmt.setString(10, dto.getMem_birth());
			pstmt.setString(11, dto.getMem_gender());
			pstmt.setString(12, dto.getMem_is_active());

			
			pstmt.execute();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			db.dbClose(pstmt, conn);
		}
	}
	
	
	public String getName(String mem_id)
	{
		String name="";
		
		Connection conn=db.getConnection();
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql="select * from member where mem_id=?";
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, mem_id);
			rs=pstmt.executeQuery();
			
			if(rs.next())
				name=rs.getString("name");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			db.dbClose(rs, pstmt, conn);
		}
		
		
		return name;
	}
	
	
    // 전체 출력
    public List<memberDto> getAllDatas(){
        
        List<memberDto> list = new ArrayList<memberDto>();
        
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "select * from member order by mem_num ";
        
        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                
            	memberDto dto = new memberDto();
                
                dto.setMem_num(rs.getString("mem_num"));
                // 나머지 dto에 관련된 속성도 이와 같이 추가
                
                list.add(dto); // 리스트에 dto 추가
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
            
        }
        
        return list;
    }
    
    
    // 아이디 중복체크
    public int idCheck(String mem_id) {
        
        int a = 0;
        
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "select count(*) from member where mem_id =?";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,mem_id);
            rs=pstmt.executeQuery();
            
            if(rs.next()) {
                a = rs.getInt(1);    
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return a;
    }
    
    
    // 닉네임 중복체크
    public int nicknameCheck(String mem_nickname) {
        
        int b = 0;
        
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "select count(*) from member where mem_nickname =?";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,mem_nickname);
            rs=pstmt.executeQuery();
            
            if(rs.next()) {
                b = rs.getInt(1);    
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        return b;
    }
    
    
    // 로그인시 아이디와 비번체크
    public boolean isIdPass(String mem_id, String mem_password) {
        
        boolean b = false;
        
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "select * from member where mem_id=? and mem_password=?";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, mem_id);
            pstmt.setString(2, mem_password);
            rs= pstmt.executeQuery();
            
            if(rs.next()) 
                b=true;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);    
        }
        return b;
        
    }
    
    
    // 이름과 이메일을 기반으로 아이디 찾기
    public String findId(String mem_name, String mem_email) {
    	 Connection conn = db.getConnection();
         PreparedStatement pstmt = null;
         ResultSet rs = null;
		 String mid = null;
		
		try {
			String sql = "select mem_id from member where mem_name=? and mem_email=? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mem_name);
			pstmt.setString(2, mem_email);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				mid = rs.getString("mem_id");
			}
				
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mid;
	}
    
    
    // 이름, 아이디, 이메일를 기반으로 비밀번호 찾기
    public String findPw(String mem_name,String mem_id, String mem_email) {
        String mid = null;
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "select mem_password from member where mem_name=? and mem_id=? and mem_email=? ";
    
        try {
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, mem_name);
            pstmt.setString(2, mem_id);
            pstmt.setString(3, mem_email);
            
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                mid = rs.getString("mem_password");
            }
                
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mid;
    }
    
    
    // 이름, 아이디, 핸드폰 번호를 기반으로 이메일 조회
    public String getUserEmailByInfo(String mem_name, String mem_id,String mem_hp) {
        String memail = null;
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        
        String sql = "select mem_email from member where mem_name=? and mem_id =? and mem_hp =?";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1,mem_name);
            pstmt.setString(2, mem_id);
            pstmt.setString(3, mem_hp);
            rs = pstmt.executeQuery();
            
            if(rs.next()) {
                memail = rs.getString("mem_email");
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
            
        }
        return memail;
        
    }
    
    
}
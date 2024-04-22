package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import data.dto.MemberDto;
import data.dto.MemberDto;
import db.DbConnect;

public class MemberDao {
	
	DbConnect db= new DbConnect();
		
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
	
	public void insertMember(MemberDto dto) {
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
    public List<MemberDto> getAllDatas(){
        
        List<MemberDto> list = new ArrayList<MemberDto>();
        
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "select * from member order by mem_num ";
        
        try {
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            
            while(rs.next()) {
                
            	MemberDto dto = new MemberDto();
                
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

    public static void main(String[] args) {
        MemberDao dao = new MemberDao();
        MemberDto dto = new MemberDto();

        String id = "test";
        String pw = "pw1234";
        String name = "김테일";
        String nickname = "드래곤1";
        String hp = "010-1234-5678";
        String zipcode = "1234";
        String address = "서울특별시 강남구 테헤란로 127 그레이스타워";
        String address_detail = "123동 456호";
        String email = "test";
        String birth = "2024-04-22";
        String[] gender = {"남자","여자","선택안함"};
        String[] is_active = {"Y","N"};

        String sql = "insert into member values (null,?,?,?,?,?,?,?,?,?,?,?,?,now())";

        DbConnect db= new DbConnect();
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;



        for (int i = 1; i < 100; i++) {
            try {
                pstmt = conn.prepareStatement(sql);

                pstmt.setString(1, id+(i+1));
                pstmt.setString(2, pw);
                pstmt.setString(3, name+(i+1));
                pstmt.setString(4, nickname+(i+1));
                pstmt.setString(5, hp);
                pstmt.setString(6, zipcode+(i%10));
                pstmt.setString(7, address);
                pstmt.setString(8, address_detail);
                pstmt.setString(9, email+(i+1)+"@naver.com");
                pstmt.setString(10, birth);
                pstmt.setString(11, gender[i%3]);
                pstmt.setString(12, is_active[i%2]);

            } catch (SQLException e) {
                e.printStackTrace();
            }finally {
                db.dbClose(pstmt, conn);
            }

        }

        }




    
    	
	
	
}

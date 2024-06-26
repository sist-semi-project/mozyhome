package data.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import com.mysql.cj.jdbc.ConnectionImpl;
import data.dto.MemberDto;
import data.dto.MemberDto;
import db.DbConnect;
import oracle.jdbc.proxy.annotation.Pre;
import org.apache.commons.lang3.StringUtils;

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
				name=rs.getString("mem_name");
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


    // 2024-04-18 추가
    // 구매자 정보 가져오기 (mem_id를 이용하여)
    public MemberDto getMemberInfo(String mem_id) {
        MemberDto memberDto = null;
        
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        
        String sql = "SELECT * FROM member WHERE mem_id = ?";
        
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, mem_id);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                memberDto = new MemberDto();
                memberDto.setMem_num(rs.getString("mem_num"));
                memberDto.setMem_id(rs.getString("mem_id"));
                memberDto.setMem_name(rs.getString("mem_name"));
                memberDto.setMem_nickname(rs.getString("mem_nickname"));
                memberDto.setMem_hp(rs.getString("mem_hp"));
                memberDto.setMem_zipcode(rs.getString("mem_zipcode"));
                memberDto.setMem_address(rs.getString("mem_address"));
                memberDto.setMem_address_detail(rs.getString("mem_address_detail"));
                memberDto.setMem_email(rs.getString("mem_email"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(rs, pstmt, conn);
        }
        
        return memberDto;
    }

    public int getMemberCount() {

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int count = 0;

        String sql = "select count(*) as count from member;";

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

    public List<MemberDto> getAllMemberPagingForAdmin(int startIndex, int perPage) {
        List<MemberDto> list = new ArrayList<MemberDto>();

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        //회원번호/이름/아이디/닉네임/이메일/성별/가입일/탈퇴여부/구매/관리
        String sql ="select m.mem_num, m.mem_name, m.mem_id, m.mem_nickname, m.mem_email,\n" +
                " m.mem_gender, m.mem_gaipday, m.mem_is_active, count(o.mem_num) as buy_count, count(*) OVER() as total_count\n" +
                " from member as m\n" +
                " left join order_detail as o on m.mem_num = o.mem_num\n" +
                " group by m.mem_num \n"+
                " order by m.mem_num limit ?,?";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, startIndex);
            pstmt.setInt(2, perPage);
            rs = pstmt.executeQuery();

            while (rs.next()) {
                MemberDto dto = new MemberDto();
                //회원번호/이름/아이디/닉네임/이메일/성별/가입일/탈퇴여부/구매/관리
                dto.setMem_num(rs.getString("m.mem_num"));
                dto.setMem_name(rs.getString("m.mem_name"));
                dto.setMem_id(rs.getString("m.mem_id"));
                dto.setMem_nickname(rs.getString("m.mem_nickname"));
                dto.setMem_email(rs.getString("m.mem_email"));
                dto.setMem_gender(rs.getString("m.mem_gender"));
                dto.setMem_gaipday(rs.getTimestamp("m.mem_gaipday"));
                dto.setMem_is_active(rs.getString("m.mem_is_active"));
                dto.setBuyCount(rs.getInt("buy_count"));
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

    public List<MemberDto> getFilteredMembers(Map<String, Object> sqlParams) {
        List<MemberDto> list = new ArrayList<>();

        //페이지 변수
        int perPage = 8;
        int page = (Integer)sqlParams.get("page");
        int startIndex = perPage * page;

        //날짜 변수(null값일시 2024-01-05~2024-0715 세팅)
        String startDate = StringUtils.defaultIfBlank((String) sqlParams.get("startDate"), "2024-01-05");
        String endDate = StringUtils.defaultIfBlank((String) sqlParams.get("endDate"), "2024-07-15");

        String searchText = "%" + (String) sqlParams.get("searchText") + "%";
        String searchType = (String) sqlParams.get("searchType");

        //회원 상태
        String[] memberStatus = (String[]) sqlParams.get("memberStatus");

        String sql = buildDynamicSql(memberStatus, searchType);

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            pstmt = conn.prepareStatement(sql);

            // 인덱스를 1부터 증가시키며 파라미티값 세팅
            int paramIndex = 1;
            pstmt.setString(paramIndex++, startDate);
            pstmt.setString(paramIndex++, endDate);
            for (String status : memberStatus) {
                pstmt.setString(paramIndex++, status);
            }
            pstmt.setString(paramIndex++, searchText);
            pstmt.setInt(paramIndex++, startIndex);
            pstmt.setInt(paramIndex, perPage);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                MemberDto dto = new MemberDto();
                //회원번호/이름/아이디/닉네임/이메일/성별/가입일/탈퇴여부/구매/관리
                dto.setMem_num(rs.getString("m.mem_num"));
                dto.setMem_name(rs.getString("m.mem_name"));
                dto.setMem_id(rs.getString("m.mem_id"));
                dto.setMem_nickname(rs.getString("m.mem_nickname"));
                dto.setMem_email(rs.getString("m.mem_email"));
                dto.setMem_gender(rs.getString("m.mem_gender"));
                dto.setMem_gaipday(rs.getTimestamp("m.mem_gaipday"));
                dto.setMem_is_active(rs.getString("m.mem_is_active"));
                dto.setBuyCount(rs.getInt("buy_count"));
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

    private String buildDynamicSql(String[] memberStatus, String searchType) {

        String sqlTemplate = "select m.mem_num, m.mem_name, m.mem_id, m.mem_nickname, m.mem_email,\n" +
                "m.mem_gender, m.mem_gaipday, m.mem_is_active, count(o.mem_num) as buy_count,\n" +
                "count(*) OVER() as total_count\n" +
                "from member as m\n" +
                "left join order_detail as o on m.mem_num = o.mem_num\n" +
                "where (m.mem_gaipday BETWEEN ? AND ?) AND m.mem_is_active IN (%s) AND %s like ? \n" +
                "group by m.mem_num\n" +
                "order by m.mem_num limit ?,?";

        // 멤버상태(가입,탈퇴,둘다)에 따라 ?배열 생성후 ","으로 연결(join)
        String memberStatusPlaceholders = String.join(", ", Collections.nCopies(memberStatus.length, "?"));


        //searchType // id,name,nickname,email
        if (searchType.equals("id")) {
            
            return String.format(sqlTemplate, memberStatusPlaceholders, "m.mem_id");
            
        } else if (searchType.equals("name")) {
            
            return String.format(sqlTemplate, memberStatusPlaceholders, "m.mem_name");
        } else if (searchType.equals("nickname")) {
            
            return String.format(sqlTemplate, memberStatusPlaceholders, "m.mem_nickname");
        } else if (searchType.equals("email")) {

            return String.format(sqlTemplate, memberStatusPlaceholders, "m.mem_email");
        }
        return null;

    }

    public MemberDto getOneMemberDetail(String num) {
        MemberDto dto = new MemberDto();

        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        String sql = "select m.mem_num, m.mem_name, m.mem_id, m.mem_nickname,m.mem_birth,m.mem_hp, m.mem_email,\n" +
                "m.mem_gender, m.mem_zipcode, m.mem_address, m.mem_address_detail, \n" +
                " m.mem_gaipday, count(distinct o.order_num) as buy_count, count(distinct r.review_num) as review_count\n" +
                "from member as m\n" +
                "left join order_detail as o on m.mem_num = o.mem_num\n" +
                "left join review as r on m.mem_num = r.mem_num\n" +
                "group by m.mem_num\n" +
                "having m.mem_num = ?;";

        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, num);

            rs = pstmt.executeQuery();

            while (rs.next()) {
                dto.setMem_num(rs.getString("m.mem_num"));
                dto.setMem_name(rs.getString("m.mem_name"));
                dto.setMem_id(rs.getString("m.mem_id"));
                dto.setMem_nickname(rs.getString("m.mem_nickname"));
                dto.setMem_birth(rs.getString("m.mem_birth"));
                dto.setMem_hp(rs.getString("m.mem_hp"));
                dto.setMem_email(rs.getString("m.mem_email"));
                dto.setMem_gender(rs.getString("m.mem_gender"));
                dto.setMem_zipcode(rs.getString("m.mem_zipcode"));
                dto.setMem_address(rs.getString("m.mem_address"));
                dto.setMem_address_detail(rs.getString("m.mem_address_detail"));
                dto.setMem_gaipday(rs.getTimestamp("m.mem_gaipday"));
                dto.setBuyCount(rs.getInt("buy_count"));
                dto.setReviewCount(rs.getInt("review_count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            db.dbClose(rs, pstmt, conn);
        }
        return dto;
    }

	
	// 2024-04-23 추가
    // 회원정보수정
    
    public boolean updateMember(MemberDto member) {
    	Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            String sql = "UPDATE member SET mem_password=?, mem_name=?, mem_nickname=?, mem_zipcode=?, mem_address=?, mem_address_detail=?, mem_hp=? WHERE mem_id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, member.getMem_password());
            pstmt.setString(2, member.getMem_name());
            pstmt.setString(3, member.getMem_nickname());
            pstmt.setString(4, member.getMem_zipcode());
            pstmt.setString(5, member.getMem_address());
            pstmt.setString(6, member.getMem_address_detail());
            pstmt.setString(7, member.getMem_hp());
            pstmt.setString(8, member.getMem_id());
            
            int rowsAffected = pstmt.executeUpdate();
            
            // 업데이트 성공 여부 확인
            if(rowsAffected > 0) {
                success = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
        	db.dbClose(pstmt, conn);
        }
        
        return success;
    }
    
    // 회원 탈퇴 메서드
    public boolean deleteMember(String mem_id) {
    	
        Connection conn = db.getConnection();
        PreparedStatement pstmt = null;
        boolean success = false;
        
        try {
            String sql = "UPDATE member SET mem_is_active = 'N' WHERE mem_id = ?"; 
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, mem_id);
            int rowsAffected = pstmt.executeUpdate();
            
            // 삭제가 성공적으로 이루어졌는지 확인
            if(rowsAffected > 0) {
                success = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            db.dbClose(pstmt, conn);
        }
        
        return success;
    }

}
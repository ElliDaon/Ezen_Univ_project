package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.domain.MemberVo;

public class AdminDao {
	
	private Connection conn; 
	private PreparedStatement pstmt;
	
	public AdminDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();
	}
	
	public ArrayList<MemberVo> studentAll(){
		ArrayList<MemberVo> slist = new ArrayList<MemberVo>();
		ResultSet rs = null;
		
		String sql = "select sidx, s_name,s_birth,s_email,s_major from student where s_yn='N' order by sidx desc";
		
		try{
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MemberVo mv = new MemberVo();
				
				mv.setSidx( rs.getInt("sidx") ); 
				mv.setS_name( rs.getString("s_name") );
				mv.setS_birth( rs.getInt("s_birth"));
				mv.setS_email( rs.getString("s_email"));
				mv.setS_major( rs.getString("s_major"));
				
				slist.add(mv);
			}
		}catch(Exception e){
			e.printStackTrace();		
		}finally{
			try{
				//rs.close();
				//pstmt.close();
				//conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return slist;
	}
	public ArrayList<MemberVo> professorAll(){
		ArrayList<MemberVo> plist = new ArrayList<MemberVo>();
		ResultSet rs = null;
		
		String sql = "select pidx, p_name,p_birth,p_email,p_major from professor where p_yn='N' order by pidx desc";
		
		try{
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MemberVo mv = new MemberVo();
				
				mv.setPidx( rs.getInt("pidx") ); 
				mv.setP_name( rs.getString("p_name") );
				mv.setP_birth( rs.getInt("p_birth"));
				mv.setP_email( rs.getString("p_email"));
				mv.setP_major( rs.getString("p_major"));
				
				plist.add(mv);
			}
		}catch(Exception e){
			e.printStackTrace();		
		}finally{
			try{
				//rs.close();
				//pstmt.close();
				//conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return plist;
	}

	public int studentAccept(int sidx) {
		int exec = 0;
		String sql = "update student set s_yn='Y' where sidx=?";
		
		try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, sidx);
		exec = pstmt.executeUpdate();
		
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return exec;
	}
	
	public int professorAccept(int pidx) {
		int exec = 0;
		String sql = "update professor set p_yn='Y' where pidx=?";
		
		try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, pidx);
		exec = pstmt.executeUpdate();
		
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return exec;
	}
	
	public int studentDeny(int sidx) {
		int exec = 0;
		String sql = "delete from student where sidx=?";
		
		try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, sidx);
		exec = pstmt.executeUpdate();
		
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return exec;
	}
	
	public int professorDeny(int pidx) {
		int exec = 0;
		String sql = "delete from professor where pidx=?";
		
		try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, pidx);
		exec = pstmt.executeUpdate();
		
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return exec;
	}
	
	public int studentCheckedAccept(int[] selectedData) {
		int exec=0;
		String sql = "update student set s_yn='Y' where sidx=?";
		
		try{
			pstmt = conn.prepareStatement(sql);
			for (int value : selectedData) {
                pstmt.setInt(1, value);
                int rowsAffected = pstmt.executeUpdate();
                exec += rowsAffected;
            }
		}catch (SQLException e) {
            // 예외 처리
            e.printStackTrace();
        }finally {
            // 리소스 해제
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
		return exec;
		
	}

	public int studentCheckedADeny(int[] selectedData) {
		int exec=0;
		String sql = "delete from professor where pidx=?";
		
		try{
			pstmt = conn.prepareStatement(sql);
			for (int value : selectedData) {
                pstmt.setInt(1, value);
                int rowsAffected = pstmt.executeUpdate();
                exec += rowsAffected;
            }
		}catch (SQLException e) {
            // 예외 처리
            e.printStackTrace();
        }finally {
            // 리소스 해제
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
		return exec;
		
	}
	
}

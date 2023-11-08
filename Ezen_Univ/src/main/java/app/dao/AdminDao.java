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
			//rs.next() -> 다음값이 있는지 확인하는 메서드(있으면 true, 없으면 false)
			while(rs.next()){
				MemberVo mv = new MemberVo();
				//rs에서 값 꺼내서 mv에 옮겨담는다.
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
			//rs.next() -> 다음값이 있는지 확인하는 메서드(있으면 true, 없으면 false)
			while(rs.next()){
				MemberVo mv = new MemberVo();
				//rs에서 값 꺼내서 mv에 옮겨담는다.
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
	
}

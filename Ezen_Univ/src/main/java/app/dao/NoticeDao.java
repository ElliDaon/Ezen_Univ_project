package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.domain.CourseVo;
import app.domain.NoticeVo;



//DB  접근해서 데이터를 가져온다
public class NoticeDao {

	//멤버변수 선언하고 전역으로 활용한다
	private Connection conn;  //멤버변수는 선언만해도 자동초기화됨
	private PreparedStatement pstmt;
		
		//생성자를 만든다
	public NoticeDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();
	}	
	
	
	public int noticeWrite(NoticeVo nv){
		int exec = 0;
		
		String sql = "insert into notice(n_skipdate, n_category, n_contents, n_count, pidx, cidx, n_delyn)\r\n"
				+ "VALUES(?,?,?,0,?,?,'N')";
	
		
		try{

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, nv.getN_skipdate());
		pstmt.setString(2, nv.getN_category());
		pstmt.setString(3, nv.getN_contents());	
		pstmt.setInt(4, nv.getPidx());
		pstmt.setInt(5, nv.getCidx());
		

		exec = pstmt.executeUpdate();
		

		
		}catch(Exception e){
			
			e.printStackTrace();
		}
		return exec;	
	}
	
	public String getDate(){
		String SQL = "SELECT NOW()";
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "";
 	}
	
	public int getNext(){
		String SQL = "SELECT nidx FROM notice ORDER BY nidx DESC";
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
 	}
	
	public ArrayList<CourseVo> courselist(int pidx){
		ArrayList<CourseVo> courselist = new ArrayList<>();
		ResultSet rs = null;
		
		
		String SQL ="SELECT cidx,c_name from course where pidx=?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, pidx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CourseVo cv = new CourseVo();
				cv.setCidx(rs.getInt("cidx")); 
				cv.setC_name(rs.getString("c_name"));
				courselist.add(cv);
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return courselist;
	}
	
}

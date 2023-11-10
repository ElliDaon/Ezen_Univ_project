package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.domain.CourseVo;
import app.domain.NoticeVo;
import app.domain.SearchCriteria;




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
	public ArrayList<NoticeVo> getList(int pidx,SearchCriteria scri){
		ResultSet rs = null;
		String str= "";
		if (scri.getSubject()!=0) {
			str = " and B.cidx="+scri.getSubject()+"\r\n";
		}	
		String SQL = "SELECT nidx,CONCAT('[',A.n_category,']','[',A.n_skipdate,']','[',B.c_name,']') as subject,A.n_writeday,A.n_count\r\n"
				+ "FROM notice A\r\n"
				+ "join course B\r\n"
				+ "on A.cidx = B.cidx\r\n"
				+ "where A.pidx = ? and A.n_delyn = 'N'\r\n"
				+str
				+ "order by nidx desc limit ?,?";
				
				ArrayList<NoticeVo> alist = new ArrayList<NoticeVo>();
		
		
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			
			
			pstmt.setInt(1, pidx);
			pstmt.setInt(2, (scri.getPage()-1)*scri.getPerPageNum());
			pstmt.setInt(3, scri.getPerPageNum());
			rs = pstmt.executeQuery();
			while(rs.next()) {
				NoticeVo nv = new NoticeVo();
				nv.setNidx(rs.getInt("nidx"));
				nv.setN_subject(rs.getString("subject"));
				nv.setN_writeday(rs.getString("A.n_writeday"));
				nv.setN_count(rs.getInt("A.n_count"));
				
				alist.add(nv);
				
			}
			
		}catch(Exception e) {
			
			e.printStackTrace();
		}finally{
			try{
				rs.close();
				pstmt.close();
				//conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return alist;
	}
	public int boardTotalCount(SearchCriteria scri){
		int value=0;  // 결과값이 0인지 아닌지
		
		String str= "";
		if (scri.getSubject()!=0) {
			str =" and cidx="+scri.getSubject();
		}		
		
		String sql="select count(*) as cnt from notice where n_delyn='N' "+str;
		ResultSet rs = null;
		try{
			pstmt = conn.prepareStatement(sql);			
			rs = pstmt.executeQuery();
			
			if (rs.next()){
				value =	rs.getInt("cnt");
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			try{
				rs.close();
				pstmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		//System.out.println("DAO 안에 value"+value);
		return value;
	}	
	public NoticeVo boardSelectOne(int nidx) {
		NoticeVo nv = null;
		String sql="select * from notice A\r\n"
				+ "join course B\r\n"
				+ "on A.cidx = B.cidx\r\n"
				+ "where nidx=?";
		PreparedStatement pstmt= null;
		ResultSet rs = null;
		//향상된 구문클래스를 꺼낸다
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, nidx);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				//bv생성하고 결과값 옮겨담기
				nv = new NoticeVo();
			
				nv.setNidx(rs.getInt("nidx"));
				nv.setN_skipdate(rs.getString("n_skipdate"));
				nv.setN_category(rs.getString("n_category"));
				nv.setN_contents(rs.getString("n_contents"));
				nv.setN_writeday(rs.getString("n_writeday"));
				nv.setN_count(rs.getInt("n_count"));
				nv.setPidx(rs.getInt("pidx"));
				nv.setCidx(rs.getInt("cidx"));
				nv.setC_name(rs.getString("B.c_name"));

				
				
			}			
		} catch (SQLException e) {			
			e.printStackTrace();
		}finally{
			try{
				rs.close();
				pstmt.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}	
		
		return nv;
	}
	
	public int NoticeCntUpdate(int nidx){
		int exec = 0;		
	
		String sql ="update Notice set\r\n"
				+ "n_count = n_count+1\r\n"
				+ "where nidx = ?";
		
		try{		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, nidx);		
		exec = pstmt.executeUpdate();	
		
		}catch(Exception e){			
			e.printStackTrace();
		}
		return exec;	
	}
	public int noticeDelete(int nidx){
		int exec = 0;		
	
		String sql ="update notice set \r\n"
				+ "n_delyn = 'Y'\r\n"
				+ "where nidx = ?";
		
		try{		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, nidx);	
		
		exec = pstmt.executeUpdate();	
		
		}catch(Exception e){			
			e.printStackTrace();
		}
		return exec;	
	}
}

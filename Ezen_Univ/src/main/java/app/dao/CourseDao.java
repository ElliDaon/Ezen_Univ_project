package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.domain.CourseVo;

public class CourseDao {

	private Connection conn; 
	private PreparedStatement pstmt;

	public CourseDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();
	}
	
	public int professorCourseList(int pidx){
		
		
		int exec = 0;

		String sql = "select ct_year, ct_semester, c_name, c_major, c_grade, c_sep, c_score, ct_room, ct_week, pe_period "+
				"from course c join coursetime t"+
				"where c.cidx=t.cidx and pidx=?"
;
				try{
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,pidx);


				exec = pstmt.executeUpdate();
				} catch(Exception e){
					e.printStackTrace();
				}
		
		return exec;
	}
	public ArrayList<CourseVo> studentCourseList(int sidx){
		ArrayList<CourseVo> list = new ArrayList<>();
		ResultSet rs;
		
		String sql= "select A.c_name,A.c_major,A.c_grade, P.p_name,A.c_sep,A.c_score, D.ct_room, group_concat(distinct D.ct_week,D.pe_period) as times \r\n"
				+ "	from course A\r\n"
				+ "	join coursetime D on A.cidx = D.cidx\r\n"
				+ "	join professor P on P.pidx = A.pidx\r\n"
				+ "	join courselist cl on cl.cidx = A.cidx where cl.sidx=?\r\n"
				+ "	group by A.c_name,D.ct_room,A.c_major,A.c_sep,A.c_grade,A.c_score,P.p_name";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sidx);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CourseVo cv = new CourseVo();
				
				cv.setC_name(rs.getString("A.c_name"));
				cv.setC_major(rs.getString("A.c_major"));
				cv.setC_grade(rs.getInt("A.c_grade"));
				cv.setP_name(rs.getString("P.p_name"));
				cv.setC_sep(rs.getString("A.c_sep"));
				cv.setC_score(rs.getInt("A.c_score"));
				cv.setCt_room(rs.getString("D.ct_room"));
				cv.setC_times(rs.getString("times"));
				list.add(cv);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
}

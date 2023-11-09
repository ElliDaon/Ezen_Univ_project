package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.domain.AttendanceVo;

public class AttendanceDao {

	private Connection conn; 
	private PreparedStatement pstmt;

	public AttendanceDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();
	}
	

	public ArrayList<AttendanceVo> attendanceCourseList(int sidx){
		ArrayList<AttendanceVo> list = new ArrayList<>();
		ResultSet rs;
		String sql= "select A.c_sep, A.c_name, A.c_score, P.p_name, D.ct_room, group_concat(distinct D.ct_week,D.pe_period) as times\r\n"
				+ "from course A\r\n"
				+ "join coursetime D on A.cidx = D.cidx\r\n"
				+ "join professor P on P.pidx = A.pidx\r\n"
				+ "join courselist cl on cl.cidx = A.cidx where cl.sidx= ? \r\n"
				+ "group by A.c_sep, A.c_name, A.c_score, P.p_name, D.ct_room";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sidx);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AttendanceVo av = new AttendanceVo();
				
				av.setC_sep(rs.getString("A.c_sep"));
				av.setC_name(rs.getString("A.c_name"));
				av.setC_score(rs.getInt("A.c_score"));
				av.setP_name(rs.getString("P.p_name"));
				av.setCt_room(rs.getString("D.ct_room"));
				av.setC_times(rs.getString("times"));
				list.add(av);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
}

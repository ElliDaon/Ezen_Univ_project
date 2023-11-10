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
	
	public ArrayList<AttendanceVo> attendanceCourseList(int sidx) {
		
		ArrayList<AttendanceVo> list = new ArrayList<>();
		ResultSet rs;
		String sql= "select A.c_sep, A.cidx, A.c_name, A.c_score, P.p_name, D.ct_room, group_concat(distinct D.ct_week,D.pe_period) as times\r\n"
				+ "	from course A\r\n"
				+ "	join coursetime D on A.cidx = D.cidx\r\n"
				+ "	join professor P on P.pidx = A.pidx\r\n"
				+ "	join courselist cl on cl.cidx = A.cidx where cl.sidx=?\r\n"
				+ "	group by A.c_sep, A.cidx, A.c_name, A.c_score, P.p_name, D.ct_room\r\n"
				+ "order by 3";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sidx);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AttendanceVo av = new AttendanceVo();
				
				av.setC_sep(rs.getString("A.c_sep"));
				av.setCidx(rs.getInt("A.cidx"));
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
	
	public ArrayList<AttendanceVo> attendanceList(int sidx, int cidx) {
		
		ArrayList<AttendanceVo> alist = new ArrayList<>();
		ResultSet rs;
		String sql= "select t.widx, concat(date_format(t.a_date,'%m'),'월 ',date_format(t.a_date,'%d'),'일') as atdate,\r\n"
				+ "      concat(P.pe_start,' ~ ' ,P.pe_end) as attime, t.e_attendance\r\n"
				+ "from period P\r\n"
				+ "join\r\n"
				+ "   (select A.widx, A.a_date, D.pe_period, B.e_attendance\r\n"
				+ "   from attendance A\r\n"
				+ "      join course C on A.cidx = C.cidx\r\n"
				+ "      join Eachcheck B on B.aidx = A.aidx\r\n"
				+ "      join coursetime D on A.ctidx = D.ctidx\r\n"
				+ "      join courselist cl on cl.clidx = A.clidx\r\n"
				+ "   where C.cidx=? and cl.sidx=?\r\n"
				+ "   group by A.widx, A.a_date,D.pe_period,B.e_attendance) t\r\n"
				+ "on P.pe_period = t.pe_period";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sidx);
			pstmt.setInt(2, cidx);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AttendanceVo av = new AttendanceVo();
				
				av.setWidx(rs.getInt("T.widx"));
				av.setAtdate(rs.getString("atdate"));
				av.setAttime(rs.getString("attime"));
				av.setE_attendance(rs.getString("T.e_attendance"));
				alist.add(av);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return alist;
	}
	
	public AttendanceVo attendanceCount(int sidx, int cidx) {

		AttendanceVo av = new AttendanceVo();
		ResultSet rs;
		String sql= "select count(*) as attendance\r\n"
				+ "from attendance A\r\n"
				+ "	join course C on A.cidx = C.cidx\r\n"
				+ "	join Eachcheck B on B.aidx = A.aidx\r\n"
				+ "	join courselist cl on cl.clidx = A.clidx\r\n"
				+ "	where C.cidx=? and cl.sidx=? and B.e_attendance='출석'";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sidx);
			pstmt.setInt(2, cidx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				av.setAttendanceCount(rs.getInt("attendance"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return av;
	}
	
	public AttendanceVo lateCount(int sidx, int cidx) {

		AttendanceVo alv = new AttendanceVo();
		ResultSet rs;
		String sql= "select count(*) as late\r\n"
				+ "from attendance A\r\n"
				+ "	join course C on A.cidx = C.cidx\r\n"
				+ "	join Eachcheck B on B.aidx = A.aidx\r\n"
				+ "	join courselist cl on cl.clidx = A.clidx\r\n"
				+ "	where C.cidx=? and cl.sidx=? and B.e_attendance='지각'";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sidx);
			pstmt.setInt(2, cidx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				alv.setLateCount(rs.getInt("late"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return alv;
	}
	
	public AttendanceVo leaveCount(int sidx, int cidx) {

		AttendanceVo alev = new AttendanceVo();
		ResultSet rs;
		String sql= "select count(*) as leave\r\n"
				+ "from attendance A\r\n"
				+ "	join course C on A.cidx = C.cidx\r\n"
				+ "	join Eachcheck B on B.aidx = A.aidx\r\n"
				+ "	join courselist cl on cl.clidx = A.clidx\r\n"
				+ "	where C.cidx=? and cl.sidx=? and B.e_attendance='조퇴'";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sidx);
			pstmt.setInt(2, cidx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				alev.setLeaveCount(rs.getInt("leave"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return alev;
	}
	
	public AttendanceVo absentCount(int sidx, int cidx) {

		AttendanceVo abv = new AttendanceVo();
		ResultSet rs;
		String sql= "select count(*) as absent\r\n"
				+ "from attendance A\r\n"
				+ "	join course C on A.cidx = C.cidx\r\n"
				+ "	join Eachcheck B on B.aidx = A.aidx\r\n"
				+ "	join courselist cl on cl.clidx = A.clidx\r\n"
				+ "	where C.cidx=? and cl.sidx=? and B.e_attendance='결석'";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sidx);
			pstmt.setInt(2, cidx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				abv.setAbsentCount(rs.getInt("absent"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return abv;
	}
}

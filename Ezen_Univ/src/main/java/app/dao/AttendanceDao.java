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
	
	public ArrayList<AttendanceVo> attendanceCourseList_s(int sidx, int year, int semester) {
		
		ArrayList<AttendanceVo> slist = new ArrayList<>();
		ResultSet rs;
		String sql= "select ra.c_sep, ra.cidx, ra.c_name, ra.c_score, ra.p_name, ra.ct_room, ra.times, rb.abpercent, rb.abyn from\r\n"
				+ "(select A.c_sep, A.cidx, A.c_name, A.c_score, P.p_name, D.ct_room, group_concat(distinct D.ct_week, D.pe_period separator ' , ') as times\r\n"
				+ "from course A join coursetime D on A.cidx = D.cidx\r\n"
				+ "join professor P on P.pidx = A.pidx\r\n"
				+ "join courselist cl on cl.cidx = A.cidx\r\n"
				+ "where cl.sidx=? and D.ct_year=? and D.ct_semester=?\r\n"
				+ "group by A.c_sep, A.cidx, A.c_name, A.c_score, P.p_name, D.ct_room\r\n"
				+ "order by 3) ra\r\n"
				+ "join (SELECT DISTINCT c.c_name,\r\n"
				+ "CONCAT( round(((SELECT COUNT(*) FROM courselist cl JOIN eachcheck ec ON cl.clidx = ec.clidx\r\n"
				+ "WHERE cl.cidx = c.cidx AND cl.sidx = ? AND ec.e_attendance = '결석') / c.c_totaltime * 100),1),'%') as abpercent,\r\n"
				+ "CASE WHEN (SELECT COUNT(*) FROM courselist cl JOIN eachcheck ec ON cl.clidx = ec.clidx\r\n"
				+ "WHERE cl.cidx = c.cidx AND cl.sidx = ? AND ec.e_attendance = '결석') / c.c_totaltime > 0.25 THEN 'Y' ELSE 'N' END as abyn\r\n"
				+ "FROM course c JOIN courselist cl ON c.cidx = cl.cidx) rb on ra.c_name=rb.c_name";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sidx);
			pstmt.setInt(2, year);
			pstmt.setInt(3, semester);
			pstmt.setInt(4, sidx);
			pstmt.setInt(5, sidx);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AttendanceVo av = new AttendanceVo();
				
				av.setC_sep(rs.getString("Ra.c_sep"));
				av.setCidx(rs.getInt("Ra.cidx"));
				av.setC_name(rs.getString("Ra.c_name"));
				av.setC_score(rs.getInt("Ra.c_score"));
				av.setP_name(rs.getString("Ra.p_name"));
				av.setCt_room(rs.getString("Ra.ct_room"));
				av.setC_times(rs.getString("Ra.times"));
				av.setAbpercent(rs.getString("Rb.abpercent"));
				av.setAbyn(rs.getString("Rb.abyn"));
				slist.add(av);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return slist;
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
				+ "on P.pe_period = t.pe_period\r\n"
				+ "order by 1,2,3";
		
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
	
	public ArrayList<AttendanceVo> attendanceCourseList_p(int pidx, int year, int semester) {
		
		ArrayList<AttendanceVo> plist = new ArrayList<>();
		ResultSet rs;
		String sql= "select a.c_sep, a.cidx, a.c_name, a.c_major, a.c_grade, b.ct_room, b.times, a.s_cnt\r\n"
				+ "from\r\n"
				+ "(select c.cidx, c.c_sep, c.c_name, c.c_major, c.c_grade, count(DISTINCT cl.sidx) as s_cnt\r\n"
				+ "from professor p\r\n"
				+ "join course c on p.pidx = c.pidx\r\n"
				+ "join courselist cl on cl.cidx=c.cidx\r\n"
				+ "join coursetime ct on ct.cidx=c.cidx\r\n"
				+ "where p.pidx=?\r\n"
				+ "and date_format(c.c_writeday,'%Y') like '2023'\r\n"
				+ "and cast(date_format(c.c_writeday,'%m') as signed) >= 8\r\n"
				+ "and ct.ct_year=? and ct.ct_semester=?\r\n"
				+ "group by  c.cidx, c.c_sep, c.c_name) a\r\n"
				+ "join\r\n"
				+ "(select c.cidx, ct.ct_room, group_concat(concat(ct_week, pe_period) separator ' , ') as times\r\n"
				+ "from coursetime ct\r\n"
				+ "join course c on ct.cidx=c.cidx\r\n"
				+ "group by c.cidx, ct.ct_room\r\n"
				+ "order by c_name)b\r\n"
				+ "on a.cidx=b.cidx";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pidx);
			pstmt.setInt(2, year);
			pstmt.setInt(3, semester);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AttendanceVo av = new AttendanceVo();
				
				av.setC_sep(rs.getString("A.c_sep"));
				av.setCidx(rs.getInt("A.cidx"));
				av.setC_name(rs.getString("A.c_name"));
				av.setC_major(rs.getString("A.c_major"));
				av.setC_grade(rs.getInt("A.c_grade"));
				av.setCt_room(rs.getString("B.ct_room"));
				av.setC_times(rs.getString("B.times"));
				av.setS_cnt(rs.getInt("A.s_cnt"));
				plist.add(av);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return plist;
	}
	
	public ArrayList<AttendanceVo> searchList(String c_name, String a_date, String a_start) {
		
		ArrayList<AttendanceVo> searchlist = new ArrayList<>();
		ResultSet rs;
		String sql= "SELECT s.s_major, s.s_name, s.s_no, ec.e_attendance\r\n"
				+ "FROM eachcheck ec\r\n"
				+ "	join attendance a on a.aidx = ec.aidx\r\n"
				+ "	join courselist cl on cl.clidx = a.clidx\r\n"
				+ "	join course c on cl.cidx = c.cidx\r\n"
				+ "	join student s on s.sidx = cl.sidx\r\n"
				+ "where c.c_name=? and a_date = ? AND a_start = ?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, c_name);
			pstmt.setString(2, a_date);
			pstmt.setString(3, a_start);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AttendanceVo av = new AttendanceVo();
				
				av.setS_major(rs.getString("S.s_major"));
				av.setS_name(rs.getString("S.s_name"));
				av.setS_no(rs.getInt("S.s_no"));
				av.setE_attendance(rs.getString("Ec.e_attendance"));
				searchlist.add(av);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return searchlist;
	}
	
	public ArrayList<AttendanceVo> selectCourse(int pidx, int year, int semester) {
		
		ArrayList<AttendanceVo> courselist = new ArrayList<>();
		ResultSet rs;
		String sql= "select c.cidx, c.c_name, count(DISTINCT cl.sidx) as s_cnt\r\n"
				+ "from professor p\r\n"
				+ "join course c on p.pidx = c.pidx\r\n"
				+ "join courselist cl on cl.cidx=c.cidx\r\n"
				+ "join coursetime ct on ct.cidx=c.cidx\r\n"
				+ "where p.pidx=?\r\n"
				+ "and date_format(c.c_writeday,'%Y') like '2023'\r\n"
				+ "and cast(date_format(c.c_writeday,'%m') as signed) >= 8\r\n"
				+ "and ct.ct_year=? and ct.ct_semester=?\r\n"
				+ "group by c.cidx, c.c_name";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pidx);
			pstmt.setInt(2, year);
			pstmt.setInt(3, semester);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AttendanceVo av = new AttendanceVo();
				
				av.setCidx(rs.getInt("C.cidx"));
				av.setC_name(rs.getString("C.c_name"));
				av.setS_cnt(rs.getInt("s_cnt"));
				courselist.add(av);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return courselist;
	}
	public AttendanceVo totalStudentCount(int cidx, int year, int semester) {
		
		AttendanceVo tscount = new AttendanceVo();
		ResultSet rs;
		String sql= "select c.cidx, c.c_name, count(DISTINCT cl.sidx) as s_cnt\r\n"
				+ "from professor p\r\n"
				+ "join course c on p.pidx = c.pidx\r\n"
				+ "join courselist cl on cl.cidx=c.cidx\r\n"
				+ "join coursetime ct on ct.cidx=c.cidx\r\n"
				+ "where c.cidx=?\r\n"
				+ "and date_format(c.c_writeday,'%Y') like '2023'\r\n"
				+ "and cast(date_format(c.c_writeday,'%m') as signed) >= 8\r\n"
				+ "and ct.ct_year=? and ct.ct_semester=?\r\n"
				+ "group by c.cidx, c.c_name";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cidx);
			pstmt.setInt(2, year);
			pstmt.setInt(3, semester);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				tscount.setS_cnt(rs.getInt("s_cnt"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return tscount;
	}
}

package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.domain.AttendanceVo;
import app.domain.EachCheckVo;
import app.domain.MemberVo;

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
		String sql= "call attendanceshortfall(?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sidx);
			pstmt.setInt(2, year);
			pstmt.setInt(3, semester);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AttendanceVo av = new AttendanceVo();
				
				av.setC_sep(rs.getString("c_sep"));
				av.setCidx(rs.getInt("cidx"));
				av.setC_name(rs.getString("c_name"));
				av.setC_score(rs.getInt("c_score"));
				av.setP_name(rs.getString("p_name"));
				av.setCt_room(rs.getString("ct_room"));
				av.setC_times(rs.getString("times"));
				av.setAbpercent(rs.getString("persen"));
				av.setAbyn(rs.getString("yn"));
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
			pstmt.setInt(1, cidx);
			pstmt.setInt(2, sidx);
			
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
			pstmt.setInt(1, cidx);
			pstmt.setInt(2, sidx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				av.setAttendanceCount(rs.getInt("attendance"));
				System.out.println(av.getAttendanceCount());
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
			pstmt.setInt(1, cidx);
			pstmt.setInt(2, sidx);
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
		String sql= "select count(*) as cnt\r\n"
				+ "from attendance A\r\n"
				+ "	join course C on A.cidx = C.cidx\r\n"
				+ "	join Eachcheck B on B.aidx = A.aidx\r\n"
				+ "	join courselist cl on cl.clidx = A.clidx\r\n"
				+ "	where C.cidx=? and cl.sidx=? and B.e_attendance='조퇴'";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cidx);
			pstmt.setInt(2, sidx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				alev.setLeaveCount(rs.getInt("cnt"));
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
			pstmt.setInt(1, cidx);
			pstmt.setInt(2, sidx);
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
	
	public ArrayList<AttendanceVo> professorManagement(int cidx){
		LocalDate now = LocalDate.now();
		int year = now.getYear();
		int month = now.getMonthValue();
		int semester = 0;
		if(month >= 1 && month <= 7) {
			semester = 1;
		}else {
			semester = 2;
		}
		
		ArrayList<AttendanceVo> list = new ArrayList<AttendanceVo>();
		ResultSet rs;
		String sql = "call professorManagement(?,?,?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,cidx);
			pstmt.setInt(2,year);
			pstmt.setInt(3,semester);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				AttendanceVo av = new AttendanceVo();
				av.setCidx(rs.getInt("cidx"));
				av.setW_week(rs.getInt("w_week"));
				av.setCt_week(rs.getString("ct_week"));
				av.setAtdate(rs.getString("wk"));
				av.setPe_period(rs.getInt("pe_period"));
				av.setPe_start(rs.getString("pe_start"));
				av.setPe_end(rs.getString("pe_end"));
				av.setAttendanceCount(rs.getInt("att"));
				av.setLeaveCount(rs.getInt("early"));
				av.setLateCount(rs.getInt("late"));
				av.setAbsentCount(rs.getInt("absent"));
				list.add(av);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public AttendanceVo searchDetail(int cidx, String ct_week, int pe_period, int w_week) {
		LocalDate now = LocalDate.now();
		int year = now.getYear();
		int month = now.getMonthValue();
		int semester = 0;
		if(month >= 1 && month <= 7) {
			semester = 1;
		}else {
			semester = 2;
		}
		
		AttendanceVo av = new AttendanceVo();
		ResultSet rs;
		ResultSet rs2;
		
		String sql1="select ctidx, pe.pe_start, pe.pe_end, c.c_name\r\n"
				+ "from coursetime ct \r\n"
				+ "join period pe on ct.pe_period = pe.pe_period\r\n"
				+ "join course c on ct.cidx=c.cidx\r\n"
				+ "where ct.cidx=? and ct.ct_week=? and ct.pe_period=?";
		
		
		String sql2="select widx\r\n"
				+ "from weektb\r\n"
				+ "where w_week=? and startyear=? and starttm=?";
		
		try {
			pstmt = conn.prepareStatement(sql1);
			pstmt.setInt(1,cidx);
			pstmt.setString(2, ct_week);
			pstmt.setInt(3, pe_period);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				av.setCtidx(rs.getInt("ctidx"));
				av.setPe_start(rs.getString("pe_start"));
				av.setPe_end(rs.getString("pe_end"));
				av.setC_name(rs.getString("c_name"));
			}
			pstmt = conn.prepareStatement(sql2);
			pstmt.setInt(1, w_week);
			pstmt.setInt(2, year);
			pstmt.setInt(3, semester);
			rs2 = pstmt.executeQuery();
			
			while(rs2.next()) {
				av.setWidx(rs2.getInt("widx"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return av;
	}
	public ArrayList<MemberVo> professorAttendProcessing(int cidx,String dates, int w_week, int period, int ctidx){
		ArrayList<MemberVo> list = new ArrayList<>();
		ResultSet rs;
		
		String sql = "select c.clidx,s.s_name, s.s_no, ect.e_attendance\r\n"
				+ "from courselist c\r\n"
				+ "join student s on c.sidx=s.sidx\r\n"
				+ "left join (select ec.e_attendance, ec.clidx\r\n"
				+ "from eachcheck ec\r\n"
				+ "join attendance a on ec.aidx = a.aidx\r\n"
				+ "join weektb w on a.widx = w.widx\r\n"
				+ "join coursetime ct on a.ctidx = ct.ctidx\r\n"
				+ "where a.cidx=? and a.a_date = ? and w.w_week=? and ct.pe_period = ?\r\n"
				+ "group by ec.e_attendance, ec.clidx) ect on c.clidx = ect.clidx\r\n"
				+ "where c.cidx=? and c.ctidx=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cidx);
			pstmt.setString(2, dates);
			pstmt.setInt(3, w_week);
			pstmt.setInt(4, period);
			pstmt.setInt(5, cidx);
			pstmt.setInt(6, ctidx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberVo mv = new MemberVo();
				mv.setClidx(rs.getInt("c.clidx"));
				mv.setS_name(rs.getString("s.s_name"));
				mv.setS_no(rs.getInt("s.s_no"));
				mv.setE_attendance(rs.getString("ect.e_attendance"));
				list.add(mv);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	public int attendanceAction(ArrayList<EachCheckVo> list, AttendanceVo av) {
		int value = 0;
		ResultSet rs;
		ResultSet cnt;
		String checkcnt = "select count(*) cnt, a.aidx\r\n"
				+ "from eachcheck ec\r\n"
				+ "join attendance a on ec.aidx = a.aidx\r\n"
				+ "join coursetime ct on a.ctidx=ct.ctidx\r\n"
				+ "where a.cidx=? and a.a_date=? and ct.pe_period=? and ec.clidx=?\r\n"
				+ "group by a.aidx";
		
		String insertAtt = "insert into attendance(ctidx, a_date, a_start, a_end, a_skipyn, clidx, cidx, widx)\r\n"
						 + "values(?,?,?,?, 'N', ?, ?, ?)";
		
		String maxAidx = "select max(aidx) as maxval from attendance";
		
		String insertEach = "insert into eachcheck(clidx, aidx, e_attendance)values(?, ?,?)";
		
		String updateatt = "UPDATE eachcheck set e_attendance=? where aidx=?";
		
		try {
			conn.setAutoCommit(false);
			for(int i=0; i<list.size(); i++) {
				pstmt = conn.prepareStatement(checkcnt);
				pstmt.setInt(1, av.getCidx());
				pstmt.setString(2, av.getA_date());
				pstmt.setInt(3, av.getPe_period());
				pstmt.setInt(4, list.get(i).getClidx());
				cnt = pstmt.executeQuery();
				int counting = 0;
				int cntaidx = 0;
				while(cnt.next()) {
					counting = cnt.getInt("cnt");
					cntaidx = cnt.getInt("a.aidx");
				}
				
				if(counting == 0) {
					//System.out.println(list.get(i).getE_attendance());
					pstmt = conn.prepareStatement(insertAtt);
					pstmt.setInt(1, av.getCtidx());
					pstmt.setString(2, av.getA_date());
					pstmt.setString(3, av.getA_start());
					pstmt.setString(4, av.getA_end());
					pstmt.setInt(5, list.get(i).getClidx());
					pstmt.setInt(6, av.getCidx());
					pstmt.setInt(7, av.getWidx());
					pstmt.executeUpdate();
					
					pstmt = conn.prepareStatement(maxAidx);
					rs = pstmt.executeQuery();
					int aidx = 0;
					while(rs.next()) {
						aidx = rs.getInt("maxval");
					}
					
					pstmt = conn.prepareStatement(insertEach);
					pstmt.setInt(1, list.get(i).getClidx());
					pstmt.setInt(2, aidx);
					pstmt.setString(3, list.get(i).getE_attendance());
					value = pstmt.executeUpdate();
				}else {
					pstmt = conn.prepareStatement(updateatt);
					pstmt.setString(1, list.get(i).getE_attendance());
					pstmt.setInt(2, cntaidx);
					value = pstmt.executeUpdate();
				}
			}
			conn.commit();
		} catch (SQLException e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		
		//System.out.println(list.toString()+av.getCtidx());
		return value;
	}
	
	public AttendanceVo toomuchAbsenceList(int cidx){
		AttendanceVo av = new AttendanceVo();
		ResultSet rs;
		String sql = "call attendanceshortfall_rate(?)";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cidx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				av.setCidx(rs.getInt("cidx"));
				av.setC_name(rs.getString("c_name"));
				av.setAbperal(rs.getString("result"));
				av.setAbpercent(rs.getString("rate"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return av;
	}
	public ArrayList<MemberVo> toomuchAbsenceListAction(int cidx){
		ArrayList<MemberVo> list = new ArrayList<>();
		ResultSet rs;
		String sql = "call attendanceshortfall_p(?)";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cidx);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberVo mv = new MemberVo();
				mv.setS_name(rs.getString("s_name"));
				mv.setS_no(rs.getInt("s_no"));
				mv.setAbcount(rs.getString("count"));
				mv.setAbper(rs.getString("per"));
				list.add(mv);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
}

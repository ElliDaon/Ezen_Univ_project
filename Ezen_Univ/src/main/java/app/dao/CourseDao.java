package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.domain.CourseVo;
import app.domain.TableVo;

public class CourseDao {

	private Connection conn; 
	private PreparedStatement pstmt;

	public CourseDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();
	}
	
	public ArrayList<CourseVo> professorCourseList(int pidx, int year, int term){
		ResultSet rs;
		
		ArrayList<CourseVo> courselist = new ArrayList<>();
		String sql = "select A.c_name,A.c_major,A.c_grade, P.p_name,A.c_sep,A.c_score, D.ct_room, group_concat(distinct D.ct_week,D.pe_period) as times\r\n"
				+ "	from course A\r\n"
				+ "	join coursetime D on A.cidx = D.cidx\r\n"
				+ "	join professor P on P.pidx = A.pidx\r\n"
				+ "	where P.pidx=? and D.ct_year=? and D.ct_semester=?\r\n"
				+ "	group by A.c_name,D.ct_room,A.c_major,A.c_sep,A.c_grade,A.c_score,P.p_name;"
;
				try{
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1,pidx);
				pstmt.setInt(2, year);
				pstmt.setInt(3, term);
				rs = pstmt.executeQuery();
				
					while(rs.next()) {
						CourseVo cv = new CourseVo();
						
						cv.setC_name(rs.getString("A.c_name"));
						cv.setC_major(rs.getString("A.c_major"));
						cv.setC_grade(rs.getInt("A.c_grade"));
						cv.setC_sep(rs.getString("A.c_sep"));
						cv.setC_score(rs.getInt("A.c_score"));
						cv.setCt_room(rs.getString("D.ct_room"));
						cv.setC_times(rs.getString("times"));
						courselist.add(cv);
					}
					
				} catch(Exception e){
					e.printStackTrace();
				}
		
		return courselist;
	}
	public ArrayList<CourseVo> studentCourseList(int sidx, int year, int term){
		ArrayList<CourseVo> list = new ArrayList<>();
		ResultSet rs;
		
		String sql= "select A.c_name,A.c_major,A.c_grade, P.p_name,A.c_sep,A.c_score, D.ct_room, group_concat(distinct D.ct_week,D.pe_period) as times\r\n"
				+ "	from course A\r\n"
				+ "	join coursetime D on A.cidx = D.cidx\r\n"
				+ "	join professor P on P.pidx = A.pidx\r\n"
				+ "	join courselist cl on cl.cidx = A.cidx where cl.sidx=? and D.ct_year=? and D.ct_semester=?\r\n"
				+ "	group by A.c_name,D.ct_room,A.c_major,A.c_sep,A.c_grade,A.c_score,P.p_name;";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sidx);
			pstmt.setInt(2, year);
			pstmt.setInt(3, term);
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
	
	public ArrayList<TableVo> studentMyTable(int sidx, int year, int term){
		ArrayList<TableVo> list = new ArrayList<>();
		ResultSet rs;
		
		String sql="select pe.pe_period,ifnull(월,'') as mon, ifnull(화,'') as two,ifnull(수,'') as wed,ifnull(목,'') as thu,ifnull(금,'') as fri\r\n"
				+ "from period pe\r\n"
				+ "left join\r\n"
				+ "(\r\n"
				+ "SELECT\r\n"
				+ "  ct.pe_period,\r\n"
				+ "  MAX(CASE WHEN ct.ct_week = '월' THEN concat(co.c_name, '<br>', ct.ct_room, '<br>', p.p_name) ELSE '' END) AS 월,\r\n"
				+ "  MAX(CASE WHEN ct.ct_week = '화' THEN concat(co.c_name, '<br>', ct.ct_room, '<br>', p.p_name) ELSE '' END) AS 화,\r\n"
				+ "  MAX(CASE WHEN ct.ct_week = '수' THEN concat(co.c_name, '<br>', ct.ct_room, '<br>', p.p_name) ELSE '' END) AS 수,\r\n"
				+ "  MAX(CASE WHEN ct.ct_week = '목' THEN concat(co.c_name, '<br>', ct.ct_room, '<br>', p.p_name) ELSE '' END) AS 목,\r\n"
				+ "  MAX(CASE WHEN ct.ct_week = '금' THEN concat(co.c_name, '<br>', ct.ct_room, '<br>', p.p_name) ELSE '' END) AS 금\r\n"
				+ "FROM courselist cl\r\n"
				+ "JOIN coursetime ct ON ct.ctidx = cl.ctidx\r\n"
				+ "JOIN course co ON ct.cidx = co.cidx\r\n"
				+ "JOIN professor p ON p.pidx = co.pidx\r\n"
				+ "WHERE cl.sidx = ? and ct.ct_year=? and ct.ct_semester=? \r\n"
				+ "GROUP BY ct.pe_period) a\r\n"
				+ "on pe.pe_period = a.pe_period;";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sidx);
			pstmt.setInt(2, year);
			pstmt.setInt(3, term);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				TableVo tv = new TableVo();
				tv.setPe_period(rs.getInt("pe.pe_period"));
				tv.setMon(rs.getString("mon"));
				tv.setTwo(rs.getString("two"));
				tv.setWed(rs.getString("wed"));
				tv.setThu(rs.getString("thu"));
				tv.setFri(rs.getString("fri"));
				list.add(tv);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<TableVo> professorMyTable(int pidx, int year, int term){
		ArrayList<TableVo> tablelist = new ArrayList<>();
		ResultSet rs;
		
		String sql="select pe.pe_period,ifnull(월,'') as mon, ifnull(화,'') as two,ifnull(수,'') as wed,ifnull(목,'') as thu,ifnull(금,'') as fri\r\n"
				+ "from period pe\r\n"
				+ "left join\r\n"
				+ "(\r\n"
				+ "SELECT\r\n"
				+ "  ct.pe_period,\r\n"
				+ "  MAX(CASE WHEN ct.ct_week = '월' THEN concat(co.c_name, '<br>', ct.ct_room) ELSE '' END) AS 월,\r\n"
				+ "  MAX(CASE WHEN ct.ct_week = '화' THEN concat(co.c_name, '<br>', ct.ct_room) ELSE '' END) AS 화,\r\n"
				+ "  MAX(CASE WHEN ct.ct_week = '수' THEN concat(co.c_name, '<br>', ct.ct_room) ELSE '' END) AS 수,\r\n"
				+ "  MAX(CASE WHEN ct.ct_week = '목' THEN concat(co.c_name, '<br>', ct.ct_room) ELSE '' END) AS 목,\r\n"
				+ "  MAX(CASE WHEN ct.ct_week = '금' THEN concat(co.c_name, '<br>', ct.ct_room) ELSE '' END) AS 금\r\n"
				+ "FROM courselist cl\r\n"
				+ "JOIN coursetime ct ON ct.ctidx = cl.ctidx\r\n"
				+ "JOIN course co ON ct.cidx = co.cidx\r\n"
				+ "JOIN professor p ON p.pidx = co.pidx\r\n"
				+ "WHERE p.pidx = ? and ct.ct_year=? and ct.ct_semester=?\r\n"
				+ "GROUP BY ct.pe_period) a\r\n"
				+ "on pe.pe_period = a.pe_period;";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pidx);
			pstmt.setInt(2, year);
			pstmt.setInt(3, term);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				TableVo tv = new TableVo();
				tv.setPe_period(rs.getInt("pe.pe_period"));
				tv.setMon(rs.getString("mon"));
				tv.setTwo(rs.getString("two"));
				tv.setWed(rs.getString("wed"));
				tv.setThu(rs.getString("thu"));
				tv.setFri(rs.getString("fri"));
				tablelist.add(tv);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return tablelist;
	}
}

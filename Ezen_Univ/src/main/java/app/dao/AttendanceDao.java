package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.domain.AttendanceVo;

public class AttendanceDao {
	private Connection conn; 
	private PreparedStatement pstmt;

	//생성자를 만들고 DB에 연결
	public AttendanceDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();
	}

	public ArrayList<AttendanceVo> studentCourseList() {
		//무한배열클래스 객체생성해서 데이터를 담을 준비를 한다
		ArrayList<AttendanceVo> clist = new ArrayList<AttendanceVo>();
		ResultSet rs = null;
		String sql = "select A.c_name, A.c_major, A.c_sep, A.c_score, concat( D.ct_room, ' ', group_concat(distinct D.ct_week,D.pe_period)) as 시간표" +
				"from course A" +
				"join coursetime D on A.cidx = D.cidx" +
				"join courselist cl on cl.cidx = A.cidx where cl.sidx=?" +
				"group by A.c_name, D.ct_room, A.c_major, A.c_sep,A.c_score";

				try{
				//구문(쿼리)객체
				pstmt = conn.prepareStatement(sql);
				//DB에 있는 값을 담아오는 전용객체
				rs = pstmt.executeQuery();
				}catch(Exception e) {
					e.printStackTrace();
				}
		return clist;
	}
}

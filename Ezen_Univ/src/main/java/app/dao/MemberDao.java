package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.domain.MemberVo;

public class MemberDao {
	
	
	private Connection conn; //멤버 변수는 선언만해도 자동초기화됨
	private PreparedStatement pstmt;
	//부분만 사용하는 변수는 전역으로 선언하지 X
	
	
	public MemberDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();
	}
	
	public int memberInsert( 
			String memberId, String memberPwd, 
			String memberName, String memberBirth,
			String memberGender, String memberPhone, 
			String memberEmail, String memberAddr, 
			String memberHobby){
		int exec = 0;

		String sql = "insert into student(s_id, s_pwd, s_name, s_phone, s_email, s_birth, s_major, s_no)"+
				" values(?,?,?,?,?,?,?,?,?)";
				try{
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,memberId);
				pstmt.setString(2,memberPwd);
				pstmt.setString(3,memberName);
				pstmt.setString(4,memberBirth);
				pstmt.setString(5,memberGender);
				pstmt.setString(6,memberPhone);
				pstmt.setString(7,memberEmail);
				pstmt.setString(8,memberAddr);

				exec = pstmt.executeUpdate();
				} catch(Exception e){
					e.printStackTrace();
				}
		
		return exec;
	}
	public int studentInsert(String s_id, String s_pwd, String s_name, String s_phone, String s_email, int s_birth, String s_major) {
		
		int exec = 0;

		String sql = "insert into student(s_id, s_pwd, s_name, s_phone, s_email, s_birth, s_major, s_yn)"+
				" values(?,?,?,?,?,?,?,'N')";
				try{
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1,s_id);
				pstmt.setString(2,s_pwd);
				pstmt.setString(3,s_name);
				pstmt.setString(4,s_phone);
				pstmt.setString(5,s_email);
				pstmt.setInt(6,s_birth);
				pstmt.setString(7,s_major);
				
				exec = pstmt.executeUpdate();
				} catch(Exception e){
					e.printStackTrace();
				}
		
		return exec;
	}
	public int professorInsert(String p_id, String p_pwd, String p_name, String p_phone, String p_email, int p_birth, String p_major) {
		
		int exec = 0;
		
		String sql = "insert into professor(p_id, p_pwd, p_name, p_phone, p_email, p_birth, p_major, p_yn)"+
				" values(?,?,?,?,?,?,?,'N')";
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,p_id);
			pstmt.setString(2,p_pwd);
			pstmt.setString(3,p_name);
			pstmt.setString(4,p_phone);
			pstmt.setString(5,p_email);
			pstmt.setInt(6,p_birth);
			pstmt.setString(7,p_major);

			
			exec = pstmt.executeUpdate();
		} catch(Exception e){
			e.printStackTrace();
		}
		
		return exec;
	}

	public ArrayList<MemberVo> memberSelectAll(){
		//무한배열클래스 객체생성해서 데이터 담을 준비를 한다.
		ArrayList<MemberVo> alist = new ArrayList<MemberVo>();
		ResultSet rs;
		String sql="select midx, membername, memberid, date_format(writeday,\"%Y-%m-%d\") as writeday from member0803 where delyn='N' order by midx desc";
		try{
			//구문(쿼리)객체
			pstmt = conn.prepareStatement(sql);
			//DB에 있는 값을 담아오는 전용객체
			rs = pstmt.executeQuery();
			//rs.next() -> 다음값이 있는지 확인하는 메서드(있으면 true, 없으면 false)
			while(rs.next()){
				MemberVo mv = new MemberVo();
				//rs에서 midx값 꺼내서 mv에 옮겨담는다.
				/*
				 * mv.setMidx( rs.getInt("midx") ); mv.setMemberId( rs.getString("memberid") );
				 * mv.setMemberName( rs.getString("membername")); mv.setWriteday(
				 * rs.getString("writeday")); alist.add(mv);
				 */
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return alist;
	}

	public int memberIdCheck1(String memberId){
		int value = 0; //결과값이 0인지 아닌지
		String sql = "select count(*) as cnt from student where s_id=?";
		ResultSet rs = null;
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,memberId);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				value = rs.getInt("cnt");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return value;
	}
	
	public int memberIdCheck2(String memberId){
		int value = 0; //결과값이 0인지 아닌지
		String sql = "select count(*) as cnt from professor where p_id=?";
		ResultSet rs = null;
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,memberId);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				value = rs.getInt("cnt");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return value;
	}


	public int memberLoginCheck(String memberId, String memberPwd){
		int value=0;
		String sql = "select midx from member0803 where memberid=? and memberpwd=?";
		ResultSet rs = null;
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,memberId);
			pstmt.setString(2,memberPwd);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				value = rs.getInt("midx");
				//value가 0이면 일치하지 않는다
				//value가 1이면 일치한다
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return value;
	}
	public int studentLoginCheck(String s_id, String s_pwd){
		int value=0;
		String sql = "select sidx from student where s_id=? and s_pwd=?";
		ResultSet rs = null;
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,s_id);
			pstmt.setString(2,s_pwd);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				value = rs.getInt("sidx");
				//value가 0이면 일치하지 않는다
				//value가 1이면 일치한다
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return value;
	}
	public int professorLoginCheck(String p_id, String p_pwd){
		int value=0;
		String sql = "select pidx from professor where p_id=? and p_pwd=?";
		ResultSet rs = null;
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,p_id);
			pstmt.setString(2,p_pwd);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				value = rs.getInt("pidx");
				//value가 0이면 일치하지 않는다
				//value가 1이면 일치한다
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return value;
	}
	public MemberVo studentSidxSearch(String s_id) {
		MemberVo mv = new MemberVo();
		
		String sql = "select sidx, s_no, s_name, s_major from student where s_id=?";
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, s_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				mv.setSidx(rs.getInt("sidx"));
				mv.setS_no(rs.getInt("s_no"));
				mv.setS_name(rs.getString("s_name"));
				mv.setS_major(rs.getString("s_major"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
				
		return mv;
	}
	public MemberVo professorPidxSearch(String p_id) {
		MemberVo mv = new MemberVo();
		
		String sql = "select pidx, p_no, p_name, p_major from professor where p_id=?";
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				mv.setPidx(rs.getInt("pidx"));
				mv.setP_no(rs.getInt("p_no"));
				mv.setP_name(rs.getString("p_name"));
				mv.setP_major(rs.getString("p_major"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return mv;
	}
	
	public MemberVo studentInfo(int sidx) {
		MemberVo mv = new MemberVo();
		
		String sql = "select s_id,s_no, s_name, s_grade, s_phone,s_birth, s_major, s_email from student where sidx=?;";
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sidx);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				
				mv.setS_id(rs.getString("s_id"));
				mv.setS_no(rs.getInt("s_no"));
				mv.setS_name(rs.getString("s_name"));
				mv.setS_grade(rs.getInt("s_grade"));
				mv.setS_phone(rs.getString("s_phone"));
				mv.setS_birth(rs.getInt("s_birth"));
				mv.setS_major(rs.getString("s_major"));
				mv.setS_email(rs.getString("s_email"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	public int studentInfoModify(int sidx, String studentPhone, String studentEmail) {
		int value=0;
		
		String sql = "update student set s_phone=?, s_email=?\r\n"
				+ "where sidx=?\r\n";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, studentPhone);
			pstmt.setString(2, studentEmail);
			pstmt.setInt(3, sidx);
			value=pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return value;
	}
	public MemberVo professorInfo(int pidx) {
		MemberVo mv = new MemberVo();
		
		String sql = "select p_id, p_no, p_name, p_phone, p_birth, p_major, p_email from professor where pidx=?;";
		ResultSet rs = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pidx);
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				
				mv.setP_id(rs.getString("p_id"));
				mv.setP_no(rs.getInt("p_no"));
				mv.setP_name(rs.getString("p_name"));
				mv.setP_phone(rs.getString("p_phone"));
				mv.setP_birth(rs.getInt("p_birth"));
				mv.setP_major(rs.getString("p_major"));
				mv.setP_email(rs.getString("p_email"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return mv;
	}
	
	public int professorInfoModify(int pidx, String professorPhone, String professorEmail) {
		int value=0;
		
		String sql = "update professor set p_phone=?, p_email=?\r\n"
				+ "where pidx=?\r\n";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, professorPhone);
			pstmt.setString(2, professorEmail);
			pstmt.setInt(3, pidx);
			value=pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return value;
	}
	
	public String studentSearchId(int sidx) {
		String s_id = "";
		ResultSet rs = null;
		
		String sql="select s_id from student where sidx=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, sidx);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				s_id = rs.getString("s_id");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return s_id;
	}
	
	public int studentPwdModify(int sidx, String s_pwd, String s_newpwd) {
		int value = 0;
		
		String sql = "update student set s_pwd=?\r\n"
				+ "where sidx=? and s_pwd=?\r\n";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, s_newpwd);
			pstmt.setInt(2, sidx);
			pstmt.setString(3, s_pwd);
			value=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return value;
	}
	
	public String professorSearchId(int pidx) {
		String p_id = "";
		ResultSet rs = null;
		
		String sql="select p_id from professor where pidx=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pidx);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				p_id = rs.getString("p_id");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return p_id;
	}
	
	public int professorPwdModify(int pidx, String p_pwd, String p_newpwd) {
		int value = 0;
		
		String sql = "update professor set p_pwd=?\r\n"
				+ "where pidx=? and p_pwd=?\r\n";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_newpwd);
			pstmt.setInt(2, pidx);
			pstmt.setString(3, p_pwd);
			value=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return value;
	}
	
	public ArrayList<MemberVo> professorListForTable(String p_name) {
		ArrayList<MemberVo> list = new ArrayList<>();
		ResultSet rs;
		String sql = "select p_major, pidx, p_name from professor where p_name like concat('%',?,'%')";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_name);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberVo mv = new MemberVo();
				
				mv.setP_major(rs.getString("p_major"));
				mv.setPidx(rs.getInt("pidx"));
				mv.setP_name(rs.getString("p_name"));
				list.add(mv);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}
	public int searchStudentIdcnt(String memberName, String memberEmail) {
		int value = 0;
		String sql = "select count(*) as cnt from student where s_name=? and s_email=?";
		ResultSet rs;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberName);
			pstmt.setString(2, memberEmail);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				value = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return value;
	}
	
	public String searchStudentId(String memberName, String memberEmail) {
		String memberId = "";
		String sql = "select s_id from student where s_name=? and s_email=?";
		ResultSet rs;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberName);
			pstmt.setString(2, memberEmail);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberId = rs.getString("s_id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return memberId;
	}
	public int searchProfessorIdcnt(String memberName, String memberEmail) {
		int value = 0;
		String sql = "select count(*) as cnt from professor where p_name=? and p_email=?";
		ResultSet rs;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberName);
			pstmt.setString(2, memberEmail);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				value = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return value;
	}
	
	public String searchProfessorId(String memberName, String memberEmail) {
		String memberId = "";
		String sql = "select p_id from professor where p_name=? and p_email=?";
		ResultSet rs;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberName);
			pstmt.setString(2, memberEmail);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				memberId = rs.getString("p_id");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return memberId;
	}
	
	public int searchStudentPwd(String memberId, String memberName, String memberEmail) {
		int value = 0;
		ResultSet rs;
		
		String sql = "select count(*) as cnt from student where s_id=? and s_name=? and s_Email=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberName);
			pstmt.setString(3, memberEmail);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				value = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return value;
	}
	public int changeStudentPwd(String memberId, String memberName, String memberEmail, String newPwd) {
		int value = 0;
		
		String sql = "update student set s_pwd = ? where s_id=? and s_name=? and s_Email=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newPwd);
			pstmt.setString(2, memberId);
			pstmt.setString(3, memberName);
			pstmt.setString(4, memberEmail);
			value = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return value;
	}
	
	public int searchProfessorPwd(String memberId, String memberName, String memberEmail) {
		int value = 0;
		ResultSet rs;
		
		String sql = "select count(*) as cnt from professor where p_id=? and p_name=? and p_Email=?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, memberName);
			pstmt.setString(3, memberEmail);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				value = rs.getInt("cnt");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return value;
	}
	
	public int changeProfessorPwd(String memberId, String memberName, String memberEmail, String newPwd) {
		int value = 0;
		
		String sql = "update professor set p_pwd = ? where p_id=? and p_name=? and p_Email=?";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newPwd);
			pstmt.setString(2, memberId);
			pstmt.setString(3, memberName);
			pstmt.setString(4, memberEmail);
			value = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return value;
	}
	

}

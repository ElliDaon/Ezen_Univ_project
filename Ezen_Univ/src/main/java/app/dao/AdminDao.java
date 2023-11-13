package app.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.domain.CourseTimeVo;
import app.domain.CourseVo;
import app.domain.MemberVo;

public class AdminDao {
	
	private Connection conn; 
	private PreparedStatement pstmt;
	
	public AdminDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();
	}
	
	public ArrayList<MemberVo> studentAll(){
		ArrayList<MemberVo> slist = new ArrayList<MemberVo>();
		ResultSet rs = null;
		
		String sql = "select sidx, s_name,s_birth,s_email,s_major from student where s_yn='N' order by sidx desc";
		
		try{
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MemberVo mv = new MemberVo();
				
				mv.setSidx( rs.getInt("sidx") ); 
				mv.setS_name( rs.getString("s_name") );
				mv.setS_birth( rs.getInt("s_birth"));
				mv.setS_email( rs.getString("s_email"));
				mv.setS_major( rs.getString("s_major"));
				
				slist.add(mv);
			}
		}catch(Exception e){
			e.printStackTrace();		
		}finally{
			try{
				//rs.close();
				//pstmt.close();
				//conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return slist;
	}
	public ArrayList<MemberVo> professorAll(){
		ArrayList<MemberVo> plist = new ArrayList<MemberVo>();
		ResultSet rs = null;
		
		String sql = "select pidx, p_name,p_birth,p_email,p_major from professor where p_yn='N' order by pidx desc";
		
		try{
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MemberVo mv = new MemberVo();
				
				mv.setPidx( rs.getInt("pidx") ); 
				mv.setP_name( rs.getString("p_name") );
				mv.setP_birth( rs.getInt("p_birth"));
				mv.setP_email( rs.getString("p_email"));
				mv.setP_major( rs.getString("p_major"));
				
				plist.add(mv);
			}
		}catch(Exception e){
			e.printStackTrace();		
		}finally{
			try{
				//rs.close();
				//pstmt.close();
				//conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		return plist;
	}

	public int studentAccept(int sidx) {
		int exec = 0;
		String sql = "update student set s_yn='Y' where sidx=?";
		
		try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, sidx);
		exec = pstmt.executeUpdate();
		
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return exec;
	}
	
	public int professorAccept(int pidx) {
		int exec = 0;
		String sql = "update professor set p_yn='Y' where pidx=?";
		
		try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, pidx);
		exec = pstmt.executeUpdate();
		
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return exec;
	}
	
	public int studentDeny(int sidx) {
		int exec = 0;
		String sql = "delete from student where sidx=?";
		
		try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, sidx);
		exec = pstmt.executeUpdate();
		
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return exec;
	}
	
	public int professorDeny(int pidx) {
		int exec = 0;
		String sql = "delete from professor where pidx=?";
		
		try{
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, pidx);
		exec = pstmt.executeUpdate();
		
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			try {
				pstmt.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return exec;
	}
	
	public int studentCheckedAccept(int[] selectedData) {
		int exec=0;
		String sql = "update student set s_yn='Y' where sidx=?";
		
		try{
			pstmt = conn.prepareStatement(sql);
			for (int value : selectedData) {
                pstmt.setInt(1, value);
                int rowsAffected = pstmt.executeUpdate();
                exec += rowsAffected;
            }
		}catch (SQLException e) {
            // 예외 처리
            e.printStackTrace();
        }finally {
            // 리소스 해제
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
		return exec;
		
	}

	public int studentCheckedADeny(int[] selectedData) {
		int exec=0;
		String sql = "delete from student where sidx=?";
		
		try{
			pstmt = conn.prepareStatement(sql);
			for (int value : selectedData) {
                pstmt.setInt(1, value);
                int rowsAffected = pstmt.executeUpdate();
                exec += rowsAffected;
            }
		}catch (SQLException e) {
            // 예외 처리
            e.printStackTrace();
        }finally {
            // 리소스 해제
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
		return exec;
		
	}
	
	public int professorCheckedAccept(int[] selectedData) {
		int exec=0;
		String sql = "update professor set p_yn='Y' where pidx=?";
		
		try{
			pstmt = conn.prepareStatement(sql);
			for (int value : selectedData) {
                pstmt.setInt(1, value);
                int rowsAffected = pstmt.executeUpdate();
                exec += rowsAffected;
            }
		}catch (SQLException e) {
            // 예외 처리
            e.printStackTrace();
        }finally {
            // 리소스 해제
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
		return exec;
		
	}

	public int professorCheckedADeny(int[] selectedData) {
		int exec=0;
		String sql = "delete from professor where pidx=?";
		
		try{
			pstmt = conn.prepareStatement(sql);
			for (int value : selectedData) {
                pstmt.setInt(1, value);
                int rowsAffected = pstmt.executeUpdate();
                exec += rowsAffected;
            }
		}catch (SQLException e) {
            // 예외 처리
            e.printStackTrace();
        }finally {
            // 리소스 해제
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
		return exec;
		
	}

	public ArrayList<CourseVo> courseRegisterList(int year_int, int term_int) {
		ArrayList<CourseVo> list = new ArrayList<CourseVo>();
		ResultSet rs=null;
		
		
		String sql = "select a.cidx,a.c_name,d.p_no,d.p_name,a.c_major,a.c_grade,a.c_sep,a.c_score,b.ct_room,GROUP_CONCAT(b.ct_week,c.pe_period) as times \r\n"
				+ "from course a join coursetime b on a.cidx=b.cidx \r\n"
				+ "join period c on b.pe_period=c.pe_period \r\n"
				+ "join professor d on a.pidx=d.pidx \r\n"
				+ "where b.ct_year=? and b.ct_semester=? and p_yn='Y' \r\n"
				+ "group by a.cidx,a.c_name,a.c_major,a.c_grade,a.c_sep,a.c_score,b.ct_room";
;
				try{
				 
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, year_int);
				pstmt.setInt(2, term_int);
				rs = pstmt.executeQuery();
				
					while(rs.next()) {
						CourseVo cv = new CourseVo();
						
						cv.setCidx(rs.getInt("a.cidx"));
						cv.setC_name(rs.getString("a.c_name"));
						cv.setP_no(rs.getInt("d.p_no"));
						cv.setP_name(rs.getString("d.p_name"));
						cv.setC_major(rs.getString("a.c_major"));
						cv.setC_grade(rs.getInt("a.c_grade"));
						cv.setC_sep(rs.getString("a.c_sep"));	
						cv.setC_score(rs.getInt("a.c_score"));
						cv.setCt_room(rs.getString("b.ct_room"));
						cv.setC_times(rs.getString("times"));
						list.add(cv);
					}
					
				} catch(Exception e){
					e.printStackTrace();
				}
				
		
		return list;
	}

	public int courseDelete(int cidx) {
	    PreparedStatement selectStmt = null;
	    PreparedStatement deleteStmtByCtidx = null;
	    PreparedStatement deleteStmtByCidx = null;
	    ResultSet rs = null;
	    int exec = 0;

	    try {
	        // ctidx 값을 가져오기
	        String selectCtidx = "select ctidx from coursetime a join course b on a.cidx=b.cidx where b.cidx=?";
	        selectStmt = conn.prepareStatement(selectCtidx);
	        selectStmt.setInt(1, cidx);
	        rs = selectStmt.executeQuery();

	        // ctidx 값을 가진 행 삭제쿼리
	        String deleteCtidx = "delete from coursetime where ctidx=?";
	        deleteStmtByCtidx = conn.prepareStatement(deleteCtidx);

	        // cidx 값을 가진 행 삭제 쿼리
	        String deleteCidx = "delete from course where cidx=?";
	        deleteStmtByCidx = conn.prepareStatement(deleteCidx);

	        while (rs.next()) {
	            int ctidx = rs.getInt("ctidx");

	            // ctidx 값을 가진 행들 삭제
	            deleteStmtByCtidx.setInt(1, ctidx);
	            exec += deleteStmtByCtidx.executeUpdate();

	        }
	        
	        // cidx 값을 가진 행 삭제
	        deleteStmtByCidx.setInt(1, cidx);
	        exec += deleteStmtByCidx.executeUpdate();
	        
	    } catch (SQLException e) {
            e.printStackTrace();
            // 오류 처리
        } finally{
			try{
	            if (selectStmt != null) selectStmt.close();
	            if (deleteStmtByCtidx != null) deleteStmtByCtidx.close();
	            if (deleteStmtByCidx != null) deleteStmtByCidx.close();
	            conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
        return exec;
    }

	public ArrayList<MemberVo> registerView(String c_major) {
		ArrayList<MemberVo> list = new ArrayList<MemberVo>();
		ResultSet rs = null;
		
		String sql = "select p_no,p_name from professor where p_major=?";
		
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, c_major);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MemberVo mv = new MemberVo();
				mv.setP_no( rs.getInt("p_no") ); 
				mv.setP_name( rs.getString("p_name") );
				list.add(mv);

			}
	    } catch(Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            // rs, pstmt, conn close 로직
	        } catch(Exception e) {
	            e.printStackTrace();
	        }
	    }
		
		return list;
	}

}

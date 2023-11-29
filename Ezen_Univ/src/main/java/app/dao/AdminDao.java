package app.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Year;
import java.util.ArrayList;

import app.dbconn.DbConn;
import app.domain.AdminVo;
import app.domain.CourseTimeVo;
import app.domain.CourseVo;
import app.domain.MemberVo;
import app.domain.WeektbVo;

public class AdminDao {
	
	private Connection conn; 
	private PreparedStatement pstmt;
	
	public AdminDao() {
		DbConn dbconn = new DbConn();
		this.conn = dbconn.getConnection();
	}
	
	
	public int adminLoginCheck(String ad_id, String ad_pwd){
		int value=0;
		String sql = "select adidx from admin where ad_id=? and ad_pwd=?";
		ResultSet rs = null;
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,ad_id);
			pstmt.setString(2,ad_pwd);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				value = rs.getInt("adidx");
				//value가 0이면 일치하지 않는다
				//value가 1이면 일치한다
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return value;
	}
	
	
	public AdminVo adminAdidxSearch(String ad_id) {
		AdminVo av = new AdminVo();
		
		String sql = "select adidx from admin where ad_id=?";
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ad_id);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				av.setAdidx(rs.getInt("adidx"));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
				
		return av;
	}
	
	public ArrayList<MemberVo> studentAll(){
		ArrayList<MemberVo> slist = new ArrayList<MemberVo>();
		ResultSet rs = null;
		
		String sql = "select sidx,s_name,s_birth,s_email,s_major from student where s_yn='N' order by sidx desc";
		
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
        PreparedStatement selectS_no = null;
        PreparedStatement insertS_no = null;
        ResultSet rs = null;
        int exec = 0;
        int currentYear = Year.now().getValue();

        String selectCnt = "select count(*) as cnt from student where s_no=?";
        String selectedS_no = "update student set s_yn='Y', s_no=? where sidx=?";
        int s_no;

        try {
        	
            // 트랜잭션 시작
            conn.setAutoCommit(false);
        	
            do {
                // 랜덤으로 s_no 생성
                s_no = currentYear * 100000 + (int) (Math.random() * 89999);

                // 중복 체크
                selectS_no = conn.prepareStatement(selectCnt);
                selectS_no.setInt(1, s_no);
                rs = selectS_no.executeQuery();

            } while (rs.next() && rs.getInt("cnt") > 0);

            // 중복이 아닐 때 업데이트
            insertS_no = conn.prepareStatement(selectedS_no);
            insertS_no.setInt(1, s_no);
            insertS_no.setInt(2, sidx);
            exec = insertS_no.executeUpdate();

            // 트랜잭션 커밋
            conn.commit();

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                // 트랜잭션 롤백
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackException) {
                rollbackException.printStackTrace();
            }
        } finally {
            try {
                // 리소스 정리 및 AutoCommit 설정 복원
                if (rs != null) {
                    rs.close();
                }
                if (selectS_no != null) {
                    selectS_no.close();
                }
                if (insertS_no != null) {
                    insertS_no.close();
                }
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException closeException) {
                closeException.printStackTrace();
            }
        }

        return exec;
    }
	
	public int professorAccept(int pidx) {
        PreparedStatement selectP_no = null;
        PreparedStatement insertP_no = null;
        ResultSet rs = null;
        int exec = 0;
        int currentYear = Year.now().getValue();

        String selectCnt = "select count(*) as cnt from professor where p_no=?";
        String selectedP_no = "update professor set p_yn='Y', p_no=? where pidx=?";
        int p_no;

        try {
        	
            // 트랜잭션 시작
            conn.setAutoCommit(false);
            
            do {
                // 랜덤으로 s_no 생성
                p_no = currentYear * 10000 + (int) (Math.random() * 9000) + 1000;

                // 중복 체크
                selectP_no = conn.prepareStatement(selectCnt);
                selectP_no.setInt(1, p_no);
                rs = selectP_no.executeQuery();

            } while (rs.next() && rs.getInt("cnt") > 0);

            // 중복이 아닐 때 업데이트
            insertP_no = conn.prepareStatement(selectedP_no);
            insertP_no.setInt(1, p_no);
            insertP_no.setInt(2, pidx);
            exec = insertP_no.executeUpdate();

            // 트랜잭션 커밋
            conn.commit();

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                // 트랜잭션 롤백
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackException) {
                rollbackException.printStackTrace();
            }
        } finally {
            try {
                // 리소스 정리 및 AutoCommit 설정 복원
                if (rs != null) {
                    rs.close();
                }
                if (selectP_no != null) {
                    selectP_no.close();
                }
                if (insertP_no != null) {
                    insertP_no.close();
                }
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException closeException) {
                closeException.printStackTrace();
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
		PreparedStatement selectS_no = null;
		PreparedStatement insertS_no = null;
		ResultSet rs = null;
        int exec = 0;
        int currentYear = Year.now().getValue();

        String selectCnt = "select count(*) as cnt from student where s_no=?";
        String selectedS_no = "update student set s_yn='Y', s_no=? where sidx=?";
		
		try{
			
            // 트랜잭션 시작
            conn.setAutoCommit(false);
			
            for (int value : selectedData) {
                int s_no;

                // 각 value에 대해 새로운 s_no 생성 및 중복 체크
                do {
                    s_no = currentYear * 100000 + (int) (Math.random() * 89999);

                    // 중복 체크
                    selectS_no = conn.prepareStatement(selectCnt);
                    selectS_no.setInt(1, s_no);
                    rs = selectS_no.executeQuery();
                } while (rs.next() && rs.getInt("cnt") > 0);

                // 중복이 아닐 때 업데이트
                insertS_no = conn.prepareStatement(selectedS_no);
                insertS_no.setInt(1, s_no);
                insertS_no.setInt(2, value);
                int rowsAffected = insertS_no.executeUpdate();
                exec += rowsAffected;
            }
            // 트랜잭션 커밋
            conn.commit();

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                // 트랜잭션 롤백
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackException) {
                rollbackException.printStackTrace();
            }
        } finally {
            try {
                // 리소스 정리 및 AutoCommit 설정 복원
                if (rs != null) {
                    rs.close();
                }
                if (selectS_no != null) {
                    selectS_no.close();
                }
                if (insertS_no != null) {
                    insertS_no.close();
                }
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException closeException) {
                closeException.printStackTrace();
            }
        }

        return exec;
		
	}

	public int studentCheckedDeny(int[] selectedData) {
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
		PreparedStatement selectP_no = null;
		PreparedStatement insertP_no = null;
		ResultSet rs = null;
        int exec = 0;
        int currentYear = Year.now().getValue();

        String selectCnt = "select count(*) as cnt from professor where p_no=?";
        String selectedP_no = "update professor set p_yn='Y', p_no=? where pidx=?";
		
		try{
			
            // 트랜잭션 시작
            conn.setAutoCommit(false);
			
            for (int value : selectedData) {
                int p_no;

                // 각 value에 대해 새로운 p_no 생성 및 중복 체크
                do {
                    p_no = currentYear * 10000 + (int) (Math.random() * 9000) + 1000;

                    // 중복 체크
                    selectP_no = conn.prepareStatement(selectCnt);
                    selectP_no.setInt(1, p_no);
                    rs = selectP_no.executeQuery();
                } while (rs.next() && rs.getInt("cnt") > 0);

                // 중복이 아닐 때 업데이트
                insertP_no = conn.prepareStatement(selectedP_no);
                insertP_no.setInt(1, p_no);
                insertP_no.setInt(2, value);
                int rowsAffected = insertP_no.executeUpdate();
                exec += rowsAffected;
            }
            // 트랜잭션 커밋
            conn.commit();

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                // 트랜잭션 롤백
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackException) {
                rollbackException.printStackTrace();
            }
        } finally {
            try {
                // 리소스 정리 및 AutoCommit 설정 복원
                if (rs != null) {
                    rs.close();
                }
                if (selectP_no != null) {
                    selectP_no.close();
                }
                if (insertP_no != null) {
                    insertP_no.close();
                }
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException closeException) {
                closeException.printStackTrace();
            }
        }

        return exec;
		
	}

	public int professorCheckedDeny(int[] selectedData) {
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

	public ArrayList<CourseVo> courseListPrint(int year_int, int term_int) {
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
	    	
	    	conn.setAutoCommit(false);
	    	
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
	        
	        conn.commit();
	        
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                // 트랜잭션 롤백
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackException) {
                rollbackException.printStackTrace();
            }
        } finally{
			try{
	            if (selectStmt != null) selectStmt.close();
	            if (deleteStmtByCtidx != null) deleteStmtByCtidx.close();
	            if (deleteStmtByCidx != null) deleteStmtByCidx.close();
	            if (conn != null) {
	                if (!conn.getAutoCommit()) {
	                    // 트랜잭션이 활성화된 경우에만 롤백 및 자동 커밋 설정
	                    conn.rollback();
	                    conn.setAutoCommit(true);
	                }
	                conn.close();
	            }
            } catch (SQLException closeException) {
                closeException.printStackTrace();
            }
		}
        return exec;
    }

	public ArrayList<MemberVo> courseRegisterCheck(String c_major) {
		ArrayList<MemberVo> list = new ArrayList<MemberVo>();
		ResultSet rs = null;
		
		String sql = "select p_no from professor where p_major=?";
		
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, c_major);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MemberVo mv = new MemberVo();
				mv.setP_no( rs.getInt("p_no") ); 
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
	
	public int professorVerification(int p_no, String p_name) {
		ResultSet rs = null;
		String checkName = null;
		int value = 0;
		
		String sql = "select p_name from professor where p_no =?";
		
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			rs = pstmt.executeQuery();
		
			if (rs.next()){
				checkName =	rs.getString("p_name");
			}
			
			if(checkName.equals(p_name)) {
				value=1;
			}else value =0; 
			
		
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
		return value;
	}
	
	
	public MemberVo courseProfessorCheck(int p_no) {
	    ResultSet rs = null;
	    MemberVo memberVo = null; 
		
		String sql = "select p_name from professor where p_no =?";
		
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, p_no);
			rs = pstmt.executeQuery();
		
			if (rs.next()){
	            memberVo = new MemberVo(); // 객체를 생성합니다.
	            memberVo.setP_name(rs.getString("p_name"));
			}
			

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
		return memberVo;
	}

	public int courseTimeVerification(String ct_room, String ct_week, int pe_period, int ct_semester, int ct_year, String c_major, int c_grade, int p_no) {
		ResultSet rs = null;
		int value=0;
		
		String sql = "SELECT COUNT(*) AS cnt\n"
				+ "FROM course a\n"
				+ "JOIN coursetime b ON a.cidx = b.cidx\n"
				+ "JOIN professor c ON c.pidx = a.pidx\n"
				+ "WHERE (\n"
				+ "    (REPLACE(ct_room, ' ', '') = REPLACE(?,' ','') OR (c_major = ? AND c_grade = ?) OR p_no = ?)\n"
				+ "    AND ct_week = ?\n"
				+ "    AND pe_period = ?\n"
				+ "    AND ct_semester = ?\n"
				+ "    AND ct_year = ?\n"
				+ ")";
		
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, ct_room);
			pstmt.setString(2, c_major);
			pstmt.setInt(3, c_grade);
			pstmt.setInt(4, p_no);
			pstmt.setString(5, ct_week);
			pstmt.setInt(6, pe_period);
			pstmt.setInt(7, ct_semester);
			pstmt.setInt(8, ct_year);
			
			rs = pstmt.executeQuery();
		
			if (rs.next()){
				value =	rs.getInt("cnt");
			}

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
		return value;
	}
		

	public int courseRegister(String c_name, String c_major, String c_sep, String p_no, String c_grade, String p_name,
			String c_score, String c_totaltime, ArrayList<CourseTimeVo> ctv) {
		PreparedStatement selectStmt =null;
		PreparedStatement intsertStmtPidx = null;
		PreparedStatement insertCourseTimeStmt = null;
		ResultSet rs = null;
		int exec = 0;

	    try {
	    	
	    	// 트랜잭션 설정
	    	conn.setAutoCommit(false);
	    	
	        // pidx 값을 가져오기
	    	String selectPidx = "select pidx from professor where p_major=? and p_no=? and p_name =?";
	        selectStmt = conn.prepareStatement(selectPidx);
	        selectStmt.setString(1, c_major);
	        selectStmt.setString(2, p_no);
	        selectStmt.setString(3, p_name);
	        rs = selectStmt.executeQuery();
	        
	        int pidx = 0;
	        if (rs.next()) {
	            pidx = rs.getInt("pidx");
	        }

	        // course 테이블에 데이터 삽입
	        String insertCourse = "INSERT INTO course(pidx, c_name, c_grade, c_major, c_score, c_totaltime, c_sep) VALUES (?, ?, ?, ?, ?, ?, ?)";
	        intsertStmtPidx = conn.prepareStatement(insertCourse);
	        intsertStmtPidx.setInt(1, pidx);
	        intsertStmtPidx.setString(2, c_name);
	        intsertStmtPidx.setString(3, c_grade);
	        intsertStmtPidx.setString(4, c_major);
	        intsertStmtPidx.setString(5, c_score);
	        intsertStmtPidx.setString(6, c_totaltime);
	        intsertStmtPidx.setString(7, c_sep);

	        exec = intsertStmtPidx.executeUpdate();
	        
	        // coursetime 테이블에 데이터 삽입
	        for (CourseTimeVo courseTimeVo : ctv) {
	        	String insertCourseTime = "insert into coursetime(cidx,ct_room,ct_week,pe_period,ct_semester,ct_year)\n"
	        			+ "values((select max(cidx) from course),?,?,?,?,?)";
	        	insertCourseTimeStmt = conn.prepareStatement(insertCourseTime);
	            insertCourseTimeStmt.setString(1, courseTimeVo.getCt_room());
	            insertCourseTimeStmt.setString(2, courseTimeVo.getCt_week());
	            insertCourseTimeStmt.setInt(3, courseTimeVo.getPe_period());
	            insertCourseTimeStmt.setInt(4, courseTimeVo.getCt_semester());
	            insertCourseTimeStmt.setInt(5, courseTimeVo.getCt_year());
	            
	            int result = insertCourseTimeStmt.executeUpdate();
	            
	            // result를 확인하여 적절한 처리 수행
	            if (result == 0) {
	                throw new SQLException("Failed to insert into coursetime");
	            }
	        }
	        
	        // 트랜잭션 성공 시 커밋
	        conn.commit();

	    } catch (Exception e) {
	        e.printStackTrace();

	        try {
	            // 트랜잭션 롤백
	            if (conn != null) {
	                conn.rollback();
	            }
	        } catch (SQLException rollbackException) {
	            rollbackException.printStackTrace();
	        }

	    } finally {
	        try {
	            // ResultSet, PreparedStatement, Connection close 로직
	            if (rs != null) rs.close();
	            if (selectStmt != null) selectStmt.close();
	            if (intsertStmtPidx != null) intsertStmtPidx.close();
	            if (insertCourseTimeStmt != null) insertCourseTimeStmt.close();
	            if (conn != null) {
	                // 원래의 autocommit 설정으로 변경
	                conn.setAutoCommit(true);
	                conn.close();
	            }
	        } catch (SQLException closeException) {
	            closeException.printStackTrace();
	        }
	    }

	    return exec;
	}

	public ArrayList<MemberVo> courseMatchStudentList(int cidx, String c_major, int c_grade) {
		ArrayList<MemberVo> sMacthList = new ArrayList<MemberVo>();
		ResultSet rs = null;
		
		String sql = "select a.sidx,a.s_name,a.s_no,a.s_grade,a.s_major\n"
				+ "from student a left join courselist b on a.sidx=b.sidx\n"
				+ "left join course c on b.cidx=c.cidx\n"
				+ "where (b.sidx not in (select sidx from courselist where cidx =?) or b.cidx is null)\n"
				+ "and s_yn='Y' and a.s_major=? and a.s_grade=?\n"
				+ "group by a.sidx,a.s_name,a.s_no,a.s_grade,a.s_major";
		
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cidx);
			pstmt.setString(2, c_major);
			pstmt.setInt(3, c_grade);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				MemberVo mv = new MemberVo();
				
				mv.setSidx( rs.getInt("a.sidx") ); 
				mv.setS_name( rs.getString("a.s_name") );
				mv.setS_no( rs.getInt("a.s_no"));
				mv.setS_grade( rs.getInt("a.s_grade"));
				mv.setS_major( rs.getString("a.s_major"));
				
				sMacthList.add(mv);
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
		return sMacthList;
	}

	public int checkedEnroll(ArrayList<MemberVo> mv, int cidx) {
		PreparedStatement selectStmt =null;
		PreparedStatement insertStmtSidxCtidx = null;
		ResultSet rs = null;
		int exec = 0;
		
	    try {
	    	
	    	conn.setAutoCommit(false);
	    	
	        // ctidx 값을 가져오기
	        String selectCtidx = "SELECT ctidx FROM coursetime a JOIN course b ON a.cidx = b.cidx WHERE b.cidx = ?";
	        selectStmt = conn.prepareStatement(selectCtidx);
	        selectStmt.setInt(1, cidx);
	        rs = selectStmt.executeQuery();

	        // ctidx 값을 저장할 리스트
	        ArrayList<Integer> ctidxList = new ArrayList<>();
	        while (rs.next()) {
	            int ctidx = rs.getInt("ctidx");
	            ctidxList.add(ctidx);
	        }

	        // sidxArray와 ctidxList를 순회하며 데이터 입력
	        String insertcourseList = "INSERT INTO courselist(sidx, cidx, ctidx) VALUES (?, ?, ?)";
	        insertStmtSidxCtidx = conn.prepareStatement(insertcourseList);

	        for (MemberVo memberVo : mv) {
	            int sidx = memberVo.getSidx();

	            // ctidxList를 기준으로 sidx를 여러번 insert
	            for (int ctidx : ctidxList) {
	            	insertStmtSidxCtidx.setInt(1, sidx);
	            	insertStmtSidxCtidx.setInt(2, cidx);
	            	insertStmtSidxCtidx.setInt(3, ctidx);

	                exec += insertStmtSidxCtidx.executeUpdate();
	            }
	        }
	        
	        conn.commit();

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                // 트랜잭션 롤백
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackException) {
                rollbackException.printStackTrace();
            }
	    } finally {
	        // 필요에 따라 리소스를 닫아주는 로직 추가
	        try {
	            if (rs != null) rs.close();
	            if (selectStmt != null) selectStmt.close();
	            if (insertStmtSidxCtidx != null) insertStmtSidxCtidx.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException closeException) {
                closeException.printStackTrace();
            }
	    }

	    return exec;
	}

	public int studentEnroll(int cidx, int sidx) {
		PreparedStatement selectStmt =null;
		PreparedStatement insertStmtCtidx = null;
		ResultSet rs = null;
		int exec = 0;
	    try {
	    	
	    	conn.setAutoCommit(false);
	    	
	        // ctidx 값을 가져오기
	        String selectCtidx = "SELECT ctidx FROM coursetime a JOIN course b ON a.cidx = b.cidx WHERE b.cidx = ?";
	        selectStmt = conn.prepareStatement(selectCtidx);
	        selectStmt.setInt(1, cidx);
	        rs = selectStmt.executeQuery();

	        // ctidx 값을 저장할 리스트
	        ArrayList<Integer> ctidxList = new ArrayList<>();
	        while (rs.next()) {
	            int ctidx = rs.getInt("ctidx");
	            ctidxList.add(ctidx);
	        }

	        // ctidxList를 순회하며 데이터 입력
	        String insertcourseList = "INSERT INTO courselist(sidx, cidx, ctidx) VALUES (?, ?, ?)";
	        insertStmtCtidx = conn.prepareStatement(insertcourseList);
	        
            for (int ctidx : ctidxList) {
            	insertStmtCtidx.setInt(1, sidx);
            	insertStmtCtidx.setInt(2, cidx);
            	insertStmtCtidx.setInt(3, ctidx);

                exec += insertStmtCtidx.executeUpdate();
            }
            
            conn.commit();
	            
	    } catch (Exception e) {
	        e.printStackTrace();
            try {
                // 트랜잭션 롤백
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackException) {
                rollbackException.printStackTrace();
            }
	    } finally {
	        // 필요에 따라 리소스를 닫아주는 로직 추가
	        try {
	            if (rs != null) rs.close();
	            if (selectStmt != null) selectStmt.close();
	            if (insertStmtCtidx != null) insertStmtCtidx.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException closeException) {
                closeException.printStackTrace();
            }
	    }

	    return exec;

	}

	public ArrayList<WeektbVo> opendateList(int year_int, int term_int) {
		ArrayList<WeektbVo> datelist = new ArrayList<WeektbVo>();
		ResultSet rs=null;
		
		String sql = "select w_week,w_start,w_end from weektb where startyear = ? and starttm = ?";
		
		try{
		 
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, year_int);
			pstmt.setInt(2, term_int);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				WeektbVo wv = new WeektbVo();
				
				wv.setW_week(rs.getInt("w_week"));
				wv.setW_start(rs.getString("w_start"));
				wv.setW_end(rs.getString("w_end"));
				datelist.add(wv);
			}
			
		} catch(Exception e){
			e.printStackTrace();
		}
				
		return datelist;
	}
	
	public int openDateRegisterCheck(int year_int, int semester_int) {
		ResultSet rs = null;
		int exec = 0;

		 String sql = "select count(*) cnt from weektb where startyear = ? and starttm = ?";
		 
		try{
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, year_int);
			pstmt.setInt(2, semester_int);
			rs = pstmt.executeQuery();
			
			if (rs.next()){
				exec =	rs.getInt("cnt");
			}
			
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
	
	
	public int openDateRegister(String startdate, int startyear, int tm) {
		int exec = 0;
		String sql = "CALL weekmake4(?,?,?)";
		 
		try (CallableStatement cstmt = conn.prepareCall(sql)) {
		    cstmt.setString(1, startdate);
		    cstmt.setInt(2, startyear);
		    cstmt.setInt(3, tm);
		    exec = cstmt.executeUpdate();
		} catch (SQLException e) {
		    e.printStackTrace();
		}
			
		return exec;
	}

	public int openDateUpdate(String startdate, int syear, int stm) {
		int exec = 0;
		String sql = "CALL Updateweekmake4(?,?,?)";
		 
		try (CallableStatement cstmt = conn.prepareCall(sql)) {
		    cstmt.setString(1, startdate);
		    cstmt.setInt(2, syear);
		    cstmt.setInt(3, stm);
		    exec = cstmt.executeUpdate();
		} catch (SQLException e) {
		    e.printStackTrace();
		}
			
		return exec;
	}








	

}
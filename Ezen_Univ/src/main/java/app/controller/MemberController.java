package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import app.dao.MemberDao;
import app.domain.MemberVo;
import app.mail.NaverMailSend;

//HttpServlet를 상속받았기 때문에 클래스가 인터넷페이지가 된다.
@WebServlet("/MemberController")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private String location;
	public MemberController(String location) {
		this.location = location;
	}

	@SuppressWarnings("null")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		/*요청 주소 파악*/
		//String requestURI = request.getRequestURI();
		//String contextPath = request.getContextPath();
		//String command = requestURI.substring(contextPath.length());
		//System.out.println("M.Front.C : 1. 요청 주소 계산 완료");
		
		/*각 요청 주소의 매핑 처리*/
		//ActionForward forward = null;
		//Action action = null;
		
		
		
		if(location.equals("memberIdCheck.do")) {
			MemberDao md = new MemberDao();
			String memberId = request.getParameter("memberId");
			int check1 = 0;
			int check2 = 0;
			int value = 0;
			
			check1 = md.memberIdCheck1(memberId);
			check2 = md.memberIdCheck2(memberId);
			value = check1 + check2;
			String str = "{\"value\":\""+value+"\"}";
			PrintWriter out = response.getWriter();
			out.println(str);
			
		}else if(location.equals("studentJoinAction.do")) {
			

			String s_id = request.getParameter("memberId");
			String s_pwd = request.getParameter("memberPwd");
			String s_name = request.getParameter("memberName");
			String s_phone = request.getParameter("memberPhone");
			String s_email = request.getParameter("memberEmail");
			int s_birth = Integer.parseInt(request.getParameter("memberBirth"));
			String s_major = request.getParameter("memberMajor");
			
			LocalDate now = LocalDate.now();
			int year = now.getYear();
			
			//int s_no = year*100000;
			//s_no += (int)(Math.random() * 89999);
			//중복 체크하는 메소드 필요
			
			MemberDao md = new MemberDao();
			int exec = md.studentInsert(s_id, s_pwd, s_name, s_phone, s_email, s_birth, s_major);

			PrintWriter out = response.getWriter();
			//boolean tf = stmt.execute(sql);//해당 구문(쿼리)를 실행시킨다

			//System.out.println(sql);
			//System.out.println(tf);
			if(exec == 1){
				//자동 이동 메소드
				//response.sendRedirect(request.getContextPath()+"/member/memberList.html");
				out.println("<script>alert(\"회원가입되었습니다.\");"
				+"document.location.href='"+request.getContextPath()+"/index.jsp'</script>");
			}else{
				out.println("<script>history.back();</script>");
			}
			
		}else if(location.equals("professorJoinAction.do")) {
			

			String p_id = request.getParameter("memberId");
			String p_pwd = request.getParameter("memberPwd");
			String p_name = request.getParameter("memberName");
			String p_phone = request.getParameter("memberPhone");
			String p_email = request.getParameter("memberEmail");
			int p_birth = Integer.parseInt(request.getParameter("memberBirth"));
			String p_major = request.getParameter("memberMajor");
			
			LocalDate now = LocalDate.now();
			int year = now.getYear();
			
			//int p_no = year*10000;
			//p_no += (int)(Math.random() * 8999);
			//중복 체크하는 메소드 필요
			
			MemberDao md = new MemberDao();
			int exec = md.professorInsert(p_id, p_pwd, p_name, p_phone, p_email, p_birth, p_major);

			PrintWriter out = response.getWriter();
			//boolean tf = stmt.execute(sql);//해당 구문(쿼리)를 실행시킨다

			//System.out.println(sql);
			//System.out.println(tf);
			if(exec == 1){
				//자동 이동 메소드
				//response.sendRedirect(request.getContextPath()+"/member/memberList.html");
				out.println("<script>alert(\"회원가입되었습니다.\");"
				+"document.location.href='"+request.getContextPath()+"/index.jsp'</script>");
			}else{
				out.println("<script>history.back();</script>");
			}
			
		}else if(location.equals("memberLogout.do")) {
			HttpSession session = request.getSession();

			session.invalidate(); //초기화
			PrintWriter out = response.getWriter();
			
			out.println("<script>alert('로그아웃이 완료되었습니다.'); localStorage.clear(); document.location.href='"+request.getContextPath() +"/index.jsp'</script>");
			
			
			//response.sendRedirect(request.getContextPath()+"/index.jsp");
			
		}else if(location.equals("studentLoginAction.do")) {
			
			String s_id = request.getParameter("memberId");
			String s_pwd = request.getParameter("memberPwd");
			
			
			MemberDao md = new MemberDao();
			int midx = 0;
			midx = md.studentLoginCheck(s_id, s_pwd);
			if (midx!=0){ //아이디비번 일치
				//세션에 회원 아이디를 담는다
				HttpSession session = request.getSession();
				MemberVo mv = new MemberVo();
				
				mv = md.studentSidxSearch(s_id);
				PrintWriter out = response.getWriter();
				
				if(mv.getS_no()==0) {
					out.println("<script>alert('가입승인이 이루어지지 않았습니다.'); history.back();</script>");
				}else {
					
					session.setAttribute("sidx", mv.getSidx());
					session.setAttribute("s_no", mv.getS_no());
					session.setAttribute("s_name", mv.getS_name());
					session.setAttribute("s_major", mv.getS_major());
					
					response.sendRedirect(request.getContextPath()+"/main/main_s.do");
				}
				
			}else{//아이디 비번 불일치
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script language='javascript' type='text/javascript'> alert('로그인 실패'); </script>");
				out.println("<script>location.href='../index.jsp';</script>");
				//response.sendRedirect("./main/main_s.do");
			}
			
		}else if(location.equals("professorLoginAction.do")) {
			
			String p_id = request.getParameter("memberId");
			String p_pwd = request.getParameter("memberPwd");
			
			
			MemberDao md = new MemberDao();
			int pidx = 0;
			pidx = md.professorLoginCheck(p_id, p_pwd);
			if (pidx!=0){ 
				
				HttpSession session = request.getSession();
				MemberVo mv = new MemberVo();
				
				mv = md.professorPidxSearch(p_id);
				PrintWriter out = response.getWriter();
				
				if(mv.getP_no()==0) {
					out.println("<script>alert('가입승인이 이루어지지 않았습니다.'); history.back();</script>");
				}else {
					
					session.setAttribute("pidx", mv.getPidx());
					session.setAttribute("p_no", mv.getP_no());
					session.setAttribute("p_name", mv.getP_name());
					session.setAttribute("p_major", mv.getP_major());
					
					response.sendRedirect(request.getContextPath()+"/main/main_p.do");
				}
				
			}else{//아이디 비번 불일치
				response.setCharacterEncoding("UTF-8");
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script language='javascript' type='text/javascript'> alert('로그인 실패'); </script>");
				out.println("<script>location.href='../index.jsp';</script>");
				//response.sendRedirect("./main/main_s.do");
			}
			
		}else if(location.equals("searchStudentId.do")) {
			String memberName = request.getParameter("memberName");
			String memberEmail = request.getParameter("memberEmail");
			
			MemberDao md = new MemberDao();
			int value = md.searchStudentIdcnt(memberName, memberEmail);
			String memberId = "";
			String str = "";
			if(value==0) {
				str = null;
			}else {
				memberId = md.searchStudentId(memberName, memberEmail);
				str = "{\"memberId\" : \""+memberId+"\"}";
			}
			PrintWriter out = response.getWriter();
			out.println(str);
			//System.out.println(str);
		}else if(location.equals("searchProfessorId.do")) {
			String memberName = request.getParameter("memberName");
			String memberEmail = request.getParameter("memberEmail");
			
			MemberDao md = new MemberDao();
			int value = md.searchProfessorIdcnt(memberName, memberEmail);
			String memberId = "";
			String str = "";
			if(value==0) {
				str = null;
			}else {
				memberId = md.searchProfessorId(memberName, memberEmail);
				str = "{\"memberId\" : \""+memberId+"\"}";
			}
			PrintWriter out = response.getWriter();
			out.println(str);
		}else if(location.equals("searchStudentPwd.do")) {
			String memberId = request.getParameter("memberId");
			String memberName = request.getParameter("memberName");
			String memberEmail = request.getParameter("memberEmail");
			
			HttpSession session = request.getSession();
			
			MemberDao md = new MemberDao();
			int value = md.searchStudentPwd(memberId, memberName, memberEmail);
			String str = "";
			if(value==0) {
				str = null;
			}else {
				str = "{\"value\" : \""+value+"\"}";
				NaverMailSend nm = new NaverMailSend();
				try {
					System.out.println("메일인증 컨트롤러");
					nm.sendEmail(memberEmail, session);
					System.out.println("저장된 세션값:"+session.getAttribute("authenCode"));
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			PrintWriter out = response.getWriter();
			out.println(str);
		}else if(location.equals("searchProfessorPwd.do")) {
			String memberId = request.getParameter("memberId");
			String memberName = request.getParameter("memberName");
			String memberEmail = request.getParameter("memberEmail");
			HttpSession session = request.getSession();
			
			MemberDao md = new MemberDao();
			int value = md.searchProfessorPwd(memberId, memberName, memberEmail);
			String str = "";
			if(value==0) {
				str = null;
			}else {
				str = "{\"value\" : \""+value+"\"}";
				NaverMailSend nm = new NaverMailSend();
				try {
					System.out.println("메일인증 컨트롤러");
					nm.sendEmail(memberEmail, session);
					System.out.println(nm.toString());
					
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
			//System.out.println("저장된 세션값:"+session.getAttribute("authenCode"));
			PrintWriter out = response.getWriter();
			out.println(str);

		}else if(location.equals("changeStudentPwd.do")) {
			String memberId = request.getParameter("memberId");
			String memberName = request.getParameter("memberName");
			String memberEmail = request.getParameter("memberEmail");
			String newpwd = request.getParameter("newpwd");
			
			MemberDao md = new MemberDao();
			int value = md.changeStudentPwd(memberId, memberName, memberEmail, newpwd);
			String str = "";
			if(value==0) {
				str = null;
			}else {
				str = "{\"value\" : \""+value+"\"}";
			}
			PrintWriter out = response.getWriter();
			out.println(str);
		}
		else if(location.equals("changeProfessorPwd.do")) {
			String memberId = request.getParameter("memberId");	
			String memberName = request.getParameter("memberName");
			String memberEmail = request.getParameter("memberEmail");
			String newpwd = request.getParameter("newpwd");
			
			MemberDao md = new MemberDao();
			int value = md.changeProfessorPwd(memberId, memberName, memberEmail, newpwd);
			String str = "";
			if(value==0) {
				str = null;
			}else {
				str = "{\"value\" : \""+value+"\"}";
			}
			PrintWriter out = response.getWriter();
			out.println(str);
		}else if(location.equals("send_emailAction.do")) {
			String memberId = request.getParameter("m_id");
			String memberemail = request.getParameter("m_email");
			HttpSession forsession =request.getSession();
			
			NaverMailSend nm = new NaverMailSend();
			try {
				nm.sendEmail(memberemail,forsession);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else if(location.equals("securepassCheck.do")) {
			String securepass = request.getParameter("securepass");
			HttpSession session = request.getSession();
			String savedPass = (String) session.getAttribute("authenCode");
			String str = "";
			if(securepass.equals(savedPass)) {
				str = "{\"value\":\"1\"}";
			}else {
				str = "{\"value\":\"0\"}";
			}
			PrintWriter out = response.getWriter();
			out.println(str);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import app.dao.CourseDao;
import app.dao.MemberDao;
import app.domain.CourseVo;
import app.domain.MemberVo;
import app.domain.TableVo;

@WebServlet("/CourseController")
public class MypageController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private String location;
	public MypageController(String location) {
		this.location = location;
	}
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		if(location.equals("courseList_s.do")) {
			CourseDao cd = new CourseDao();
			
			HttpSession session = request.getSession();
			int sidx = ((Integer)(session.getAttribute("sidx"))).intValue();
			
			LocalDate now = LocalDate.now();
			int year = now.getYear();
			int month = now.getMonthValue();
			int term = 0;
			if(month >= 1 && month <= 7) {
				term = 1;
			}else {
				term = 2;
			}
			
			ArrayList<CourseVo> list = cd.studentCourseList(sidx,year,term);
			
			request.setAttribute("list", list);
			request.setAttribute("year", year);
			request.setAttribute("semester", term);
			
			String path = "/mypage/courseList_s.jsp";
			//화면용도의 주소는 forward로 토스해서 해당 찐 주소로 보낸다.
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(location.equals("personalinfo_s.do")) {

			MemberDao md = new MemberDao();
			
			HttpSession session = request.getSession();
			int sidx = ((Integer)(session.getAttribute("sidx"))).intValue();
			
			MemberVo mv = md.studentInfo(sidx);
			
			request.setAttribute("mv", mv);
			
			String path = "/mypage/personalinfo_s.jsp";
			
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(location.equals("modifyinfo_s.do")) {
			MemberDao md = new MemberDao();
			
			HttpSession session = request.getSession();
			int sidx = ((Integer)(session.getAttribute("sidx"))).intValue();
			
			MemberVo mv = md.studentInfo(sidx);
			
			request.setAttribute("mv", mv);
			
			String path = "/mypage/modifyinfo_s.jsp";
			
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(location.equals("modifyinfo_sAction.do")) {
			
			HttpSession session = request.getSession();
			int sidx = ((Integer)(session.getAttribute("sidx"))).intValue();
			
			String studentPhone = request.getParameter("studentPhone");
			String studentEmail = request.getParameter("studentEmail");
			
			int value = 0;
			MemberDao md = new MemberDao();
			value = md.studentInfoModify(sidx, studentPhone, studentEmail);
			
			if(value ==0) {
				PrintWriter out = response.getWriter();
				out.println("<script language='javascript' type='text/javascript'> alert('수정 실패'); </script>");
				out.println("<script>location.href='modifyinfo_s.do';</script>");
			}else {
				response.sendRedirect(request.getContextPath()+"/mypage/personalinfo_s.do");
			}
			
		}else if(location.equals("modifypassword_s.do")) {
			
			HttpSession session = request.getSession();
			int sidx = ((Integer)(session.getAttribute("sidx"))).intValue();
			
			String s_id = "";
			MemberDao md = new MemberDao();
			s_id = md.studentSearchId(sidx);
			
			request.setAttribute("s_id", s_id);
			
			String path = "/mypage/modifypassword_s.jsp";
			
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(location.equals("modifypassword_sAction.do")) {
			
			HttpSession session = request.getSession();
			int sidx = ((Integer)(session.getAttribute("sidx"))).intValue();
			
			String s_pwd = request.getParameter("nowPass");
			String s_newpwd = request.getParameter("newPass");
			
			int value = 0;
			MemberDao md = new MemberDao();
			
			value = md.studentPwdModify(sidx, s_pwd, s_newpwd);
			PrintWriter out = response.getWriter();
			if(value != 0) {
				out.println("<script language='javascript' type='text/javascript'> alert('비밀번호가 정상적으로 변경되었습니다.'); </script>");
				out.println("<script>location.href='modifypassword_s.do';</script>");
			}else {
				out.println("<script language='javascript' type='text/javascript'> alert('현재 비밀번호가 일치하지 않습니다.'); </script>");
				out.println("<script>location.href='modifypassword_s.do';</script>");
			}
			
		}else if(location.equals("mytable_s.do")) {
			CourseDao cd = new CourseDao();
			
			HttpSession session = request.getSession();
			int sidx = ((Integer)(session.getAttribute("sidx"))).intValue();
			
			LocalDate now = LocalDate.now();
			int year = now.getYear();
			int month = now.getMonthValue();
			int term = 0;
			if(month >= 1 && month <= 7) {
				term = 1;
			}else {
				term = 2;
			}
			
			ArrayList<TableVo> list = new ArrayList<>();
			list = cd.studentMyTable(sidx,year,term);
			
			request.setAttribute("list", list);
			request.setAttribute("year", year);
			request.setAttribute("semester", term);
			
			String path = "/mypage/mytable_s.jsp";
			
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(location.equals("personalinfo_p.do")) {
			MemberDao md = new MemberDao();
			
			HttpSession session = request.getSession();
			int pidx = ((Integer)(session.getAttribute("pidx"))).intValue();
			
			MemberVo mv = md.professorInfo(pidx);
			
			String phone = mv.getP_phone();
			phone = phone.substring(0, 3)+"-"+phone.substring(3, 7)+"-"+phone.substring(7);
			mv.setP_phone(phone);
			
			
			request.setAttribute("mv", mv);
			String path = "/mypage/personalinfo_p.jsp";
			
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(location.equals("modifyinfo_p.do")) {
			MemberDao md = new MemberDao();
			
			HttpSession session = request.getSession();
			int pidx = ((Integer)(session.getAttribute("pidx"))).intValue();
			
			MemberVo mv = md.professorInfo(pidx);
			
			request.setAttribute("mv", mv);
			
			String path = "/mypage/modifyinfo_p.jsp";
			
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(location.equals("modifyinfo_pAction.do")) {
			
			HttpSession session = request.getSession();
			int pidx = ((Integer)(session.getAttribute("pidx"))).intValue();
			
			String professorPhone = request.getParameter("professorPhone");
			String professorEmail = request.getParameter("professorEmail");
			
			int value = 0;
			MemberDao md = new MemberDao();
			value = md.professorInfoModify(pidx, professorPhone, professorEmail);
			
			if(value ==0) {
				PrintWriter out = response.getWriter();
				out.println("<script language='javascript' type='text/javascript'> alert('수정 실패'); </script>");
				out.println("<script>location.href='modifyinfo_p.do';</script>");
			}else {
				response.sendRedirect(request.getContextPath()+"/mypage/personalinfo_p.do");
			}
			
		}else if(location.equals("modifypassword_p.do")) {
			
			HttpSession session = request.getSession();
			int pidx = ((Integer)(session.getAttribute("pidx"))).intValue();
			
			String p_id = "";
			MemberDao md = new MemberDao();
			p_id = md.professorSearchId(pidx);
			
			request.setAttribute("p_id", p_id);
			
			String path = "/mypage/modifypassword_p.jsp";
			
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(location.equals("modifypassword_pAction.do")) {
			
			HttpSession session = request.getSession();
			int pidx = ((Integer)(session.getAttribute("pidx"))).intValue();
			
			String p_pwd = request.getParameter("nowPass");
			String p_newpwd = request.getParameter("newPass");
			
			int value = 0;
			MemberDao md = new MemberDao();
			
			value = md.professorPwdModify(pidx, p_pwd, p_newpwd);
			PrintWriter out = response.getWriter();
			if(value != 0) {
				out.println("<script language='javascript' type='text/javascript'> alert('비밀번호가 정상적으로 변경되었습니다.'); </script>");
			}else {
				out.println("<script language='javascript' type='text/javascript'> alert('현재 비밀번호가 일치하지 않습니다.'); </script>");
			}
			out.println("<script>location.href='modifypassword_p.do';</script>");
			
		}else if(location.equals("courseList_p.do")) {
			CourseDao cd = new CourseDao();
			
			HttpSession session = request.getSession();
			int pidx = ((Integer)(session.getAttribute("pidx"))).intValue();
			
			LocalDate now = LocalDate.now();
			int year = now.getYear();
			int month = now.getMonthValue();
			int term = 0;
			if(month >= 1 && month <= 7) {
				term = 1;
			}else {
				term = 2;
			}
			
			ArrayList<CourseVo> courselist = cd.professorCourseList(pidx,year,term);
			ArrayList<TableVo> tablelist = cd.professorMyTable(pidx,year,term);
			
			request.setAttribute("courselist", courselist);
			request.setAttribute("tablelist", tablelist);
			request.setAttribute("year", year);
			request.setAttribute("semester", term);
			
			String path = "/mypage/courseList_p.jsp";
			//화면용도의 주소는 forward로 토스해서 해당 찐 주소로 보낸다.
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}
	}
	
}
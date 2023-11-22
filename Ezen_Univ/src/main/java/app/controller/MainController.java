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
import app.dao.NoticeDao;
import app.domain.NoticeVo;
import app.domain.SearchCriteria;
import app.domain.TableVo;

@WebServlet("/MainController")
public class MainController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private String location;
	public MainController(String location) {
		this.location = location;
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		if(location.equals("main_s.do")) {
			
			HttpSession session = request.getSession();
			
			PrintWriter out = response.getWriter();
			if(session.getAttribute("sidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
			}
			
			if(session.getAttribute("sidx")!=null&&session.getAttribute("pidx")!=null) {
				session.invalidate();
				String path = request.getContextPath();
				out.println("<script>alert('다시 로그인해주세요'); location.href='"+path+"/index.jsp';</script>");
			}
			int sidx = ((Integer)(session.getAttribute("sidx"))).intValue();

			String subject = request.getParameter("subject");
			if (subject ==null) subject="0";			
			String page = request.getParameter("page");
			if (page ==null) page ="1";
			
			String sub = request.getParameter("subject");
			request.setAttribute("sub", sub);
			
			SearchCriteria scri = new SearchCriteria();
			scri.setPage(Integer.parseInt(page));	
			
			int cidx = Integer.parseInt(subject);
			scri.setSubject(cidx);
			
			NoticeDao nd = new NoticeDao();
			CourseDao cd = new CourseDao();
			
			
			ArrayList<NoticeVo> alist = nd.getList_p(sidx, scri);
			ArrayList<NoticeVo> noticeList = new ArrayList<>();
			
			if(alist.size()!=0) {
				if(alist.size()>5) {
					for(int i=0; i<5; i++) {
						noticeList.add(i, alist.get(i));
					}
				}else {
					for(int i=0; i<alist.size(); i++) {
						noticeList.add(i, alist.get(i));
					}
				}
			}
			request.setAttribute("alist", noticeList);
			
			
			LocalDate now = LocalDate.now();
			int year = now.getYear();
			int month = now.getMonthValue();
			int term = 0;
			if(month >= 1 && month <= 7) {
				term = 1;
			}else {
				term = 2;
			}
			
			ArrayList<TableVo> tablelist = cd.studentMyTable(sidx,year,term);
			request.setAttribute("tablelist", tablelist);
			
			String path = "/main/main_s.jsp";

			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		}else if(location.equals("main_p.do")) {
			
			HttpSession session = request.getSession(); 
			PrintWriter out = response.getWriter();
			if(session.getAttribute("sidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
			}
			if(session.getAttribute("sidx")!=null&&session.getAttribute("pidx")!=null) {
				session.invalidate();
				String path = request.getContextPath();
				out.println("<script>alert('다시 로그인해주세요'); location.href='"+path+"/index.jsp';</script>");
			}
			String subject = request.getParameter("subject");
			if (subject ==null) subject="0";			
			String page = request.getParameter("page");
			if (page ==null) page ="1";
			
			String sub = request.getParameter("subject");
			request.setAttribute("sub", sub);
			
			SearchCriteria scri = new SearchCriteria();
			scri.setPage(Integer.parseInt(page));	
			
			int cidx = Integer.parseInt(subject);
			scri.setSubject(cidx);
			
			NoticeDao nd = new NoticeDao();
			CourseDao cd = new CourseDao();
			
			
			int pidx = ((Integer)(session.getAttribute("pidx"))).intValue();
			
			ArrayList<NoticeVo> alist = nd.getList_p(pidx, scri);
			ArrayList<NoticeVo> noticeList = new ArrayList<>();
			
			if(alist.size()!=0) {
				if(alist.size()>5) {
					for(int i=0; i<5; i++) {
						noticeList.add(i, alist.get(i));
					}
				}else {
					for(int i=0; i<alist.size(); i++) {
						noticeList.add(i, alist.get(i));
					}
				}
			}
			
			request.setAttribute("alist", noticeList);
			
			LocalDate now = LocalDate.now();
			int year = now.getYear();
			int month = now.getMonthValue();
			int term = 0;
			if(month >= 1 && month <= 7) {
				term = 1;
			}else {
				term = 2;
			}
			
			ArrayList<TableVo> tablelist = cd.professorMyTable(pidx,year,term);
			request.setAttribute("tablelist", tablelist);
			
			String path = "/main/main_p.jsp";

			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		}else if(location.equals("main_a.do")) {
				
			response.sendRedirect(request.getContextPath()+"/main/main_a.jsp");
		}
	}
}

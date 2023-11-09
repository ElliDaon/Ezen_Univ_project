package app.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import app.dao.CourseDao;
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
			
			CourseDao cd = new CourseDao();
			
			HttpSession session = request.getSession();
			int sidx = ((Integer)(session.getAttribute("sidx"))).intValue();
			
			ArrayList<TableVo> tablelist = cd.studentMyTable(sidx);
			request.setAttribute("tablelist", tablelist);
			
			String path = "/main/main_s.jsp";

			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		}else if(location.equals("main_p.do")) {
			
			
			CourseDao cd = new CourseDao();
			
			HttpSession session = request.getSession();
			int pidx = ((Integer)(session.getAttribute("pidx"))).intValue();
			
			ArrayList<TableVo> tablelist = cd.professorMyTable(pidx);
			request.setAttribute("tablelist", tablelist);
			
			String path = "/main/main_p.jsp";

			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		}
	}
}

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
import app.domain.CourseVo;

@WebServlet("/CourseController")
public class MypageController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private String location;
	public MypageController(String location) {
		this.location = location;
	}
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		if(location.equals("courseList_s.jsp")) {
			System.out.println("컨트롤러 왔음");
			CourseDao cd = new CourseDao();
			
			HttpSession session = request.getSession();
			int sidx = Integer.parseInt((String) session.getAttribute("sidx"));
			
			ArrayList<CourseVo> list = cd.studentCourseList(sidx);
			
			
			request.setAttribute("list", list);
			
			String path = "/mypage/courseList_s.jsp";
			//화면용도의 주소는 forward로 토스해서 해당 찐 주소로 보낸다.
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}
	}
	
}
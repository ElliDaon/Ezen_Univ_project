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

import app.dao.AttendanceDao;
import app.domain.AttendanceVo;

@WebServlet("/AttendanceController")
public class AttendanceController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private String location;
	public AttendanceController(String location) {
		this.location = location;
	}
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(location.equals("attendanceSituation_s.do")) {
			System.out.println("컨트롤러");
			AttendanceDao ad = new AttendanceDao();
			
			HttpSession session = request.getSession();
			int sidx = ((Integer)(session.getAttribute("sidx"))).intValue();
			
			
			ArrayList<AttendanceVo> list = ad.attendanceCourseList(sidx);
			
			
			request.setAttribute("list", list);
			
			String path = "/attendance/attendanceSituation_s.jsp";
			//화면용도의 주소는 forward로 토스해서 해당 찐 주소로 보낸다.
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}
	}
	
}
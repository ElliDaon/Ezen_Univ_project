package app.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import app.dao.AttendanceDao;
import app.domain.AttendanceVo;

@WebServlet("/AttendanceController")
public class AttendanceController {
	private static final long serialVersionUID = 1L;

	private String location;
	public AttendanceController(String location) {
		this.location = location;
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		if (location.equals("studentCourseList.do")) {

			AttendanceDao ad = new AttendanceDao();
			ArrayList<AttendanceVo> clist = ad.studentCourseList();

			//화면으로 가지고 간다
			request.setAttribute("clist", clist);	

			String path ="/attendance/attendanceSituation_s.jsp";
			//화면용도의 주소는 포워드로 토스해서 해당 찐주소로 보낸다
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);	

			}

	}
}
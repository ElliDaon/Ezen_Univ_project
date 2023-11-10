package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
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
			
		}else if(location.equals("attendanceCount.do")) {
			AttendanceDao ad = new AttendanceDao();
			
			HttpSession session = request.getSession();
			int sidx = ((Integer)(session.getAttribute("sidx"))).intValue();		
			int cidx = Integer.parseInt(request.getParameter("cidx"));
			
			AttendanceVo av = ad.attendanceCount(sidx, cidx);
			AttendanceVo alv = ad.lateCount(sidx, cidx);
			AttendanceVo alev = ad.leaveCount(sidx, cidx);
			AttendanceVo abv = ad.absentCount(sidx, cidx);
						
			int attcnt = 0;
			int latecnt = 0;
			int leavecnt = 0;
			int absentcnt = 0;
			
			attcnt = av.getAttendanceCount();
			latecnt = av.getLateCount();
			leavecnt = av.getLeaveCount();
			absentcnt = av.getAbsentCount();
			String str ="";
			str = str + "{\"attcnt\":"+attcnt+",\"latecnt\":"+latecnt+",\"leavecnt\":"+leavecnt+",\"absentcnt\":"+absentcnt+"}";
			
			PrintWriter out = response.getWriter();
			out.println(str);
			System.out.println(str);
			
		}else if(location.equals("attendanceList.do")) {
			AttendanceDao ad = new AttendanceDao();
			
			HttpSession session = request.getSession();
			int sidx = Integer.parseInt(request.getParameter("sidx"));
			int cidx = Integer.parseInt(request.getParameter("cidx"));
			
			ArrayList<AttendanceVo> alist = ad.attendanceList(sidx, cidx);
			request.setAttribute("alist", alist);
			int listCnt = alist.size();
			int widx = 0;
			String atdate = "";
			String attime = "";
			String e_attendance = "";
			
			for(int i = 0; i < listCnt; i++) {
			widx = alist.get(i).getWidx();
			atdate = alist.get(i).getAtdate();
			attime = alist.get(i).getAttime();
			e_attendance = alist.get(i).getE_attendance();
			
			String comma = "";
			if (i == listCnt-1) {	//i가 listsize의 마지막 횟수이면 ,(comma)가 아닌 쉼표를 쓸거다
				comma = "";
			}else {
				comma = ",";
			}
			
			String str ="";
			str = str + "{\"widx\":"+widx+",\"atdate\":"+atdate+",\"attime\":"+attime+",\"e_attendance\":"+e_attendance+"}";
			
			PrintWriter out = response.getWriter();
			out.println(str);
			System.out.println(str);
		}
	}
}
}
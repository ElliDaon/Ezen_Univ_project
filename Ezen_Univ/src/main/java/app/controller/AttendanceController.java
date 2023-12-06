package app.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import app.dao.AttendanceDao;
import app.dao.CourseDao;
import app.domain.AttendanceVo;
import app.domain.CourseVo;
import app.domain.EachCheckVo;
import app.domain.MemberVo;

@WebServlet("/AttendanceController")
public class AttendanceController extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	private String location;
	public AttendanceController(String location) {
		this.location = location;
	}
	
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(location.equals("attendanceSituation_s.do")) {
			
			
			
			HttpSession session = request.getSession();
			
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("sidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
			}
			int sidx = ((Integer)(session.getAttribute("sidx"))).intValue();
			AttendanceDao ad = new AttendanceDao();
			
			LocalDate now = LocalDate.now();
			int year = now.getYear();
			int month = now.getMonthValue();
			int semester = 0;
			if(month >= 1 && month <= 7) {
				semester = 1;
			}else {
				semester = 2;
			}
			
			ArrayList<AttendanceVo> slist = ad.attendanceCourseList_s(sidx, year, semester);
			request.setAttribute("list", slist);
			request.setAttribute("year", year);
			request.setAttribute("semester", semester);
			
			String path = "/attendance/attendanceSituation_s.jsp";
			//화면용도의 주소는 forward로 토스해서 해당 찐 주소로 보낸다.
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
			out.println(sidx);
			
			
		}else if(location.equals("attendanceCount.do")) {
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("sidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
			}
			
			AttendanceDao ad = new AttendanceDao();
			
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
			latecnt = alv.getLateCount();
			leavecnt = alev.getLeaveCount();
			absentcnt = abv.getAbsentCount();
			String str ="";
			str = str + "{\"attcnt\":"+attcnt+",\"latecnt\":"+latecnt+",\"leavecnt\":"+leavecnt+",\"absentcnt\":"+absentcnt+"}";
			
			out.println(str);
			
		}else if(location.equals("attendanceList.do")) {
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("sidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
			}
			
			AttendanceDao ad = new AttendanceDao();
			
			int sidx = ((Integer)(session.getAttribute("sidx"))).intValue();
			int cidx = Integer.parseInt(request.getParameter("cidx"));
			
			ArrayList<AttendanceVo> alist = ad.attendanceList(sidx, cidx);
			request.setAttribute("alist", alist);
			
			int listCnt = alist.size();
			int widx = 0;
			String atdate = "";
			String attime = "";
			String e_attendance = "";
			String str2 ="";
			
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
			
			str2 = str2 + "{\"widx\":"+widx+",\"atdate\":\""+atdate+"\",\"attime\":\""+attime+"\",\"e_attendance\":\""+e_attendance+"\"}"+comma;
			
			}
			//for 구문 밖에서 대괄호로 감싸주기
			str2= "["+str2+"]";
			out.println(str2);
			
		}else if(location.equals("attendanceSituation_p.do")) {
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("pidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
			}
			
			AttendanceDao ad = new AttendanceDao();
			
			int pidx = ((Integer)(session.getAttribute("pidx"))).intValue();
			
			LocalDate now = LocalDate.now();
			int year = now.getYear();
			int month = now.getMonthValue();
			int semester = 0;
			if(month >= 1 && month <= 7) {
				semester = 1;
			}else {
				semester = 2;
			}
			
			
			CourseDao cd = new CourseDao();
			ArrayList<CourseVo> courselist = cd.professorCourseList(pidx,year,semester);

			ArrayList<Integer> clist = new ArrayList<>();
			for(int i=0; i<courselist.size(); i++) {
				clist.add(courselist.get(i).getCidx());
			}
			
			ArrayList<AttendanceVo> plist = new ArrayList<>();
			for(int i=0; i<courselist.size(); i++) {
				AttendanceVo av = ad.attendanceCourseList_p(clist.get(i));
				plist.add(av);
			}
			request.setAttribute("list", plist);
			request.setAttribute("year", year);
			request.setAttribute("semester", semester);
			
			String path = "/attendance/attendanceSituation_p.jsp";
			//화면용도의 주소는 forward로 토스해서 해당 찐 주소로 보낸다.
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		}else if(location.equals("getAttendanceTable.do")) {
			
			
			AttendanceDao ad = new AttendanceDao();
			
			int cidx = Integer.parseInt(request.getParameter("cidx"));
			
			LocalDate now = LocalDate.now();
			int year = now.getYear();
			int month = now.getMonthValue();
			int semester = 0;
			if(month >= 1 && month <= 7) {
				semester = 1;
			}else {
				semester = 2;
			}
			ArrayList<AttendanceVo> getDate = ad.getAttendanceDate(cidx, year, semester);
			int listsize = getDate.size();
			String a_date = "";
			String ct_week = "";
			int pe_period = 0;
			String str = "";
			
			for(int i=0; i<listsize; i++) {
				a_date = getDate.get(i).getA_date();
				ct_week = getDate.get(i).getCt_week();
				pe_period = getDate.get(i).getPe_period();
				
				String comma = "";
				if (i == listsize - 1) {
					comma = "";
				} else {
					comma = ",";
				}
				str = str+"{\"a_date\" : \""+a_date+"\", \"ct_week\" : \""+ct_week+"\", \"pe_period\" : \""+pe_period+"\"}"+comma;
			}
			
			PrintWriter out = response.getWriter();
			out.println("[" + str + "]");
			
		}else if(location.equals("attendancePreManagement.do")) {
			
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("pidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
			}
			AttendanceDao ad = new AttendanceDao();
			
			int pidx = ((Integer)(session.getAttribute("pidx"))).intValue();
			
			LocalDate now = LocalDate.now();
			int year = now.getYear();
			int month = now.getMonthValue();
			int semester = 0;
			if(month >= 1 && month <= 7) {
				semester = 1;
			}else {
				semester = 2;
			}
			
			ArrayList<AttendanceVo> courselist = ad.selectCourse(pidx, year, semester);
			request.setAttribute("list", courselist);
			request.setAttribute("year", year);
			request.setAttribute("semester", semester);
			
			String path = "/attendance/attendancePreManagement.jsp";
			//화면용도의 주소는 forward로 토스해서 해당 찐 주소로 보낸다.
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(location.equals("tscount.do")){
			AttendanceDao ad = new AttendanceDao();
			
			int cidx = Integer.parseInt(request.getParameter("cidx"));
			
			LocalDate now = LocalDate.now();
			int year = now.getYear();
			int month = now.getMonthValue();
			int semester = 0;
			if(month >= 1 && month <= 7) {
				semester = 1;
			}else {
				semester = 2;
			}
			
			AttendanceVo av = ad.totalStudentCount(cidx, year, semester);
			int s_cnt = 0;
			
			s_cnt = av.getS_cnt();
			
			String str = "";
			
			str = str + "{\"s_cnt\" : "+s_cnt+"}";
				
			
			PrintWriter out = response.getWriter();
			out.println(str);

		}else if(location.equals("professorManagement.do")) {
			int cidx = Integer.parseInt(request.getParameter("cidx"));
			AttendanceDao ad = new AttendanceDao();
			ArrayList<AttendanceVo> list = ad.professorManagement(cidx);
			int list_size = list.size();
			int w_week = 0;
			String ct_week = ""; 
			String wk = "";
			int pe_period = 0;
			String pe_start = "";
			String pe_end = "";
			int att = 0;
			int early = 0;
			int late = 0;
			int absent =  0;
			String str = "";
			for(int i=0; i<list_size; i++) {
				w_week = list.get(i).getW_week();
				ct_week = list.get(i).getCt_week();
				wk = list.get(i).getAtdate();
				pe_period = list.get(i).getPe_period();
				pe_start = list.get(i).getPe_start();
				pe_end = list.get(i).getPe_end();
				att = list.get(i).getAttendanceCount();
				early = list.get(i).getLeaveCount();
				late = list.get(i).getLateCount();
				absent = list.get(i).getAbsentCount();
				
				String comma = "";
				if (i == list_size - 1) {
					comma = "";
				} else {
					comma = ",";
				}
				
				str = str + "{\"w_week\" : \""+w_week+"\", \"ct_week\" : \""+ct_week+"\", \"wk\" : \""+wk+"\", \"pe_period\" : \""+pe_period
					+"\", \"pe_start\" : \""+pe_start+"\", \"pe_end\" : \""+pe_end+"\", \"att\" : \""+att
					+"\", \"early\" : \""+early+"\", \"late\" : \""+late+"\", \"absent\" : \""+absent+"\"}"+comma;
			}
			PrintWriter out = response.getWriter();
			out.println("[" + str + "]");
			
		}else if(location.equals("attendanceManagement.do")) {
			int cidx = Integer.parseInt(request.getParameter("cidx"));
			int w_week = Integer.parseInt(request.getParameter("no"));
			String dates = request.getParameter("dates");
			String ct_week = request.getParameter("week");
			int period = Integer.parseInt(request.getParameter("period"));
			
			
			String str = "{\"cidx\":\""+cidx+"\", \"w_week\": \""+w_week+"\", \"dates\":\""+dates+"\", \"ct_week\":\""+ct_week+"\", \"period\":\""+period+"\"}";
			PrintWriter out = response.getWriter();
			out.println(str);
		}else if(location.equals("professorAttendProcessing.do")) {
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("pidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
			}
			int cidx = Integer.parseInt(request.getParameter("cidx"));
			int w_week = Integer.parseInt(request.getParameter("w_week"));
			String dates = request.getParameter("dates");
			String ct_week = request.getParameter("ct_week");
			int period = Integer.parseInt(request.getParameter("period"));
			
			AttendanceVo av = new AttendanceVo();
			
			AttendanceDao ad = new AttendanceDao();
			av = ad.searchDetail(cidx, ct_week, period, w_week);
			av.setCidx(cidx);
			av.setW_week(w_week);
			av.setCt_week(ct_week);
			av.setPe_period(period);
			av.setA_date(dates);
			
			String str2 = w_week +"주차&ensp;/&ensp;"+ dates + "&ensp;/&ensp;" + period + "교시 ";
			
			request.setAttribute("str2", str2);
			
			request.setAttribute("av", av);
			
			ArrayList<MemberVo> list = ad.professorAttendProcessing(cidx, dates, w_week, period,av.getCtidx());
			request.setAttribute("list", list);
			
			String path = "/attendance/attendanceManagement.jsp";
			
			
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		}else if(location.equals("attendanceAction.do")) {
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("pidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
			}
			
			int ctidx = Integer.parseInt(request.getParameter("ctidx"));
			String a_date = request.getParameter("a_date");
			String pe_start = request.getParameter("pe_start");
			String pe_end = request.getParameter("pe_end");
			int cidx = Integer.parseInt(request.getParameter("cidx"));
			int widx = Integer.parseInt(request.getParameter("widx"));
			int period = Integer.parseInt(request.getParameter("period"));
			
			AttendanceVo av = new AttendanceVo();
			av.setCtidx(ctidx);
			av.setA_date(a_date);
			av.setA_start(pe_start);
			av.setA_end(pe_end);
			av.setCidx(cidx);
			av.setWidx(widx);
			av.setPe_period(period);
			
			String attendValue = request.getParameter("Array");
			
			JSONParser parser = new JSONParser();
		    JSONArray jsonArray = null;
		    
		    try {
				jsonArray = (JSONArray) parser.parse(attendValue);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
		    ArrayList<EachCheckVo> list = new ArrayList<>();
		    for(int i=1; i<jsonArray.size(); i++){
				//배열 안에 있는것도 JSON형식 이기 때문에 JSON Object 로 추출            
				JSONObject insertData = (JSONObject) jsonArray.get(i);
				int clidx = Integer.parseInt((String) insertData.get("clidx"));
				String attvalue = (String)insertData.get("attendvalue");
				
				EachCheckVo ecv = new EachCheckVo();
				ecv.setClidx(clidx);
				ecv.setE_attendance(attvalue);
				list.add(ecv);
			}
		    
		    AttendanceDao ad = new AttendanceDao();
		    int value = ad.attendanceAction(list, av);
		    
			String str = "{\"value\":\""+value+"\"}";
			out.println(str);
			
		}else if(location.equals("lackOfAttendance.do")) {
			HttpSession session = request.getSession();
			PrintWriter out = response.getWriter();
			
			if(session.getAttribute("pidx")==null) {
				String path = request.getContextPath();
				out.println("<script>alert('로그인이 필요합니다'); location.href='"+path+"/index.jsp';</script>");
			}
			int pidx = ((Integer)(session.getAttribute("pidx"))).intValue();
			
			LocalDate now = LocalDate.now();
			int year = now.getYear();
			int month = now.getMonthValue();
			int semester = 0;
			if(month >= 1 && month <= 7) {
				semester = 1;
			}else {
				semester = 2;
			}
			
			request.setAttribute("year", year);
			request.setAttribute("semester", semester);
			
			AttendanceDao ad = new AttendanceDao();
			ArrayList<AttendanceVo> cidxList = ad.selectCourse(pidx, year, semester);
			ArrayList<AttendanceVo> CourseList = new ArrayList<>();
			
			int cidxCnt = cidxList.size();
			
			for(int i=0; i<cidxCnt; i++) {
				int listCidx = cidxList.get(i).getCidx();
				CourseList.add(i,ad.toomuchAbsenceList(listCidx));
			}
			
			request.setAttribute("list", CourseList);
			
			String path = "/attendance/lackOfAttendance.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		}else if(location.equals("toomuchAbsenceListAction.do")) {
			int cidx = Integer.parseInt(request.getParameter("cidx"));
			
			AttendanceDao ad = new AttendanceDao();
			ArrayList<MemberVo> list = ad.toomuchAbsenceListAction(cidx);
			int listsize = list.size();
			
			String str = "";
			
			for(int i=0; i<listsize; i++) {
				String s_name = list.get(i).getS_name();
				int s_no = list.get(i).getS_no();
				String count = list.get(i).getAbcount();
				String per = list.get(i).getAbper();
				String c_name = list.get(i).getC_name();
			
				
				String comma = "";
				if (i == listsize - 1) {
					comma = "";
				} else {
					comma = ",";
				}
				
				str = str + "{\"c_name\" : \""+c_name+"\",\"s_name\" : \""+s_name+"\", \"s_no\" : \""+s_no+"\", \"count\" : \""+count+"\", \"per\" : \""+per+"\"}"+comma;
			}
			
			PrintWriter out = response.getWriter();
		
			
			out.println("["+str+"]");
			
		}else if(location.equals("getStudentList.do")) {
			int cidx = Integer.parseInt(request.getParameter("cidx"));
			
			AttendanceDao ad = new AttendanceDao();
			ArrayList<MemberVo> studentlist = ad.getAttendanceStudent(cidx);
			String s_name = "";
			int s_no = 0;
			int c_totaltime = 0;
			String str = "";
			for(int i=0; i<studentlist.size(); i++) {
				String comma = "";
				if (i == studentlist.size() - 1) {
					comma = "";
				} else {
					comma = ",";
				}
				
				s_name = studentlist.get(i).getS_name();
				s_no = studentlist.get(i).getS_no();
				c_totaltime = studentlist.get(i).getC_totaltime();
				str = str + "{\"s_name\" : \""+s_name+"\", \"s_no\" : \""+s_no+"\",\"c_totaltime\" : \""+c_totaltime+"\"}"+comma;
			}
			PrintWriter out = response.getWriter();
			out.println("["+str+"]");
		}else if(location.equals("getEachCheck.do")) {
			int cidx = Integer.parseInt(request.getParameter("cidx"));
			
			AttendanceDao ad = new AttendanceDao();
			List<AttendanceVo> eachlist = ad.getEachCehck(cidx);
			int s_no = 0;
			String a_date = "";
			String a_start = "";
			String e_attendance = "";
			String str = "";
			int pe_period = 0;
			for(int i=0; i<eachlist.size(); i++) {
				String comma = "";
				if (i == eachlist.size() - 1) {
					comma = "";
				} else {
					comma = ",";
				}
				
				s_no = eachlist.get(i).getS_no();
				a_date = eachlist.get(i).getA_date();
				a_date = a_date.substring(5, 7)+a_date.substring(8,10);
				a_start = eachlist.get(i).getA_start();
				a_start = a_start.substring(0,5);
				
				if(a_start.equals("09:00")) {
					pe_period = 1;
				}else if(a_start.equals("10:00")) {
					pe_period = 2;
				}else if(a_start.equals("11:00")) {
					pe_period = 3;
				}else if(a_start.equals("12:00")) {
					pe_period = 4;
				}else if(a_start.equals("13:00")) {
					pe_period = 5;
				}else if(a_start.equals("14:00")) {
					pe_period = 6;
				}else if(a_start.equals("15:00")) {
					pe_period = 7;
				}else if(a_start.equals("16:00")) {
					pe_period = 8;
				}else if(a_start.equals("17:00")) {
					pe_period = 9;
				}
				e_attendance = eachlist.get(i).getE_attendance();
				
				str = str + "{\"s_no\" : \""+s_no+"\", \"a_date\" : \""+a_date+"\", \"pe_period\" : \""+pe_period+"\", \"e_attendance\" : \""+e_attendance+"\"}"+comma;
			}
			PrintWriter out = response.getWriter();
			out.println("["+str+"]");
		}
	}	
}
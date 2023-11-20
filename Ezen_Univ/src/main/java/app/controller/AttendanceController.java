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

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import app.dao.AttendanceDao;
import app.domain.AttendanceVo;
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
			//System.out.println("컨트롤러");
			AttendanceDao ad = new AttendanceDao();
			
			HttpSession session = request.getSession();
			int sidx = ((Integer)(session.getAttribute("sidx"))).intValue();
			
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
			
			PrintWriter out = response.getWriter();
			out.println(sidx);
			//System.out.println(sidx);
			
			
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
			latecnt = alv.getLateCount();
			leavecnt = alev.getLeaveCount();
			absentcnt = abv.getAbsentCount();
			String str ="";
			str = str + "{\"attcnt\":"+attcnt+",\"latecnt\":"+latecnt+",\"leavecnt\":"+leavecnt+",\"absentcnt\":"+absentcnt+"}";
			
			PrintWriter out = response.getWriter();
			out.println(str);
			System.out.println(str);
			
		}else if(location.equals("attendanceList.do")) {
			AttendanceDao ad = new AttendanceDao();
			
			HttpSession session = request.getSession();
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
			PrintWriter out = response.getWriter();
			out.println(str2);
			//System.out.println(str2);
			
		}else if(location.equals("attendanceSituation_p.do")) {
			AttendanceDao ad = new AttendanceDao();
			
			HttpSession session = request.getSession();
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
			
			ArrayList<AttendanceVo> plist = ad.attendanceCourseList_p(pidx, year, semester);
			request.setAttribute("list", plist);
			request.setAttribute("year", year);
			request.setAttribute("semester", semester);
			
			String path = "/attendance/attendanceSituation_p.jsp";
			//화면용도의 주소는 forward로 토스해서 해당 찐 주소로 보낸다.
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
			
		}else if(location.equals("searchList.do")) {
			AttendanceDao ad = new AttendanceDao();
			
			String c_name = request.getParameter("c_name");
			String a_date = request.getParameter("a_date");
			String a_start = request.getParameter("a_start");
			
			ArrayList<AttendanceVo> searchlist = ad.searchList(c_name, a_date, a_start);
			int list_size = searchlist.size();
			String s_name = "";
			String s_major = "";
			int s_no = 0;
			String e_attendance = "";
			
			String str = "";
			
			for(int i=0; i<list_size; i++) {
				s_name = searchlist.get(i).getS_name();
				s_major = searchlist.get(i).getS_major();
				s_no = searchlist.get(i).getS_no();
				e_attendance = searchlist.get(i).getE_attendance();
				
				String comma = "";
				if (i == list_size - 1) {
					comma = "";
				} else {
					comma = ",";
				}
				
				str = str + "{\"s_name\" : \""+s_name+"\" , \"s_major\" : \""+s_major+"\", \"s_no\" : \""+s_no+"\", \"e_attendance\" : \""+e_attendance+"\"}"+comma;
			}
			
			PrintWriter out = response.getWriter();
			out.println("[" + str + "]");
			
		}else if(location.equals("attendancePreManagement.do")) {
			AttendanceDao ad = new AttendanceDao();
			
			HttpSession session = request.getSession();
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
			
			
			//System.out.println("cidx: "+cidx+"\n w_week: "+w_week+"\n dates: "+dates+"\n ct_week: "+ct_week+"\n period: "+period);
			
			String str = "{\"cidx\":\""+cidx+"\", \"w_week\": \""+w_week+"\", \"dates\":\""+dates+"\", \"ct_week\":\""+ct_week+"\", \"period\":\""+period+"\"}";
			PrintWriter out = response.getWriter();
			out.println(str);
		}else if(location.equals("professorAttendProcessing.do")) {
			
			int cidx = Integer.parseInt(request.getParameter("cidx"));
			int w_week = Integer.parseInt(request.getParameter("w_week"));
			String dates = request.getParameter("dates");
			String ct_week = request.getParameter("ct_week");
			int period = Integer.parseInt(request.getParameter("period"));
			
			//System.out.println("cidx?"+cidx+"w_week?"+w_week+"dates?"+dates+"ct_week?"+ct_week+"period?"+period);
			
			AttendanceVo av = new AttendanceVo();
			
			AttendanceDao ad = new AttendanceDao();
			av = ad.searchDetail(cidx, ct_week, period, w_week);
			av.setCidx(cidx);
			av.setW_week(w_week);
			av.setCt_week(ct_week);
			av.setPe_period(period);
			av.setA_date(dates);
			
			//System.out.println("ctidx: "+av.getCtidx()+"\n a_start: "+av.getPe_start()+"\n a_end: "+av.getPe_end()+"\n widx: "+av.getWidx()+"\n c_name: "+av.getC_name());
			request.setAttribute("av", av);
			
			ArrayList<MemberVo> list = ad.professorAttendProcessing(cidx, dates, w_week, period,av.getCtidx());
			request.setAttribute("list", list);
			
			String path = "/attendance/attendanceManagement.jsp";
			
			
			RequestDispatcher rd = request.getRequestDispatcher(path);
			rd.forward(request, response);
		}else if(location.equals("attendanceAction.do")) {
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
			//System.out.println("넘어온값"+ctidx+a_date+pe_start+pe_end+cidx+widx+"\n value"+attendValue);
			
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
				
				//System.out.println(clidx+attvalue);
				//System.out.println(insertData);
			}
		    
		    AttendanceDao ad = new AttendanceDao();
		    int value = ad.attendanceAction(list, av);
		    
			String str = "{\"value\":\""+value+"\"}";
			PrintWriter out = response.getWriter();
			out.println(str);
			
		}else if(location.equals("lackOfAttendance.do")) {
			HttpSession session = request.getSession();
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
				
				String comma = "";
				if (i == listsize - 1) {
					comma = "";
				} else {
					comma = ",";
				}
				
				str = str + "{\"s_name\" : \""+s_name+"\", \"s_no\" : \""+s_no+"\", \"count\" : \""+count+"\", \"per\" : \""+per+"\"}"+comma;
			}
			
			
			//System.out.println(cidx);
			
			PrintWriter out = response.getWriter();
			out.println("["+str+"]");
			
		}
	}	
}
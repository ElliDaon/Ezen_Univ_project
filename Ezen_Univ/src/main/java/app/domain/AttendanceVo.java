package app.domain;

public class AttendanceVo extends CourseVo  {
	private int aidx;
	private int ctidx;
	private String a_date;
	private String a_start; 
	private String a_end;
	private String a_skipyn;
	private int clidx;
	private int cidx;
	private int widx;
	private int sidx;
	private String atdate;
	private String attime;
	private String e_attendance;
	private int attendanceCount;
	private int lateCount;
	private int leaveCount;
	private int absentCount;
	private int s_cnt;
	
	public int getAidx() {
		return aidx;
	}
	public void setAidx(int aidx) {
		this.aidx = aidx;
	}
	public int getCtidx() {
		return ctidx;
	}
	public void setCtidx(int ctidx) {
		this.ctidx = ctidx;
	}
	public String getA_date() {
		return a_date;
	}
	public void setA_date(String a_date) {
		this.a_date = a_date;
	}
	public String getA_start() {
		return a_start;
	}
	public void setA_start(String a_start) {
		this.a_start = a_start;
	}
	public String getA_end() {
		return a_end;
	}
	public void setA_end(String a_end) {
		this.a_end = a_end;
	}
	public String getA_skipyn() {
		return a_skipyn;
	}
	public void setA_skipyn(String a_skipyn) {
		this.a_skipyn = a_skipyn;
	}
	public int getClidx() {
		return clidx;
	}
	public void setClidx(int clidx) {
		this.clidx = clidx;
	}
	public int getCidx() {
		return cidx;
	}
	public void setCidx(int cidx) {
		this.cidx = cidx;
	}
	public int getWidx() {
		return widx;
	}
	public void setWidx(int widx) {
		this.widx = widx;
	}
	public int getSidx() {
		return sidx;
	}
	public void setSidx(int sidx) {
		this.sidx = sidx;
	}
	public String getAtdate() {
		return atdate;
	}
	public void setAtdate(String atdate) {
		this.atdate = atdate;
	}
	public String getAttime() {
		return attime;
	}
	public void setAttime(String attime) {
		this.attime = attime;
	}
	public String getE_attendance() {
		return e_attendance;
	}
	public void setE_attendance(String e_attendance) {
		this.e_attendance = e_attendance;
	}
	public int getAttendanceCount() {
		return attendanceCount;
	}
	public void setAttendanceCount(int attendanceCount) {
		this.attendanceCount = attendanceCount;
	}
	public int getLateCount() {
		return lateCount;
	}
	public void setLateCount(int lateCount) {
		this.lateCount = lateCount;
	}
	public int getLeaveCount() {
		return leaveCount;
	}
	public void setLeaveCount(int leaveCount) {
		this.leaveCount = leaveCount;
	}
	public int getAbsentCount() {
		return absentCount;
	}
	public void setAbsentCount(int absentCount) {
		this.absentCount = absentCount;
	}
	public int getS_cnt() {
		return s_cnt;
	}
	public void setS_cnt(int s_cnt) {
		this.s_cnt = s_cnt;
	}
}

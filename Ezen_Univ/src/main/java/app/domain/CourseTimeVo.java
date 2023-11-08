package app.domain;

public class CourseTimeVo extends PeriodVo{

	private int ctidx;
	private int cidx;
	private String ct_room;
	private String ct_week;
	private int pe_period;
	private int ct_semester;
	private int ct_year;
	private String ct_open;
	private String ct_close;
	
	public int getCtidx() {
		return ctidx;
	}
	public void setCtidx(int ctidx) {
		this.ctidx = ctidx;
	}
	public int getCidx() {
		return cidx;
	}
	public void setCidx(int cidx) {
		this.cidx = cidx;
	}
	public String getCt_room() {
		return ct_room;
	}
	public void setCt_room(String ct_room) {
		this.ct_room = ct_room;
	}
	public String getCt_week() {
		return ct_week;
	}
	public void setCt_week(String ct_week) {
		this.ct_week = ct_week;
	}
	public int getPe_period() {
		return pe_period;
	}
	public void setPe_period(int pe_period) {
		this.pe_period = pe_period;
	}
	public int getCt_semester() {
		return ct_semester;
	}
	public void setCt_semester(int ct_semester) {
		this.ct_semester = ct_semester;
	}
	public int getCt_year() {
		return ct_year;
	}
	public void setCt_year(int ct_year) {
		this.ct_year = ct_year;
	}
	public String getCt_open() {
		return ct_open;
	}
	public void setCt_open(String ct_open) {
		this.ct_open = ct_open;
	}
	public String getCt_close() {
		return ct_close;
	}
	public void setCt_close(String ct_close) {
		this.ct_close = ct_close;
	}

}

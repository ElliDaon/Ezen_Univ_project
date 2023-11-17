package app.domain;

import java.util.Date;

public class WeektbVo {
	private int w_week;
	private Date w_start;
	private Date w_end;
	private String startyear;
	private int starttm;
	private int widx;
	
	public int getW_week() {
		return w_week;
	}
	public void setW_week(int w_week) {
		this.w_week = w_week;
	}
	public Date getW_start() {
		return w_start;
	}
	public void setW_start(Date w_start) {
		this.w_start = w_start;
	}
	public Date getW_end() {
		return w_end;
	}
	public void setW_end(Date w_end) {
		this.w_end = w_end;
	}
	public String getStartyear() {
		return startyear;
	}
	public void setStartyear(String startyear) {
		this.startyear = startyear;
	}
	public int getStarttm() {
		return starttm;
	}
	public void setStarttm(int starttm) {
		this.starttm = starttm;
	}
	public int getWidx() {
		return widx;
	}
	public void setWidx(int widx) {
		this.widx = widx;
	}

}

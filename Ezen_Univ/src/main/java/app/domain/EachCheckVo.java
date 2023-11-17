package app.domain;

public class EachCheckVo extends AttendanceVo{
	private int eidx;
	private int clidx;
	private int aidx;
	private String e_attendance;
	
	public int getEidx() {
		return eidx;
	}
	public void setEidx(int eidx) {
		this.eidx = eidx;
	}
	public int getClidx() {
		return clidx;
	}
	public void setClidx(int clidx) {
		this.clidx = clidx;
	}
	public int getAidx() {
		return aidx;
	}
	public void setAidx(int aidx) {
		this.aidx = aidx;
	}
	public String getE_attendance() {
		return e_attendance;
	}
	public void setE_attendance(String e_attendance) {
		this.e_attendance = e_attendance;
	}
}

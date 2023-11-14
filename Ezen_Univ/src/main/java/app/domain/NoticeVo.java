package app.domain;

public class NoticeVo extends CourseVo{
	private int nidx;
	private String n_skipdate;
	private String n_category;
	private String n_contents;
	private String n_writeday;
	private int n_count;
	private int pidx;
	private int cidx;
	private boolean n_dday;
	
	public String getN_subject() {
		return n_subject;
	}
	public void setN_subject(String n_subject) {
		this.n_subject = n_subject;
	}
	private String n_delyn;
	private String n_subject;
	

	public int getNidx() {
		return nidx;
	}
	public void setNidx(int nidx) {
		this.nidx = nidx;
	}
	public String getN_skipdate() {
		return n_skipdate;
	}
	public void setN_skipdate(String n_skipdate) {
		this.n_skipdate = n_skipdate;
	}
	public String getN_category() {
		return n_category;
	}
	public void setN_category(String n_category) {
		this.n_category = n_category;
	}
	public String getN_contents() {
		return n_contents;
	}
	public void setN_contents(String n_contents) {
		this.n_contents = n_contents;
	}
	public String getN_writeday() {
		return n_writeday;
	}
	public void setN_writeday(String n_writeday) {
		this.n_writeday = n_writeday;
	}
	public int getN_count() {
		return n_count;
	}
	public void setN_count(int n_count) {
		this.n_count = n_count;
	}
	public int getPidx() {
		return pidx;
	}
	public void setPidx(int pidx) {
		this.pidx = pidx;
	}
	public int getCidx() {
		return cidx;
	}
	public void setCidx(int cidx) {
		this.cidx = cidx;
	}
	public String getN_delyn() {
		return n_delyn;
	}
	public void setN_delyn(String n_delyn) {
		this.n_delyn = n_delyn;
	}
	public boolean isN_dday() {
		return n_dday;
	}
	public void setN_dday(boolean n_dday) {
		this.n_dday = n_dday;
	}


}

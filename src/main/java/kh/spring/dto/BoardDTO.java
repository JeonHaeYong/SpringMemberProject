package kh.spring.dto;

import java.sql.Timestamp;

public class BoardDTO {
	private int seq;
	private String image;
	private String title;
	private String writer;
	private String contents;
	private int view_count;
	private Timestamp write_date;
	
	public BoardDTO() {
		super();
	}
	public BoardDTO(int seq, String image, String title, String writer, String contents, int view_count,
			Timestamp write_date) {
		super();
		this.seq = seq;
		this.image = image;
		this.title = title;
		this.writer = writer;
		this.contents = contents;
		this.view_count = view_count;
		this.write_date = write_date;
	}
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public int getView_count() {
		return view_count;
	}
	public void setView_count(int view_count) {
		this.view_count = view_count;
	}
	public Timestamp getWrite_date() {
		return write_date;
	}
	public void setWrite_date(Timestamp write_date) {
		this.write_date = write_date;
	}
}

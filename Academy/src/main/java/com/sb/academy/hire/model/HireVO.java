package com.sb.academy.hire.model;

import org.springframework.web.multipart.MultipartFile;

public class HireVO {

	private int boardNum;

	private String photo;

	private String title;

	private String content;
	
	private String date;

	private MultipartFile file;

	public int getBoardNum() {
		return boardNum;
	}

	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public MultipartFile getFile() {
		return file;
	}

	public void setFile(MultipartFile file) {
		this.file = file;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	@Override
	public String toString() {
		return "HireVO [boardNum=" + boardNum + ", photo=" + photo + ", title=" + title + ", content=" + content
				+ ", date=" + date + ", file=" + file + "]";
	}
	
	


	

}

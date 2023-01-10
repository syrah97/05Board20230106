package com.test.dto;

public class Criteria {
	private int pageno;	 //현재 페이지 
	private int amount;	 //표시할 게시물 양(10건)
	private String type;	//	제목,작성자,게시물번호
	private String keyword;	//	포함문자열
	
	
	public Criteria() {
		pageno=1;
		amount=10;
	}
	public Criteria(int no,int amt) {
		pageno = no;
		amount =amt;
	}
	
	
	public int getPageno() {
		return pageno;
	}
	public void setPageno(int pageno) {
		this.pageno = pageno;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	@Override
	public String toString() {
		return "Criteria [pageno=" + pageno + ", amount=" + amount + ", type=" + type + ", keyword=" + keyword + "]";
	}
	
	
	//Getter and Setter
	//toString
	//default 생성자
	
}

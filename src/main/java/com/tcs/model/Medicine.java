package com.tcs.model;

public class Medicine {
	String name;
	long mid;
	int qty;
	double rate;
	double amount;
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public long getMid() {
		return mid;
	}
	
	public void setMid(long mid) {
		this.mid = mid;
	}
	
	public int getQty() {
		return qty;
	}
	
	public void setQty(int qty) {
		this.qty = qty;
	}
	
	public double getRate() {
		return rate;
	}
	
	public void setRate(double rate) {
		this.rate = rate;
	}
	
	public double getAmount() {
		return amount;
	}
	
	public void setAmount() {
		this.amount = this.rate*this.qty;
	}
}

package com.tcs.model;

public class Diagnostic {
	long id;
	String name;
	double amount;
	
	public long getId() {
		return id;
	}
	
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public double getAmount() {
		return amount;
	}
	
	public void setAmount(double amount) {
		this.amount = amount;
	}

	public void setId(long id) {
		this.id=id;
	}
}

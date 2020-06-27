package com.tcs.model;

import java.util.Date;

public class Patient {
	long ssnId;
	long Id;
	String name;
	int age;
	Date doj;
	String typeOfBed;
	String address;
	String city;
	String state;
	String status;
	
	public long getSsnId() {
		return ssnId;
	}
	
	public void setSsnId(long ssnId) {
		this.ssnId = ssnId;
	}
	
	public long getId() {
		return Id;
	}
	
	public void setId(long id) {
		Id = id;
	}
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public int getAge() {
		return age;
	}
	
	public void setAge(int age) {
		this.age = age;
	}
	
	public Date getDoj() {
		return doj;
	}
	
	public void setDoj(Date doj) {
		this.doj = doj;
	}
	
	public String getTypeOfBed() {
		return typeOfBed;
	}
	
	public void setTypeOfBed(String typeOfBed) {
		this.typeOfBed = typeOfBed;
	}
	
	public String getAddress() {
		return address;
	}
	
	public void setAddress(String address) {
		this.address = address;
	}
	
	public String getCity() {
		return city;
	}
	
	public void setCity(String city) {
		this.city = city;
	}
	
	public String getState() {
		return state;
	}
	
	public void setState(String state) {
		this.state = state;
	}
	
	public String getStatus() {
		return status;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}
}

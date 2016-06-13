package com.websocketdemo.models;

import java.io.Serializable;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Stock implements Serializable {
	  private static final long serialVersionUID = 1L;
	  
	  private DateFormat df = new SimpleDateFormat("dd MMM yyyy, HH:mm:ss");
	  private String code = "";
	  private double price = 0.0;
	  private Date time = new Date();
	  
	  public Stock() {
		     
	  }
	   
	  public Stock(String code, double price) {
	    this.code = code;
	    this.price = price;
	  }
	   
	  
	   
	  public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public String getTimeStr() {
	    return df.format(time);
	  }
}

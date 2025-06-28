package com.hugi.barbershop.customer.model;

public class Customer {
	private String custId;
	private String custName;
	private String custEmail;
	private String custPassword;
	private String custPhoneNumber;
	private String custPicture;
	private int loyaltyPoints;
	
	public String getCustId() {
		return custId;
	}
	public void setCustId(String custId) {
		this.custId = custId;
	}
	public String getCustName() {
		return custName;
	}
	public void setCustName(String custName) {
		this.custName = custName;
	}
	public String getCustEmail() {
		return custEmail;
	}
	public void setCustEmail(String custEmail) {
		this.custEmail = custEmail;
	}
	public String getCustPassword() {
		return custPassword;
	}
	public void setCustPassword(String custPassword) {
		this.custPassword = custPassword;
	}
	public String getCustPhoneNumber() {
		return custPhoneNumber;
	}
	public void setCustPhoneNumber(String custPhoneNumber) {
		this.custPhoneNumber = custPhoneNumber;
	}
	public String getCustPicture() {
		return custPicture;
	}
	public void setCustPicture(String custPicture) {
		this.custPicture = custPicture;
	}
	public int getLoyaltyPoints() {
		return loyaltyPoints;
	}
	public void setLoyaltyPoints(int loyaltyPoints) {
		this.loyaltyPoints = loyaltyPoints;
	}

	// Getters and setters for each field
	// ... (write them or generate via IDE)
}

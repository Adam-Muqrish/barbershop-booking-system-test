package com.hugi.barbershop.customer.model;

public class Appointment {
	private String appointmentId;
	private String custBookFor;
	private String appointmentDate;
	private String appointmentTime;
	private String custType;
	private String paymentStatus;
	private String serviceStatus;
	private String custId;
	private String staffId;
	private int valueLoyalty;
	private String appointmentBarber;
	
	public String getAppointmentId() {
		return appointmentId;
	}
	public void setAppointmentId(String appointmentId) {
		this.appointmentId = appointmentId;
	}
	public String getCustBookFor() {
		return custBookFor;
	}
	public void setCustBookFor(String custBookFor) {
		this.custBookFor = custBookFor;
	}
	public String getAppointmentDate() {
		return appointmentDate;
	}
	public void setAppointmentDate(String appointmentDate) {
		this.appointmentDate = appointmentDate;
	}
	public String getAppointmentTime() {
		return appointmentTime;
	}
	public void setAppointmentTime(String appointmentTime) {
		this.appointmentTime = appointmentTime;
	}
	public String getCustType() {
		return custType;
	}
	public void setCustType(String custType) {
		this.custType = custType;
	}
	public String getPaymentStatus() {
		return paymentStatus;
	}
	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}
	public String getServiceStatus() {
		return serviceStatus;
	}
	public void setServiceStatus(String serviceStatus) {
		this.serviceStatus = serviceStatus;
	}
	public String getCustId() {
		return custId;
	}
	public void setCustId(String custId) {
		this.custId = custId;
	}
	public String getStaffId() {
		return staffId;
	}
	public void setStaffId(String staffId) {
		this.staffId = staffId;
	}
	public int getValueLoyalty() {
		return valueLoyalty;
	}
	public void setValueLoyalty(int valueLoyalty) {
		this.valueLoyalty = valueLoyalty;
	}
	public String getAppointmentBarber() {
		return appointmentBarber;
	}
	public void setAppointmentBarber(String appointmentBarber) {
		this.appointmentBarber = appointmentBarber;
	}	
}

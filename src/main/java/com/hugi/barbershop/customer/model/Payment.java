package com.hugi.barbershop.customer.model;

import java.time.LocalDate;

public class Payment {
	private String paymentId;
	private LocalDate paymentDate;
	private double paymentAmount;
	private String appointmentId;
	private String paymentMethod;

	// Getters and setters
	public String getPaymentId() { return paymentId; }
	public void setPaymentId(String paymentId) { this.paymentId = paymentId; }

	public LocalDate getPaymentDate() { return paymentDate; }
	public void setPaymentDate(LocalDate paymentDate) { this.paymentDate = paymentDate; }

	public double getPaymentAmount() { return paymentAmount; }
	public void setPaymentAmount(double paymentAmount) { this.paymentAmount = paymentAmount; }

	public String getAppointmentId() { return appointmentId; }
	public void setAppointmentId(String appointmentId) { this.appointmentId = appointmentId; }
	
	public String getPaymentMethod() {
	    return paymentMethod;
	}

	public void setPaymentMethod(String paymentMethod) {
	    this.paymentMethod = paymentMethod;
	}

}

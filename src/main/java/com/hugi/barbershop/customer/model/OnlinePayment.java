package com.hugi.barbershop.customer.model;

public class OnlinePayment {
	private String paymentId;
	private String bankName;
	private String bankHolderName;

	// Getters and setters
	public String getPaymentId() { return paymentId; }
	public void setPaymentId(String paymentId) { this.paymentId = paymentId; }

	public String getBankName() { return bankName; }
	public void setBankName(String bankName) { this.bankName = bankName; }

	public String getBankHolderName() { return bankHolderName; }
	public void setBankHolderName(String bankHolderName) { this.bankHolderName = bankHolderName; }
}

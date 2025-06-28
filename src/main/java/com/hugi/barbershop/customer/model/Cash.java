package com.hugi.barbershop.customer.model;

public class Cash {
    private String paymentId;
    private double cashReceive;

    // Getters and setters
    public String getPaymentId() { return paymentId; }
    public void setPaymentId(String paymentId) { this.paymentId = paymentId; }

    public double getCashReceive() { return cashReceive; }
    public void setCashReceive(double cashReceive) { this.cashReceive = cashReceive; }
}

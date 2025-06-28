package com.hugi.barbershop.common.dao;

import com.hugi.barbershop.common.util.DBUtil;
import com.hugi.barbershop.customer.model.Payment;
import com.hugi.barbershop.customer.model.Cash;
import com.hugi.barbershop.customer.model.OnlinePayment;

import java.sql.*;
import java.time.LocalDate;

public class PaymentDAO {

	// Insert payment and return Payment object (PAYMENT_ID is auto-incremented)
	public Payment insertPayment(double amount, String appointmentId) {
		if (!appointmentExists(appointmentId)) {
			System.out.println("Cannot insert payment: Appointment ID " + appointmentId + " does not exist");
			return null;
		}

		String sql = "INSERT INTO PAYMENTS (PAYMENT_DATE, PAYMENT_AMOUNT, APPOINTMENT_ID) VALUES (?, ?, ?)";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql, new String[]{"PAYMENT_ID"})) {
			stmt.setDate(1, Date.valueOf(LocalDate.now()));
			stmt.setDouble(2, amount);
			stmt.setInt(3, Integer.parseInt(appointmentId));

			if (stmt.executeUpdate() > 0) {
				try (ResultSet rs = stmt.getGeneratedKeys()) {
					if (rs.next()) {
						Payment payment = new Payment();
						payment.setPaymentId(String.valueOf(rs.getInt(1)));
						payment.setPaymentDate(LocalDate.now());
						payment.setPaymentAmount(amount);
						payment.setAppointmentId(appointmentId);
						return payment;
					}
				}
			}
		} catch (Exception e) {
			System.out.println("Error inserting payment:");
			e.printStackTrace();
		}
		return null;
	}

	// Insert online payment and return OnlinePayment object
	public OnlinePayment insertOnlinePayment(String paymentId, String bankName, String bankHolderName) {
		String sql = "INSERT INTO ONLINE_PAYMENTS (PAYMENT_ID, BANK_NAME, BANK_HOLDER_NAME) VALUES (?, ?, ?)";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, Integer.parseInt(paymentId));
			stmt.setString(2, bankName);
			stmt.setString(3, bankHolderName);

			if (stmt.executeUpdate() > 0) {
				OnlinePayment onlinePayment = new OnlinePayment();
				onlinePayment.setPaymentId(paymentId);
				onlinePayment.setBankName(bankName);
				onlinePayment.setBankHolderName(bankHolderName);
				return onlinePayment;
			}
		} catch (Exception e) {
			System.out.println("Error inserting online payment:");
			e.printStackTrace();
		}
		return null;
	}

	// Insert cash payment and return Cash object
	public Cash insertCashPayment(String paymentId, double cashReceived) {
		String sql = "INSERT INTO CASHES (PAYMENT_ID, CASH_RECEIVE) VALUES (?, ?)";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, Integer.parseInt(paymentId));
			stmt.setDouble(2, cashReceived);

			if (stmt.executeUpdate() > 0) {
				Cash cash = new Cash();
				cash.setPaymentId(paymentId);
				cash.setCashReceive(cashReceived);
				return cash;
			}
		} catch (Exception e) {
			System.out.println("Error inserting cash payment:");
			e.printStackTrace();
		}
		return null;
	}

	// Fetch payment by ID
	public Payment getPaymentById(String paymentId) {
		String sql = "SELECT * FROM PAYMENTS WHERE PAYMENT_ID = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, Integer.parseInt(paymentId));
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					Payment payment = new Payment();
					payment.setPaymentId(String.valueOf(rs.getInt("PAYMENT_ID")));
					payment.setPaymentDate(rs.getDate("PAYMENT_DATE").toLocalDate());
					payment.setPaymentAmount(rs.getDouble("PAYMENT_AMOUNT"));
					payment.setAppointmentId(String.valueOf(rs.getInt("APPOINTMENT_ID")));
					payment.setPaymentMethod(getPaymentMethod(paymentId));
					return payment;
				}
			}
		} catch (Exception e) {
			System.out.println("Error fetching payment by ID:");
			e.printStackTrace();
		}
		return null;
	}

	// Fetch payment by appointment ID
	public Payment getPaymentByAppointmentId(String appointmentId) {
		String sql = "SELECT * FROM PAYMENTS WHERE APPOINTMENT_ID = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, Integer.parseInt(appointmentId));
			try (ResultSet rs = stmt.executeQuery()) {
				if (rs.next()) {
					Payment payment = new Payment();
					payment.setPaymentId(String.valueOf(rs.getInt("PAYMENT_ID")));
					payment.setPaymentDate(rs.getDate("PAYMENT_DATE").toLocalDate());
					payment.setPaymentAmount(rs.getDouble("PAYMENT_AMOUNT"));
					payment.setAppointmentId(String.valueOf(rs.getInt("APPOINTMENT_ID")));
					payment.setPaymentMethod(getPaymentMethod(payment.getPaymentId()));
					return payment;
				}
			}
		} catch (Exception e) {
			System.out.println("Error fetching payment by appointment ID:");
			e.printStackTrace();
		}
		return null;
	}

	// Helper: check if appointment exists
	private boolean appointmentExists(String appointmentId) {
		String sql = "SELECT 1 FROM APPOINTMENTS WHERE APPOINTMENT_ID = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, Integer.parseInt(appointmentId));
			try (ResultSet rs = stmt.executeQuery()) {
				return rs.next();
			}
		} catch (Exception e) {
			System.out.println("Error checking appointment existence:");
			e.printStackTrace();
			return false;
		}
	}

	// Helper: get payment method
	private String getPaymentMethod(String paymentId) {
		if (isCashPayment(paymentId)) {
			return "Cash";
		} else if (isOnlinePayment(paymentId)) {
			return "Online Banking";
		} else {
			return "unknown";
		}
	}

	private boolean isCashPayment(String paymentId) {
		String sql = "SELECT 1 FROM CASHES WHERE PAYMENT_ID = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, Integer.parseInt(paymentId));
			try (ResultSet rs = stmt.executeQuery()) {
				return rs.next();
			}
		} catch (Exception e) {
			System.out.println("Error checking cash payment:");
			e.printStackTrace();
			return false;
		}
	}

	private boolean isOnlinePayment(String paymentId) {
		String sql = "SELECT 1 FROM ONLINE_PAYMENTS WHERE PAYMENT_ID = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, Integer.parseInt(paymentId));
			try (ResultSet rs = stmt.executeQuery()) {
				return rs.next();
			}
		} catch (Exception e) {
			System.out.println("Error checking online payment:");
			e.printStackTrace();
			return false;
		}
	}
}
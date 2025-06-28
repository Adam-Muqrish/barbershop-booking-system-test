package com.hugi.barbershop.common.dao;

import com.hugi.barbershop.customer.model.Appointment;
import com.hugi.barbershop.common.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AppointmentDAO {

	// Get appointment by ID
	public Appointment getAppointmentById(String appointmentId) {
		String sql = "SELECT * FROM APPOINTMENTS WHERE APPOINTMENT_ID = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, appointmentId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				Appointment appointment = new Appointment();
				appointment.setAppointmentId(rs.getString("APPOINTMENT_ID"));
				appointment.setCustId(rs.getString("CUSTOMER_ID"));
				appointment.setStaffId(rs.getString("STAFF_ID"));
				appointment.setAppointmentDate(rs.getDate("APPOINTMENT_DATE").toString());
				appointment.setAppointmentTime(rs.getString("APPOINTMENT_TIME"));
				appointment.setValueLoyalty(rs.getInt("VALUE_LOYALTY"));
				appointment.setPaymentStatus(rs.getString("PAYMENT_STATUS"));
				appointment.setServiceStatus(rs.getString("SERVICE_STATUS"));
				appointment.setCustBookFor(rs.getString("CUST_BOOK_FOR"));
				appointment.setCustType(rs.getString("CUST_TYPE"));
				return appointment;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// Insert a new appointment (APPOINTMENT_ID is auto-incremented)
	public String insertAppointment(Appointment appointment) {
		String sql = "INSERT INTO APPOINTMENTS (CUST_BOOK_FOR, APPOINTMENT_DATE, APPOINTMENT_TIME, CUST_TYPE, PAYMENT_STATUS, SERVICE_STATUS, CUSTOMER_ID, STAFF_ID, VALUE_LOYALTY) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql, new String[] {"APPOINTMENT_ID"})) {
			stmt.setString(1, appointment.getCustBookFor());
			stmt.setDate(2, java.sql.Date.valueOf(appointment.getAppointmentDate()));
			stmt.setString(3, appointment.getAppointmentTime());
			stmt.setString(4, appointment.getCustType());
			stmt.setString(5, appointment.getPaymentStatus());
			stmt.setString(6, appointment.getServiceStatus());
			stmt.setString(7, appointment.getCustId());
			stmt.setString(8, appointment.getStaffId());
			stmt.setInt(9, appointment.getValueLoyalty());
			int affectedRows = stmt.executeUpdate();
			if (affectedRows > 0) {
				ResultSet rs = stmt.getGeneratedKeys();
				if (rs.next()) {
					return rs.getString(1);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// Get all pending appointments for a customer
	public List<Appointment> getAppointmentsByCustomerId(String custId) {
		List<Appointment> appointments = new ArrayList<>();
		String sql = "SELECT a.*, s.STAFF_NAME AS BARBERNAME " +
				"FROM APPOINTMENTS a " +
				"LEFT JOIN STAFFS s ON a.STAFF_ID = s.STAFF_ID " +
				"WHERE a.CUSTOMER_ID = ? " +
				"AND (a.SERVICE_STATUS = 'Pending' OR a.SERVICE_STATUS = 'pending') " +
				"ORDER BY a.APPOINTMENT_DATE DESC, a.APPOINTMENT_TIME DESC";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, custId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Appointment appointment = new Appointment();
				appointment.setAppointmentId(rs.getString("APPOINTMENT_ID"));
				appointment.setCustBookFor(rs.getString("CUST_BOOK_FOR"));
				appointment.setAppointmentDate(rs.getDate("APPOINTMENT_DATE").toString());
				appointment.setAppointmentTime(rs.getString("APPOINTMENT_TIME"));
				appointment.setCustType(rs.getString("CUST_TYPE"));
				appointment.setPaymentStatus(rs.getString("PAYMENT_STATUS"));
				appointment.setServiceStatus(rs.getString("SERVICE_STATUS"));
				appointment.setCustId(rs.getString("CUSTOMER_ID"));
				appointment.setStaffId(rs.getString("STAFF_ID"));
				appointment.setValueLoyalty(rs.getInt("VALUE_LOYALTY"));
				appointment.setAppointmentBarber(rs.getString("BARBERNAME"));
				appointments.add(appointment);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return appointments;
	}

	// Get all appointments for a customer with status 'Done' or 'Cancelled'
	public List<Appointment> getHistoryAppointmentsByCustomerId(String custId, int offset, int pageSize) {
		List<Appointment> appointments = new ArrayList<>();
		String sql = "SELECT a.*, s.STAFF_NAME AS BARBERNAME " +
				"FROM APPOINTMENTS a " +
				"LEFT JOIN STAFFS s ON a.STAFF_ID = s.STAFF_ID " +
				"WHERE a.CUSTOMER_ID = ? AND (a.SERVICE_STATUS = 'Done' OR a.SERVICE_STATUS = 'Cancelled') " +
				"ORDER BY a.APPOINTMENT_DATE DESC, a.APPOINTMENT_TIME DESC " +
				"OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, custId);
			stmt.setInt(2, offset);
			stmt.setInt(3, pageSize);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Appointment appointment = new Appointment();
				appointment.setAppointmentId(rs.getString("APPOINTMENT_ID"));
				appointment.setCustBookFor(rs.getString("CUST_BOOK_FOR"));
				appointment.setAppointmentDate(rs.getDate("APPOINTMENT_DATE").toString());
				appointment.setAppointmentTime(rs.getString("APPOINTMENT_TIME"));
				appointment.setCustType(rs.getString("CUST_TYPE"));
				appointment.setPaymentStatus(rs.getString("PAYMENT_STATUS"));
				appointment.setServiceStatus(rs.getString("SERVICE_STATUS"));
				appointment.setCustId(rs.getString("CUSTOMER_ID"));
				appointment.setStaffId(rs.getString("STAFF_ID"));
				appointment.setValueLoyalty(rs.getInt("VALUE_LOYALTY"));
				appointment.setAppointmentBarber(rs.getString("BARBERNAME"));
				appointments.add(appointment);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return appointments;
	}

	// Count total done appointments for a customer
	public int countDoneAppointmentsByCustomerId(String custId) {
		String sql = "SELECT COUNT(*) FROM APPOINTMENTS WHERE CUSTOMER_ID = ? AND SERVICE_STATUS = 'Done'";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, custId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}

	// Update payment status for an appointment
	public boolean updatePaymentStatus(String custId, String appointmentDate, String appointmentTime, String paymentStatus) {
		String sql = "UPDATE APPOINTMENTS SET PAYMENT_STATUS = ? WHERE CUSTOMER_ID = ? AND APPOINTMENT_DATE = ? AND APPOINTMENT_TIME = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, paymentStatus);
			stmt.setString(2, custId);
			stmt.setDate(3, java.sql.Date.valueOf(appointmentDate));
			stmt.setString(4, appointmentTime);
			return stmt.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Get the latest appointment for a customer
	public Appointment getLatestAppointment(String custId) {
		String sql = "SELECT * FROM APPOINTMENTS WHERE CUSTOMER_ID = ? ORDER BY APPOINTMENT_DATE DESC, APPOINTMENT_TIME DESC FETCH FIRST 1 ROWS ONLY";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, custId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				Appointment appointment = new Appointment();
				appointment.setAppointmentId(rs.getString("APPOINTMENT_ID"));
				appointment.setCustBookFor(rs.getString("CUST_BOOK_FOR"));
				appointment.setAppointmentDate(rs.getDate("APPOINTMENT_DATE").toString());
				appointment.setAppointmentTime(rs.getString("APPOINTMENT_TIME"));
				appointment.setCustType(rs.getString("CUST_TYPE"));
				appointment.setPaymentStatus(rs.getString("PAYMENT_STATUS"));
				appointment.setServiceStatus(rs.getString("SERVICE_STATUS"));
				appointment.setCustId(rs.getString("CUSTOMER_ID"));
				appointment.setStaffId(rs.getString("STAFF_ID"));
				appointment.setValueLoyalty(rs.getInt("VALUE_LOYALTY"));
				return appointment;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// Get barber name by staff ID
	public String getBarberNameById(String staffId) {
		String sql = "SELECT STAFF_NAME FROM STAFFS WHERE STAFF_ID = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, staffId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getString("STAFF_NAME");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	// Mark an appointment as done
	public boolean markAsDone(int appointmentId) {
		String sql = "UPDATE APPOINTMENTS SET SERVICE_STATUS = 'Done' WHERE APPOINTMENT_ID = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setInt(1, appointmentId);
			return stmt.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Mark an appointment as cancelled
	public boolean markAsCancelled(String appointmentId) {
		String sql = "UPDATE APPOINTMENTS SET SERVICE_STATUS = 'Cancelled' WHERE APPOINTMENT_ID = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, appointmentId);
			return stmt.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Update an existing appointment
	public boolean updateAppointment(Appointment appointment) {
		String sql = "UPDATE APPOINTMENTS SET APPOINTMENT_DATE = ?, APPOINTMENT_TIME = ?, STAFF_ID = ? WHERE APPOINTMENT_ID = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setDate(1, java.sql.Date.valueOf(appointment.getAppointmentDate()));
			stmt.setString(2, appointment.getAppointmentTime());
			stmt.setString(3, appointment.getStaffId());
			stmt.setString(4, appointment.getAppointmentId());
			return stmt.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Get total loyalty points for a customer
	public int getTotalLoyaltyPointsByCustomerId(String custId) {
		String sql = "SELECT SUM(VALUE_LOYALTY) FROM APPOINTMENTS WHERE CUSTOMER_ID = ?";
		try (Connection conn = DBUtil.getConnection();
				PreparedStatement stmt = conn.prepareStatement(sql)) {
			stmt.setString(1, custId);
			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return 0;
	}
}

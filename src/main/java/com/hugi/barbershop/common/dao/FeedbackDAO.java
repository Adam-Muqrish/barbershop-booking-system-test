package com.hugi.barbershop.common.dao;

import com.hugi.barbershop.customer.model.Feedback;
import com.hugi.barbershop.common.util.DBUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class FeedbackDAO {
    // Insert a new feedback (FEEDBACK_ID is auto-incremented)
    public String insertFeedback(Feedback feedback) {
        String sql = "INSERT INTO FEEDBACKS (COMMENTS, RATING, APPOINTMENT_ID, CUSTOMER_ID) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, new String[] {"FEEDBACK_ID"})) {
            stmt.setString(1, feedback.getComments());
            stmt.setInt(2, feedback.getRating());
            stmt.setInt(3, feedback.getAppointmentId());
            stmt.setString(4, feedback.getCustId());
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getString(1); // Return generated FEEDBACK_ID
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get feedback by appointment ID and customer ID
    public Feedback getFeedbackByAppointmentAndCustomer(int appointmentId, String custId) {
        String sql = "SELECT * FROM FEEDBACKS WHERE APPOINTMENT_ID = ? AND CUSTOMER_ID = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, appointmentId);
            stmt.setString(2, custId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Feedback feedback = new Feedback();
                feedback.setFeedbackId(rs.getString("FEEDBACK_ID"));
                feedback.setComments(rs.getString("COMMENTS"));
                feedback.setRating(rs.getInt("RATING"));
                feedback.setAppointmentId(rs.getInt("APPOINTMENT_ID"));
                feedback.setCustId(rs.getString("CUSTOMER_ID"));
                return feedback;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update existing feedback
    public boolean updateFeedback(Feedback feedback) {
        String sql = "UPDATE FEEDBACKS SET COMMENTS = ?, RATING = ? WHERE APPOINTMENT_ID = ? AND CUSTOMER_ID = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, feedback.getComments());
            stmt.setInt(2, feedback.getRating());
            stmt.setInt(3, feedback.getAppointmentId());
            stmt.setString(4, feedback.getCustId());
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete feedback
    public boolean deleteFeedback(int appointmentId, String custId) {
        String sql = "DELETE FROM FEEDBACKS WHERE APPOINTMENT_ID = ? AND CUSTOMER_ID = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, appointmentId);
            stmt.setString(2, custId);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}

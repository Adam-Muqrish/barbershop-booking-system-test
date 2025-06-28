package com.hugi.barbershop.common.dao;

import com.hugi.barbershop.customer.model.Customer;
import com.hugi.barbershop.common.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    // Insert a new customer (CUSTOMER_ID is auto-incremented)
    public String insertCustomer(Customer customer) {
        String sql = "INSERT INTO CUSTOMERS (CUSTOMER_NAME, CUSTOMER_EMAIL, CUSTOMER_PASSWORD, CUSTOMER_PHONE_NUMBER, CUSTOMER_PICTURE, LOYALTY_POINTS) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, new String[] {"CUSTOMER_ID"})) {

            stmt.setString(1, customer.getCustName());
            stmt.setString(2, customer.getCustEmail());
            stmt.setString(3, customer.getCustPassword());
            stmt.setString(4, customer.getCustPhoneNumber());
            stmt.setString(5, customer.getCustPicture());
            stmt.setInt(6, customer.getLoyaltyPoints());

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getString(1); // Return generated CUSTOMER_ID
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get customer by ID
    public Customer getCustomerById(String customerId) {
        String sql = "SELECT * FROM CUSTOMERS WHERE CUSTOMER_ID = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, customerId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Customer customer = new Customer();
                customer.setCustId(rs.getString("CUSTOMER_ID"));
                customer.setCustName(rs.getString("CUSTOMER_NAME"));
                customer.setCustEmail(rs.getString("CUSTOMER_EMAIL"));
                customer.setCustPhoneNumber(rs.getString("CUSTOMER_PHONE_NUMBER"));
                customer.setLoyaltyPoints(rs.getInt("LOYALTY_POINTS"));
                customer.setCustPassword(rs.getString("CUSTOMER_PASSWORD"));
                customer.setCustPicture(rs.getString("CUSTOMER_PICTURE"));
                return customer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get customer by email
    public Customer getCustomerByEmail(String email) {
        String sql = "SELECT * FROM CUSTOMERS WHERE CUSTOMER_EMAIL = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Customer customer = new Customer();
                customer.setCustId(rs.getString("CUSTOMER_ID"));
                customer.setCustName(rs.getString("CUSTOMER_NAME"));
                customer.setCustEmail(rs.getString("CUSTOMER_EMAIL"));
                customer.setCustPhoneNumber(rs.getString("CUSTOMER_PHONE_NUMBER"));
                customer.setLoyaltyPoints(rs.getInt("LOYALTY_POINTS"));
                customer.setCustPassword(rs.getString("CUSTOMER_PASSWORD"));
                customer.setCustPicture(rs.getString("CUSTOMER_PICTURE"));
                return customer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Verify password
    public boolean verifyPassword(Customer customer, String inputPassword) {
        return customer.getCustPassword() != null &&
               customer.getCustPassword().equals(inputPassword);
    }

    // Update customer
    public boolean updateCustomer(Customer customer) {
        String sql = "UPDATE CUSTOMERS SET CUSTOMER_NAME = ?, CUSTOMER_EMAIL = ?, CUSTOMER_PHONE_NUMBER = ?, CUSTOMER_PASSWORD = ?, CUSTOMER_PICTURE = ? WHERE CUSTOMER_ID = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, customer.getCustName());
            stmt.setString(2, customer.getCustEmail());
            stmt.setString(3, customer.getCustPhoneNumber());
            stmt.setString(4, customer.getCustPassword());
            stmt.setString(5, customer.getCustPicture());
            stmt.setString(6, customer.getCustId());

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all customers
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM CUSTOMERS";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustId(rs.getString("CUSTOMER_ID"));
                customer.setCustName(rs.getString("CUSTOMER_NAME"));
                customer.setCustEmail(rs.getString("CUSTOMER_EMAIL"));
                customer.setCustPhoneNumber(rs.getString("CUSTOMER_PHONE_NUMBER"));
                customer.setLoyaltyPoints(rs.getInt("LOYALTY_POINTS"));
                customer.setCustPassword(rs.getString("CUSTOMER_PASSWORD"));
                customer.setCustPicture(rs.getString("CUSTOMER_PICTURE"));
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    // Delete customer by ID
    public boolean deleteCustomerById(String customerId) {
        String sql = "DELETE FROM CUSTOMERS WHERE CUSTOMER_ID = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, customerId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Check if email exists
    public boolean emailExists(String email) {
        String sql = "SELECT 1 FROM CUSTOMERS WHERE CUSTOMER_EMAIL = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

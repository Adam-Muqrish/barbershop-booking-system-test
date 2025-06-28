package com.hugi.barbershop.customer.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;

import com.hugi.barbershop.customer.model.Customer;
import com.hugi.barbershop.common.dao.CustomerDAO;

@WebServlet("/profile-management")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024) // 5MB
public class ProfileManagementController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CustomerDAO customerDAO;

	@Override
	public void init() {
		customerDAO = new CustomerDAO(); // no ServletContext needed
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		String custId = (session != null) ? (String) session.getAttribute("custId") : null;

		Customer customer = customerDAO.getCustomerById(custId);
		if (customer == null) {
			request.setAttribute("error", "Customer not found for ID: " + custId);
		} else {
			request.setAttribute("customer", customer);
		}

		request.getRequestDispatcher("/WEB-INF/views/customer/profile-management.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		String custId = (session != null) ? (String) session.getAttribute("custId") : null;
		
		Customer customer = customerDAO.getCustomerById(custId);
		if (customer == null) {
			request.setAttribute("error", "Customer not found for ID: " + custId);
			doGet(request, response);
			return;
		}

		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String phone = request.getParameter("phone");
		String oldPassword = request.getParameter("oldPassword");
		String newPassword = request.getParameter("newPassword");

		// Validate old password if provided
		if (oldPassword != null && !oldPassword.isEmpty() && !customerDAO.verifyPassword(customer, oldPassword)) {
			request.setAttribute("error", "Old password is incorrect.");
			request.setAttribute("customer", customer);
			doGet(request, response);
			return;
		}

		boolean updated = false;

		if (name != null && !name.trim().isEmpty() && !name.equals(customer.getCustName())) {
			customer.setCustName(name);
			updated = true;
		}
		if (email != null && !email.trim().isEmpty() && !email.equals(customer.getCustEmail())) {
			customer.setCustEmail(email);
			updated = true;
		}
		if (phone != null && !phone.trim().isEmpty() && !phone.equals(customer.getCustPhoneNumber())) {
			customer.setCustPhoneNumber(phone);
			updated = true;
		}
		if (newPassword != null && !newPassword.isEmpty()) {
			customer.setCustPassword(newPassword);
			updated = true;
		}

		// Handle profile picture upload
		Part filePart = request.getPart("profilePicture");
		String fileName = null;
		if (filePart != null && filePart.getSize() > 0) {
			fileName = filePart.getSubmittedFileName();
			String uploadPath = getServletContext().getRealPath("") + File.separator + "resources/uploads";
			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists()) uploadDir.mkdir();

			filePart.write(uploadPath + File.separator + fileName);
			customer.setCustPicture(fileName);
			updated = true;
		}

		if (updated) {
			boolean success = customerDAO.updateCustomer(customer);
			if (success) {
				// After updating and fetching the latest customer
				request.setAttribute("message", "Profile updated successfully.");
				customer = customerDAO.getCustomerById(custId);
				session.setAttribute("customer", customer);

			} else {
				request.setAttribute("error", "Failed to update profile.");
			}
		}
		// Set the updated customer object in the request
		request.setAttribute("customer", customer);
		request.getRequestDispatcher("/WEB-INF/views/customer/profile-management.jsp").forward(request, response);
	}
}
package com.hugi.barbershop.common.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.hugi.barbershop.customer.model.Customer;
import com.hugi.barbershop.common.dao.CustomerDAO;

@WebServlet("/auth")
public class AuthController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		if (request.getSession().getAttribute("customer") != null) {
			response.sendRedirect("index");
			return;
		}
		request.getRequestDispatcher("/WEB-INF/views/customer/register.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		CustomerDAO customerDAO = new CustomerDAO();

		if ("login".equals(action)) {
			String email = request.getParameter("email");
			String password = request.getParameter("password");
			Customer customer = customerDAO.getCustomerByEmail(email);

			if (customer != null && customerDAO.verifyPassword(customer, password)) {
				HttpSession session = request.getSession();
				session.setAttribute("customer", customer);
				session.setAttribute("custId", customer.getCustId());
				request.setAttribute("justLoggedIn", true);
				request.getRequestDispatcher("/WEB-INF/views/customer/register.jsp").forward(request, response);
				return;
			} else {
				request.setAttribute("error", "Invalid email or password");
			}
			request.getRequestDispatcher("/WEB-INF/views/customer/register.jsp").forward(request, response);

		} else if ("register".equals(action)) {
			String custName = request.getParameter("name");
			String custEmail = request.getParameter("email");
			String custPassword = request.getParameter("password");
			String custPhoneNumber = request.getParameter("phone");

			if (customerDAO.emailExists(custEmail)) {
				request.setAttribute("error", "Email already registered.");
			} else {
				Customer customer = new Customer();
				customer.setCustName(custName);
				customer.setCustEmail(custEmail);
				customer.setCustPassword(custPassword);
				customer.setCustPhoneNumber(custPhoneNumber);
				customer.setLoyaltyPoints(0);

				String newCustId = customerDAO.insertCustomer(customer);
				if (newCustId != null) {
					request.setAttribute("successMessage", "Registration successful! Redirecting to login...");
				} else {
					request.setAttribute("error", "Registration failed. Please try again.");
				}
			}
			request.getRequestDispatcher("/WEB-INF/views/customer/register.jsp").forward(request, response);
		}
	}
}

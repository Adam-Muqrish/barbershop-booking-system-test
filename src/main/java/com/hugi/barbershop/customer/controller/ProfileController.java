package com.hugi.barbershop.customer.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.hugi.barbershop.customer.model.Customer;
import com.hugi.barbershop.common.dao.AppointmentDAO;
import com.hugi.barbershop.common.dao.CustomerDAO;

/**
 * Servlet implementation class ProfileController
 */
@WebServlet("/profile")
public class ProfileController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CustomerDAO customerDAO;
	private AppointmentDAO appointmentDAO;

	@Override
	public void init() {
		customerDAO = new CustomerDAO(); // no ServletContext needed
		appointmentDAO = new AppointmentDAO(); // no ServletContext needed
	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProfileController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String custId = (String) request.getSession().getAttribute("custId");

		Customer customer = customerDAO.getCustomerById(custId);

		if (customer == null) {
			request.setAttribute("error", "Customer data not found");
			request.getRequestDispatcher("/WEB-INF/views/customer/error.jsp").forward(request, response);
			return;
		}

		int loyaltyPoints = appointmentDAO.getTotalLoyaltyPointsByCustomerId(custId);

		// Set customer and loyalty points in request attributes
		request.setAttribute("customer", customer);
		request.setAttribute("loyaltyPoints", loyaltyPoints);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/customer/profile.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

package com.hugi.barbershop.customer.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.hugi.barbershop.customer.model.Appointment;
import com.hugi.barbershop.customer.model.Customer;
import com.hugi.barbershop.common.dao.AppointmentDAO;
import com.hugi.barbershop.common.dao.CustomerDAO;

/**
 * Servlet implementation class ViewAppointmentController
 */
@WebServlet("/view-appointment")
public class ViewAppointmentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CustomerDAO customerDAO;
	private AppointmentDAO appointmentDAO;

	@Override
	public void init() {
		customerDAO = new CustomerDAO();
		appointmentDAO = new AppointmentDAO(); // no ServletContext needed
	}
	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ViewAppointmentController() {
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

		// Pagination logic
		int page = 1;
		int pageSize = 4;
		String pageParam = request.getParameter("page");
		if (pageParam != null) {
			try {
				page = Integer.parseInt(pageParam);
			} catch (NumberFormatException e) {
				page = 1;
			}
		}

		List<Appointment> allAppointments = appointmentDAO.getAppointmentsByCustomerId(custId);
		int totalAppointments = allAppointments.size();
		int totalPages = (int) Math.ceil((double) totalAppointments / pageSize);

		// Clamp page to valid range
		if (page < 1) page = 1;
		if (page > totalPages && totalPages > 0) page = totalPages;

		int fromIndex = (page - 1) * pageSize;
		int toIndex = Math.min(fromIndex + pageSize, totalAppointments);
		List<Appointment> appointments = (fromIndex < toIndex) ? allAppointments.subList(fromIndex, toIndex) : new java.util.ArrayList<>();

		request.setAttribute("customer", customer);
		request.setAttribute("appointments", appointments);
		request.setAttribute("currentPage", page);
		request.setAttribute("totalPages", totalPages);
		
		// After showing appointments, remove bookingKey before forwarding
		request.getSession().removeAttribute("bookingKey");

		// Check if it's an AJAX request
		String isAjaxRequest = request.getParameter("ajax");
		if (isAjaxRequest != null && isAjaxRequest.equals("true")) {
			// Only return the appointment list partial
			request.getRequestDispatcher("/WEB-INF/views/customer/appointment-list-partial.jsp").forward(request, response);
		} else {
			// Return the full page
			request.getRequestDispatcher("/WEB-INF/views/customer/view-appointment.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

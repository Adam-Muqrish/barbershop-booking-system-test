package com.hugi.barbershop.customer.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.hugi.barbershop.customer.model.Appointment;
import com.hugi.barbershop.common.dao.AppointmentDAO;

/**
 * Servlet implementation class AppointmentHistoryController
 */
@WebServlet("/appointment-history")
public class AppointmentHistoryController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AppointmentDAO appointmentDAO;

	@Override
	public void init() {
		appointmentDAO = new AppointmentDAO(); // no ServletContext needed
	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AppointmentHistoryController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String custId = (String) request.getSession().getAttribute("custId");
		int page = 1;
		int pageSize = 4; // or any default size
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		int totalAppointments = appointmentDAO.countDoneAppointmentsByCustomerId(custId);
		int totalPages = (int) Math.ceil((double) totalAppointments / pageSize);
		int offset = (page - 1) * pageSize;
		List<Appointment> doneAppointments = appointmentDAO.getHistoryAppointmentsByCustomerId(custId, offset, pageSize);
		request.setAttribute("doneAppointments", doneAppointments);
		request.setAttribute("currentPage", page);
		request.setAttribute("totalPages", totalPages);
		if ("true".equals(request.getParameter("ajax"))) {
		    request.getRequestDispatcher("/WEB-INF/views/customer/appointment-history-list-partial.jsp").forward(request, response);
		} else {
		    request.getRequestDispatcher("/WEB-INF/views/customer/appointment-history.jsp").forward(request, response);
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

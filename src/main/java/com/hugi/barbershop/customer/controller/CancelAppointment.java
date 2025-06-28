package com.hugi.barbershop.customer.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.hugi.barbershop.common.dao.AppointmentDAO;

/**
 * Servlet implementation class CancelAppointment
 */
@WebServlet("/cancel-appointment")
public class CancelAppointment extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AppointmentDAO appointmentDAO;

	@Override
	public void init() {
		appointmentDAO = new AppointmentDAO();
	}

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CancelAppointment() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String appointmentId = request.getParameter("appointmentId");
		if (appointmentId != null) {
			appointmentDAO.markAsCancelled(appointmentId);
		}
		response.sendRedirect("appointment-history");
	}
}


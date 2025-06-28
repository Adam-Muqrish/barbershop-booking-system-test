package com.hugi.barbershop.customer.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.hugi.barbershop.common.dao.AppointmentDAO;

/**
 * Servlet implementation class MarkAsDone
 */
@WebServlet("/markAsDone")
public class MarkAsDone extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private AppointmentDAO appointmentDAO;
    
    @Override
	public void init() {
		appointmentDAO = new AppointmentDAO();
	}
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MarkAsDone() {
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
	    int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));
	    // Call your service/DAO to update the status
	    appointmentDAO.markAsDone(appointmentId);
	    // Redirect to appointment list or history as needed
	    response.sendRedirect("appointment-history");
	}

}

package com.hugi.barbershop.customer.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

import com.hugi.barbershop.common.dao.AppointmentDAO;
import com.hugi.barbershop.common.dao.PaymentDAO;
import com.hugi.barbershop.customer.model.Appointment;
import com.hugi.barbershop.customer.model.Payment;

@WebServlet("/payment")
public class PaymentController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AppointmentDAO appointmentDAO;
	private PaymentDAO paymentDAO;

	@Override
	public void init() {
		appointmentDAO = new AppointmentDAO();
		paymentDAO = new PaymentDAO();
	}

	public PaymentController() {
		super();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

		// Validate booking key
		String bookingKey = request.getParameter("bookingKey");
		String sessionBookingKey = (String) session.getAttribute("bookingKey");
		if (bookingKey == null || !bookingKey.equals(sessionBookingKey)) {
			response.sendRedirect("view-appointment");
			return;
		} 

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/customer/payment.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();

		// Validate booking key
		String bookingKey = request.getParameter("bookingKey");
		String sessionBookingKey = (String) session.getAttribute("bookingKey");
		if (bookingKey == null || !bookingKey.equals(sessionBookingKey)) {
			response.sendRedirect("view-appointment");
			return;
		}

		String custId = (String) session.getAttribute("custId");
		String paymentMethod = request.getParameter("payment-method");
		
		// Retrieve booking details from session
		String bookingFor = (String) session.getAttribute("bookingFor");
		String bookingDate = (String) session.getAttribute("bookingDate");
		String selectedTime = (String) session.getAttribute("selectedTime");
		String category = (String) session.getAttribute("category");
		String selectedBarber = (String) session.getAttribute("selectedBarber");
		String staffId = (String) session.getAttribute("staffId");
		Double price = (Double) session.getAttribute("price");
		if (price == null) price = 0.0;

		// Create and save appointment
		Appointment appointment = new Appointment();
		appointment.setCustBookFor(bookingFor);
		appointment.setAppointmentDate(bookingDate);
		appointment.setAppointmentTime(selectedTime);
		appointment.setCustType(category);
		appointment.setPaymentStatus("pending");
		appointment.setServiceStatus("pending");
		appointment.setCustId(custId);
		appointment.setStaffId(staffId);
		appointment.setAppointmentBarber(selectedBarber);
		appointment.setValueLoyalty(1);

		String appointmentId = appointmentDAO.insertAppointment(appointment);
		if (appointmentId == null) {
			request.setAttribute("error", "Failed to create appointment.");
			request.getRequestDispatcher("/WEB-INF/views/customer/error.jsp").forward(request, response);
			return;
		}

		// Simulate payment success
		boolean paymentSuccess = true;
		if (!paymentSuccess) {
			request.setAttribute("error", "Payment failed.");
			request.getRequestDispatcher("/WEB-INF/views/customer/error.jsp").forward(request, response);
			return;
		}
		
		Payment payment = paymentDAO.insertPayment(price, appointmentId);
		if (payment == null) {
			request.setAttribute("error", "Failed to process payment.");
			request.getRequestDispatcher("/WEB-INF/views/customer/error.jsp").forward(request, response);
			return;
		}
		String paymentId = payment.getPaymentId();

		// Insert into inheritance table and update payment status
		if ("cash".equals(paymentMethod)) {
			paymentDAO.insertCashPayment(paymentId, price);
			appointmentDAO.updatePaymentStatus(custId, bookingDate, selectedTime, "pending");
		} else if ("online-banking".equals(paymentMethod)) {
			paymentDAO.insertOnlinePayment(paymentId, "Toyyib Pay", "Customer Name");
			appointmentDAO.updatePaymentStatus(custId, bookingDate, selectedTime, "completed");
		}

		// Save appointmentId in session for receipt
		session.setAttribute("appointmentId", appointmentId);

		// Save payment info in session (optional, for receipt)
		session.setAttribute("paymentId", paymentId);
		session.setAttribute("paymentMethod", paymentMethod);
		session.setAttribute("paymentStatus", "online-banking".equals(paymentMethod) ? "completed" : "pending");

		response.sendRedirect("receipt?appointmentId=" + appointmentId + "&bookingKey=" + bookingKey);
	}
}

package com.hugi.barbershop.customer.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.hugi.barbershop.customer.model.Appointment;
import com.hugi.barbershop.customer.model.Customer;
import com.hugi.barbershop.common.dao.AppointmentDAO;
import com.hugi.barbershop.common.dao.CustomerDAO;
import com.hugi.barbershop.common.dao.StaffDAO;
import com.hugi.barbershop.staff.model.Staff;

@WebServlet("/appointment-management")
public class AppointmentManagement extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private AppointmentDAO appointmentDAO;
	private CustomerDAO customerDAO;

	@Override
	public void init() {
		appointmentDAO = new AppointmentDAO();
		customerDAO = new CustomerDAO();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String appointmentId = request.getParameter("appointmentId");
		if (appointmentId == null || appointmentId.isEmpty()) {
			request.setAttribute("error", "No appointment selected for update.");
			request.getRequestDispatcher("/WEB-INF/views/customer/error.jsp").forward(request, response);
			return;
		}

		Appointment appointment = appointmentDAO.getAppointmentById(appointmentId);
		if (appointment == null) {
			request.setAttribute("error", "Appointment not found.");
			request.getRequestDispatcher("/WEB-INF/views/customer/error.jsp").forward(request, response);
			return;
		}

		// Fetch customer and barbers
		Customer customer = customerDAO.getCustomerById(appointment.getCustId());
		StaffDAO staffDAO = new StaffDAO();
		List<Staff> barbers = staffDAO.getAllBarbers();

		// Prepare unavailable barbers by slot for the selected date
		String selectedDate = appointment.getAppointmentDate();
		String[] slots = {
				"10:00 am", "10:30 am", "11:00 am", "11:30 am",
				"12:00 pm", "12:30 pm", "1:00 pm", "1:30 pm",
				"2:00 pm", "2:30 pm", "3:00 pm", "3:30 pm",
				"4:00 pm", "4:30 pm", "5:00 pm", "5:30 pm",
				"6:00 pm", "6:30 pm", "7:00 pm", "7:30 pm",
				"8:00 pm", "8:30 pm", "9:00 pm", "9:30 pm"
		};
		Map<String, List<String>> unavailableBarbersBySlot = new HashMap<>();
		for (String slot : slots) {
		    List<String> unavailableBarbers = staffDAO.getUnavailableBarbersForSlot(slot, selectedDate, appointmentId);
		    unavailableBarbersBySlot.put(slot, unavailableBarbers);
		}

		// Create JSON for unavailable barbers
		String unavailableBarbersBySlotJson = new com.google.gson.Gson().toJson(unavailableBarbersBySlot);

		// Set attributes for JSP
		request.setAttribute("appointment", appointment);
		request.setAttribute("customer", customer);
		request.setAttribute("barbers", barbers);
		request.setAttribute("selectedDate", selectedDate);
		request.setAttribute("unavailableBarbersBySlot", unavailableBarbersBySlot);
		request.setAttribute("unavailableBarbersBySlotJson", unavailableBarbersBySlotJson);

		RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/customer/appointment-management.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String appointmentId = request.getParameter("appointmentId");
		String date = request.getParameter("date");
		String slot = request.getParameter("slot");
		String barber = request.getParameter("barber");

		if (appointmentId == null || date == null || slot == null || barber == null ||
				appointmentId.isEmpty() || date.isEmpty() || slot.isEmpty() || barber.isEmpty()) {
			request.setAttribute("error", "All fields are required.");
			doGet(request, response);
			return;
		}

		Appointment appointment = appointmentDAO.getAppointmentById(appointmentId);
		if (appointment == null) {
			request.setAttribute("error", "Appointment not found.");
			doGet(request, response);
			return;
		}

		// Update appointment fields
		appointment.setAppointmentDate(date);
		appointment.setAppointmentTime(slot);
		appointment.setStaffId(barber);

		boolean updated = appointmentDAO.updateAppointment(appointment);
		if (updated) {
			// Redirect or show success message
			response.sendRedirect("view-appointment");
		} else {
			request.setAttribute("error", "Failed to update appointment.");
			doGet(request, response);
		}
	}
}

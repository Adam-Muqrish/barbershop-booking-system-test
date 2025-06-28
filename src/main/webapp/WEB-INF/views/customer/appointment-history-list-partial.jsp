<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.hugi.barbershop.customer.model.Appointment"%>
<%
List<Appointment> doneAppointments = (List<Appointment>) request.getAttribute("doneAppointments");
int currentPage = request.getAttribute("currentPage") != null ? (Integer) request.getAttribute("currentPage") : 1;
int totalPages = request.getAttribute("totalPages") != null ? (Integer) request.getAttribute("totalPages") : 1;
String pageUrl = "appointment-history?page=";
%>
<div class="grid grid-cols-1 md:grid-cols-2 gap-6">hgjhgj
	<%
	if (doneAppointments != null && !doneAppointments.isEmpty()) {
		for (Appointment appt : doneAppointments) {
	%>
	<div
		class="bg-white p-6 rounded-lg shadow-md flex flex-col justify-between">
		<p>
			<strong>Book For :</strong>
			<%=appt.getCustBookFor()%></p>
		<p>
			<strong>Customer Category:</strong>
			<%=appt.getCustType()%></p>
		<p>
			<strong>Date:</strong>
			<%=appt.getAppointmentDate()%></p>
		<p>
			<strong>Time:</strong>
			<%=appt.getAppointmentTime()%></p>
		<p>
			<strong>Barber:</strong>
			<%=appt.getAppointmentBarber()%></p>

		<div class="flex justify-end gap-2 mt-4">
			<!-- appointment details -->
			<div class="flex justify-end gap-2 mt-4">
				<a
					href="receipt?appointmentId=<%=appt.getAppointmentId()%>&source=appointment-history">
					<button
						class="bg-blue-200 text-blue-700 px-4 py-1 rounded hover:bg-blue-300 text-sm">View
						Receipt</button>
				</a>
				<%
				if ("Done".equalsIgnoreCase(appt.getServiceStatus())) {
				%>
				<a href="feedback?appointmentId=<%=appt.getAppointmentId()%>">
					<button
						class="bg-blue-500 text-white px-4 py-1 rounded hover:bg-blue-600 text-sm">Edit
						Feedback</button>
				</a>
				<%
				}
				%>
			</div>
		</div>
	</div>
	<%
	}
	} else {
	%>
	<p>No completed appointments found.</p>
	<%
	}
	%>
</div>
<%
int pageWindow = 3;
int startPage = Math.max(1, currentPage - pageWindow / 2);
int endPage = startPage + pageWindow - 1;
if (endPage > totalPages) {
	endPage = totalPages;
	startPage = Math.max(1, endPage - pageWindow + 1);
}
%>
<div class="flex justify-end mt-6">
	<nav>
		<ul class="flex gap-2">
			<%
			if (currentPage > 1) {
			%>
			<li><a href="javascript:void(0)"
				onclick="loadHistory(<%=currentPage - 1%>)"
				class="px-3 py-1 rounded-l bg-gray-200 hover:bg-gray-300 text-center">
					Previous </a></li>
			<%
			}
			%>
			<%
			for (int i = startPage; i <= endPage; i++) {
			%>
			<li><a href="javascript:void(0)" onclick="loadHistory(<%=i%>)"
				class="px-3 py-1 <%=i == currentPage ? "bg-blue-500 text-white" : "bg-gray-200 hover:bg-gray-300"%> text-center">
					<%=i%>
			</a></li>
			<%
			}
			%>
			<%
			if (currentPage < totalPages) {
			%>
			<li><a href="javascript:void(0)"
				onclick="loadHistory(<%=currentPage + 1%>)"
				class="px-3 py-1 rounded-r bg-gray-200 hover:bg-gray-300 text-center">
					Next </a></li>
			<%
			}
			%>
		</ul>
	</nav>
</div>
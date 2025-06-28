<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.hugi.barbershop.customer.model.Appointment"%>
<%@ page import="java.util.List"%>
<%
List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
int currentPage = request.getAttribute("currentPage") != null ? (Integer) request.getAttribute("currentPage") : 1;
int totalPages = request.getAttribute("totalPages") != null ? (Integer) request.getAttribute("totalPages") : 1;
%>

<!-- Modal HTML -->
<div id="cancelModal"
	class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-40 z-50 hidden">
	<div class="bg-white rounded-lg shadow-lg p-6 w-80">
		<h2 class="text-lg font-semibold mb-4">Cancel Appointment</h2>
		<p class="mb-6">Are you sure you want to cancel this appointment?</p>
		<div class="flex justify-end gap-2">
			<button id="cancelModalNo"
				class="px-4 py-1 rounded bg-gray-300 hover:bg-gray-400">No</button>
			<button id="cancelModalYes"
				class="px-4 py-1 rounded bg-red-500 text-white hover:bg-red-600">Yes</button>
		</div>
	</div>
</div>

<div class="grid grid-cols-1 md:grid-cols-2 gap-6">
	<%
    if (appointments != null && !appointments.isEmpty()) {
        for (Appointment appt : appointments) {
    %>
	<div
		class="bg-white p-6 rounded-lg shadow-md flex flex-col justify-between">
		<div>
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
		</div>
		<div
			class="flex flex-col md:flex-row flex-wrap gap-2 mt-4 w-full justify-end">
			<a
				href="receipt?appointmentId=<%=appt.getAppointmentId()%>&source=view-appointment"
				class="w-full md:w-auto">
				<button
					class="w-full md:w-auto bg-blue-200 text-blue-800 text-sm px-3 py-1 rounded hover:bg-blue-300">View
					Receipt</button>
			</a>
			<form action="markAsDone" method="post" style="display: inline;"
				class="w-full md:w-auto">
				<input type="hidden" name="appointmentId"
					value="<%=appt.getAppointmentId()%>" />
				<button type="submit"
					class="w-full md:w-auto bg-green-500 text-white text-sm px-3 py-1 rounded hover:bg-green-600">Done</button>
			</form>
			<a
				href="appointment-management?appointmentId=<%=appt.getAppointmentId()%>"
				class="w-full md:w-auto">
				<button
					class="w-full md:w-auto bg-blue-500 text-white text-sm px-3 py-1 rounded hover:bg-blue-600">Edit</button>
			</a>
			<button type="button"
				class="w-full md:w-auto bg-red-500 text-white text-sm px-3 py-1 rounded hover:bg-red-600"
				onclick="showCancelModal('<%=appt.getAppointmentId()%>')">Cancel</button>
			<form id="cancelForm-<%=appt.getAppointmentId()%>"
				action="cancel-appointment" method="post" style="display: none;">
				<input type="hidden" name="appointmentId"
					value="<%=appt.getAppointmentId()%>" />
			</form>
		</div>
	</div>
	<%
    }
    } else {
    %>
	<p>No appointments found.</p>
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
	<nav class="flex flex-col sm:flex-row gap-2 w-full sm:w-auto">
		<ul class="flex flex-col sm:flex-row gap-2 w-full sm:w-auto">
			<%
            if (currentPage > 1) {
            %>
			<li class="w-full sm:w-auto"><a href="javascript:void(0)"
				onclick="loadAppointments(<%=currentPage - 1%>)"
				class="block w-full sm:w-auto px-3 py-1 rounded-l bg-gray-200 hover:bg-gray-300 text-center">
					Previous </a></li>
			<%
            }
            %>
			<%
            for (int i = startPage; i <= endPage; i++) {
            %>
			<li class="w-full sm:w-auto"><a href="javascript:void(0)"
				onclick="loadAppointments(<%=i%>)"
				class="block w-full sm:w-auto px-3 py-1 <%=i == currentPage ? "bg-blue-500 text-white" : "bg-gray-200 hover:bg-gray-300"%> text-center">
					<%=i%>
			</a></li>
			<%
            }
            %>
			<%
            if (currentPage < totalPages) {
            %>
			<li class="w-full sm:w-auto"><a href="javascript:void(0)"
				onclick="loadAppointments(<%=currentPage + 1%>)"
				class="block w-full sm:w-auto px-3 py-1 rounded-r bg-gray-200 hover:bg-gray-300 text-center">
					Next </a></li>
			<%
            }
            %>
		</ul>
	</nav>
</div>
<script>
let selectedAppointmentId = null;

function showCancelModal(appointmentId) {
    selectedAppointmentId = appointmentId;
    document.getElementById('cancelModal').classList.remove('hidden');
}

document.getElementById('cancelModalNo').onclick = function() {
    document.getElementById('cancelModal').classList.add('hidden');
    selectedAppointmentId = null;
};

document.getElementById('cancelModalYes').onclick = function() {
    if (selectedAppointmentId) {
        document.getElementById('cancelForm-' + selectedAppointmentId).submit();
    }
    document.getElementById('cancelModal').classList.add('hidden');
    selectedAppointmentId = null;
};
</script>

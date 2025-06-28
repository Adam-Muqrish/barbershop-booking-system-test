<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="com.hugi.barbershop.customer.model.Appointment"%>
<%@ page import="com.hugi.barbershop.customer.model.Payment"%>
<%
Appointment appointment = (Appointment) request.getAttribute("appointment");
Payment payment = (Payment) request.getAttribute("payment");
String barberName = (String) request.getAttribute("barberName");

String bookingFor = appointment != null ? appointment.getCustBookFor() : "";
String bookingDate = appointment != null ? appointment.getAppointmentDate() : "";
String selectedTime = appointment != null ? appointment.getAppointmentTime() : "";
String category = appointment != null ? appointment.getCustType() : "";

double price = payment != null ? payment.getPaymentAmount() : 0.0;
String paymentMethod = payment != null ? payment.getPaymentMethod() : "";
String paymentId = payment != null ? payment.getPaymentId() : "N/A";
String paymentDate = payment != null && payment.getPaymentDate() != null ? payment.getPaymentDate().toString() : "";

// Condition to know where the customer came from
String source = request.getParameter("source");
String backUrl;
String backText;
System.out.println("Source: " + source);
if ("appointment-history".equals(source)) {
    backUrl = "appointment-history";
    backText = "Appointment History";
} else if ("view-appointment".equals(source)) {
    backUrl = "view-appointment";
    backText = "Appointment page";
} else {
    backUrl = "view-appointment"; // default
    backText = "Appointment page";
}
%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<body class="flex flex-col h-screen justify-between bg-yellow-100">
	<%@ include file="/WEB-INF/views/includes/nav.jsp"%>
	<main class="flex flex-col items-center mx-3 my-4 flex-grow">
		<div class="bg-white rounded-lg shadow-lg p-6 w-full">
			<h1 class="text-2xl font-bold text-center mb-2">Receipt</h1>
			<p class="text-center text-lg mb-6">Thank you for your payment!</p>

			<hr class="mb-4">

			<!-- Appointment Details -->
			<div class="mb-6">
				<h2 class="font-semibold mb-2">Appointment Details</h2>
				<p>
					Booking For:
					<%=bookingFor%></p>
				<p>
					Customer Category
					<%=category%></p>
				<p>
					Date:
					<%=bookingDate%></p>
				<p>
					Time:
					<%=selectedTime%></p>
				<p>
					Barber:
					<%=barberName%></p>
			</div>

			<hr class="mb-4">

			<!-- Payment Details -->
			<div class="mb-6">
				<h2 class="font-semibold mb-2">Payment Details</h2>
				<p>
					Payment ID:
					<%=paymentId%></p>
				<p>
					Payment Method:
					<%=paymentMethod%></p>
				<p>
					Amount Paid: RM
					<%=String.format("%.2f", price)%></p>
				<p>
					Date of Payment:
					<%=paymentDate%></p>
			</div>

			<hr class="mb-4">

			<!-- Customer Information -->
			<div class="mb-6">
				<h2 class="font-semibold mb-2">Customer Information</h2>
				<p>
					Name:
					<%=customer != null ? customer.getCustName() : ""%></p>
				<p>
					Email:
					<%=customer != null ? customer.getCustEmail() : ""%></p>
				<p>
					Phone Number:
					<%=customer != null ? customer.getCustPhoneNumber() : ""%></p>
			</div>

			<hr class="mb-4">

			<p class="text-sm text-center text-gray-600 mt-4">This receipt is
				generated automatically and does not require a signature.</p>

			<div class="flex justify-center mt-6">
				<a href="<%=backUrl%>"
					class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-4 rounded">
					Back to <%=backText%></a>
			</div>
		</div>
	</main>
	<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
	<script>
		// Force reload from server when navigating via back/forward
		window.addEventListener('pageshow', function(event) {
			if (event.persisted) {
				window.location.reload();
			}
		});
	</script>
</body>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.hugi.barbershop.customer.model.Customer"%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<script>
function loadAppointments(page) {
    const xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("appointment-container").innerHTML = this.responseText;
        }
    };
    xhr.open("GET", "view-appointment?page=" + page + "&ajax=true", true);
    xhr.send();
}
</script>
<body class="flex flex-col h-screen justify-between bg-yellow-100">
    <%@ include file="/WEB-INF/views/includes/nav.jsp"%>
    <main class="flex flex-col items-center mx-3 my-4 flex-grow justify-center">
        <div class="bg-white rounded-lg shadow-lg p-6 w-full">
            <h1 class="text-2xl font-bold mb-6">Your Current Appointments:</h1>
            <div id="appointment-container">
                <!-- This will be populated with appointment data -->
                <jsp:include page="appointment-list-partial.jsp" />
            </div>
        </div>
    </main>
    <%@ include file="/WEB-INF/views/includes/footer.jsp"%>
</body>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<script>
function loadHistory(page) {
    const xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function() {
        if (this.readyState === 4 && this.status === 200) {
            document.getElementById("history-container").innerHTML = this.responseText;
        }
    };
    xhr.open("GET", "appointment-history?page=" + page + "&ajax=true", true);
    xhr.send();
}
</script>
<body class="flex flex-col h-screen justify-between bg-yellow-100">
    <%@ include file="/WEB-INF/views/includes/nav.jsp"%>
    <main class="flex flex-col items-center mx-3 my-4 flex-grow justify-center">
        <div class="bg-white rounded-lg shadow-lg p-6 w-full">
            <h1 class="text-2xl font-bold mb-6">Your Appointments History:</h1>
            <div id="history-container">
                <jsp:include page="appointment-history-list-partial.jsp" />
            </div>
        </div>
    </main>
    <%@ include file="/WEB-INF/views/includes/footer.jsp"%>
</body>
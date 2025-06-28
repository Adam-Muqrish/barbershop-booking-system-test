<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
response.setHeader("Pragma", "no-cache"); // HTTP 1.0
response.setDateHeader("Expires", 0); // Proxies

// Check if the 'customer' object is present in the session
%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<body class="flex flex-col h-screen justify-between bg-yellow-100">
	<%@ include file="/WEB-INF/views/includes/nav.jsp"%>
	<%
	// If already logged in, redirect to index page
	if (customer != null) {
		response.sendRedirect("index");
		return;
	}
	%>
	<main class="flex flex-col items-center mx-3 my-4 flex-grow">
		<div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-md">
			<h1 class="text-2xl font-bold mb-4">Login</h1>
			<%
			String error = (String) session.getAttribute("error");
			if (error != null) {
			    out.println("<p class=\"text-red-500 mb-4\">" + error + "</p>");
			    session.removeAttribute("error"); // Remove error so it won't show on refresh
			}
			%>
			<form action="login" method="post">
				<!-- Add this above the email input -->
				<div class="mb-4">
				    <label class="block text-sm font-semibold mb-1">Login as:</label>
				    <select name="userType" class="w-full border rounded px-3 py-2">
				        <option value="customer">Customer</option>
				        <option value="staff">Staff</option>
				    </select>
				</div>
				<div class="mb-4">
					<label class="block text-sm font-semibold mb-1" for="email">Email:</label>
					<input type="email" id="email" name="email"
						class="w-full border rounded px-3 py-2" required>
				</div>
				<div class="mb-4">
					<label class="block text-sm font-semibold mb-1" for="password">Password:</label>
					<input type="password" id="password" name="password"
						class="w-full border rounded px-3 py гем2" required>
				</div>
				<button type="submit"
					class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 w-full">Login</button>
			</form>
		</div>
	</main>
	<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
</body>
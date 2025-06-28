<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.hugi.barbershop.customer.model.Customer"%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<body class="flex flex-col h-screen justify-between bg-yellow-100">
	<%@ include file="/WEB-INF/views/includes/nav.jsp"%>
	<main class="flex flex-col items-center mx-3 my-4 flex-grow">
		<div class="bg-white rounded-lg shadow-lg p-6 w-full">
			<h1 class="text-2xl font-bold mb-4">Profile Management</h1>
			<%
			String error = (String) request.getAttribute("error");
			String message = (String) request.getAttribute("message");

			if (error != null) {
			%>
			<p class="text-red-500 mb-4"><%=error%></p>
			<%
			}
			if (message != null) {
			%>
			<p class="text-green-500 mb-4"><%=message%></p>
			<%
			}
			if (customer == null) {
			%>
			<p class="text-red-500 mb-4">Unable to load profile. Please
				ensure a valid customer ID is used.</p>
			<%
			} else {
			%>
			<form action="profile-management"
				method="post" enctype="multipart/form-data">
				<div class="mb-4">
					<label class="block text-sm font-semibold mb-1" for="name">Name:</label>
					<input type="text" id="name" name="name"
						value="<%=customer.getCustName()%>"
						class="w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500" />
				</div>
				<div class="mb-4">
					<label class="block text-sm font-semibold mb-1" for="email">Email:</label>
					<input type="email" id="email" name="email"
						value="<%=customer.getCustEmail()%>"
						class="w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500" />
				</div>
				<div class="mb-4">
					<label class="block text-sm font-semibold mb-1" for="phone">Phone
						Number:</label> <input type="text" id="phone" name="phone"
						value="<%=customer.getCustPhoneNumber()%>"
						class="w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500" />
				</div>
				<div class="mb-4">
					<label class="block text-sm font-semibold mb-1" for="old-password">Old
						Password:</label> <input type="password" id="old-password"
						name="oldPassword"
						class="w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500" />
				</div>
				<div class="mb-4">
					<label class="block text-sm font-semibold mb-1" for="new-password">New
						Password:</label> <input type="password" id="new-password"
						name="newPassword"
						class="w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500" />
				</div>
				<div class="mb-4">
					<label class="block text-sm font-semibold mb-1"
						for="profile-picture">Profile Picture:</label> <input type="file"
						id="profile-picture" name="profilePicture"
						class="w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500 text-gray-700 file:mr-4 file:py-1 file:px-3 file:rounded file:border-0 file:bg-blue-500 file:text-white file:hover:bg-blue-600" />
				</div>
				<div class="flex space-x-2">
					<button type="submit"
						class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 flex-1">
						Save Changes</button>
					<button type="button"
						class="bg-gray-300 text-black px-4 py-2 rounded hover:bg-gray-400 flex-1">
						Cancel</button>
				</div>
			</form>
			<%
			}
			%>
		</div>
	</main>
	<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
</body>
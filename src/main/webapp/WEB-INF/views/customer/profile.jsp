<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.hugi.barbershop.customer.model.Customer"%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<body class="flex flex-col h-screen justify-between bg-yellow-100">
	<%@ include file="/WEB-INF/views/includes/nav.jsp"%>
	<%-- No variable declaration in nav.jsp! --%>
	<%
	if (customer == null) {
	%>
	<main class="flex-grow flex items-center justify-center">
		<p class="text-red-500 text-lg">Error: Customer data not found.</p>
	</main>
	<%
	} else {
	%>
	<main class="flex flex-col items-center mx-3 my-4 flex-grow">
		<div class="bg-white rounded-lg shadow-lg p-6 w-full">
			<h1 class="text-2xl font-bold mb-4">My Profile</h1>
			<div class="flex items-center space-x-4">
				<div class="bg-gray-200 rounded-lg p-4 flex flex-col items-center">
					<div class="w-16 h-16 bg-gray-300 rounded-full mb-2">
						<%
						if (picture != null && !picture.isEmpty()) {
						%>
						<img src="<%=request.getContextPath()%>/resources/uploads/<%=picture%>"
							class="w-16 h-16 rounded-full" alt="Profile Picture">
						<%
						} else {
						%>
						<svg class="w-12 h-12 text-gray-400" fill="currentColor"
							viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd"
								d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z"
								clip-rule="evenodd"></path>
                            </svg>
						<%
						}
						%>
					</div>
					<p class="text-sm font-semibold">Loyalty Points</p>
					<p class="text-lg font-bold">${loyaltyPoints}</p>
				</div>
				<div class="flex-1">
					<p class="text-sm font-semibold">Name :</p>
					<p class="text-sm mb-2"><%=customer.getCustName()%></p>
					<p class="text-sm font-semibold">Phone Number :</p>
					<p class="text-sm mb-2"><%=customer.getCustPhoneNumber()%></p>
					<p class="text-sm font-semibold">Email :</p>
					<p class="text-sm"><%=customer.getCustEmail()%></p>
				</div>
			</div>
			<a href="profile-management">
				<button
					class="mt-4 bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 w-full">
					Edit Profile</button>
			</a>
		</div>
	</main>
	<%
	}
	%>
	<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
</body>
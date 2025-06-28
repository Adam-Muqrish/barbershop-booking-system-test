<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.hugi.barbershop.customer.model.Customer"%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<%
com.hugi.barbershop.customer.model.Feedback existingFeedback = (com.hugi.barbershop.customer.model.Feedback) request
		.getAttribute("existingFeedback");
String feedbackSuccess = (String) request.getAttribute("feedbackSuccess");
%>
<body class="flex flex-col h-screen justify-between bg-yellow-100">
	<%@ include file="/WEB-INF/views/includes/nav.jsp"%>
	<main class="flex flex-col items-center mx-3 my-4 flex-grow">
		<div class="bg-white rounded-lg shadow-lg p-6 w-full">
			<div class="w-full">
				<h1 class="text-2xl font-semibold mb-4">Feedback</h1>
				<div class="p-6 rounded-lg shadow-sm">
					<form action="feedback" method="post">
						<!-- Rating -->
						<div class="mb-4">
							<label class="block text-lg font-semibold mb-2">Your
								Rating:</label>
							<div class="flex space-x-1" id="star-rating">
								<span class="star text-gray-400 text-xl cursor-pointer"
									data-value="1">&#9733;</span> <span
									class="star text-gray-400 text-xl cursor-pointer"
									data-value="2">&#9733;</span> <span
									class="star text-gray-400 text-xl cursor-pointer"
									data-value="3">&#9733;</span> <span
									class="star text-gray-400 text-xl cursor-pointer"
									data-value="4">&#9733;</span> <span
									class="star text-gray-400 text-xl cursor-pointer"
									data-value="5">&#9733;</span>
							</div>
							<input type="hidden" name="rating" id="rating-input"
								value="<%=existingFeedback != null ? existingFeedback.getRating() : 0%>" />
						</div>
						<!-- Feedback Text -->
						<div class="mb-6">
							<label class="block text-sm font-medium mb-2">Your
								Feedback:</label>
							<textarea
								class="w-full h-32 p-3 rounded-md shadow-lg resize-none focus:outline-none focus:ring-2 focus:ring-blue-500"
								name="feedback"><%=existingFeedback != null ? existingFeedback.getComments() : ""%></textarea>
						</div>
						<!-- Buttons -->
						<div class="flex space-x-4">
							<button type="submit"
								class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-4 rounded-full shadow-md">Submit
								Feedback</button>
							<button type="button" id="deleteBtn"
								class="bg-red-500 hover:bg-red-600 text-white font-semibold py-2 px-4 rounded-full shadow-md">Delete
								Feedback</button>
						</div>
					</form>
					<!-- Confirmation Modal (Tailwind CSS) -->
					<div id="confirmModal"
						class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-40 hidden">
						<div
							class="relative w-full max-w-sm mx-4 bg-white rounded-3xl shadow-2xl flex flex-col items-center p-8">
							<div class="mb-4 flex justify-center">
								<div
									class="w-20 h-20 rounded-full bg-yellow-400 flex items-center justify-center shadow-lg">
									<svg class="w-12 h-12 text-white" fill="none"
										stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
										<path d="M12 8v4m0 4h.01" stroke-linecap="round" />
										<circle cx="12" cy="12" r="10" stroke="none" />
									</svg>
								</div>
							</div>
							<h2 class="text-xl font-bold text-gray-900 mb-2 text-center">Delete
								Feedback?</h2>
							<p class="text-base text-gray-700 mb-6 text-center">Are you
								sure you want to delete your feedback? This action cannot be
								undone.</p>
							<div class="w-full flex space-x-3">
								<button id="confirmDelete"
									class="flex-1 rounded-xl bg-red-500 hover:bg-red-600 text-white py-3 font-semibold shadow transition-all">Delete</button>
								<button id="cancelDelete"
									class="flex-1 rounded-xl bg-gray-200 hover:bg-gray-300 text-gray-800 py-3 font-semibold shadow transition-all">Cancel</button>
							</div>
						</div>
					</div>
					<!-- Alert Modal (Tailwind CSS) -->
					<div id="alertModal"
						class="fixed inset-0 z-50 flex items-center justify-center bg-black bg-opacity-40 hidden">
						<div
							class="relative w-full max-w-sm mx-4 bg-white rounded-3xl shadow-2xl flex flex-col items-center p-8">
							<div class="mb-4 flex justify-center">
								<div id="alertIconContainer"
									class="w-20 h-20 rounded-full bg-blue-500 flex items-center justify-center shadow-lg">
									<svg id="alertIconSuccess" class="w-12 h-12 text-white"
										fill="none" stroke="currentColor" stroke-width="2"
										viewBox="0 0 24 24">
										<path d="M5 13l4 4L19 7" stroke-linecap="round"
											stroke-linejoin="round" />
										<circle cx="12" cy="12" r="10" stroke="none" />
									</svg>
									<svg id="alertIconError" class="w-12 h-12 text-white hidden"
										fill="none" stroke="currentColor" stroke-width="2"
										viewBox="0 0 24 24">
										<path d="M12 8v4m0 4h.01" stroke-linecap="round" />
										<circle cx="12" cy="12" r="10" stroke="none" />
									</svg>
								</div>
							</div>
							<h2 id="alertHeadline"
								class="text-xl font-bold text-gray-900 mb-2 text-center">Success</h2>
							<p id="alertMessage"
								class="text-base text-gray-700 mb-6 text-center"></p>
							<button id="closeAlert"
								class="w-full rounded-xl bg-blue-500 hover:bg-blue-600 text-white py-3 font-semibold shadow transition-all">Dismiss</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
	<script>
	// Star rating functionality
	const stars = document.querySelectorAll('#star-rating .star');
	let rating = 0;
	const ratingInput = document.getElementById('rating-input');

	stars.forEach((star, idx) => {
		star.addEventListener('click', () => {
			rating = idx + 1;
			ratingInput.value = rating;
			updateStars();
		});
		star.addEventListener('mouseover', () => {
			highlightStars(idx + 1);
		});
		star.addEventListener('mouseout', () => {
			updateStars();
		});
	});

	function updateStars() {
		stars.forEach((star, i) => {
			star.classList.toggle('text-yellow-400', i < rating);
			star.classList.toggle('text-gray-400', i >= rating);
		});
	}

	function highlightStars(hoverRating) {
		stars.forEach((star, i) => {
			star.classList.toggle('text-yellow-400', i < hoverRating);
			star.classList.toggle('text-gray-400', i >= hoverRating);
		});
	}

	window.addEventListener('DOMContentLoaded', () => {
			<%if (existingFeedback != null) {%>
			rating = <%=existingFeedback.getRating()%>;
			ratingInput.value = rating;
			<%} else {%>
			rating = 0;
			ratingInput.value = 0;
			<%}%>
			updateStars();
	});

	// Delete button logic
	document.getElementById('deleteBtn').addEventListener('click', function() {
		document.getElementById('confirmModal').classList.remove('hidden');
	});
	document.getElementById('cancelDelete').addEventListener('click', function() {
		document.getElementById('confirmModal').classList.add('hidden');
	});

	// Dismiss button logic
	document.getElementById('closeAlert').onclick = function() {
		document.getElementById('alertModal').classList.add('hidden');
	};

	function showAlert(message, type = "success", redirect = false) {
		const alertModal = document.getElementById('alertModal');
		const alertMessage = document.getElementById('alertMessage');
		const alertHeadline = document.getElementById('alertHeadline');
		const iconContainer = document.getElementById('alertIconContainer');
		const iconSuccess = document.getElementById('alertIconSuccess');
		const iconError = document.getElementById('alertIconError');
		const closeBtn = document.getElementById('closeAlert');

		alertMessage.textContent = message;

		if (type === "error") {
			alertHeadline.textContent = "Error";
			iconContainer.classList.remove("bg-blue-500");
			iconContainer.classList.add("bg-red-500");
			iconSuccess.classList.add("hidden");
			iconError.classList.remove("hidden");
			closeBtn.classList.remove("bg-blue-500", "hover:bg-blue-600");
			closeBtn.classList.add("bg-red-500", "hover:bg-red-600");
			closeBtn.onclick = function() {
				alertModal.classList.add('hidden');
			};
		} else {
			alertHeadline.textContent = "Success";
			iconContainer.classList.remove("bg-red-500");
			iconContainer.classList.add("bg-blue-500");
			iconSuccess.classList.remove("hidden");
			iconError.classList.add("hidden");
			closeBtn.classList.remove("bg-red-500", "hover:bg-red-600");
			closeBtn.classList.add("bg-blue-500", "hover:bg-blue-600");
			closeBtn.onclick = function() {
				alertModal.classList.add('hidden');
				if (redirect) {
					const appointmentId = getAppointmentIdFromUrl();
					if (appointmentId) {
						window.location.href = "feedback?appointmentId=" + appointmentId;
					} else {
						window.location.href = "feedback";
					}
				}
			};
		}
		alertModal.classList.remove('hidden');
	}

		// Show success alert if present (after full reload)
	   <%if (feedbackSuccess != null) {%>
		window.addEventListener('DOMContentLoaded', function() {
			showAlert('<%=feedbackSuccess%>');
		});
	   <%}%>

		function getAppointmentIdFromUrl() {
			const params = new URLSearchParams(window.location.search);
			return params.get('appointmentId');
		}

	// AJAX submit for feedback form
	document.querySelector('form[action="feedback"]').addEventListener('submit', function(e) {
		e.preventDefault();
		const form = this;
		const rating = document.getElementById('rating-input').value;
		const comments = form.querySelector('textarea[name="feedback"]').value.trim();
		const appointmentId = getAppointmentIdFromUrl();

		if (!rating || rating == "0" || !comments) {
			showAlert('Rating and comments cannot be empty.', 'error');
			return;
		}

		const data = new URLSearchParams();
		data.append('rating', rating);
		data.append('feedback', comments);

		fetch('feedback?appointmentId=' + appointmentId, {
			method: 'POST',
			body: data,
			credentials: 'same-origin',
			headers: { 'X-Requested-With': 'XMLHttpRequest' }
		})
			.then(response => {
				if (response.ok) {
					// Redirect immediately, do not show alert here
					window.location.href = "feedback?appointmentId=" + appointmentId;
				} else {
					showAlert('Failed to submit feedback.', 'error');
				}
			});
	});

	// AJAX for delete
	document.getElementById('confirmDelete').addEventListener('click', function() {
		const appointmentId = getAppointmentIdFromUrl();
		const data = new URLSearchParams();
		data.append('action', 'delete');

		fetch('feedback?appointmentId=' + appointmentId, {
			method: 'POST',
			body: data,
			credentials: 'same-origin',
			headers: { 'X-Requested-With': 'XMLHttpRequest' }
		})
			.then(response => {
				if (response.ok) {
					// Redirect immediately, do not show alert here
					window.location.href = "feedback?appointmentId=" + appointmentId;
				} else {
					showAlert('Failed to delete feedback.', 'error');
				}
			});
	});
	</script>
</body>

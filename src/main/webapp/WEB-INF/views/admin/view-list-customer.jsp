<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<body class="flex flex-col h-screen justify-between bg-yellow-100">
	<main
		class="flex flex-col items-center mx-3 my-4 flex-grow justify-center">
		<div class="bg-white rounded-lg shadow-lg p-6 w-full">
			<div class="flex min-h-screen bg-gray-100">
				<!-- Sidebar -->
				<aside
					class="w-64 bg-gray-300 min-h-screen flex flex-col justify-between p-6">
					<div>
						<!-- Logo -->
						<div class="mb-10 flex items-center justify-center">
							<img src="https://i.imgur.com/jQT5P2C.png" alt="HUGI Logo"
								class="h-20" />
						</div>
						<nav class="space-y-2">
							<button
								class="flex items-center w-full text-left px-4 py-2 text-gray-900 bg-gray-400 rounded-lg font-medium">
								<svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
			            <path d="M3 12l2-2 4 4 8-8 2 2-10 10z" />
			          </svg>
								Dashboard
							</button>
							<button
								class="flex items-center w-full text-left px-4 py-2 text-gray-900 bg-gray-400 rounded-lg font-medium">
								<svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
			            <circle cx="12" cy="12" r="10" />
			            <path d="M12 6v6l4 2" />
			          </svg>
								Customer
							</button>
							<button
								class="flex items-center w-full text-left px-4 py-2 hover:bg-gray-400 rounded-lg font-medium">
								<svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
			            <path
										d="M7 7v-4h10v4M5 18v-2c0-1 1-2 2-2h10a2 2 0 0 1 2 2v2" />
			          </svg>
								Barber
							</button>
							<button
								class="flex items-center w-full text-left px-4 py-2 hover:bg-gray-400 rounded-lg font-medium">
								<svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
			            <rect width="20" height="14" x="2" y="5" rx="4" />
			            <path d="M12 5v14" />
			          </svg>
								Appointment
							</button>
							<button
								class="flex items-center w-full text-left px-4 py-2 hover:bg-gray-400 rounded-lg font-medium">
								<svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
			            <path d="M9 17v-6h13M5 7h4V3a2 2 0 1 1 4 0v4h4" />
			          </svg>
								Report
							</button>
							<button
								class="flex items-center w-full text-left px-4 py-2 hover:bg-gray-400 rounded-lg font-medium">
								<svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
			            <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4" />
			            <polyline points="7 10 12 15 17 10" />
			          </svg>
								Feedback
							</button>
							<button
								class="flex items-center w-full text-left px-4 py-2 hover:bg-gray-400 rounded-lg font-medium">
								<svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
									viewBox="0 0 24 24">
			            <circle cx="12" cy="8" r="4" />
			            <path d="M6 20v-2a4 4 0 0 1 8 0v2" />
			          </svg>
								Register Staff
							</button>
						</nav>
					</div>
					<a href="logout"
						class="flex items-center px-4 py-2 text-gray-700 hover:bg-gray-400 rounded-lg font-medium">
						<svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor"
							viewBox="0 0 24 24">
					    <path d="M17 16l4-4m0 0l-4-4m4 4H7" />
					  </svg> Logout
					</a>
				</aside>

				<!-- Main content -->
				<div class="flex-1 flex flex-col">
					<!-- Topbar -->
					<header
						class="bg-gray-800 py-6 px-10 flex items-center justify-between">
						<span class="text-white text-5xl font-light tracking-widest">HUGI
							BARBERSHOP</span>
						<div class="flex items-center gap-4">
							<div
								class="bg-white flex items-center px-5 py-2 rounded-full shadow">
								<img src="https://randomuser.me/api/portraits/men/89.jpg"
									alt="Admin"
									class="h-10 w-10 rounded-full border-2 border-gray-400 mr-4">
								<span> <span class="block text-gray-800 font-semibold">Karim
										Benzema</span> <span class="block text-xs text-gray-500">Admin</span>
								</span>
								<button class="ml-5 text-gray-500">
									<svg class="w-6 h-6" fill="none" stroke="currentColor"
										viewBox="0 0 24 24">
			              <path d="M4 8h16M4 16h16" />
			            </svg>
								</button>
							</div>
						</div>
					</header>

					<!-- Customers Table -->
					<main class="flex-1 p-10 bg-white">
						<div class="mb-6">
							<h2 class="text-2xl font-semibold mb-1">List of Customer</h2>
							<p class="text-gray-400 text-sm">From latest to oldest
								customer registration</p>
						</div>
						<div class="overflow-x-auto">
							<table class="min-w-full bg-white">
								<thead>
									<tr class="border-b border-gray-200">
										<th
											class="text-left px-6 py-3 font-semibold text-lg text-gray-500">Name</th>
										<th
											class="text-left px-6 py-3 font-semibold text-lg text-gray-500">Phone
											Number</th>
										<th
											class="text-left px-6 py-3 font-semibold text-lg text-gray-500">Email</th>
									</tr>
								</thead>
								<tbody>
									<!-- Customer Row Example -->
									<tr class="border-b border-gray-200">
										<td class="flex items-center gap-3 px-6 py-4"><img
											src="https://randomuser.me/api/portraits/women/85.jpg" alt=""
											class="h-8 w-8 rounded-full border"> Bluenose</td>
										<td class="px-6 py-4">012-6069866</td>
										<td class="px-6 py-4">email@example.com</td>
									</tr>
									<tr class="border-b border-gray-200">
										<td class="flex items-center gap-3 px-6 py-4"><img
											src="https://randomuser.me/api/portraits/men/94.jpg" alt=""
											class="h-8 w-8 rounded-full border"> Pennywise</td>
										<td class="px-6 py-4">012-6069866</td>
										<td class="px-6 py-4">email@example.com</td>
									</tr>
									<tr class="border-b border-gray-200">
										<td class="flex items-center gap-3 px-6 py-4"><img
											src="https://randomuser.me/api/portraits/men/95.jpg" alt=""
											class="h-8 w-8 rounded-full border"> Flotsam</td>
										<td class="px-6 py-4">012-6069866</td>
										<td class="px-6 py-4">email@example.com</td>
									</tr>
									<tr class="border-b border-gray-200">
										<td class="flex items-center gap-3 px-6 py-4"><img
											src="https://randomuser.me/api/portraits/men/79.jpg" alt=""
											class="h-8 w-8 rounded-full border"> Gregautsch</td>
										<td class="px-6 py-4">012-6069866</td>
										<td class="px-6 py-4">email@example.com</td>
									</tr>
									<tr class="border-b border-gray-200">
										<td class="flex items-center gap-3 px-6 py-4"><img
											src="https://randomuser.me/api/portraits/men/50.jpg" alt=""
											class="h-8 w-8 rounded-full border"> ElPistolero</td>
										<td class="px-6 py-4">012-6069866</td>
										<td class="px-6 py-4">email@example.com</td>
									</tr>
									<tr>
										<td class="flex items-center gap-3 px-6 py-4"><img
											src="https://randomuser.me/api/portraits/women/12.jpg" alt=""
											class="h-8 w-8 rounded-full border"> Siuuuuuuu</td>
										<td class="px-6 py-4">012-6069866</td>
										<td class="px-6 py-4">email@example.com</td>
									</tr>
								</tbody>
							</table>
						</div>
						<!-- Pagination -->
						<div class="flex justify-end mt-8">
							<nav class="inline-flex rounded-md shadow-sm"
								aria-label="Pagination">
								<button
									class="px-4 py-2 text-sm text-gray-400 bg-gray-100 rounded-l-md border border-gray-300"
									disabled>Previous page</button>
								<button
									class="px-4 py-2 text-sm font-semibold text-gray-700 bg-white border-t border-b border-gray-300">1</button>
								<button
									class="px-4 py-2 text-sm text-gray-700 bg-white border border-gray-300">2</button>
								<button
									class="px-4 py-2 text-sm text-gray-700 bg-white rounded-r-md border border-gray-300">Next
									page</button>
							</nav>
						</div>
					</main>
				</div>
			</div>
		</div>
	</main>
</body>
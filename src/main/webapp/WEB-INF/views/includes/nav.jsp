<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="com.hugi.barbershop.customer.model.Customer"%>
<%
Customer customer = (Customer) session.getAttribute("customer");
String picture = (customer != null) ? customer.getCustPicture() : null;
%>
<nav class="border-b border-gray-200 shadow-xl bg-neutral-900">
	<div
		class="flex flex-col md:flex-row items-center justify-between p-4 mx-auto space-y-4 lg:space-y-0"
		style="background-color: #101820; border-bottom: 1px solid #FFFCFB;">
		<ul
			class="flex flex-col lg:flex-row justify-start md:justify-end space-x-6 text-left w-full md:w-auto">
			<li class="block text-white">CONTACT US: 0127865132</li>
			<li class="block text-white">OPENING HOUR: TUESDAY - SUNDAY (10
				a.m - 10 p.m)</li>
		</ul>
		<div
			class="flex flex-row justify-start md:justify-end space-x-6 text-left w-full md:w-auto">
			<svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" x="0px"
				y="0px" width="100" height="100" viewBox="0,0,256,256">
				<g fill="#fefefe" fill-rule="nonzero" stroke="none" stroke-width="1"
					stroke-linecap="butt" stroke-linejoin="miter"
					stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0"
					font-family="none" font-weight="none" font-size="none"
					text-anchor="none" style="mix-blend-mode: normal">
				<g transform="scale(8.53333,8.53333)">
				<path
					d="M28,6.937c-0.957,0.425 -1.985,0.711 -3.064,0.84c1.102,-0.66 1.947,-1.705 2.345,-2.951c-1.03,0.611 -2.172,1.055 -3.388,1.295c-0.973,-1.037 -2.359,-1.685 -3.893,-1.685c-2.946,0 -5.334,2.389 -5.334,5.334c0,0.418 0.048,0.826 0.138,1.215c-4.433,-0.222 -8.363,-2.346 -10.995,-5.574c-0.458,0.788 -0.721,1.704 -0.721,2.683c0,1.85 0.941,3.483 2.372,4.439c-0.874,-0.028 -1.697,-0.268 -2.416,-0.667c0,0.023 0,0.044 0,0.067c0,2.585 1.838,4.741 4.279,5.23c-0.447,0.122 -0.919,0.187 -1.406,0.187c-0.343,0 -0.678,-0.034 -1.003,-0.095c0.679,2.119 2.649,3.662 4.983,3.705c-1.825,1.431 -4.125,2.284 -6.625,2.284c-0.43,0 -0.855,-0.025 -1.273,-0.075c2.361,1.513 5.164,2.396 8.177,2.396c9.812,0 15.176,-8.128 15.176,-15.177c0,-0.231 -0.005,-0.461 -0.015,-0.69c1.043,-0.753 1.948,-1.692 2.663,-2.761z"></path></g></g>
			</svg>
			<svg class="w-5 h-5" xmlns="http://www.w3.org/2000/svg" x="0px"
				y="0px" width="24" height="24" viewBox="0,0,256,256">
				<g fill="#fefefe" fill-rule="nonzero" stroke="none" stroke-width="1"
					stroke-linecap="butt" stroke-linejoin="miter"
					stroke-miterlimit="10" stroke-dasharray="" stroke-dashoffset="0"
					font-family="none" font-weight="none" font-size="none"
					text-anchor="none" style="mix-blend-mode: normal">
				<g transform="scale(10.66667,10.66667)">
				<path
					d="M17.525,9h-3.525v-2c0,-1.032 0.084,-1.682 1.563,-1.682h1.868v-3.18c-0.909,-0.094 -1.823,-0.14 -2.738,-0.138c-2.713,0 -4.693,1.657 -4.693,4.699v2.301h-3v4l3,-0.001v9.001h4v-9.003l3.066,-0.001z"></path></g></g>
			</svg>
			<svg class="w-5 h-5 text-white dark:text-white" aria-hidden="true"
				xmlns="http://www.w3.org/2000/svg" width="24" height="24"
				fill="currentColor" viewBox="0 0 24 24">
			  <path fill-rule="evenodd"
					d="M12.51 8.796v1.697a3.738 3.738 0 0 1 3.288-1.684c3.455 0 4.202 2.16 4.202 4.97V19.5h-3.2v-5.072c0-1.21-.244-2.766-2.128-2.766-1.827 0-2.139 1.317-2.139 2.676V19.5h-3.19V8.796h3.168ZM7.2 6.106a1.61 1.61 0 0 1-.988 1.483 1.595 1.595 0 0 1-1.743-.348A1.607 1.607 0 0 1 5.6 4.5a1.601 1.601 0 0 1 1.6 1.606Z"
					clip-rule="evenodd" />
			  <path d="M7.2 8.809H4V19.5h3.2V8.809Z" />
			</svg>

			<svg class="w-5 h-5 text-white dark:text-white" aria-hidden="true"
				xmlns="http://www.w3.org/2000/svg" width="24" height="24"
				fill="currentColor" viewBox="0 0 24 24">
			  <path fill-rule="evenodd"
					d="M21.7 8.037a4.26 4.26 0 0 0-.789-1.964 2.84 2.84 0 0 0-1.984-.839c-2.767-.2-6.926-.2-6.926-.2s-4.157 0-6.928.2a2.836 2.836 0 0 0-1.983.839 4.225 4.225 0 0 0-.79 1.965 30.146 30.146 0 0 0-.2 3.206v1.5a30.12 30.12 0 0 0 .2 3.206c.094.712.364 1.39.784 1.972.604.536 1.38.837 2.187.848 1.583.151 6.731.2 6.731.2s4.161 0 6.928-.2a2.844 2.844 0 0 0 1.985-.84 4.27 4.27 0 0 0 .787-1.965 30.12 30.12 0 0 0 .2-3.206v-1.516a30.672 30.672 0 0 0-.202-3.206Zm-11.692 6.554v-5.62l5.4 2.819-5.4 2.801Z"
					clip-rule="evenodd" />
			</svg>
		</div>
	</div>
	<div class="flex flex-wrap items-center p-4 mx-auto justify-between relative z-50" style="background-color: #101820;">
		<a href="index" class="flex items-center"> <img src="#"
			class="h-8 mr-3 hidden" alt="#"> <span
			class="self-center text-2xl font-semibold whitespace-nowrap text-white">Hugi
				Barbershop</span>
		</a>
		<button id="menu-button" data-collapse-toggle="navbar-default"
			type="button"
			class="inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 rounded-lg md:hidden hover:bg-gray-100 focus:outline-none focus:ring-2 focus:ring-gray-200"
			aria-controls="navbar-default" aria-expanded="false">
			<span class="sr-only">Open main menu</span>
			<svg class="w-5 h-5" aria-hidden="true"
				xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 17 14">
                <path stroke="currentColor" stroke-linecap="round"
					stroke-linejoin="round" stroke-width="2" d="M1 1h15M1 7h15M1 13h15" />
            </svg>
		</button>
		<div class="hidden w-full md:block md:w-auto" id="navbar-default">
			<ul
				class="font-medium flex flex-col p-4 md:p-0 mt-4 rounded-lg md:flex-row md:space-x-8 md:mt-0 md:border-0 bg-gray-800 md:bg-transparent md:items-center">
				<li><a href="index"
					class="block py-2 pl-3 pr-4 text-white rounded lg:hover:bg-transparent lg:border-0 lg:hover:text-white lg:p-0 transition duration-300 ease-in-out">
						Home </a></li>
				<!-- Appointment Dropdown Start -->
				<li class="relative group">
					<!-- Mobile Dropdown Button -->
					<button type="button"
						class="dropdown-toggle flex items-center w-full py-2 pl-3 pr-4 text-white rounded transition duration-300 ease-in-out
				           lg:hover:bg-transparent lg:border-0 lg:hover:text-white lg:p-0 md:hidden"
						aria-haspopup="true" aria-expanded="false">
						Appointment
						<svg class="ml-2 w-4 h-4" fill="currentColor" viewBox="0 0 20 20">
				      <path fill-rule="evenodd"
								d="M5.23 7.21a.75.75 0 0 1 1.06-.02L10 10.67l3.71-3.5a.75.75 0 1 1 1.04 1.08l-4.25 4a.75.75 0 0 1-1.04 0l-4.25-4a.75.75 0 0 1-.02-1.06z"
								clip-rule="evenodd" />
				    </svg>
					</button> <!-- Desktop Dropdown Trigger (clickable) --> <span
					id="appointment-desktop-trigger"
					class="hidden md:flex items-center w-full py-2 pl-3 pr-4 text-white rounded transition duration-300 ease-in-out
				           lg:hover:bg-transparent lg:border-0 lg:hover:text-white lg:p-0 cursor-pointer">
						Appointment <svg class="ml-2 w-4 h-4" fill="currentColor"
							viewBox="0 0 20 20">
				      <path fill-rule="evenodd"
								d="M5.23 7.21a.75.75 0 0 1 1.06-.02L10 10.67l3.71-3.5a.75.75 0 1 1 1.04 1.08l-4.25 4a.75.75 0 0 1-1.04 0l-4.25-4a.75.75 0 0 1-.02-1.06z"
								clip-rule="evenodd" />
				    </svg>
				</span> <!-- Dropdown Menu -->
					<ul id="appointment-dropdown-menu"
						class="z-10 hidden absolute left-0 md:min-w-[12rem] mt-2 bg-gray-900 rounded-lg shadow-lg
				           md:shadow-xl md:mt-2 transition-all duration-200
				           md:absolute
				           md:bg-gray-900">
						<li><a href="booking"
							class="block px-4 py-2 text-white hover:text-white hover:text-gray-900 transition">Book
								Appointment</a></li>
						<li><a href="view-appointment"
							class="block px-4 py-2 text-white hover:text-white hover:text-gray-900 transition">Current
								Appointment</a></li>
						<li><a href="appointment-history"
							class="block px-4 py-2 text-white hover:text-white hover:text-gray-900 transition">Appointment
								History</a></li>
					</ul>
				</li>
				<li><a href="#aboutUs"
					class="block py-2 pl-3 pr-4 text-white rounded lg:hover:bg-transparent lg:border-0 lg:hover:text-white lg:p-0 transition duration-300 ease-in-out">
						About Us </a></li>
				<% if (customer != null) { %>
				<li><a href="logout"
					class="block py-2 pl-3 pr-4 !text-white rounded lg:hover:bg-transparent lg:border-0 lg:hover:!text-white lg:p-0 transition duration-300 ease-in-out">
						Logout </a></li>
				<li>
					<!-- Avatar icon shown on md and up -->
					<div
						class="relative w-10 h-10 overflow-hidden bg-gray-100 rounded-full hidden md:block">
						<a href="profile"> <% if (picture != null && !picture.isEmpty()) { %>
							<img
							src="<%=request.getContextPath()%>/resources/uploads/<%=picture%>"
							class="absolute w-12 h-12 rounded-full" alt="Profile picture" />
							<% } else { %> <svg
								class="absolute w-12 h-12 text-gray-400 -left-1"
								fill="currentColor" viewBox="0 0 20 20"
								xmlns="http://www.w3.org/2000/svg">
                        <path fill-rule="evenodd"
									d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z"
									clip-rule="evenodd"></path>
                    </svg> <% } %>
						</a>
					</div> <!-- Text shown below md --> <a href="profile"
					class="block md:hidden py-2 pl-3 pr-4 text-white rounded lg:hover:bg-transparent lg:border-0 lg:hover:text-white lg:p-0 transition duration-300 ease-in-out">
						Profile </a>
				</li>
				<% } else { %>
				<li><a href="auth"
					  class="block py-2 pl-3 pr-4 !text-white rounded 
					  lg:hover:bg-transparent lg:border-0 
					  lg:hover:!text-white lg:p-0 transition duration-300 ease-in-out">
					  Login
					</a>
					</li>
				<li>
					<!-- Avatar icon shown on md and up -->
					<div
						class="relative w-10 h-10 overflow-hidden bg-gray-100 rounded-full hidden md:block">
						<a href="profile"> <svg
								class="absolute w-12 h-12 text-gray-400 -left-1"
								fill="currentColor" viewBox="0 0 20 20"
								xmlns="http://www.w3.org/2000/svg">
                    <path fill-rule="evenodd"
									d="M10 9a3 3 0 100-6 3 3 0 000 6zm-7 9a7 7 0 1114 0H3z"
									clip-rule="evenodd"></path>
                </svg>
						</a>
					</div> <!-- Text shown below md --> <a href="profile"
					class="block md:hidden py-2 pl-3 pr-4 text-white rounded lg:hover:bg-transparent lg:border-0 lg:hover:text-white lg:p-0 transition duration-300 ease-in-out">
						Profile </a>
				</li>
				<% } %>
			</ul>
		</div>
	</div>
</nav>
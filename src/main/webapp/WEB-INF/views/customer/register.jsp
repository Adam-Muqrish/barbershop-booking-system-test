<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
boolean justLoggedIn = request.getAttribute("justLoggedIn") != null;
if (session.getAttribute("customer") != null) {
    if (justLoggedIn) {
        // Allow JSP to render and show the modal below
    } else {
        response.sendRedirect("index");
        return;
    }
}
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html>
<head>
    <%@ include file="/WEB-INF/views/includes/header.jsp" %>
    <style>
        .form-container { position: relative; overflow: hidden; }
        .panel {
            width: 50%; height: 100%; position: relative;
            transition: opacity 0.5s, z-index 0.5s;
        }
        .panel.inactive {
            opacity: 0; z-index: 0; pointer-events: none;
        }
        .panel.active {
            opacity: 1; z-index: 2; pointer-events: auto;
        }
        .sliding-panel {
            position: absolute; top: 0; left: 50%;
            width: 50%; height: 100%; transition: left 0.5s cubic-bezier(0.23, 1, 0.32, 1), border-radius 0.5s;
            z-index: 5; display: flex; flex-direction: column; align-items: center; justify-content: center;
            background-color: #9ca3af; padding: 2rem;
            border-top-right-radius: 1rem; border-bottom-right-radius: 1rem;
        }
        .sliding-panel.left {
            left: 0;
            border-top-right-radius: 0; border-bottom-right-radius: 0;
            border-top-left-radius: 1rem; border-bottom-left-radius: 1rem;
        }
        .modal-overlay {
            position: fixed; inset: 0; background: rgba(0, 0, 0, 0.35);
            display: flex; align-items: center; justify-content: center;
            z-index: 50; opacity: 0; pointer-events: none; transition: opacity 0.3s;
        }
        .modal-overlay.show { opacity: 1; pointer-events: auto; }
        .modal-content {
            background: #fff; border-radius: 1rem; box-shadow: 0 8px 32px rgba(0, 0, 0, 0.15);
            padding: 3rem 2.5rem 2.5rem 2.5rem; text-align: center; position: relative;
            min-width: 320px; max-width: 90vw; animation: popin 0.3s cubic-bezier(0.23, 1, 0.32, 1);
        }
        @keyframes popin { from { transform: scale(0.95); opacity: 0; } to { transform: scale(1); opacity: 1; } }
        .modal-checkmark, .modal-xmark { display: flex; justify-content: center; align-items: center; margin-bottom: 1.2rem; }
        .modal-checkmark svg, .modal-xmark svg { width: 64px; height: 64px; }
        .modal-checkmark .circle { stroke: #22c55e; stroke-width: 4; fill: none; animation: checkmark-circle 0.4s ease; }
        @keyframes checkmark-circle { from { stroke-dasharray: 0 150; } to { stroke-dasharray: 150 0; } }
        .modal-checkmark .check {
            stroke: #22c55e; stroke-width: 4; fill: none;
            stroke-linecap: round; stroke-linejoin: round;
            stroke-dasharray: 48; stroke-dashoffset: 48;
            animation: checkmark-draw 0.4s 0.2s forwards;
        }
        @keyframes checkmark-draw { to { stroke-dashoffset: 0; } }
        .modal-xmark .circle { stroke: #ef4444; stroke-width: 4; fill: none; animation: xmark-circle 0.4s ease; }
        @keyframes xmark-circle { from { stroke-dasharray: 0 150; } to { stroke-dasharray: 150 0; } }
        .modal-xmark .x {
            stroke: #ef4444; stroke-width: 4; fill: none;
            stroke-linecap: round; stroke-dasharray: 40; stroke-dashoffset: 40;
            animation: xmark-draw 0.4s 0.2s forwards;
        }
        @keyframes xmark-draw { to { stroke-dashoffset: 0; } }
        input { transition: all 0.3s ease; }
        input:focus {
            outline: none; box-shadow: 0 0 0 2px rgba(99, 102, 241, 0.5);
        }
    </style>
</head>
<body class="flex flex-col h-screen justify-between bg-yellow-100">
    <%-- <%@ include file="/WEB-INF/views/includes/nav.jsp"%> --%>
    <!-- Modal Notification -->
    <div id="modal-overlay" class="modal-overlay">
        <div class="modal-content" id="modal-content"></div>
    </div>
    <main class="flex flex-col items-center mx-3 my-4 flex-grow justify-center">
        <div class="form-container bg-white rounded-2xl shadow-xl w-full max-w-3xl mx-4 md:mx-auto overflow-hidden" style="height: 600px;">
            <div class="flex w-full h-full relative">
                <!-- Register Form -->
                <div id="register-form-container" class="panel active bg-gray-100 p-8 rounded-l-2xl flex flex-col justify-center transition-opacity duration-500">
                    <h2 class="text-2xl font-bold mb-6">Register</h2>
                    <form id="register-form" class="space-y-4" action="auth" method="post" autocomplete="off">
                        <input type="hidden" name="action" value="register">
                        <div>
                            <label class="block text-gray-700 mb-1">Name</label>
                            <input type="text" name="name" class="w-full p-2 border border-gray-300 rounded" required>
                        </div>
                        <div>
                            <label class="block text-gray-700 mb-1">Email</label>
                            <input type="email" name="email" class="w-full p-2 border border-gray-300 rounded" required>
                        </div>
                        <div>
                            <label class="block text-gray-700 mb-1">Phone Number</label>
                            <input type="tel" name="phone" class="w-full p-2 border border-gray-300 rounded" required>
                        </div>
                        <div>
                            <label class="block text-gray-700 mb-1">Password</label>
                            <input type="password" name="password" class="w-full p-2 border border-gray-300 rounded" required>
                        </div>
                        <div>
                            <label class="block text-gray-700 mb-1">Confirm Password</label>
                            <input type="password" name="confirmPassword" class="w-full p-2 border border-gray-300 rounded" required>
                        </div>
                        <button type="submit" class="bg-black text-white py-2 px-6 rounded-full hover:bg-gray-800 transition-colors">
                            Register
                        </button>
                    </form>
                </div>
                <!-- Login Form -->
                <div id="login-form-container" class="panel inactive bg-gray-100 p-8 rounded-r-2xl flex flex-col justify-center absolute top-0 right-0 h-full transition-opacity duration-500">
                    <h2 class="text-2xl font-bold mb-6">Login</h2>
                    <form id="login-form" class="space-y-4" action="auth" method="post" autocomplete="off">
                        <input type="hidden" name="action" value="login">
                        <div>
                            <label class="block text-gray-700 mb-1">Email</label>
                            <input type="email" name="email" class="w-full p-2 border border-gray-300 rounded" required>
                        </div>
                        <div>
                            <label class="block text-gray-700 mb-1">Password</label>
                            <input type="password" name="password" class="w-full p-2 border border-gray-300 rounded" required>
                        </div>
                        <div class="flex justify-between items-center">
                            <label class="flex items-center">
                                <input type="checkbox" name="remember" class="mr-2">
                                <span class="text-sm">Remember me</span>
                            </label>
                            <a href="#" class="text-sm text-blue-600 hover:underline">Forgot password?</a>
                        </div>
                        <button type="submit" class="bg-[#101820] text-white py-2 px-6 rounded-full hover:bg-gray-800 transition-colors">
                            Login
                        </button>
                    </form>
                </div>
                <!-- Sliding Panel -->
                <div id="sliding-panel" class="sliding-panel right transition-all duration-500"  style="background-color: #101820;">
                    <div class="flex-1 flex flex-col items-center justify-center">
                        <div class="mb-12">
                            <h1 class="text-2xl font-bold mb-1 text-center text-white">HUGI BARBERSHOP</h1>
                            <div class="border-t-2 border-white mb-4"></div>
                            <p class="text-lg text-center text-white">Customer Account</p>
                        </div>
                        <button id="toggle-login" class="bg-white text-black py-2 px-10 rounded-full hover:bg-gray-100 transition-colors">
                            Login
                        </button>
                        <button id="toggle-register" 
							class="text-white py-2 px-6 rounded-full hover:bg-gray-800 transition-colors mt-4 hidden" style="background-color: !#101820;">
							Register
						</button>

                    </div>
                </div>
            </div>
        </div>
    </main>
    <%-- <%@ include file="/WEB-INF/views/includes/footer.jsp" %> --%>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const slidingPanel = document.getElementById('sliding-panel');
            const registerFormContainer = document.getElementById('register-form-container');
            const loginFormContainer = document.getElementById('login-form-container');
            const toggleLoginBtn = document.getElementById('toggle-login');
            const toggleRegisterBtn = document.getElementById('toggle-register');
            const modalOverlay = document.getElementById('modal-overlay');
            const modalContent = document.getElementById('modal-content');

            function showModal(success, message, redirectUrl) {
                modalContent.innerHTML = success
                    ? `<div class="modal-checkmark">
                            <svg viewBox="0 0 64 64">
                                <circle class="circle" cx="32" cy="32" r="28"/>
                                <polyline class="check" points="18,34 28,44 46,22"/>
                            </svg>
                        </div>
                        <h3 class="text-green-600 text-xl font-semibold mb-2">Success</h3>
                        <div class="text-gray-700 text-base mb-1">${message}</div>`
                    : `<div class="modal-xmark">
                            <svg viewBox="0 0 64 64">
                                <circle class="circle" cx="32" cy="32" r="28"/>
                                <line class="x" x1="22" y1="22" x2="42" y2="42"/>
                                <line class="x" x1="42" y1="22" x2="22" y2="42"/>
                            </svg>
                        </div>
                        <h3 class="text-red-600 text-xl font-semibold mb-2">Failed</h3>
                        <div class="text-gray-700 text-base mb-1">${message}</div>`;
                modalOverlay.classList.add('show');
                setTimeout(() => {
                    modalOverlay.classList.remove('show');
                    if (success && redirectUrl) {
                        window.location.href = redirectUrl;
                    }
                }, 2000);
            }

            // Show modal if there is a success or error message
            <% if (justLoggedIn) { %>
			    showModal(true, "Login successful! Redirecting...", "index");
			<% } else if (request.getAttribute("successMessage") != null) { %>
			    showModal(true, "<%=request.getAttribute("successMessage").toString().replace("\"", "\\\"")%>");
			<% } else if (request.getAttribute("error") != null) { %>
			    showModal(false, "<%=request.getAttribute("error").toString().replace("\"", "\\\"")%>");
			<% } %>

            // Sliding panel logic
            function showLogin() {
                slidingPanel.classList.add('left');
                registerFormContainer.classList.remove('active');
                registerFormContainer.classList.add('inactive');
                loginFormContainer.classList.remove('inactive');
                loginFormContainer.classList.add('active');
                toggleLoginBtn.style.display = 'none';
                toggleRegisterBtn.style.display = '';
            }
            function showRegister() {
                slidingPanel.classList.remove('left');
                loginFormContainer.classList.remove('active');
                loginFormContainer.classList.add('inactive');
                registerFormContainer.classList.remove('inactive');
                registerFormContainer.classList.add('active');
                toggleLoginBtn.style.display = '';
                toggleRegisterBtn.style.display = 'none';
            }
            // Init state
            slidingPanel.classList.remove('left');
            registerFormContainer.classList.add('active');
            loginFormContainer.classList.add('inactive');
            toggleLoginBtn.style.display = '';
            toggleRegisterBtn.style.display = 'none';

            toggleLoginBtn.addEventListener('click', showLogin);
            toggleRegisterBtn.addEventListener('click', showRegister);

            // Allow clicking overlay to close early
            modalOverlay.addEventListener('click', function(e) {
                if (e.target === modalOverlay) {
                    modalOverlay.classList.remove('show');
                }
            });
            
         	// Place this at the bottom of your JSP, inside <script>
            window.addEventListener('pageshow', function(event) {
                if (event.persisted) {
                    // If page is loaded from bfcache, reload from server.
                    window.location.reload();
                }
            });
        });
    </script>
</body>
</html>
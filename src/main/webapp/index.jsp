<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<body class="flex flex-col min-h-screen bg-neutral-900">
	<%@ include file="/WEB-INF/views/includes/nav.jsp"%>

	<main class="flex-1 w-full bg-white">
		<!-- HERO BANNER (small height) -->
		<section
			class="relative w-full h-[160px] md:h-[220px] lg:h-[280px] bg-cover bg-center flex items-center overflow-hidden -mt-[1px]"
			style="background-image: url('https://images.unsplash.com/photo-1515378791036-0648a3ef77b2?auto=format&fit=crop&w=1200&q=80');">
			<div class="absolute inset-0 bg-black/50"></div>
			<div class="relative z-10 w-full flex justify-center items-center">
				<h1
					class="text-white text-2xl md:text-4xl font-extrabold tracking-widest text-center drop-shadow-lg">
					HUGI BARBERSHOP</h1>
			</div>
		</section>

		<!-- ABOUT US + IMAGE COLLAGE -->
		<section id="aboutUs"
			class="relative max-w-6xl mx-auto px-4 md:px-8 lg:px-12 py-8 bg-white overflow-visible">
			<div
				class="grid grid-cols-1 md:grid-cols-2 gap-8 items-start relative">
				<!-- TEXT CONTENT -->
				<div class="flex flex-col justify-center z-10">
					<h2 class="text-lg text-red-600 uppercase font-bold mb-2">About
						Us</h2>
					<h3 class="text-2xl md:text-3xl font-extrabold mb-4">Welcome
						to Hugi Barbershop</h3>
					<p class="text-gray-700 mb-3">At Hugi Barbershop, we combine
						the classic art of barbering with contemporary techniques. Our
						team of skilled barbers specializes in modern fades, sharp beard
						trims, and clean, stylish precision haircuts.</p>
					<p class="text-gray-700 mb-3">Whether you’re here for a quick
						touch-up or a full grooming session, we promise top-tier care and
						unmatched attention and expertise.</p>
					<p class="text-gray-800 font-medium mb-6">Ready for your next
						cut? Book your appointment today — we’re looking forward to
						serving you!</p>

					<!-- IMAGE COLLAGE: Mobile-specific, two overlapping images at bottom of text block, now larger -->
					<div
						class="relative flex flex-col items-center mt-4 mb-2 md:hidden"
						style="min-height: 270px;">
						<!-- Portrait photo (top, vertical, rounded, shadow) -->
						<img
							src="https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=400&q=80"
							alt="Person in denim jacket and hoodie"
							class="w-40 h-56 rounded-xl shadow-lg border-2 border-white z-20 object-cover"
							style="margin-bottom: -40px;" />
						<!-- Landscape photo (bottom, overlapped, rotated, wider) -->
						<img
							src="https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80"
							alt="Scenic landscape"
							class="w-60 h-36 rounded-lg shadow-md border-2 border-white z-10 object-cover -rotate-6" />
					</div>
				</div>
				<!-- IMAGE COLLAGE: Desktop/tablet view unchanged -->
				<div
					class="relative hidden md:flex h-[320px] md:h-[340px] lg:h-[380px] w-full md:w-auto">
					<!-- Top right: Portrait image, touches the hero banner -->
					<img
						src="https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=400&q=80"
						alt="Portrait"
						class="absolute -top-12 right-0 w-32 md:w-40 lg:w-44 xl:w-48 h-auto rounded-lg shadow-xl border-4 border-white z-30 object-cover" />
					<!-- Center right, slightly rotated: Landscape image -->
					<img
						src="https://images.unsplash.com/photo-1464983953574-0892a716854b?auto=format&fit=crop&w=400&q=80"
						alt="Barbershop interior"
						class="absolute top-24 right-4 md:top-24 md:right-16 w-44 md:w-56 lg:w-64 xl:w-72 h-auto rounded-lg shadow-lg border-4 border-white z-20 object-cover rotate-3" />
				</div>
			</div>
		</section>

		<!-- APPOINTMENT CTA WITH IMAGE LEFT -->
		<section
			class="relative max-w-6xl mx-auto px-4 md:px-8 lg:px-12 py-8 bg-neutral-100 my-4 rounded-lg shadow mb-16">
			<div class="grid grid-cols-1 md:grid-cols-2 gap-8 items-center">
				<!-- IMAGE LEFT -->
				<div class="relative flex justify-center md:justify-start">
					<div
						class="w-72 h-48 md:w-80 md:h-56 rounded shadow-lg overflow-hidden border-4 border-white">
						<img
							src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=crop&w=400&q=80"
							alt="Haircut Action" class="object-cover w-full h-full">
					</div>
				</div>
				<!-- TEXT RIGHT -->
				<div>
					<h3 class="text-2xl md:text-3xl font-bold mb-4">Let’s Make An
						Appointment!</h3>
					<p class="text-gray-700 mb-4">Book your haircut online today
						for a stress-free experience—skip the wait, choose your preferred
						barber, get instant confirmation, and enjoy hassle-free reminders.
						Your perfect haircut is just a click away!</p>
					<a href="#booking"
						class="inline-block bg-red-600 hover:bg-red-700 text-white font-semibold py-3 px-6 rounded-md shadow transition duration-300">
						BOOK NOW ! </a>
				</div>
			</div>
		</section>
	</main>

	<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
</body>
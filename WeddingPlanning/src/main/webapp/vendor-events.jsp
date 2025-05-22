<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.WeddingPlanner.services.BookingService" %>
<%@ page import="com.WeddingPlanner.model.Booking" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Events | DeegaLK</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500;600&family=Great+Vibes&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #9d7e67;
            --secondary: #c9b18c;
            --accent: #e8d5b7;
            --dark: #2c3e50;
            --light: #f8f5f0;
            --white: #ffffff;
            --gold: #d4af37;
            --gradient: linear-gradient(135deg, #9d7e67 0%, #c9b18c 100%);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: var(--light);
            color: var(--dark);
            min-height: 100vh;
            display: flex;
        }

        .dashboard-container {
            display: flex;
            width: 100%;
        }

        .sidebar {
            width: 280px;
            background: var(--white);
            padding: 2rem;
            border-right: 1px solid rgba(0,0,0,0.05);
            height: 100vh;
            position: fixed;
            transition: all 0.3s ease;
        }

        .brand {
            font-family: 'Great Vibes', cursive;
            font-size: 2.5rem;
            color: var(--primary);
            text-align: center;
            margin-bottom: 2rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }

        .menu-item {
            padding: 1rem;
            margin: 0.5rem 0;
            border-radius: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 1rem;
            color: var(--dark);
            text-decoration: none;
        }

        .menu-item:hover, .menu-item.active {
            background: var(--gradient);
            color: var(--white);
            transform: translateX(5px);
        }

        .menu-item i {
            font-size: 1.2rem;
        }

        .main-content {
            margin-left: 280px;
            padding: 2rem;
            width: calc(100% - 280px);
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding: 1.5rem;
            background: var(--white);
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
        }

        .user-welcome {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .user-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-size: 1.5rem;
            font-family: 'Playfair Display', serif;
        }

        .welcome-text h2 {
            font-family: 'Playfair Display', serif;
            font-weight: 600;
        }

        .date-time {
            font-size: 0.9rem;
            color: var(--primary);
        }

        .events-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 1.5rem;
            padding: 1rem 0;
        }

        .event-card {
            background: var(--white);
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            animation: fadeUp 0.6s ease-out forwards;
        }

        .event-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.1);
        }

        .event-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--accent);
        }

        .event-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.25rem;
            color: var(--primary);
        }

        .event-price {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--gold);
            padding: 0.5rem 1rem;
            background: var(--light);
            border-radius: 20px;
        }

        .event-info {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 1rem;
            margin: 1rem 0;
        }

        .info-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            font-size: 0.9rem;
        }

        .info-item i {
            color: var(--primary);
            font-size: 1rem;
        }

        .services-title {
            font-family: 'Playfair Display', serif;
            color: var(--dark);
            margin: 1rem 0 0.5rem 0;
            font-size: 1rem;
        }

        .services-list {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-top: 0.5rem;
        }

        .service-tag {
            background: var(--light);
            color: var(--primary);
            padding: 0.4rem 0.8rem;
            border-radius: 15px;
            font-size: 0.85rem;
            transition: all 0.3s ease;
        }

        .service-tag:hover {
            background: var(--gradient);
            color: var(--white);
            transform: translateY(-2px);
        }

        .no-events {
            text-align: center;
            padding: 3rem;
            background: var(--white);
            border-radius: 15px;
            margin: 2rem auto;
            max-width: 500px;
        }

        .no-events i {
            font-size: 3rem;
            color: var(--secondary);
            margin-bottom: 1rem;
        }

        .no-events h3 {
            color: var(--primary);
            font-family: 'Playfair Display', serif;
            margin-bottom: 1rem;
        }

        @keyframes fadeUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                z-index: 1000;
            }
            .main-content {
                margin-left: 0;
                width: 100%;
            }
        }
    </style>
</head>
<body>
<div class="dashboard-container">
    <div class="sidebar">
        <div class="brand">DeegaLK</div>
        <a href="vendor-dashboard.jsp" class="menu-item">
            <i class="fas fa-home"></i>
            <span>Dashboard</span>
        </a>
        <a href="vendor-profile.jsp" class="menu-item">
            <i class="fas fa-user"></i>
            <span>My Profile</span>
        </a>
        <a href="vendor-events.jsp" class="menu-item active">
            <i class="fas fa-calendar-alt"></i>
            <span>Events</span>
        </a>
        <a href="index.jsp" class="menu-item">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>

    <div class="main-content">
        <div class="header">
            <div class="user-welcome">
                <div class="user-avatar">
                    ${sessionScope.firstName.charAt(0)}
                </div>
                <div class="welcome-text">
                    <h2>My Events</h2>
                    <span class="date-time">2025-05-20 05:24:27</span>
                </div>
            </div>
            <div class="notification">
                <i class="fas fa-bell fa-lg"></i>
                <span class="notification-badge">3</span>
            </div>
        </div>

        <%
            BookingService bookingService = new BookingService();
            String vendorUsername = (String) session.getAttribute("username");
            List<Booking> vendorBookings = bookingService.getBookingsByVendor(vendorUsername, application);

            if(vendorBookings != null && !vendorBookings.isEmpty()) {
        %>
        <div class="events-grid">
            <% for(Booking booking : vendorBookings) { %>
            <div class="event-card">
                <div class="event-header">
                    <div class="event-title">
                        <%= booking.getBusinessName() %>
                    </div>
                    <div class="event-price">
                        Rs. <%= booking.getPrice() %>
                    </div>
                </div>
                <div class="event-info">
                    <div class="info-item">
                        <i class="fas fa-store"></i>
                        <span><%= booking.getBusinessType() %></span>
                    </div>
                    <div class="info-item">
                        <i class="fas fa-user"></i>
                        <span><%= booking.getBuyerUsername() %></span>
                    </div>
                </div>
                <div class="services-section">
                    <h4 class="services-title">Services Included</h4>
                    <div class="services-list">
                        <% for(String service : booking.getServices()) { %>
                        <span class="service-tag"><%= service %></span>
                        <% } %>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
        <% } else { %>
        <div class="no-events">
            <i class="fas fa-calendar-times"></i>
            <h3>No Events Found</h3>
            <p>You currently don't have any bookings. New bookings will appear here.</p>
        </div>
        <% } %>
    </div>
</div>
</body>
</html>
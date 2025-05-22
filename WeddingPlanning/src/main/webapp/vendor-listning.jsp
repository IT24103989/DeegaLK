<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.WeddingPlanner.services.UserAuthService" %>
<%@ page import="com.WeddingPlanner.services.BookingService" %>
<%@ page import="com.WeddingPlanner.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.ZonedDateTime" %>
<%@ page import="java.time.ZoneId" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wedding Vendors | DeegaLK</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&family=Montserrat:wght@300;400;500;600&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #ff1493;
            --secondary: #ff69b4;
            --accent: #c71585;
            --dark: #333333;
            --light: #fff0f5;
            --text: #4a4a4a;
            --white: #ffffff;
            --gray: #898989;
            --success: #7ec699;
            --warning: #ffd700;
            --danger: #ff8b8b;
            --shadow: rgba(255, 182, 193, 0.15);
            --gradient: linear-gradient(135deg, #ffb6c1, #ffd1dc);
            --border: #ffe4e8;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Montserrat', sans-serif;
        }

        body {
            background: var(--light);
            color: var(--dark);
            line-height: 1.6;
            background-image:
                    radial-gradient(circle at 10% 20%, rgba(255, 182, 193, 0.05) 0%, transparent 20%),
                    radial-gradient(circle at 90% 80%, rgba(255, 209, 220, 0.07) 0%, transparent 20%);
            padding-left: 280px;
        }

        /* New DateTime and User Info Card Styles */
        .info-container {
            background: var(--white);
            border-radius: 20px;
            box-shadow: 0 5px 20px var(--shadow);
            margin: 2rem 0;
            padding: 2rem;
            position: relative;
        }

        .info-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: var(--gradient);
            border-radius: 20px 20px 0 0;
        }

        .info-label {
            color: var(--accent);
            font-weight: 600;
            margin-bottom: 0.5rem;
            font-size: 1.1rem;
        }

        .info-value {
            color: var(--text);
            font-size: 1rem;
            padding: 0.5rem 1rem;
            background: var(--light);
            border-radius: 10px;
            display: inline-block;
            margin-bottom: 1rem;
            box-shadow: 0 2px 10px var(--shadow);
        }

        /* Enhanced Vendor Card Styles */
        .vendor-card {
            background: var(--white);
            border-radius: 20px;
            box-shadow: 0 8px 25px var(--shadow);
            transition: all 0.3s ease;
            margin-bottom: 2rem;
            overflow: hidden;
            border: none;
            position: relative;
        }

        .vendor-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 12px 30px var(--shadow);
        }

        .vendor-header {
            background: var(--gradient);
            padding: 2.5rem 2rem;
            color: var(--white);
            text-align: center;
            position: relative;
            overflow: hidden;
        }

        .vendor-header::after {
            content: '';
            position: absolute;
            bottom: -20px;
            left: 0;
            right: 0;
            height: 40px;
            background: var(--white);
            border-radius: 50% 50% 0 0;
        }

        .vendor-title {
            font-family: 'Great Vibes', cursive;
            font-size: 2.8rem;
            margin-bottom: 1rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }

        .business-type-badge {
            background: rgba(255,255,255,0.2);
            padding: 0.6rem 1.8rem;
            border-radius: 25px;
            backdrop-filter: blur(5px);
            font-size: 0.95rem;
            display: inline-block;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .card-body {
            padding: 2.5rem;
        }

        .contact-info {
            background: var(--light);
            padding: 1.8rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            box-shadow: 0 3px 15px var(--shadow);
        }

        .contact-info div {
            margin-bottom: 0.8rem;
            display: flex;
            align-items: center;
        }

        .contact-info div:last-child {
            margin-bottom: 0;
        }

        .contact-info i {
            color: var(--accent);
            width: 25px;
            font-size: 1.1rem;
        }

        .description {
            color: var(--text);
            font-size: 1rem;
            line-height: 1.7;
            margin-bottom: 2rem;
            padding: 1.5rem;
            background: var(--light);
            border-radius: 15px;
            box-shadow: 0 3px 15px var(--shadow);
        }

        .service-tag {
            background: var(--light);
            color: var(--accent);
            padding: 0.6rem 1.2rem;
            border-radius: 20px;
            margin: 0.3rem;
            display: inline-block;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            box-shadow: 0 2px 10px var(--shadow);
        }

        .service-tag:hover {
            background: var(--gradient);
            color: var(--white);
            transform: translateY(-3px);
        }

        .price-tag {
            background: var(--gradient);
            color: var(--white);
            padding: 1rem 2rem;
            border-radius: 25px;
            font-weight: 600;
            font-size: 1.1rem;
            display: inline-block;
            box-shadow: 0 5px 15px var(--shadow);
        }

        .book-now-btn {
            background: var(--gradient);
            color: var(--white);
            border: none;
            padding: 1.2rem 2.5rem;
            border-radius: 30px;
            font-weight: 500;
            font-size: 1.1rem;
            width: 100%;
            margin-top: 2rem;
            transition: all 0.3s ease;
            box-shadow: 0 5px 20px var(--shadow);
        }

        .book-now-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px var(--shadow);
        }

        .book-now-btn:disabled {
            background: var(--success);
            cursor: not-allowed;
            transform: none;
        }

        .rating {
            font-size: 1.1rem;
        }

        .rating i {
            color: var(--warning);
            margin-right: 2px;
        }
    </style>
</head>
<body>
<%
    ZonedDateTime colomboTime = ZonedDateTime.now(ZoneId.of("Asia/Colombo"));
    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    String currentTime = colomboTime.format(formatter);
    String currentUser = "";

    UserAuthService authService = new UserAuthService(application);
    BookingService bookingService = new BookingService();
    List<User> vendors = authService.getAllVendorsSortedByPrice();
%>


<div class="main-content">
    <div class="container">
        <!-- New DateTime and User Info Section -->
        <div class="info-container">
            <div class="row">
                <div class="col-12">
                    <div class="info-label">Current Date and Time (UTC - YYYY-MM-DD HH:MM:SS formatted):</div>
                    <div class="info-value"><%= currentTime %></div>
                </div>
                <div class="col-12">
                    <div class="info-label">Current User's Login:</div>
                    <div class="info-value"><%= currentUser %></div>
                </div>
            </div>
        </div>

        <h1 class="text-center mb-5" style="font-family: 'Great Vibes', cursive; color: var(--accent); font-size: 3.8rem; text-shadow: 2px 2px 4px var(--shadow);">
            Our Wedding Vendors
        </h1>

        <div class="row">
            <% if(vendors.isEmpty()) { %>
            <div class="col-12 text-center">
                <p class="text-muted">No vendors available at the moment.</p>
            </div>
            <% } else { %>
            <% for(User vendor : vendors) { %>
            <div class="col-lg-6 mb-4">
                <div class="vendor-card">
                    <div class="vendor-header">
                        <h3 class="vendor-title"><%= vendor.getVendorDetails().getBusinessName() %></h3>
                        <span class="business-type-badge">
                                        <%= vendor.getVendorDetails().getBusinessType() %>
                                    </span>
                    </div>
                    <div class="card-body">
                        <div class="contact-info">
                            <div><i class="fas fa-phone me-2"></i><%= vendor.getVendorDetails().getContactNumber() %></div>
                            <div><i class="fas fa-envelope me-2"></i><%= vendor.getEmail() %></div>
                        </div>

                        <div class="description">
                            <%= vendor.getVendorDetails().getDescription() %>
                        </div>

                        <div class="services mb-4">
                            <h6 class="mb-3" style="color: var(--accent);">Services Offered:</h6>
                            <% for(String service : vendor.getVendorDetails().getServices()) { %>
                            <span class="service-tag"><%= service %></span>
                            <% } %>
                        </div>

                        <div class="d-flex justify-content-between align-items-center">
                            <div class="rating">
                                <% double rating = vendor.getVendorDetails().getRating(); %>
                                <% for(int i = 0; i < 5; i++) { %>
                                <% if(i < rating) { %>
                                <i class="fas fa-star"></i>
                                <% } else { %>
                                <i class="far fa-star"></i>
                                <% } %>
                                <% } %>
                                <span class="ms-2">(<%= vendor.getVendorDetails().getReviewCount() %> reviews)</span>
                            </div>
                            <div class="price-tag">
                                Rs. <%= vendor.getVendorDetails().getPrice() %>
                            </div>
                        </div>

                        <%  boolean isBooked = bookingService.isVendorBookedByBuyer(currentUser, vendor.getUsername(), application); %>
                        <button class="book-now-btn" id="bookBtn_<%= vendor.getUsername() %>"
                                onclick="bookVendor('<%= vendor.getUsername() %>', this)"
                                <%= isBooked ? "disabled" : "" %>>
                            <i class="fas <%= isBooked ? "fa-check" : "fa-calendar-check" %> me-2"></i>
                            <%= isBooked ? "Booked" : "Book Now" %>
                        </button>
                    </div>
                </div>
            </div>
            <% } %>
            <% } %>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    setTimeout(function() {
        location.reload();
    }, 300000);

    function bookVendor(vendorUsername, buttonElement) {
        buttonElement.innerHTML = '<i class="fas fa-spinner fa-spin me-2"></i>Processing...';
        buttonElement.disabled = true;

        fetch('BookingServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: 'vendorUsername=' + encodeURIComponent(vendorUsername)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    buttonElement.innerHTML = '<i class="fas fa-check me-2"></i>Booked';
                    buttonElement.style.background = 'var(--success)';
                    buttonElement.disabled = true;
                } else {
                    alert('Booking failed: ' + (data.message || 'Unknown error'));
                    buttonElement.innerHTML = '<i class="fas fa-calendar-check me-2"></i>Book Now';
                    buttonElement.disabled = false;
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while processing your booking');
                buttonElement.innerHTML = '<i class="fas fa-calendar-check me-2"></i>Book Now';
                buttonElement.disabled = false;
            });
    }
</script>
</body>
</html>
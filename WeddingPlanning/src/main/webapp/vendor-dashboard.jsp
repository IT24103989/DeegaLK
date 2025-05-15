//IT24103989
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vendor Portal | Wedding Planner</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;500;600;700&family=Inter:wght@300;400;500;600&family=Great+Vibes&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>
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
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
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

        .menu-item:hover {
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
            padding: 1rem;
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

        .stat-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: var(--white);
            padding: 1.5rem;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 12px rgba(0,0,0,0.1);
        }

        .stat-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .stat-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.2rem;
            color: var(--dark);
        }

        .stat-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 600;
            color: var(--primary);
            margin: 0.5rem 0;
        }

        .stat-change {
            font-size: 0.9rem;
            color: #38a169;
        }

        .chart-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
            gap: 1.5rem;
        }

        .chart-card {
            background: var(--white);
            padding: 1.5rem;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            height: 400px;
        }

        .notification {
            position: relative;
            cursor: pointer;
        }

        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--gold);
            color: var(--white);
            width: 20px;
            height: 20px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.8rem;
        }

        .date-time {
            font-size: 0.9rem;
            color: var(--primary);
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
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

        .stat-card {
            animation: fadeUp 0.6s ease-out forwards;
        }

        .stat-card:nth-child(1) { animation-delay: 0.1s; }
        .stat-card:nth-child(2) { animation-delay: 0.2s; }
        .stat-card:nth-child(3) { animation-delay: 0.3s; }
        .stat-card:nth-child(4) { animation-delay: 0.4s; }

        .menu-item {
            animation: slideIn 0.5s ease-out forwards;
            opacity: 0;
        }

        .menu-item:nth-child(1) { animation-delay: 0.1s; }
        .menu-item:nth-child(2) { animation-delay: 0.2s; }
        .menu-item:nth-child(3) { animation-delay: 0.3s; }
        .menu-item:nth-child(4) { animation-delay: 0.4s; }
        .menu-item:nth-child(5) { animation-delay: 0.5s; }

        @media (max-width: 768px) {
            .sidebar {
                transform: translateX(-100%);
                z-index: 1000;
            }
            .main-content {
                margin-left: 0;
                width: 100%;
            }
            .sidebar.active {
                transform: translateX(0);
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <div class="sidebar">
            <div class="brand">DeegaLK</div>
            <a href="#" class="menu-item">
                <i class="fas fa-home"></i>
                <span>Dashboard</span>
            </a>
            
            <a href="#" class="menu-item">
               <i class="fas fa-user"></i>
               <span>My Profile</span>
            </a>
            <a href="#" class="menu-item">
                <i class="fas fa-calendar-alt"></i>
                <span>Events</span>
            </a>
            <a href="#" class="menu-item">
                <i class="fas fa-comments"></i>
                <span>Messages</span>
            </a>
            <a href="#" class="menu-item">
                <i class="fas fa-chart-line"></i>
                <span>Analytics</span>
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
                        <h2>Welcome back, ${sessionScope.firstName}</h2>
                        <span class="date-time">2025-04-26 22:04:33</span>
                    </div>
                </div>
                <div class="notification">
                    <i class="fas fa-bell fa-lg"></i>
                    <span class="notification-badge">3</span>
                </div>
            </div>

            <div class="stat-grid">
                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-title">Total Bookings</div>
                        <div class="stat-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                    </div>
                    <div class="stat-value">248</div>
                    <div class="stat-change">
                        <i class="fas fa-arrow-up"></i> 12% from last month
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-title">Revenue</div>
                        <div class="stat-icon">
                            <i class="fas fa-dollar-sign"></i>
                        </div>
                    </div>
                    <div class="stat-value">$45,850</div>
                    <div class="stat-change">
                        <i class="fas fa-arrow-up"></i> 8% from last month
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-title">Customer Rating</div>
                        <div class="stat-icon">
                            <i class="fas fa-star"></i>
                        </div>
                    </div>
                    <div class="stat-value">4.8</div>
                    <div class="stat-change">
                        <i class="fas fa-arrow-up"></i> 0.2 from last month
                    </div>
                </div>

                <div class="stat-card">
                    <div class="stat-header">
                        <div class="stat-title">Active Inquiries</div>
                        <div class="stat-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                    </div>
                    <div class="stat-value">18</div>
                    <div class="stat-change">
                        <i class="fas fa-arrow-up"></i> 5 new today
                    </div>
                </div>
            </div>

            <div class="chart-grid">
                <div class="chart-card">
                    <h3>Booking Trends</h3>
                    <div id="bookingChart"></div>
                </div>
                <div class="chart-card">
                    <h3>Revenue Analysis</h3>
                    <div id="revenueChart"></div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Booking Trends Chart
        var bookingOptions = {
            series: [{
                name: 'Bookings',
                data: [30, 40, 35, 50, 49, 60, 70]
            }],
            chart: {
                height: 350,
                type: 'area',
                toolbar: {
                    show: false
                }
            },
            colors: ['#9d7e67'],
            fill: {
                type: 'gradient',
                gradient: {
                    shadeIntensity: 1,
                    opacityFrom: 0.7,
                    opacityTo: 0.3,
                    stops: [0, 90, 100]
                }
            },
            stroke: {
                curve: 'smooth'
            },
            xaxis: {
                categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul']
            }
        };

        var bookingChart = new ApexCharts(document.querySelector("#bookingChart"), bookingOptions);
        bookingChart.render();

        // Revenue Chart
        var revenueOptions = {
            series: [{
                name: 'Revenue',
                data: [31000, 40000, 28000, 51000, 42000, 82000, 56000]
            }],
            chart: {
                height: 350,
                type: 'bar',
                toolbar: {
                    show: false
                }
            },
            colors: ['#c9b18c'],
            plotOptions: {
                bar: {
                    borderRadius: 10,
                    dataLabels: {
                        position: 'top',
                    },
                }
            },
            dataLabels: {
                enabled: true,
                formatter: function (val) {
                    return "$" + val;
                },
                offsetY: -20,
                style: {
                    fontSize: '12px',
                    colors: ["#304758"]
                }
            },
            xaxis: {
                categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'],
                position: 'bottom'
            }
        };

        var revenueChart = new ApexCharts(document.querySelector("#revenueChart"), revenueOptions);
        revenueChart.render();
    </script>
</body>
</html>
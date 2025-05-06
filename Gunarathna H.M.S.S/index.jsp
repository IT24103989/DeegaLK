<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DeegaLK | Wedding Planner</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600&family=Montserrat:wght@300;400;500&family=Dancing+Script:wght@700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #ff6b6b;
            --secondary: #ffd93d;
            --text: #2c3e50;
            --light: #f8f9fa;
            --dark: #343a40;
            --white: #ffffff;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Montserrat', sans-serif;
            line-height: 1.6;
            color: var(--text);
        }

        .top-bar {
            background: var(--dark);
            color: var(--white);
            padding: 8px 0;
            font-size: 0.9em;
        }

        .top-bar-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .nav-bar {
            background: var(--white);
            padding: 15px 0;
            box-shadow: 0 2px 15px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .nav-content {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 20px;
        }

        .logo {
            font-family: 'Dancing Script', cursive;
            font-size: 2.5em;
            color: var(--primary);
            text-decoration: none;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }

        .auth-buttons {
            display: flex;
            gap: 15px;
        }

        .btn {
            display: inline-block;
            padding: 12px 25px;
            border-radius: 30px;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            font-size: 0.9em;
        }

        .btn-login {
            color: var(--primary);
            border: 2px solid var(--primary);
            background: transparent;
        }

        .btn-login:hover {
            background: var(--primary);
            color: var(--white);
            transform: translateY(-2px);
        }

        .btn-signup {
            background: var(--primary);
            color: var(--white);
            border: 2px solid var(--primary);
        }

        .btn-signup:hover {
            background: #ff5252;
            border-color: #ff5252;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
        }

        .hero {
            height: 90vh;
            background: linear-gradient(rgba(0,0,0,0.4), rgba(0,0,0,0.4)),
                        url('https://images.unsplash.com/photo-1519225421980-715cb0215aed?ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            display: flex;
            align-items: center;
            text-align: center;
            color: var(--white);
        }

        .hero-content {
            max-width: 800px;
            margin: 0 auto;
            padding: 0 20px;
            animation: fadeIn 1.5s ease-out;
        }

        .hero-title {
            font-family: 'Playfair Display', serif;
            font-size: 4.5em;
            margin-bottom: 20px;
            line-height: 1.2;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .hero-subtitle {
            font-size: 1.2em;
            margin-bottom: 40px;
            line-height: 1.6;
        }

        .services {
            padding: 100px 20px;
            background: var(--light);
        }

        .services-grid {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
        }

        .service-card {
            background: var(--white);
            border-radius: 15px;
            padding: 40px 30px;
            text-align: center;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            position: relative;
            overflow: hidden;
        }

        .service-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        }

        .service-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 5px;
            background: linear-gradient(to right, var(--primary), var(--secondary));
            transform: scaleX(0);
            transition: transform 0.3s ease;
        }

        .service-card:hover::before {
            transform: scaleX(1);
        }

        .service-icon {
            font-size: 2.5em;
            color: var(--primary);
            margin-bottom: 20px;
        }

        .service-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.5em;
            margin-bottom: 15px;
            color: var(--dark);
        }

        .service-description {
            color: #666;
            font-size: 0.95em;
            line-height: 1.6;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        footer {
            background: var(--dark);
            color: var(--white);
            padding: 40px 20px;
            text-align: center;
        }

        .current-user {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .user-avatar {
            width: 30px;
            height: 30px;
            background: var(--primary);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-weight: 500;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
  
    <nav class="nav-bar">
        <div class="nav-content">
            <a href="#" class="logo">DeegaLK</a>
            <div class="auth-buttons">
                <a href="login.jsp" class="btn btn-login">Login</a>
                <a href="signup.jsp" class="btn btn-signup">Sign Up</a>
            </div>
        </div>
    </nav>

    <section class="hero">
        <div class="hero-content">
            <h1 class="hero-title">Your Perfect Day Awaits</h1>
            <p class="hero-subtitle">Let us help you create the wedding of your dreams with our expert planning services and dedicated team</p>
            <a href="#services" class="btn btn-signup">Discover Our Services</a>
        </div>
    </section>

    <section class="services" id="services">
        <div class="services-grid">
            <div class="service-card">
                <div class="service-icon">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <h3 class="service-title">Wedding Planning</h3>
                <p class="service-description">Comprehensive planning services from venue selection to day-of coordination.</p>
            </div>

            <div class="service-card">
                <div class="service-icon">
                    <i class="fas fa-glass-cheers"></i>
                </div>
                <h3 class="service-title">Vendor Management</h3>
                <p class="service-description">Access our network of trusted vendors and let us handle all the coordination.</p>
            </div>

            <div class="service-card">
                <div class="service-icon">
                    <i class="fas fa-palette"></i>
                </div>
                <h3 class="service-title">Design & Styling</h3>
                <p class="service-description">Create your perfect wedding aesthetic with our expert design services.</p>
            </div>

          
        </div>
    </section>

    <footer>
        <p>&copy; 2025 DeegaLK. All rights reserved.</p>
    </footer>

    <script>
        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });

        // Animate service cards on scroll
        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.style.opacity = '1';
                    entry.target.style.transform = 'translateY(0)';
                }
            });
        }, { threshold: 0.1 });

        document.querySelectorAll('.service-card').forEach(card => {
            card.style.opacity = '0';
            card.style.transform = 'translateY(30px)';
            observer.observe(card);
        });
    </script>
</body>
</html>
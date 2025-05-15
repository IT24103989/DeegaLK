//IT24103989
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up | DeegaLK</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600;700&family=Raleway:wght@300;400;500;600&family=Great+Vibes&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #bc8f8f;
            --secondary: #deb887;
            --accent: #d2691e;
            --text: #2c3e50;
            --light: #faf0e6;
            --white: #ffffff;
            --dark: #343a40;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Raleway', sans-serif;
            line-height: 1.6;
            color: var(--text);
            background: linear-gradient(135deg, #f6f8fb 0%, #f1f3f6 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
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
            margin-bottom: 40px;
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
            font-family: 'Great Vibes', cursive;
            font-size: 2.5em;
            color: var(--primary);
            text-decoration: none;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }

        .signup-container {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px 20px;
            position: relative;
        }

        .back-button {
            position: absolute;
            top: -20px;
            left: 50%;
            transform: translateX(-50%);
            background: var(--dark);
            color: var(--white);
            padding: 12px 30px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            border: none;
            cursor: pointer;
        }

        .back-button:hover {
            background: var(--text);
            transform: translateX(-50%) translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        }
        

        .signup-form {
            background: var(--white);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 500px;
            margin-top: 20px;
        }

        .form-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: 2.5em;
            margin-bottom: 30px;
            text-align: center;
            color: var(--text);
        }
        .user-type-toggle {
            display: flex;
            justify-content: center;
            gap: 20px;
            margin-bottom: 30px;
        }

        .type-btn {
            padding: 12px 30px;
            border: 2px solid var(--primary);
            background: transparent;
            color: var(--primary);
            border-radius: 25px;
            cursor: pointer;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .type-btn.active {
            background: var(--primary);
            color: var(--white);
        }

        #vendorFields {
            display: none;
            border-top: 2px solid #e1e1e1;
            margin-top: 20px;
            padding-top: 20px;
        }

        .services-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
            margin-top: 10px;
        }

        .service-option {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .service-option input[type="checkbox"] {
            width: auto;
        }

        .current-info {
            display: flex;
            align-items: center;
            gap: 20px;
            color: var(--white);
            font-size: 0.9em;
        }

        .current-info i {
            margin-right: 5px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: var(--text);
        }

        .form-input {
            width: 100%;
            padding: 12px;
            border: 2px solid #e1e1e1;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s ease;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(188, 143, 143, 0.1);
        }

        .submit-btn {
            width: 100%;
            padding: 12px;
            background: var(--primary);
            color: var(--white);
            border: none;
            border-radius: 8px;
            font-size: 1em;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .submit-btn:hover {
            background: var(--accent);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(188, 143, 143, 0.3);
        }

        .form-footer {
            text-align: center;
            margin-top: 20px;
        }

        .form-footer a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
        }

        .form-footer a:hover {
            color: var(--accent);
        }

        footer {
            background: var(--dark);
            color: var(--white);
            padding: 20px;
            text-align: center;
            margin-top: auto;
        }

        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }
        }
    </style>
</head>
<body>
    

    <nav class="nav-bar">
        <div class="nav-content">
            <a href="index.jsp" class="logo">DeegaLK</a>
        </div>
    </nav>

    <div class="signup-container">
        <form action="index.jsp" method="GET">
            <button type="submit" class="back-button">
                <i class="fas fa-arrow-left"></i> Back to Home
            </button>
        </form>

        <form class="signup-form" action="SignupServlet" method="POST">
            <h2 class="form-title">Create Account</h2>

            <div class="user-type-toggle">
                <button type="button" class="type-btn active" onclick="toggleUserType('buyer')">Register as Buyer</button>
                <button type="button" class="type-btn" onclick="toggleUserType('vendor')">Register as Vendor</button>
            </div>

            <input type="hidden" name="userType" id="userType" value="BUYER">
            <input type="hidden" name="registrationTime" value="2025-04-26 20:10:46">
            <input type="hidden" name="registeredBy" value="Krishmal2004">

            <div class="form-row">
                <div class="form-group">
                    <label class="form-label">First Name</label>
                    <input type="text" class="form-input" name="firstName" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Last Name</label>
                    <input type="text" class="form-input" name="lastName" required>
                </div>
            </div>

            <div class="form-group">
                <label class="form-label">Email Address</label>
                <input type="email" class="form-input" name="email" required>
            </div>

            <div class="form-group">
                <label class="form-label">Username</label>
                <input type="text" class="form-input" name="username" required>
            </div>

            <div class="form-group">
                <label class="form-label">Password</label>
                <input type="password" class="form-input" name="password" id="password" required>
            </div>

            <div class="form-group">
                <label class="form-label">Confirm Password</label>
                <input type="password" class="form-input" name="confirmPassword" id="confirmPassword" required>
            </div>

            <!-- Vendor Fields -->
            <div id="vendorFields">
                <div class="form-group">
                    <label class="form-label">Business Name</label>
                    <input type="text" class="form-input" name="businessName">
                </div>

                <div class="form-group">
                    <label class="form-label">Business Type</label>
                    <select class="form-input" name="businessType">
                        <option value="">Select Business Type</option>
                        <option value="MUSIC">Music Band</option>
                        <option value="PHOTOGRAPHY">Photography</option>
                        <option value="CARS">Wedding Cars</option>
                        <option value="DECORATION">Florist</option>
                        <option value="BRIDALGROOMING">Bridal Grooming</option>
                        <option value="PLANNING">Wedding Planning</option>
                    </select>
                </div>

                <div class="form-group">
                    <label class="form-label">Business Description</label>
                    <textarea class="form-input" name="description" rows="4"></textarea>
                </div>

                <div class="form-group">
                    <label class="form-label">Contact Number</label>
                    <input type="tel" class="form-input" name="contactNumber">
                </div>
                
                <div class="form-group">
                    <label class="form-label">Price Range</label>
                    <input type="text" class="form-input" name="Price">
                </div>

                <div class="form-group">
                    <label class="form-label">Services Offered</label>
                    <div class="services-grid">
                        <label class="service-option">
                            <input type="checkbox" name="services" value="music"> Music Band
                        </label>
                        <label class="service-option">
                            <input type="checkbox" name="services" value="photography"> Photography
                        </label>
                        <label class="service-option">
                            <input type="checkbox" name="services" value="cars"> Wedding Cars
                        </label>
                        <label class="service-option">
                            <input type="checkbox" name="services" value="videography"> Videography
                        </label>
                        <label class="service-option">
                            <input type="checkbox" name="services" value="decoration"> Decoration
                        </label>
                        <label class="service-option">
                            <input type="checkbox" name="services" value="planning"> Wedding Planning
                        </label>
                        <label class="service-option">
                            <input type="checkbox" name="services" value="BridalGrooming"> Bridal Grooming
                        </label>
                    </div>
                </div>
            </div>

            <button type="submit" class="submit-btn">Create Account</button>
            <div class="form-footer">
                <p>Already have an account? <a href="login.jsp">Login</a></p>
            </div>
        </form>
    </div>

    <footer>
        <p>&copy; 2025 DeegaLK. All rights reserved.</p>
    </footer>

    <script>
    function toggleUserType(type) {
        const vendorFields = document.getElementById('vendorFields');
        const userTypeInput = document.getElementById('userType');
        const buttons = document.querySelectorAll('.type-btn');
        
        buttons.forEach(btn => btn.classList.remove('active'));
        event.target.classList.add('active');

        if(type === 'vendor') {
            vendorFields.style.display = 'block';
            userTypeInput.value = 'VENDOR';
            // Make vendor fields required
            document.querySelectorAll('#vendorFields input:not([type="checkbox"]), #vendorFields select, #vendorFields textarea')
                .forEach(field => field.required = true);
        } else {
            vendorFields.style.display = 'none';
            userTypeInput.value = 'BUYER';
            // Remove required from vendor fields
            document.querySelectorAll('#vendorFields input, #vendorFields select, #vendorFields textarea')
                .forEach(field => field.required = false);
        }
    }

    document.querySelector('.signup-form').addEventListener('submit', function(e) {
        const password = document.getElementById('password').value;
        const confirmPassword = document.getElementById('confirmPassword').value;
        const userType = document.getElementById('userType').value;
        
        if (password !== confirmPassword) {
            e.preventDefault();
            alert('Passwords do not match!');
            return;
        }
        
        if (password.length < 6) {
            e.preventDefault();
            alert('Password must be at least 6 characters long!');
            return;
        }

        if (userType === 'VENDOR') {
            const businessName = document.querySelector('input[name="businessName"]').value;
            const businessType = document.querySelector('select[name="businessType"]').value;
            const contactNumber = document.querySelector('input[name="contactNumber"]').value;
            const services = document.querySelectorAll('input[name="services"]:checked');

            if (!businessName || !businessType || !contactNumber) {
                e.preventDefault();
                alert('Please fill all vendor fields!');
                return;
            }

            if (services.length === 0) {
                e.preventDefault();
                alert('Please select at least one service!');
                return;
            }
        }
    });
    </script>
</body>
</html>
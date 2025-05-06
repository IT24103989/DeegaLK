<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | DeegaLK</title>
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

        .login-container {
            flex: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px 20px;
        }

        .login-form {
            background: var(--white);
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
        }

        .form-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: 2.5em;
            margin-bottom: 30px;
            text-align: center;
            color: var(--text);
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

        .error-message {
            background: #ffebee;
            color: #c62828;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
        }

        footer {
            background: var(--dark);
            color: var(--white);
            padding: 20px;
            text-align: center;
            margin-top: auto;
        }
    </style>
</head>
<body>
    

    <nav class="nav-bar">
        <div class="nav-content">
            <a href="index.jsp" class="logo">DeegaLK</a>
        </div>
    </nav>

    <div class="login-container">
        <form class="login-form" action="LoginServlet" method="POST">
            <h2 class="form-title">Welcome Back</h2>
            
            <% if(request.getAttribute("error") != null) { %>
                <div class="error-message">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>

            <div class="form-group">
                <label class="form-label">Username</label>
                <input type="text" class="form-input" name="username" required>
            </div>

            <div class="form-group">
                <label class="form-label">Password</label>
                <input type="password" class="form-input" name="password" required>
            </div>

            <button type="submit" class="submit-btn">Login</button>

            <div class="form-footer">
                <p>Don't have an account? <a href="signup.jsp">Sign Up</a></p>
            </div>
        </form>
    </div>

    <footer>
        <p>&copy; 2025 DeegaLK. All rights reserved.</p>
    </footer>
</body>
</html>
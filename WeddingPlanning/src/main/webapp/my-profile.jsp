<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Romantic Wedding Planner | Forever Dreams</title>
    <link href="https://fonts.googleapis.com/css2?family=Great+Vibes&family=Montserrat:wght@300;400;500;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
        }

        .main-container {
            display: flex;
            min-height: 100vh;
        }

        /* Sidebar Styles */
        .sidebar {
            width: 280px;
            background: var(--white);
            box-shadow: 2px 0 20px var(--shadow);
            padding: 2rem;
            position: fixed;
            height: 100vh;
            overflow-y: auto;
            z-index: 1000;
        }

        .brand {
            font-family: 'Great Vibes', cursive;
            font-size: 2.5rem;
            color: var(--accent);
            text-align: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--border);
            text-shadow: 2px 2px 4px var(--shadow);
        }

        .profile-section {
            text-align: center;
            margin-bottom: 2rem;
            padding: 1.5rem;
            background: var(--light);
            border-radius: 20px;
            position: relative;
            overflow: hidden;
        }

        .profile-section::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(
                45deg,
                transparent,
                rgba(255, 182, 193, 0.1),
                transparent
            );
            transform: rotate(45deg);
            animation: shine 3s infinite;
        }

        @keyframes shine {
            0% {
                transform: translateX(-100%) rotate(45deg);
            }
            100% {
                transform: translateX(100%) rotate(45deg);
            }
        }

        .profile-avatar {
            width: 90px;
            height: 90px;
            background: var(--gradient);
            border-radius: 50%;
            margin: 0 auto 1rem;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-size: 2rem;
            font-family: 'Great Vibes', cursive;
            box-shadow: 0 5px 15px var(--shadow);
            border: 3px solid var(--white);
        }

        .profile-name {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--accent);
        }

        .profile-status {
            font-size: 0.9rem;
            color: var(--gray);
            position: relative;
            display: inline-block;
        }

        .profile-status::after {
            content: '❤️';
            position: absolute;
            right: -20px;
            top: 50%;
            transform: translateY(-50%);
        }

        .nav-menu {
            margin-bottom: 2rem;
        }

        .nav-title {
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--gray);
            margin-bottom: 1rem;
            padding-left: 1rem;
            position: relative;
        }

        .nav-title::before {
            content: '♡';
            position: absolute;
            left: 0;
            color: var(--accent);
        }

        .nav-list {
            list-style: none;
        }

        .nav-item {
            margin-bottom: 0.5rem;
        }

        .nav-link {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            color: var(--dark);
            text-decoration: none;
            border-radius: 15px;
            transition: all 0.3s ease;
            background: transparent;
        }

        .nav-link:hover, .nav-link.active {
            background: var(--gradient);
            color: var(--white);
            transform: translateX(5px);
            box-shadow: 0 5px 15px var(--shadow);
        }

        /* Main Content Styles */
        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 2rem;
        }

        .top-bar {
            background: var(--white);
            padding: 1rem 2rem;
            border-radius: 20px;
            box-shadow: 0 5px 20px var(--shadow);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }

        .top-bar::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: var(--gradient);
        }

        .datetime-display {
            display: flex;
            align-items: center;
            gap: 1rem;
            color: var(--accent);
        }

        .datetime-display i {
            font-size: 1.2rem;
        }

        .actions {
            display: flex;
            gap: 1rem;
        }

        .action-btn {
            padding: 0.8rem 1.5rem;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .primary-btn {
            background: var(--gradient);
            color: var(--white);
        }

        .outline-btn {
            background: transparent;
            border: 2px solid var(--primary);
            color: var(--accent);
        }

        .action-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px var(--shadow);
        }

        /* Dashboard Grid Layout */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 2rem;
        }

        .dashboard-card {
            background: var(--white);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 5px 20px var(--shadow);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }

        .dashboard-card:hover {
            transform: translateY(-5px);
        }

        .dashboard-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 3px;
            background: var(--gradient);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .card-title {
            font-family: 'Great Vibes', cursive;
            font-size: 1.8rem;
            color: var(--accent);
        }

        .card-icon {
            width: 50px;
            height: 50px;
            background: var(--light);
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--accent);
            font-size: 1.5rem;
            transition: all 0.3s ease;
        }

        .dashboard-card:hover .card-icon {
            background: var(--gradient);
            color: var(--white);
            transform: rotate(360deg);
        }

        /* Continue with additional styles... */
</style>
</head>
<body>
    <body>
    <div class="main-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="brand">
                <i class="fas fa-heart"></i> DeegaLK
            </div>
            
            

            <nav class="nav-menu">
                <h3 class="nav-title">Wedding Journey</h3>
                <ul class="nav-list">
                    <li class="nav-item">
                        <a href="buyer-dashboard.jsp" class="nav-link">
                            <i class="fas fa-home"></i>
                            My Dashboard
                        </a>
                    </li>
                    
                    <li class="nav-item">
                        <a href="wedding-vendors.jsp" class="nav-link">
                            <i class="fas fa-gem"></i>
                            Wedding Vendors
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="my-bookings.jsp" class="nav-link">
                            <i class="fas fa-calendar-heart"></i>
                            My Bookings
                        </a>
                  
                </ul>
            </nav>


            <nav class="nav-menu">
                <h3 class="nav-title">Account</h3>
                <ul class="nav-list">
                   <li class="nav-item">
                        <a href="my-profile.jsp" class="nav-link active">
                            <i class="fas fa-home"></i>
                            My Profile
                        </a>
                    </li>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
    <div class="top-bar">
        <div class="datetime-display">
            <i class="fa fa-calendar"></i>
            <span id="current-date"></span>
        </div>
        <div class="actions">
            <button class="action-btn primary-btn">Save Changes</button>
            <button class="action-btn outline-btn">Cancel</button>
        </div>
    </div>

    <div class="dashboard-grid">
        <!-- Edit Username Card -->
        <div class="dashboard-card">
            <div class="card-header">
                <h2 class="card-title">Edit Username</h2>
                <div class="card-icon">
                    <i class="fa fa-user-edit"></i>
                </div>
            </div>
            <form action="updateProfile.jsp" method="post">
                <label for="username">New Username:</label>
                <input type="text" id="username" name="username" required>
                <button type="submit" class="action-btn primary-btn">Update</button>
            </form>
        </div>

        <!-- Change Password Card -->
        <div class="dashboard-card">
            <div class="card-header">
                <h2 class="card-title">Change Password</h2>
                <div class="card-icon">
                    <i class="fa fa-key"></i>
                </div>
            </div>
            <form action="changePassword.jsp" method="post">
                <label for="current-password">Current Password:</label>
                <input type="password" id="current-password" name="current-password" required>
                <label for="new-password">New Password:</label>
                <input type="password" id="new-password" name="new-password" required>
                <button type="submit" class="action-btn primary-btn">Change Password</button>
            </form>
        </div>

        <!-- Delete Account Card -->
        <div class="dashboard-card">
            <div class="card-header">
                <h2 class="card-title">Delete Account</h2>
                <div class="card-icon">
                    <i class="fa fa-trash"></i>
                </div>
            </div>
            <form action="deleteAccount.jsp" method="post">
                <p>Are you sure you want to delete your account? This action cannot be undone.</p>
                <button type="submit" class="action-btn outline-btn">Delete Account</button>
            </form>
        </div>

        <!-- Log Out Card -->
        <div class="dashboard-card">
            <div class="card-header">
                <h2 class="card-title">Log Out</h2>
                <div class="card-icon">
                    <i class="fa fa-sign-out-alt"></i>
                </div>
            </div>
            <form action="index.jsp" method="post">
                <button type="submit" class="action-btn primary-btn">Log Out</button>
            </form>
        </div>
    </div>
</main>

<style>
/* Additional Romantic Styles */
.welcome-banner {
    background: linear-gradient(135deg, rgba(255,182,193,0.9), rgba(255,209,220,0.9));
    border-radius: 20px;
    padding: 2rem;
    margin-bottom: 2rem;
    color: var(--white);
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 5px 20px var(--shadow);
}

.welcome-content h1 {
    font-family: 'Great Vibes', cursive;
    font-size: 2.5rem;
    margin-bottom: 0.5rem;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
}

.countdown-container {
    text-align: center;
    background: rgba(255,255,255,0.2);
    padding: 1.5rem;
    border-radius: 15px;
    backdrop-filter: blur(5px);
}

.countdown-value {
    font-size: 3rem;
    font-weight: 700;
    margin-bottom: 0.5rem;
}

.countdown-label {
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 1px;
}

.wedding-details .detail-item {
    padding: 1rem;
    border-bottom: 1px solid var(--border);
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.wedding-details .label {
    color: var(--gray);
}

.wedding-details .value {
    color: var(--accent);
    font-weight: 500;
}

.progress-ring {
    position: relative;
    width: 120px;
    height: 120px;
    margin: 1rem auto;
}

.progress-ring-circle {
    fill: none;
    stroke: var(--primary);
    stroke-width: 8;
    stroke-linecap: round;
    transform: rotate(-90deg);
    transform-origin: 50% 50%;
    stroke-dasharray: 314;
    stroke-dashoffset: calc(314 - (314 * 75) / 100);
    transition: stroke-dashoffset 0.8s ease;
}

.progress-text {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
    color: var(--accent);
    font-weight: 600;
}

.task-item {
    display: flex;
    align-items: center;
    gap: 1rem;
    padding: 0.8rem;
    border-radius: 10px;
    transition: all 0.3s ease;
}

.task-item:hover {
    background: var(--light);
}

.task-item i {
    color: var(--success);
}

.task-item.pending i {
    color: var(--gray);
}

/* Animations */
@keyframes pulse {
    0% { transform: scale(1); }
    50% { transform: scale(1.05); }
    100% { transform: scale(1); }
}

.countdown-container {
    animation: pulse 2s infinite;
}

@keyframes progressRing {
    from { stroke-dashoffset: 314; }
    to { stroke-dashoffset: calc(314 - (314 * 75) / 100); }
}

.progress-ring-circle {
    animation: progressRing 1.5s ease-out forwards;
}
</style>

<script>
// Update time display
function updateTime() {
    const now = new Date();
    const timeString = now.toISOString().replace('T', ' ').substring(0, 19);
    document.querySelector('.datetime-display span').textContent = timeString;
}
setInterval(updateTime, 1000);

// Update countdown
function updateCountdown() {
    const weddingDate = new Date('2025-06-15');
    const now = new Date();
    const diff = weddingDate - now;
    const days = Math.ceil(diff / (1000 * 60 * 60 * 24));
    document.querySelector('.countdown-value').textContent = days;
}
updateCountdown();
setInterval(updateCountdown, 86400000); // Update daily

// Progress ring animation
document.querySelectorAll('.progress-ring-circle').forEach(circle => {
    const percent = parseInt(circle.closest('.progress-ring').querySelector('.progress-text').textContent);
    const circumference = 2 * Math.PI * 50;
    circle.style.strokeDasharray = circumference;
    circle.style.strokeDashoffset = circumference - (circumference * percent) / 100;
});
</script>

        </main>
    </div>
</body>
</html>
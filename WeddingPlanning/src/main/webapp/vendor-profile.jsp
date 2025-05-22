//IT24102085
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.google.gson.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | Wedding Planner</title>
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

        /* Keep the sidebar styles from vendor dashboard */
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

        .menu-item:hover, .menu-item.active {
            background: var(--gradient);
            color: var(--white);
            transform: translateX(5px);
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

        .profile-container {
            background: var(--white);
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.05);
            margin-top: 2rem;
        }

        .profile-header {
            display: flex;
            align-items: center;
            gap: 2rem;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--accent);
        }

        .profile-avatar {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: var(--gradient);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            font-size: 3rem;
            font-family: 'Playfair Display', serif;
        }

        .profile-info h1 {
            font-family: 'Playfair Display', serif;
            color: var(--dark);
            margin-bottom: 0.5rem;
        }

        .profile-business {
            color: var(--primary);
            font-size: 1.1rem;
        }

        .profile-form {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 2rem;
            margin-top: 2rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: var(--dark);
            font-weight: 500;
        }

        .form-group input, .form-group textarea {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid var(--accent);
            border-radius: 8px;
            font-family: 'Inter', sans-serif;
            transition: all 0.3s ease;
        }

        .form-group input:focus, .form-group textarea:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 2px rgba(157, 126, 103, 0.2);
        }

        .form-group textarea {
            height: 100px;
            resize: vertical;
        }

        .btn-container {
            grid-column: 1 / -1;
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 8px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: var(--gradient);
            color: var(--white);
        }

        .btn-secondary {
            background: var(--light);
            color: var(--primary);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .edit-mode {
            display: none;
        }

        .view-mode {
            display: block;
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

        @media (max-width: 768px) {
            .profile-form {
                grid-template-columns: 1fr;
            }
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
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="brand">DeegaLK</div>
        <a href="vendor-dashboard.jsp" class="menu-item">
            <i class="fas fa-home"></i>
            <span>Dashboard</span>
        </a>
        <a href="vendor-profile.jsp" class="menu-item active">
            <i class="fas fa-user"></i>
            <span>My Profile</span>
        </a>
        <a href="vendor-events.jsp" class="menu-item">
            <i class="fas fa-calendar-alt"></i>
            <span>Events</span>
        </a>
        <a href="index.jsp" class="menu-item">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="header">
            <div class="user-welcome">
                <div class="user-avatar">
                    ${sessionScope.firstName.charAt(0)}
                </div>
                <div class="welcome-text">
                    <h2>My Profile</h2>
                    <span class="date-time">2025-05-20 05:49:13</span>
                </div>
            </div>
            <div class="notification">
                <i class="fas fa-bell fa-lg"></i>
                <span class="notification-badge">3</span>
            </div>
        </div>

        <div class="profile-container">
            <div class="profile-header">
                <div class="profile-avatar">
                    ${sessionScope.firstName.charAt(0)}
                </div>
                <div class="profile-info">
                    <h1>${sessionScope.firstName} ${sessionScope.lastName}</h1>
                    <div class="profile-business">${sessionScope.businessName}</div>
                </div>
            </div>

            <form id="profileForm" action="updateVendorProfile" method="POST" class="profile-form">
                <div class="form-group">
                    <label for="firstName">First Name</label>
                    <input type="text" id="firstName" name="firstName" value="${sessionScope.firstName}" readonly>
                </div>
                <div class="form-group">
                    <label for="lastName">Last Name</label>
                    <input type="text" id="lastName" name="lastName" value="${sessionScope.lastName}" readonly>
                </div>
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" name="email" value="${sessionScope.email}" readonly>
                </div>
                <div class="form-group">
                    <label for="ContactNumber">Phone</label>
                    <input type="tel" id="ContactNumber" name="ContactNumber" value="${sessionScope.ContactNumber}" readonly>
                </div>
                <div class="form-group">
                    <label for="businessName">Business Name</label>
                    <input type="text" id="businessName" name="businessName" value="${sessionScope.businessName}" readonly>
                </div>
                <div class="form-group">
                    <label for="businessType">Business Type</label>
                    <input type="text" id="businessType" name="businessType" value="${sessionScope.businessType}" readonly>
                </div>
                <div class="form-group">
                    <label for="Description">Business Description</label>
                    <textarea id="Description" name="Description" readonly>${sessionScope.Description}</textarea>
                </div>
                <div class="btn-container">
                    <button type="button" class="btn btn-secondary" id="editBtn" onclick="toggleEdit()">Edit Profile</button>
                    <button type="submit" class="btn btn-primary" id="saveBtn" style="display: none;">Save Changes</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    function toggleEdit() {
        const form = document.getElementById('profileForm');
        const inputs = form.getElementsByTagName('input');
        const textareas = form.getElementsByTagName('textarea');
        const editBtn = document.getElementById('editBtn');
        const saveBtn = document.getElementById('saveBtn');

        if (editBtn.textContent === 'Edit Profile') {
            // Enable editing
            for (let input of inputs) {
                if (input.name !== 'email') { // Keep email readonly
                    input.removeAttribute('readonly');
                }
            }
            for (let textarea of textareas) {
                textarea.removeAttribute('readonly');
            }
            editBtn.textContent = 'Cancel';
            saveBtn.style.display = 'block';
        } else {
            // Disable editing
            for (let input of inputs) {
                input.setAttribute('readonly', true);
            }
            for (let textarea of textareas) {
                textarea.setAttribute('readonly', true);
            }
            editBtn.textContent = 'Edit Profile';
            saveBtn.style.display = 'none';
        }
    }

    document.getElementById('profileForm').addEventListener('submit', function(e) {
        e.preventDefault();

        const formData = new FormData(this);
        const data = {};
        formData.forEach((value, key) => data[key] = value);

        fetch('updateVendorProfile', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data)
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert('Profile updated successfully!');
                    toggleEdit(); // Return to view mode
                    // Update displayed values
                    Object.keys(data.updatedData).forEach(key => {
                        const element = document.getElementById(key);
                        if (element) {
                            element.value = data.updatedData[key];
                        }
                    });
                } else {
                    alert('Failed to update profile: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while updating the profile');
            });
    });
</script>

<script>
    function toggleEdit() {
        const form = document.getElementById('profileForm');
        const inputs = form.getElementsByTagName('input');
        const textareas = form.getElementsByTagName('textarea');
        const editBtn = document.getElementById('editBtn');
        const saveBtn = document.getElementById('saveBtn');

        if (editBtn.textContent === 'Edit Profile') {
            // Enable editing
            for (let input of inputs) {
                if (input.name !== 'email') { // Keep email readonly
                    input.removeAttribute('readonly');
                }
            }
            for (let textarea of textareas) {
                textarea.removeAttribute('readonly');
            }
            editBtn.textContent = 'Cancel';
            saveBtn.style.display = 'block';
        } else {
            // Cancel editing - reset form to original values
            form.reset();
            // Disable editing
            for (let input of inputs) {
                input.setAttribute('readonly', true);
            }
            for (let textarea of textareas) {
                textarea.setAttribute('readonly', true);
            }
            editBtn.textContent = 'Edit Profile';
            saveBtn.style.display = 'none';
        }
    }

    document.getElementById('profileForm').addEventListener('submit', function(e) {
        e.preventDefault();

        // Create data object from form
        const formData = new FormData(this);
        const data = {};
        formData.forEach((value, key) => {
            data[key] = value;
        });

        // Send update request
        fetch('updateVendorProfile', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(data)
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Network response was not ok');
                }
                return response.json();
            })
            .then(data => {
                if (data.success) {
                    alert('Profile updated successfully!');
                    // Update the form with new values
                    Object.keys(data.updatedData).forEach(key => {
                        const element = document.getElementById(key);
                        if (element) {
                            element.value = data.updatedData[key];
                        }
                    });
                    // Return to view mode
                    toggleEdit();
                    // Refresh the page to update header information
                    window.location.reload();
                } else {
                    alert('Failed to update profile: ' + (data.message || 'Unknown error'));
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while updating the profile: ' + error.message);
            });
    });

    // Update timestamp
    function updateTimestamp() {
        const timestamp = new Date().toISOString().replace('T', ' ').substring(0, 19);
        document.querySelector('.date-time').textContent = timestamp;
    }

    // Update timestamp every second
    setInterval(updateTimestamp, 1000);
    updateTimestamp();
</script>
<script>
    // Function to format current timestamp
    function getCurrentTimestamp() {
        const now = new Date();
        return now.getUTCFullYear() + '-' +
            String(now.getUTCMonth() + 1).padStart(2, '0') + '-' +
            String(now.getUTCDate()).padStart(2, '0') + ' ' +
            String(now.getUTCHours()).padStart(2, '0') + ':' +
            String(now.getUTCMinutes()).padStart(2, '0') + ':' +
            String(now.getUTCSeconds()).padStart(2, '0');
    }

    function toggleEdit() {
        const form = document.getElementById('profileForm');
        const inputs = form.getElementsByTagName('input');
        const textareas = form.getElementsByTagName('textarea');
        const editBtn = document.getElementById('editBtn');
        const saveBtn = document.getElementById('saveBtn');

        if (editBtn.textContent === 'Edit Profile') {
            // Enable editing
            for (let input of inputs) {
                if (input.name !== 'email') {
                    input.removeAttribute('readonly');
                }
            }
            for (let textarea of textareas) {
                textarea.removeAttribute('readonly');
            }
            editBtn.textContent = 'Cancel';
            saveBtn.style.display = 'block';
        } else {
            // Reset and disable editing
            form.reset();
            for (let input of inputs) {
                input.setAttribute('readonly', true);
            }
            for (let textarea of textareas) {
                textarea.setAttribute('readonly', true);
            }
            editBtn.textContent = 'Edit Profile';
            saveBtn.style.display = 'none';
        }
    }

    document.getElementById('profileForm').addEventListener('submit', async function(e) {
        e.preventDefault();

        try {
            const formData = {};
            const formElements = this.elements;

            for (let element of formElements) {
                if (element.name) {
                    formData[element.name] = element.value;
                }
            }

            const response = await fetch('updateVendorProfile', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(formData)
            });

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();

            if (data.success) {
                alert('Profile updated successfully!');

                // Update form values
                if (data.updatedData) {
                    Object.keys(data.updatedData).forEach(key => {
                        const element = document.getElementById(key);
                        if (element) {
                            element.value = data.updatedData[key];
                        }
                    });
                }

                // Update display elements
                document.querySelector('.profile-info h1').textContent =
                    `${data.updatedData.firstName} ${data.updatedData.lastName}`;
                document.querySelector('.profile-business').textContent =
                    data.updatedData.businessName;

                toggleEdit();
            } else {
                throw new Error(data.message || 'Update failed');
            }
        } catch (error) {
            console.error('Error:', error);
            alert('An error occurred while updating the profile: ' + error.message);
        }
    });

    // Update timestamp every second
    setInterval(() => {
        document.querySelector('.date-time').textContent = getCurrentTimestamp();
    }, 1000);

    // Initial timestamp
    document.querySelector('.date-time').textContent = getCurrentTimestamp();
</script>
</body>
</html>
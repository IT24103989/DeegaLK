//IT24103989
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="navbar.jsp" %> <!-- Including the navbar -->

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Manage Bookings</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        /* Custom styles for the dashboard */
        body {
            background-color: #f8f9fa;
            font-family: 'Cursive', sans-serif;
        }
        .navbar {
            background-color: #ff6f61;
        }
        .navbar-brand, .navbar-nav .nav-link {
            color: #fff !important;
        }
        .table {
            margin-top: 20px;
        }
        .btn-custom {
            background-color: #ff6f61;
            color: #fff;
        }
        .btn-custom:hover {
            background-color: #e65a50;
        }
        .card {
            margin-bottom: 20px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .dashboard-stats {
            background-color: #fff;
            border-radius: 5px;
            padding: 15px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .stats-number {
            font-size: 24px;
            font-weight: bold;
            color: #ff6f61;
        }
    </style>
</head>
<body>

<!-- Main Content -->
<div class="container mt-4">
    <div class="row">
        <div class="col-md-12">
            <h2 class="text-center mb-4">Admin Dashboard - Manage Bookings</h2>
            
            <!-- Dashboard Stats -->
            <div class="row">
                <div class="col-md-3">
                    <div class="dashboard-stats text-center">
                        <h5>Total Bookings</h5>
                        <div class="stats-number">187</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="dashboard-stats text-center">
                        <h5>Pending</h5>
                        <div class="stats-number">23</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="dashboard-stats text-center">
                        <h5>Confirmed</h5>
                        <div class="stats-number">135</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="dashboard-stats text-center">
                        <h5>This Month</h5>
                        <div class="stats-number">42</div>
                    </div>
                </div>
            </div>

            <!-- Calendar and Quick Actions -->
            <div class="row mt-3">
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-header">
                            <h5>Upcoming Bookings Calendar</h5>
                        </div>
                        <div class="card-body">
                            <p class="text-center mt-5">Calendar Widget will be displayed here</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card">
                        <div class="card-header">
                            <h5>Quick Actions</h5>
                        </div>
                        <div class="card-body">
                            <div class="d-grid gap-2">
                                <button class="btn btn-custom" type="button"><i class="bi bi-plus-circle"></i> Create New Booking</button>
                                <button class="btn btn-outline-secondary" type="button"><i class="bi bi-file-earmark-excel"></i> Export Bookings</button>
                                <button class="btn btn-outline-secondary" type="button"><i class="bi bi-printer"></i> Print Report</button>
                                <button class="btn btn-outline-secondary" type="button"><i class="bi bi-envelope"></i> Send Notifications</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Search and Filter -->
            <div class="card mt-3">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="input-group mb-3">
                                <input type="text" class="form-control" placeholder="Search bookings" aria-label="Search bookings">
                                <button class="btn btn-custom" type="button"><i class="bi bi-search"></i></button>
                            </div>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select" aria-label="Filter by status">
                                <option selected>Status</option>
                                <option value="pending">Pending</option>
                                <option value="confirmed">Confirmed</option>
                                <option value="canceled">Canceled</option>
                                <option value="completed">Completed</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <select class="form-select" aria-label="Filter by vendor">
                                <option selected>Vendor</option>
                                <option value="elegantWeddings">Elegant Weddings</option>
                                <option value="goldenLens">Golden Lens Photography</option>
                                <option value="royalCatering">Royal Catering</option>
                            </select>
                        </div>
                        <div class="col-md-2">
                            <input type="date" class="form-control" placeholder="Date">
                        </div>
                        <div class="col-md-2">
                            <button class="btn btn-custom w-100">Apply Filters</button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Bookings Table -->
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h4>All Bookings</h4>
                    <div class="btn-group">
                        <button type="button" class="btn btn-sm btn-outline-secondary">All</button>
                        <button type="button" class="btn btn-sm btn-outline-warning">Pending</button>
                        <button type="button" class="btn btn-sm btn-outline-success">Confirmed</button>
                        <button type="button" class="btn btn-sm btn-outline-danger">Canceled</button>
                        <button type="button" class="btn btn-sm btn-outline-info">Completed</button>
                    </div>
                </div>
                <div class="card-body">
                    <table class="table table-striped table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Client</th>
                                <th>Vendor</th>
                                <th>Service Type</th>
                                <th>Date</th>
                                <th>Amount</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <!-- Example Data -->
                            <tr>
                                <td>BK-2025051</td>
                                <td>Sarah Williams</td>
                                <td>Elegant Weddings</td>
                                <td>Wedding Planning</td>
                                <td>2025-06-15</td>
                                <td>$3,500.00</td>
                                <td><span class="badge status-confirmed">Confirmed</span></td>
                                <td>
                                    <div class="btn-group">
                                        <button class="btn btn-sm btn-outline-secondary"><i class="bi bi-eye"></i></button>
                                        <button class="btn btn-sm btn-outline-primary"><i class="bi bi-pencil"></i></button>
                                        <button class="btn btn-sm btn-outline-danger"><i class="bi bi-trash"></i></button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="navbar.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.WeddingPlanner.model.User" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Management</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .navbar-custom {
      background-color: #ff6f61;
    }
    .navbar-custom .nav-link,
    .navbar-custom .navbar-brand,
    .navbar-custom .text-light {
      color: white;
    }
    .table thead th {
      vertical-align: middle;
    }
  </style>
</head>
<body>
  <!-- Main Content -->
  <div class="container mt-4">
    <h4>User Management</h4>

    <% String message = request.getParameter("message"); %>
    <% if (message != null) { %>
      <div class="alert alert-info"><%= message %></div>
    <% } %>

    <div class="d-flex align-items-center my-3">
      <button class="btn btn-outline-secondary">
        All Users <span class="badge bg-secondary" id="totalCount">0</span>
      </button>

      <div class="ms-auto">
        <input type="text" class="form-control" id="searchInput" placeholder="🔍 Search by username...">
      </div>
    </div>

    <table class="table table-hover">
      <thead class="table-light">
        <tr>
          <th>First Name</th>
          <th>Last Name</th>
          <th>Email Address</th>
          <th>Username</th>
          <th>Actions</th>
        </tr>
      </thead>      
      <tbody id="userTableBody">
        <%
          List<User> users = (List<User>) request.getAttribute("users");
          if (users != null && !users.isEmpty()) {
            for (User user : users) {
        %>
          <tr>
            <td><%= user.getFirstName() %></td>
            <td><%= user.getLastName() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getUsername() %></td>
            <td>
              <button class="btn btn-sm btn-danger delete-btn" data-username="<%= user.getUsername() %>">Delete</button>
            </td>
          </tr>
        <%
            }
          } else {
        %>
          <tr>
            <td colspan="5" class="text-center">No users found</td>
          </tr>
        <%
          }
        %>
      </tbody>
    </table>
  </div>

  <!-- Bootstrap Bundle JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

  <!-- JavaScript for Search and Delete -->
  <script>
    document.addEventListener("DOMContentLoaded", function () {
      const tableBody = document.getElementById("userTableBody");
      const totalCount = document.getElementById("totalCount");
      const searchInput = document.getElementById("searchInput");

      function updateUserCount() {
        const visibleRows = tableBody.querySelectorAll("tr:not([style*='display: none'])");
        totalCount.textContent = visibleRows.length;
      }

      // Initialize user count
      updateUserCount();

      // Search filtering
      searchInput.addEventListener("input", function () {
        const query = this.value.toLowerCase();
        const rows = tableBody.querySelectorAll("tr");

        rows.forEach(row => {
          const username = row.cells[3].textContent.toLowerCase();
          row.style.display = username.includes(query) ? "" : "none";
        });

        updateUserCount();
      });

      // Delete button functionality
      document.querySelectorAll(".delete-btn").forEach(button => {
        button.addEventListener("click", function () {
          const username = this.getAttribute("data-username");
          if (confirm(`Are you sure you want to delete buyer "${username}"?`)) {
            fetch("<%= request.getContextPath() %>/deleteBuyer", {
              method: "POST",
              headers: {
                "Content-Type": "application/x-www-form-urlencoded"
              },
              body: "username=" + encodeURIComponent(username)
            })
            .then(res => res.json())
            .then(data => {
              if (data.status === "success") {
                this.closest("tr").remove();
                updateUserCount();
              } else {
                alert("Delete failed: " + (data.message || "Unknown error"));
              }
            })
            .catch(error => {
              console.error("Error:", error);
              alert("An error occurred while deleting the buyer.");
            });
          }
        });
      });
    });
  </script>
</body>
</html>

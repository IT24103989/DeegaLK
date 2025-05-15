//IT24103989
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="navbar.jsp" %>
<%@ page import="java.util.List" %>
<%@ page import="com.WeddingPlanner.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Vendor Management</title>
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
  <div class="container mt-4">
    <h4>Vendor Management</h4>

    <div class="d-flex align-items-center my-3">
      <button class="btn btn-outline-secondary">
        All Vendors <span class="badge bg-secondary" id="totalCount"><%= ((List<User>) request.getAttribute("vendors")).size() %></span>
      </button>

      <div class="ms-auto">
        <input type="text" class="form-control" id="searchInput" placeholder="🔍 Search vendors...">
      </div>
    </div>

    <table class="table table-hover">
      <thead class="table-light">
        <tr>
          <th>First Name</th>
          <th>Last Name</th>
          <th>Email Address</th>
          <th>Username</th>
          <th>Business Name</th>
          <th>Business Type</th>
          <th>Contact Number</th>
          <th>Price Range</th>
          <th>Services Offered</th>
          <th>Actions</th>
        </tr>
      </thead>
      <tbody id="vendorTableBody">
        <%
          List<User> vendors = (List<User>) request.getAttribute("vendors");
          if (vendors != null && !vendors.isEmpty()) {
            for (User vendor : vendors) {
        %>
        <tr>
          <td><%= vendor.getFirstName() %></td>
          <td><%= vendor.getLastName() %></td>
          <td><%= vendor.getEmail() %></td>
          <td><%= vendor.getUsername() %></td>
          <td><%= vendor.getVendorDetails().getBusinessName() %></td>
          <td><%= vendor.getVendorDetails().getBusinessType() %></td>
          <td><%= vendor.getVendorDetails().getContactNumber() %></td>
          <td><%= vendor.getVendorDetails().getPrice() %></td>
          <td><%= String.join(", ", vendor.getVendorDetails().getServices()) %></td>
          <td>
          
          
          
            <button class="btn btn-sm btn-danger delete-btn" data-username="<%= vendor.getUsername() %>">Delete</button>

            
          </td>
        </tr>
        <%
            }
          } else {
        %>
        <tr>
          <td colspan="9" class="text-center">No vendors found</td>
        </tr>
        <%
          }
        %>
      </tbody>
    </table>
  </div>

  <!-- Bootstrap Bundle JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

  <!-- Username Search Script -->
  <script>
    document.getElementById('searchInput').addEventListener('keyup', function () {
      const searchValue = this.value.toLowerCase();
      const rows = document.querySelectorAll('#vendorTableBody tr');

      rows.forEach(row => {
        const usernameCell = row.cells[3]; // Username column
        if (usernameCell) {
          const username = usernameCell.textContent.toLowerCase();
          if (username.includes(searchValue)) {
            row.style.display = '';
          } else {
            row.style.display = 'none';
          }
        }
      });
    });
  </script>
  
  <script>
  document.querySelectorAll(".delete-btn").forEach(button => {
    button.addEventListener("click", function () {
      const username = this.getAttribute("data-username");
      if (confirm(`Are you sure you want to delete vendor "${username}"?`)) {
        fetch("<%= request.getContextPath() %>/deleteVendor", {
          method: "POST",
          headers: {
            "Content-Type": "application/x-www-form-urlencoded"
          },
          body: "username=" + encodeURIComponent(username)
        })
        .then(res => res.json())
        .then(data => {
          if (data.status === "success") {
            // Remove the table row
            const row = this.closest("tr");
            row.remove();

            // Update count badge
            const countBadge = document.getElementById("totalCount");
            countBadge.textContent = document.querySelectorAll("#vendorTableBody tr").length;

          } else {
            alert("Delete failed: " + (data.message || "Unknown error"));
          }
        })
        .catch(error => {
          console.error("Error:", error);
          alert("An error occurred while deleting the vendor.");
        });
      }
    });
  });
</script>
  

</body>
</html>

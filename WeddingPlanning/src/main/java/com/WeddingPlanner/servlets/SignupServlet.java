// IT24103989
package com.WeddingPlanner.servlets;

import com.WeddingPlanner.model.User;
import com.WeddingPlanner.model.VendorDetails;
import com.WeddingPlanner.services.UserAuthService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

// For date and time
import java.time.ZonedDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    private UserAuthService authService;

    @Override
    public void init() throws ServletException {
        authService = new UserAuthService(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");

        // Set current date and time in Sri Lankan time zone
        ZoneId sriLankaZone = ZoneId.of("Asia/Colombo");
        ZonedDateTime nowInSriLanka = ZonedDateTime.now(sriLankaZone);
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        String formattedNow = nowInSriLanka.format(formatter);

        // ✅ Log time to server console
        System.out.println("Sri Lankan Time (formattedNow): " + formattedNow);

        User newUser = new User();
        newUser.setFirstName(firstName);
        newUser.setLastName(lastName);
        newUser.setEmail(email);
        newUser.setUsername(username);
        newUser.setPassword(password);
        newUser.setUserType(userType);
        newUser.setDateRegistered(formattedNow);
        newUser.setStatus("active");
        newUser.setRegisteredBy("IT24103989");

        if ("VENDOR".equals(userType)) {
            VendorDetails vendorDetails = new VendorDetails();
            vendorDetails.setBusinessName(request.getParameter("businessName"));
            vendorDetails.setBusinessType(request.getParameter("businessType"));
            vendorDetails.setDescription(request.getParameter("description"));
            vendorDetails.setContactNumber(request.getParameter("contactNumber"));
            vendorDetails.setPrice(request.getParameter("Price"));
            vendorDetails.setServices(request.getParameterValues("services"));
            vendorDetails.setRating(0.0);
            vendorDetails.setReviewCount(0);
            newUser.setVendorDetails(vendorDetails);
        }

        try {
            if (authService.registerUser(newUser)) {
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("userType", userType);
                session.setAttribute("firstName", firstName);
                session.setAttribute("lastName", lastName);

                String redirectPath = "VENDOR".equals(userType) ?
                        "vendor-dashboard.jsp" : "buyer-dashboard.jsp";
                response.sendRedirect(redirectPath);
            } else {
                request.setAttribute("error", "Registration failed. Username may already exist.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("signup.jsp").forward(request, response);
        }
    }
}
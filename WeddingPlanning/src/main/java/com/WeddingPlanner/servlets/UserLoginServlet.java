//IT24103989
package com.WeddingPlanner.servlets;

import com.WeddingPlanner.model.User;
import com.WeddingPlanner.services.UserAuthService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class UserLoginServlet extends HttpServlet {
    private final UserAuthService authService = new UserAuthService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        try {
            User user = authService.authenticateUser(username, password, getServletContext());
            
            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("username", user.getUsername());
                session.setAttribute("userType", user.getUserType());
                session.setAttribute("firstName", user.getFirstName());
                session.setAttribute("lastName", user.getLastName());
                session.setAttribute("email", user.getEmail());
                session.setAttribute("loginTime", "2025-04-26 21:47:41");
                
                if ("VENDOR".equals(user.getUserType()) && user.getVendorDetails() != null) {
                    session.setAttribute("businessName", user.getVendorDetails().getBusinessName());
                    session.setAttribute("businessType", user.getVendorDetails().getBusinessType());
                }
                
                response.sendRedirect("VENDOR".equals(user.getUserType()) ? 
                    "vendor-dashboard.jsp" : "buyer-dashboard.jsp");
            } else {
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("error", "Login failed: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
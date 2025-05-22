//IT24103989
package com.WeddingPlanner.servlets;

import com.WeddingPlanner.model.Admin;
import com.WeddingPlanner.services.AdminAuthService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    private final AdminAuthService authService = new AdminAuthService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        Admin admin = authService.authenticateAdmin(username, password);

        if (admin != null) {
            // Save admin in session
            HttpSession session = request.getSession();
            session.setAttribute("adminUser", admin);
            response.sendRedirect("admin-dashboard.jsp");
        } else {
            request.setAttribute("error", "Invalid admin credentials.");
            request.getRequestDispatcher("admin-login.jsp").forward(request, response);
        }
    }
}

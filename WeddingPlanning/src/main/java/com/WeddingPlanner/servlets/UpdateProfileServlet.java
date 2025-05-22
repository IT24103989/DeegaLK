//IT24103811
package com.WeddingPlanner.servlets;

import com.WeddingPlanner.model.User;
import com.WeddingPlanner.services.UserProfileService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
    private UserProfileService profileService;

    @Override
    public void init() throws ServletException {
        profileService = new UserProfileService(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");
        String userType = (String) session.getAttribute("userType");
        String action = request.getParameter("action");

        if (username == null || userType == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            switch (action) {
                case "updateProfile":
                    updateProfile(request, response, username);
                    break;
                case "changePassword":
                    changePassword(request, response, username);
                    break;
                case "deleteAccount":
                    deleteAccount(request, response, username, userType);
                    break;
                default:
                    response.sendError(400, "Invalid action");
            }
        } catch (Exception e) {
            request.setAttribute("error", "Operation failed: " + e.getMessage());
            request.getRequestDispatcher("my-profile.jsp").forward(request, response);
        }
    }

    private void updateProfile(HttpServletRequest request, HttpServletResponse response, String username)
            throws ServletException, IOException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");

        // Validate input
        if (firstName == null || firstName.trim().isEmpty() ||
            lastName == null || lastName.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required");
            request.getRequestDispatcher("my-profile.jsp").forward(request, response);
            return;
        }

        // Validate email format
        if (!profileService.isValidEmail(email)) {
            request.setAttribute("error", "Invalid email format");
            request.getRequestDispatcher("my-profile.jsp").forward(request, response);
            return;
        }

        if (profileService.updateUserProfile(username, firstName, lastName, email)) {
            // Update session attributes
            HttpSession session = request.getSession();
            session.setAttribute("firstName", firstName);
            session.setAttribute("lastName", lastName);
            session.setAttribute("email", email);
            
            request.setAttribute("success", "Profile updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update profile");
        }
        request.getRequestDispatcher("my-profile.jsp").forward(request, response);
    }

    private void changePassword(HttpServletRequest request, HttpServletResponse response, String username)
            throws ServletException, IOException {
        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate input
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            request.setAttribute("error", "All password fields are required");
            request.getRequestDispatcher("my-profile.jsp").forward(request, response);
            return;
        }

        // Validate password match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "New passwords do not match");
            request.getRequestDispatcher("my-profile.jsp").forward(request, response);
            return;
        }

        // Validate password strength
        if (!profileService.isValidPassword(newPassword)) {
            request.setAttribute("error", "Password must be at least 6 characters long");
            request.getRequestDispatcher("my-profile.jsp").forward(request, response);
            return;
        }

        if (profileService.changeUserPassword(username, currentPassword, newPassword)) {
            request.setAttribute("success", "Password changed successfully!");
        } else {
            request.setAttribute("error", "Current password is incorrect");
        }
        request.getRequestDispatcher("my-profile.jsp").forward(request, response);
    }

    private void deleteAccount(HttpServletRequest request, HttpServletResponse response, String username, String userType)
            throws ServletException, IOException {
        if (profileService.deleteUserProfile(username, userType)) {
            HttpSession session = request.getSession();
            session.invalidate();
            response.sendRedirect("login.jsp?deleted=true");
        } else {
            request.setAttribute("error", "Failed to delete account");
            request.getRequestDispatcher("my-profile.jsp").forward(request, response);
        }
    }
}
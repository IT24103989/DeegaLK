//IT24103989
package com.WeddingPlanner.servlets;

import com.WeddingPlanner.services.UserAuthService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/deleteBuyer")
public class DeleteBuyerServlet extends HttpServlet {
    private UserAuthService userService;

    @Override
    public void init() throws ServletException {
        userService = new UserAuthService(getServletContext());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        if (username != null && !username.trim().isEmpty()) {
            boolean deleted = userService.deleteBuyerByUsername(username);
            if (deleted) {
                out.write("{\"status\":\"success\"}");
            } else {
                out.write("{\"status\":\"failed\", \"message\":\"Buyer not found or couldn't delete\"}");
            }
        } else {
            out.write("{\"status\":\"failed\", \"message\":\"Invalid username\"}");
        }
    }
}

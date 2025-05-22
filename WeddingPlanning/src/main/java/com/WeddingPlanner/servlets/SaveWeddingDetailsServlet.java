package com.WeddingPlanner.servlets;

import com.google.gson.Gson;
import com.WeddingPlanner.model.WeddingDetails;
import com.WeddingPlanner.services.WeddingService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.util.List;

@WebServlet("/saveWeddingDetails")
public class SaveWeddingDetailsServlet extends HttpServlet {
    private final WeddingService weddingService = new WeddingService();
    private final Gson gson = new Gson();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        HttpSession session = request.getSession(false);
        
        // Check if session exists
        if (session == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Session expired\"}");
            return;
        }

        try {
            // Read JSON data from request
            StringBuilder buffer = new StringBuilder();
            String line;
            try (BufferedReader reader = request.getReader()) {
                while ((line = reader.readLine()) != null) {
                    buffer.append(line);
                }
            }

            // Convert JSON to WeddingDetails object
            WeddingDetails weddingDetails = gson.fromJson(buffer.toString(), WeddingDetails.class);
            
            // Save details with session
            boolean success = weddingService.saveWeddingDetails(weddingDetails, session);

            if (success) {
                // On success, send response with redirect URL
                response.getWriter().write("{\"status\":\"success\",\"message\":\"Wedding details saved successfully\",\"redirectUrl\":\"dashboard.jsp\"}");
            } else {
                throw new Exception("Failed to save wedding details");
            }

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        HttpSession session = request.getSession(false);
        
        if (session == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"Session expired\"}");
            return;
        }

        try {
            // Get wedding details for current user
            List<WeddingDetails> userDetails = weddingService.getWeddingDetailsByUserId("IT24103989");
            response.getWriter().write(gson.toJson(userDetails));
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
        }
    }
}
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
import java.io.IOException;
import java.util.List;

@WebServlet("/fetchBuyerWeddingDetails")
public class FetchBuyerWeddingDetailsServlet extends HttpServlet {
    private final WeddingService weddingService = new WeddingService();
    private final Gson gson = new Gson();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        
        try {
            // Using hardcoded ID for now since we know the current user
            String userId = "IT24103989";
            List<WeddingDetails> userDetails = weddingService.getWeddingDetailsByUserId(userId);
            
            if (!userDetails.isEmpty()) {
                WeddingDetails latestDetails = userDetails.get(userDetails.size() - 1);
                response.getWriter().write(gson.toJson(latestDetails));
            } else {
                response.getWriter().write("{\"status\":\"error\",\"message\":\"No wedding details found\"}");
            }
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"status\":\"error\",\"message\":\"" + e.getMessage() + "\"}");
        }
    }
}
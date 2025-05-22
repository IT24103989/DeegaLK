package com.WeddingPlanner.servlets;

import com.WeddingPlanner.services.BookingService;
import com.google.gson.JsonObject;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/deleteBooking")
public class DeleteBookingServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        JsonObject jsonResponse = new JsonObject();

        try {
            String bookingId = request.getParameter("bookingId");
            System.out.println("Received bookingId: " + bookingId);

            if (bookingId == null || bookingId.trim().isEmpty()) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "Booking ID is required");
                response.getWriter().write(jsonResponse.toString());
                return;
            }

            BookingService bookingService = new BookingService();
            boolean deleted = bookingService.deleteBooking(bookingId, getServletContext());

            jsonResponse.addProperty("success", deleted);
            jsonResponse.addProperty("message", deleted ? "Booking deleted successfully" : "Failed to delete booking");

        } catch (Exception e) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "Error: " + e.getMessage());
            e.printStackTrace();
        }

        response.getWriter().write(jsonResponse.toString());
    }
}

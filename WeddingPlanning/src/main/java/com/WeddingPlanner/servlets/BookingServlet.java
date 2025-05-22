package com.WeddingPlanner.servlets;

import com.WeddingPlanner.model.Booking;
import com.WeddingPlanner.model.User;
import com.WeddingPlanner.services.BookingService;
import com.WeddingPlanner.services.UserAuthService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/BookingServlet")
public class BookingServlet extends HttpServlet {
    private BookingService bookingService;
    private UserAuthService userAuthService;

    @Override
    public void init() throws ServletException {
        super.init();
        bookingService = new BookingService();
        userAuthService = new UserAuthService(getServletContext()); // Initialize with ServletContext
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String buyerUsername = (String) session.getAttribute("username");
        String vendorUsername = request.getParameter("vendorUsername");

        if (buyerUsername == null || vendorUsername == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing required parameters");
            return;
        }

        // Get vendor details
        User vendor = userAuthService.getUserByUsername(vendorUsername, getServletContext());
        if (vendor == null || vendor.getVendorDetails() == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Vendor not found");
            return;
        }

        // Create booking
        Booking booking = new Booking();
        booking.setBuyerUsername(buyerUsername);
        booking.setVendorUsername(vendorUsername);
        booking.setBusinessName(vendor.getVendorDetails().getBusinessName());
        booking.setBusinessType(vendor.getVendorDetails().getBusinessType());
        booking.setPrice(vendor.getVendorDetails().getPrice());
        booking.setServices(vendor.getVendorDetails().getServices());

        boolean success = bookingService.createBooking(booking, getServletContext());

        response.setContentType("application/json");
        if (success) {
            response.getWriter().write("{\"success\": true}");
        } else {
            response.getWriter().write("{\"success\": false, \"message\": \"Booking already exists\"}");
        }
    }
}
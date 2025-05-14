//IT24103989
package com.WeddingPlanner.servlets;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

import com.WeddingPlanner.model.User;
import com.WeddingPlanner.services.UserAuthService;

@WebServlet("/ManageVendor")
public class ManageVendorServlet extends HttpServlet {
    private UserAuthService authService;

    @Override
    public void init() throws ServletException {
        super.init();
        authService = new UserAuthService(getServletContext());
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<User> Vendors = authService. getAllVendorsSortedByPrice();
        request.setAttribute("vendors", Vendors);
        request.getRequestDispatcher("manageVendors.jsp").forward(request, response);
    }
}

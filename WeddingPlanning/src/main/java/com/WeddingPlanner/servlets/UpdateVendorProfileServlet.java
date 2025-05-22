package com.WeddingPlanner.servlets;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonArray;
import com.google.gson.JsonParser;
import com.google.gson.JsonElement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.*;
import java.nio.file.*;

@WebServlet("/updateVendorProfile")
public class UpdateVendorProfileServlet extends HttpServlet {
    private static final String USERS_FILE = "C:\\Users\\MSI\\Desktop\\Deegacom\\WeddingPlanning\\src\\main\\webapp\\WEB-INF\\lib\\users.json";

    private final Gson gson = new GsonBuilder().setPrettyPrinting().create();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // Read JSON data from request
            StringBuilder buffer = new StringBuilder();
            String line;
            BufferedReader reader = request.getReader();
            while ((line = reader.readLine()) != null) {
                buffer.append(line);
            }

            JsonObject updateData = JsonParser.parseString(buffer.toString()).getAsJsonObject();

            // Get current user from session
            HttpSession session = request.getSession();
            String username = (String) session.getAttribute("username");

            if (username == null || username.isEmpty()) {
                JsonObject errorResponse = new JsonObject();
                errorResponse.addProperty("success", false);
                errorResponse.addProperty("message", "User not logged in");
                out.print(errorResponse.toString());
                return;
            }

            File usersFile = new File(USERS_FILE);
            if (!usersFile.exists()) {
                JsonObject errorResponse = new JsonObject();
                errorResponse.addProperty("success", false);
                errorResponse.addProperty("message", "Users file not found");
                out.print(errorResponse.toString());
                return;
            }

            String fileContent = new String(Files.readAllBytes(usersFile.toPath()));
            JsonObject usersData = JsonParser.parseString(fileContent).getAsJsonObject();
            JsonArray users = usersData.getAsJsonArray("users");

            boolean updated = false;

            for (int i = 0; i < users.size(); i++) {
                JsonObject user = users.get(i).getAsJsonObject();
                if (user.get("username").getAsString().equals(username)) {

                    // Update user properties safely
                    if (hasNonNull(updateData, "firstName")) {
                        user.addProperty("firstName", updateData.get("firstName").getAsString());
                        session.setAttribute("firstName", updateData.get("firstName").getAsString());
                    }
                    if (hasNonNull(updateData, "lastName")) {
                        user.addProperty("lastName", updateData.get("lastName").getAsString());
                        session.setAttribute("lastName", updateData.get("lastName").getAsString());
                    }
                    if (hasNonNull(updateData, "ContactNumber")) {
                        user.addProperty("ContactNumber", updateData.get("ContactNumber").getAsString());
                        session.setAttribute("ContactNumber", updateData.get("ContactNumber").getAsString());
                    }
                    if (hasNonNull(updateData, "businessName")) {
                        user.addProperty("businessName", updateData.get("businessName").getAsString());
                        session.setAttribute("businessName", updateData.get("businessName").getAsString());
                    }
                    if (hasNonNull(updateData, "businessType")) {
                        user.addProperty("businessType", updateData.get("businessType").getAsString());
                        session.setAttribute("businessType", updateData.get("businessType").getAsString());
                    }
                    if (hasNonNull(updateData, "address")) {
                        user.addProperty("address", updateData.get("address").getAsString());
                        session.setAttribute("address", updateData.get("address").getAsString());
                    }
                    if (hasNonNull(updateData, "description")) {
                        user.addProperty("description", updateData.get("description").getAsString());
                        session.setAttribute("description", updateData.get("description").getAsString());
                    }

                    // Update vendorDetails if exists
                    if (user.has("vendorDetails") && user.get("vendorDetails").isJsonObject()) {
                        JsonObject vendorDetails = user.getAsJsonObject("vendorDetails");

                        if (hasNonNull(updateData, "businessName")) {
                            vendorDetails.addProperty("businessName", updateData.get("businessName").getAsString());
                        }
                        if (hasNonNull(updateData, "businessType")) {
                            vendorDetails.addProperty("businessType", updateData.get("businessType").getAsString());
                        }
                        if (hasNonNull(updateData, "description")) {
                            vendorDetails.addProperty("description", updateData.get("description").getAsString());
                        }
                        if (hasNonNull(updateData, "ContactNumber")) {
                            vendorDetails.addProperty("ContactNumber", updateData.get("ContactNumber").getAsString());
                        }
                    }

                    updated = true;
                    break;
                }
            }

            if (updated) {
                try (FileWriter fileWriter = new FileWriter(usersFile)) {
                    gson.toJson(usersData, fileWriter);
                }

                JsonObject successResponse = new JsonObject();
                successResponse.addProperty("success", true);
                successResponse.add("updatedData", updateData);
                out.print(successResponse.toString());
            } else {
                JsonObject errorResponse = new JsonObject();
                errorResponse.addProperty("success", false);
                errorResponse.addProperty("message", "User not found in database");
                out.print(errorResponse.toString());
            }

        } catch (Exception e) {
            e.printStackTrace();
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("success", false);
            errorResponse.addProperty("message", "Server error: " + e.getMessage());
            out.print(errorResponse.toString());
        }
    }

    private boolean hasNonNull(JsonObject obj, String key) {
        return obj.has(key) && !obj.get(key).isJsonNull();
    }
}

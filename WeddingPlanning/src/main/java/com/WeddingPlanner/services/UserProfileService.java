package com.WeddingPlanner.services;

import com.WeddingPlanner.model.User;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonArray;

import javax.servlet.ServletContext;
import java.io.*;
import java.nio.file.*;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

public class UserProfileService {
    private static final String DATA_FILE = "/WEB-INF/lib/users.json";
    private static final String DATA_FILE_ABSOLUTE = "C:\\Users\\MSI\\Desktop\\Deegacom\\WeddingPlanning\\src\\main\\webapp\\WEB-INF\\lib\\users.json";
    private final Gson gson = new GsonBuilder().setPrettyPrinting().create();
    private ServletContext servletContext;
    private final UserAuthService authService; // Reference to existing UserAuthService

    public UserProfileService(ServletContext servletContext) {
        this.servletContext = servletContext;
        this.authService = new UserAuthService(servletContext);
    }

    public boolean updateUserProfile(String username, String firstName, String lastName, String email) throws IOException {
        try {
            String content = new String(Files.readAllBytes(Paths.get(DATA_FILE_ABSOLUTE)));
            JsonObject rootObject = gson.fromJson(content, JsonObject.class);
            JsonArray users = rootObject.getAsJsonArray("users");
            boolean updated = false;

            for (int i = 0; i < users.size(); i++) {
                JsonObject userJson = users.get(i).getAsJsonObject();
                if (userJson.get("username").getAsString().equals(username)) {
                    userJson.addProperty("firstName", firstName);
                    userJson.addProperty("lastName", lastName);
                    userJson.addProperty("email", email);
                    updated = true;
                    break;
                }
            }

            if (updated) {
                rootObject.addProperty("lastUpdated", getCurrentTimestamp());
                Files.write(Paths.get(DATA_FILE_ABSOLUTE), gson.toJson(rootObject).getBytes());
                return true;
            }
            return false;
        } catch (Exception e) {
            throw new IOException("Failed to update profile: " + e.getMessage());
        }
    }

    public boolean changeUserPassword(String username, String currentPassword, String newPassword) throws IOException {
        try {
            // First verify the current password
            User user = authService.authenticateUser(username, currentPassword, servletContext);
            if (user == null) {
                return false; // Current password is incorrect
            }

            String content = new String(Files.readAllBytes(Paths.get(DATA_FILE_ABSOLUTE)));
            JsonObject rootObject = gson.fromJson(content, JsonObject.class);
            JsonArray users = rootObject.getAsJsonArray("users");

            for (int i = 0; i < users.size(); i++) {
                JsonObject userJson = users.get(i).getAsJsonObject();
                if (userJson.get("username").getAsString().equals(username)) {
                    userJson.addProperty("password", newPassword);
                    rootObject.addProperty("lastUpdated", getCurrentTimestamp());
                    Files.write(Paths.get(DATA_FILE_ABSOLUTE), gson.toJson(rootObject).getBytes());
                    return true;
                }
            }
            return false;
        } catch (Exception e) {
            throw new IOException("Failed to change password: " + e.getMessage());
        }
    }

    public boolean deleteUserProfile(String username, String userType) throws IOException {
        try {
            String content = new String(Files.readAllBytes(Paths.get(DATA_FILE_ABSOLUTE)));
            JsonObject rootObject = gson.fromJson(content, JsonObject.class);
            JsonArray users = rootObject.getAsJsonArray("users");
            int indexToRemove = -1;

            // Find the user to delete
            for (int i = 0; i < users.size(); i++) {
                JsonObject userJson = users.get(i).getAsJsonObject();
                if (userJson.get("username").getAsString().equals(username) &&
                    userJson.get("userType").getAsString().equals(userType)) {
                    indexToRemove = i;
                    break;
                }
            }

            // Remove the user if found
            if (indexToRemove != -1) {
                users.remove(indexToRemove);
                rootObject.addProperty("lastUpdated", getCurrentTimestamp());
                Files.write(Paths.get(DATA_FILE_ABSOLUTE), gson.toJson(rootObject).getBytes());
                return true;
            }
            return false;
        } catch (Exception e) {
            throw new IOException("Failed to delete profile: " + e.getMessage());
        }
    }

    public User getUserProfile(String username) throws IOException {
        try {
            return authService.getUserByUsername(username, servletContext);
        } catch (Exception e) {
            throw new IOException("Failed to get user profile: " + e.getMessage());
        }
    }

    private String getCurrentTimestamp() {
        ZonedDateTime nowInColombo = ZonedDateTime.now(java.time.ZoneId.of("Asia/Colombo"));
        return nowInColombo.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    // Helper method to validate email format
    public boolean isValidEmail(String email) {
        String emailRegex = "^[A-Za-z0-9+_.-]+@(.+)$";
        return email.matches(emailRegex);
    }

    // Helper method to validate password strength
    public boolean isValidPassword(String password) {
        // Password must be at least 6 characters long
        if (password.length() < 6) {
            return false;
        }
        // Add more password validation rules as needed
        return true;
    }
}
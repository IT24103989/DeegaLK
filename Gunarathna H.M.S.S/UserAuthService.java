package com.WeddingPlanner.services;

import com.WeddingPlanner.model.User;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;
import com.google.gson.JsonArray;
import javax.servlet.ServletContext;
import java.io.*;
import java.nio.file.*;

public class UserAuthService {
    private static final String DATA_FILE = "C:\\Users\\MSI\\Downloads\\oop\\WeddingPlanner\\src\\main\\webapp\\WEB-INF\\lib\\users.json";
    private final Gson gson = new GsonBuilder().setPrettyPrinting().create();

    public User authenticateUser(String username, String password, ServletContext context) throws IOException {
        try {
            // Read the JSON file
            String content = new String(Files.readAllBytes(Paths.get(DATA_FILE)));
            JsonObject rootObject = gson.fromJson(content, JsonObject.class);
            JsonArray users = rootObject.getAsJsonArray("users");

            for (int i = 0; i < users.size(); i++) {
                JsonObject userJson = users.get(i).getAsJsonObject();
                String storedUsername = userJson.get("username").getAsString();
                String storedPassword = userJson.get("password").getAsString();

                if (storedUsername.equals(username) && storedPassword.equals(password)) {
                    User user = gson.fromJson(userJson, User.class);
                    user.setLastLogin("2025-04-26 21:47:41");
                    updateUserLastLogin(user);
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new IOException("Error reading users file: " + e.getMessage());
        }
        return null;
    }

    private void updateUserLastLogin(User user) throws IOException {
        try {
            String content = new String(Files.readAllBytes(Paths.get(DATA_FILE)));
            JsonObject rootObject = gson.fromJson(content, JsonObject.class);
            JsonArray users = rootObject.getAsJsonArray("users");

            for (int i = 0; i < users.size(); i++) {
                JsonObject userJson = users.get(i).getAsJsonObject();
                if (userJson.get("username").getAsString().equals(user.getUsername())) {
                    userJson.addProperty("lastLogin", "2025-04-26 21:47:41");
                    break;
                }
            }

            rootObject.addProperty("lastUpdated", "2025-04-26 21:47:41");
            Files.write(Paths.get(DATA_FILE), gson.toJson(rootObject).getBytes());
        } catch (Exception e) {
            throw new IOException("Failed to update last login: " + e.getMessage());
        }
    }

    public boolean registerUser(User newUser) throws IOException {
        try {
            String content = new String(Files.readAllBytes(Paths.get(DATA_FILE)));
            JsonObject rootObject = gson.fromJson(content, JsonObject.class);
            JsonArray users = rootObject.getAsJsonArray("users");

            // Check for existing username
            for (int i = 0; i < users.size(); i++) {
                JsonObject userJson = users.get(i).getAsJsonObject();
                if (userJson.get("username").getAsString().equals(newUser.getUsername())) {
                    return false;
                }
            }

            // Add new user
            users.add(gson.toJsonTree(newUser));
            rootObject.addProperty("lastUpdated", "2025-04-26 21:47:41");
            Files.write(Paths.get(DATA_FILE), gson.toJson(rootObject).getBytes());
            return true;
        } catch (Exception e) {
            throw new IOException("Failed to register user: " + e.getMessage());
        }
    }
}
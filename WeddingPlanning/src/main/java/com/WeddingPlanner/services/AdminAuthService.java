//IT24103811
package com.WeddingPlanner.services;

import com.WeddingPlanner.model.Admin;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;

public class AdminAuthService {
    private static final String ADMIN_FILE = "C:\\Users\\ASUS\\Desktop\\Deegacom\\wedding planning\\src\\main\\webapp\\WEB-INF\\lib\\admin.json";
    private final Gson gson = new GsonBuilder().setPrettyPrinting().create();

    public Admin authenticateAdmin(String username, String password) throws IOException {
        try {
            String content = new String(Files.readAllBytes(Paths.get(ADMIN_FILE)));
            JsonObject adminJson = gson.fromJson(content, JsonObject.class);

            String storedUsername = adminJson.get("username").getAsString();
            String storedPassword = adminJson.get("password").getAsString();

            if (storedUsername.equals(username) && storedPassword.equals(password)) {
                Admin admin = new Admin();
                admin.setUsername(storedUsername);
                return admin;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new IOException("Error reading admin file: " + e.getMessage());
        }
        return null;
    }
}

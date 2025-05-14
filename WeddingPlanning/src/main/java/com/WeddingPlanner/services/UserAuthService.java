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

    public List<User> getAllBuyers() throws IOException {
        List<User> buyerList = new ArrayList<>();
        try {
            System.out.println("Reading user config...");
            JsonObject rootObject = readUserConfig();
            JsonArray users = rootObject.getAsJsonArray("users");

            for (int i = 0; i < users.size(); i++) {
                JsonObject userJson = users.get(i).getAsJsonObject();
                String userType = userJson.get("userType").getAsString();
                if ("BUYER".equalsIgnoreCase(userType)) {
                    User user = gson.fromJson(userJson, User.class);
                    buyerList.add(user);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new IOException("Failed to read buyers: " + e.getMessage(), e);
        }
        return buyerList;
    }

    public List<User> getAllVendorsSortedByPrice() throws IOException {
        List<User> vendorList = new LinkedList<>(); // Use LinkedList instead of ArrayList

        try {
            System.out.println("Reading user config...");
            JsonObject rootObject = readUserConfig();
            JsonArray users = rootObject.getAsJsonArray("users");

            for (int i = 0; i < users.size(); i++) {
                JsonObject userJson = users.get(i).getAsJsonObject();
                String userType = userJson.get("userType").getAsString();
                if ("VENDOR".equalsIgnoreCase(userType)) {
                    User user = gson.fromJson(userJson, User.class);
                    vendorList.add(user); // dynamically add to LinkedList
                }
            }

            // Bubble Sort on LinkedList
            int n = vendorList.size();
            for (int i = 0; i < n - 1; i++) {
                boolean swapped = false;
                for (int j = 0; j < n - i - 1; j++) {
                    // Use get() because LinkedList still supports random access via index
                    int price1 = Integer.parseInt(vendorList.get(j).getVendorDetails().getPrice());
                    int price2 = Integer.parseInt(vendorList.get(j + 1).getVendorDetails().getPrice());

                    if (price1 > price2) {
                        // Swap elements
                        User temp = vendorList.get(j);
                        vendorList.set(j, vendorList.get(j + 1));
                        vendorList.set(j + 1, temp);
                        swapped = true;
                    }
                }
                if (!swapped) break; // Optimization: stop if already sorted
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new IOException("Failed to read vendors: " + e.getMessage(), e);
        }

        return vendorList;
    }

    public boolean deleteVendorByUsername(String username) throws IOException {
        try {
            String content = new String(Files.readAllBytes(Paths.get(DATA_FILE_ABSOLUTE)));
            JsonObject rootObject = gson.fromJson(content, JsonObject.class);
            JsonArray users = rootObject.getAsJsonArray("users");

            for (int i = 0; i < users.size(); i++) {
                JsonObject userJson = users.get(i).getAsJsonObject();
                if (userJson.get("username").getAsString().equals(username)
                        && "VENDOR".equalsIgnoreCase(userJson.get("userType").getAsString())) {
                    users.remove(i);
                    rootObject.addProperty("lastUpdated", getCurrentTimestamp());
                    Files.write(Paths.get(DATA_FILE_ABSOLUTE), gson.toJson(rootObject).getBytes());
                    return true;
                }
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            throw new IOException("Failed to delete vendor: " + e.getMessage());
        }
    }
}
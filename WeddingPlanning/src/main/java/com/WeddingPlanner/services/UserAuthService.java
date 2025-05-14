// IT24103989
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
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class UserAuthService {
    private static final String DATA_FILE = "/WEB-INF/lib/users.json";
    private static final String DATA_FILE_ABSOLUTE = "C:\\Users\\MSI\\Desktop\\Deegacom\\WeddingPlanning\\src\\main\\webapp\\WEB-INF\\lib\\users.json";
    private final Gson gson = new GsonBuilder().setPrettyPrinting().create();
    private ServletContext servletContext;

    public UserAuthService() {}

    public UserAuthService(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    public User authenticateUser(String username, String password, ServletContext context) throws IOException {
        this.servletContext = context;
        try {
            JsonObject rootObject = readUserConfig();
            JsonArray users = rootObject.getAsJsonArray("users");

            for (int i = 0; i < users.size(); i++) {
                JsonObject userJson = users.get(i).getAsJsonObject();
                String storedUsername = userJson.get("username").getAsString();
                String storedPassword = userJson.get("password").getAsString();

                if (storedUsername.equals(username) && storedPassword.equals(password)) {
                    User user = gson.fromJson(userJson, User.class);
                    String currentTime = getCurrentTimestamp();
                    user.setLastLogin(currentTime);
                    updateUserLastLogin(user, currentTime);
                    return user;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw new IOException("Error reading users file: " + e.getMessage());
        }
        return null;
    }

    private void updateUserLastLogin(User user, String timestamp) throws IOException {
        try {
            String realPath = servletContext.getRealPath(DATA_FILE);
            if (realPath == null) {
                throw new IOException("users.json path is invalid.");
            }

            String content = new String(Files.readAllBytes(Paths.get(realPath)));
            JsonObject rootObject = gson.fromJson(content, JsonObject.class);
            JsonArray users = rootObject.getAsJsonArray("users");

            for (int i = 0; i < users.size(); i++) {
                JsonObject userJson = users.get(i).getAsJsonObject();
                if (userJson.get("username").getAsString().equals(user.getUsername())) {
                    userJson.addProperty("lastLogin", timestamp);
                    break;
                }
            }

            rootObject.addProperty("lastUpdated", timestamp);
            Files.write(Paths.get(realPath), gson.toJson(rootObject).getBytes());
        } catch (Exception e) {
            throw new IOException("Failed to update last login: " + e.getMessage());
        }
    }

    public boolean registerUser(User newUser) throws IOException {
        try {
            String content = new String(Files.readAllBytes(Paths.get(DATA_FILE_ABSOLUTE)));
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
            rootObject.addProperty("lastUpdated", getCurrentTimestamp());
            Files.write(Paths.get(DATA_FILE_ABSOLUTE), gson.toJson(rootObject).getBytes());
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
    
    public boolean deleteBuyerByUsername(String username) throws IOException {
        try {
            String content = new String(Files.readAllBytes(Paths.get(DATA_FILE_ABSOLUTE)));
            JsonObject rootObject = gson.fromJson(content, JsonObject.class);
            JsonArray users = rootObject.getAsJsonArray("users");

            for (int i = 0; i < users.size(); i++) {
                JsonObject userJson = users.get(i).getAsJsonObject();
                if (userJson.get("username").getAsString().equals(username)
                        && "BUYER".equalsIgnoreCase(userJson.get("userType").getAsString())) {
                    users.remove(i);
                    rootObject.addProperty("lastUpdated", getCurrentTimestamp());
                    Files.write(Paths.get(DATA_FILE_ABSOLUTE), gson.toJson(rootObject).getBytes());
                    return true;
                }
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            throw new IOException("Failed to delete buyer: " + e.getMessage());
        }
    }


    private JsonObject readUserConfig() {
        try {
            InputStream is = servletContext.getResourceAsStream(DATA_FILE);
            if (is == null) {
                System.err.println("Could not find users.json file at path: " + DATA_FILE);
                JsonObject empty = new JsonObject();
                empty.add("users", new JsonArray());
                return empty;
            }

            try (InputStreamReader reader = new InputStreamReader(is, "UTF-8")) {
                return gson.fromJson(reader, JsonObject.class);
            }
        } catch (Exception e) {
            System.err.println("Error reading users.json: " + e.getMessage());
            e.printStackTrace();
            JsonObject empty = new JsonObject();
            empty.add("users", new JsonArray());
            return empty;
        }
    }

    private String getCurrentTimestamp() {
        ZonedDateTime nowInColombo = ZonedDateTime.now(java.time.ZoneId.of("Asia/Colombo"));
        return nowInColombo.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }
}

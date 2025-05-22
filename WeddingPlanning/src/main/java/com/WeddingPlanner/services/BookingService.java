package com.WeddingPlanner.services;

import com.WeddingPlanner.model.Booking;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import javax.servlet.ServletContext;
import java.io.*;
import java.nio.file.*;
import java.util.ArrayList;
import java.util.List;

public class BookingService {
    private static final String BOOKINGS_FILE = "/WEB-INF/data/bookings.json";
    private static final String BOOKINGS_FILE_ABSOLUTE = "C:\\Users\\MSI\\Desktop\\Deegacom\\WeddingPlanning\\src\\main\\webapp\\WEB-INF\\data\\Bookings.json";
    private final Gson gson = new GsonBuilder().setPrettyPrinting().create();

    public boolean createBooking(Booking booking, ServletContext context) {
        try {
            // Try using absolute path first
            File bookingsFile = new File(BOOKINGS_FILE_ABSOLUTE);

            // Create directories if they don't exist
            bookingsFile.getParentFile().mkdirs();

            JsonObject rootObject;
            JsonArray bookings;

            // Check if file exists and read it, or create new if it doesn't exist
            if (bookingsFile.exists()) {
                String content = new String(Files.readAllBytes(bookingsFile.toPath()));
                rootObject = gson.fromJson(content, JsonObject.class);
                if (rootObject == null) {
                    rootObject = new JsonObject();
                }
                bookings = rootObject.getAsJsonArray("bookings");
                if (bookings == null) {
                    bookings = new JsonArray();
                    rootObject.add("bookings", bookings);
                }
            } else {
                rootObject = new JsonObject();
                bookings = new JsonArray();
                rootObject.add("bookings", bookings);
            }

            // Check if booking already exists
            for (int i = 0; i < bookings.size(); i++) {
                JsonObject bookingJson = bookings.get(i).getAsJsonObject();
                if (bookingJson.get("buyerUsername").getAsString().equals(booking.getBuyerUsername()) &&
                        bookingJson.get("vendorUsername").getAsString().equals(booking.getVendorUsername())) {
                    return false; // Booking already exists
                }
            }

            // Add new booking
            bookings.add(gson.toJsonTree(booking));

            // Write updated content to file
            String jsonContent = gson.toJson(rootObject);
            Files.write(bookingsFile.toPath(), jsonContent.getBytes());

            System.out.println("Booking saved successfully to: " + bookingsFile.getAbsolutePath());
            System.out.println("Booking content: " + jsonContent);

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error saving booking: " + e.getMessage());
            return false;
        }
    }

    public boolean isVendorBookedByBuyer(String buyerUsername, String vendorUsername, ServletContext context) {
        try {
            File bookingsFile = new File(BOOKINGS_FILE_ABSOLUTE);

            if (!bookingsFile.exists()) {
                return false;
            }

            String content = new String(Files.readAllBytes(bookingsFile.toPath()));
            JsonObject rootObject = gson.fromJson(content, JsonObject.class);
            if (rootObject == null || !rootObject.has("bookings")) {
                return false;
            }

            JsonArray bookings = rootObject.getAsJsonArray("bookings");

            for (int i = 0; i < bookings.size(); i++) {
                JsonObject bookingJson = bookings.get(i).getAsJsonObject();
                if (bookingJson.get("buyerUsername").getAsString().equals(buyerUsername) &&
                        bookingJson.get("vendorUsername").getAsString().equals(vendorUsername)) {
                    return true;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error checking booking status: " + e.getMessage());
        }
        return false;
    }

    public List<Booking> getBookingsByBuyer(String buyerUsername, ServletContext context) {
        List<Booking> userBookings = new ArrayList<>();
        try {
            File bookingsFile = new File(BOOKINGS_FILE_ABSOLUTE);

            if (!bookingsFile.exists()) {
                return userBookings;
            }

            String content = new String(Files.readAllBytes(bookingsFile.toPath()));
            JsonObject rootObject = gson.fromJson(content, JsonObject.class);
            if (rootObject == null || !rootObject.has("bookings")) {
                return userBookings;
            }

            JsonArray bookings = rootObject.getAsJsonArray("bookings");

            for (int i = 0; i < bookings.size(); i++) {
                JsonObject bookingJson = bookings.get(i).getAsJsonObject();
                if (bookingJson.get("buyerUsername").getAsString().equals(buyerUsername)) {
                    Booking booking = gson.fromJson(bookingJson, Booking.class);
                    userBookings.add(booking);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error retrieving bookings: " + e.getMessage());
        }
        return userBookings;
    }

    public List<Booking> getBookingsByVendor(String vendorUsername, ServletContext context) {
        List<Booking> vendorBookings = new ArrayList<>();
        try {
            File bookingsFile = new File(BOOKINGS_FILE_ABSOLUTE);

            if (!bookingsFile.exists()) {
                return vendorBookings;
            }

            String content = new String(Files.readAllBytes(bookingsFile.toPath()));
            JsonObject rootObject = gson.fromJson(content, JsonObject.class);
            if (rootObject == null || !rootObject.has("bookings")) {
                return vendorBookings;
            }

            JsonArray bookings = rootObject.getAsJsonArray("bookings");

            for (int i = 0; i < bookings.size(); i++) {
                JsonObject bookingJson = bookings.get(i).getAsJsonObject();
                if (bookingJson.get("vendorUsername").getAsString().equals(vendorUsername)) {
                    Booking booking = gson.fromJson(bookingJson, Booking.class);
                    vendorBookings.add(booking);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error retrieving vendor bookings: " + e.getMessage());
        }
        return vendorBookings;
    }
    public List<Booking> getAllBookings(ServletContext context) {
        List<Booking> allBookings = new ArrayList<>();
        try {
            File bookingsFile = new File(BOOKINGS_FILE_ABSOLUTE);

            if (!bookingsFile.exists()) {
                return allBookings;
            }

            String content = new String(Files.readAllBytes(bookingsFile.toPath()));
            JsonObject rootObject = gson.fromJson(content, JsonObject.class);
            if (rootObject == null || !rootObject.has("bookings")) {
                return allBookings;
            }

            JsonArray bookings = rootObject.getAsJsonArray("bookings");
            for (int i = 0; i < bookings.size(); i++) {
                JsonObject bookingJson = bookings.get(i).getAsJsonObject();
                Booking booking = gson.fromJson(bookingJson, Booking.class);
                allBookings.add(booking);
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.err.println("Error retrieving all bookings: " + e.getMessage());
        }
        return allBookings;
    }

    public boolean deleteBooking(String bookingId, ServletContext context) {
        try {
            // Use absolute path for file operations
            File bookingsFile = new File(BOOKINGS_FILE_ABSOLUTE);
            if (!bookingsFile.exists()) {
                System.err.println("Bookings file not found at: " + BOOKINGS_FILE_ABSOLUTE);
                return false;
            }

            // Read the current content
            String content = new String(Files.readAllBytes(bookingsFile.toPath()));
            JsonObject rootObject = gson.fromJson(content, JsonObject.class);
            if (rootObject == null || !rootObject.has("bookings")) {
                System.err.println("Invalid JSON structure in bookings file");
                return false;
            }

            JsonArray bookings = rootObject.getAsJsonArray("bookings");
            int indexToRemove = -1;

            // Find the booking to remove
            for (int i = 0; i < bookings.size(); i++) {
                JsonObject bookingJson = bookings.get(i).getAsJsonObject();
                String currentId = bookingJson.has("id") ? bookingJson.get("id").getAsString() : "";
                if (bookingId.equals(currentId)) {
                    indexToRemove = i;
                    break;
                }
            }

            // Remove the booking if found
            if (indexToRemove != -1) {
                bookings.remove(indexToRemove);

                // Write the updated content back to file
                try {
                    Files.write(bookingsFile.toPath(), gson.toJson(rootObject).getBytes());
                    System.out.println("Successfully deleted booking with ID: " + bookingId);
                    return true;
                } catch (IOException e) {
                    System.err.println("Error writing to bookings file: " + e.getMessage());
                    e.printStackTrace();
                    return false;
                }
            } else {
                System.err.println("Booking not found with ID: " + bookingId);
                return false;
            }

        } catch (Exception e) {
            System.err.println("Error in deleteBooking: " + e.getMessage());
            e.printStackTrace();
            return false;
        }

    }
}
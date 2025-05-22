package com.WeddingPlanner.services;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.reflect.TypeToken;
import com.WeddingPlanner.model.WeddingDetails;
import java.io.*;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpSession;

public class WeddingService {
    private static final String JSON_FILE_PATH = "C:\\Users\\ASUS\\Desktop\\Deegacom\\wedding planning\\src\\main\\webapp\\WEB-INF\\lib\\details.json";
    private static final Gson gson = new GsonBuilder().setPrettyPrinting().create();

    public synchronized boolean saveWeddingDetails(WeddingDetails weddingDetails, HttpSession session) {
        if (session == null) {
            return false;
        }

        try {
            // Set the current user ID and timestamp
            weddingDetails.setUserId("IT24103989");
            weddingDetails.setCreatedAt("2025-05-21 16:58:39");

            // Read existing data
            List<WeddingDetails> existingDetails = readExistingData();
            
            // Add new details
            existingDetails.add(weddingDetails);

            // Write back to file
            File file = new File(JSON_FILE_PATH);
            file.getParentFile().mkdirs(); // Create directories if they don't exist
            
            try (Writer writer = new FileWriter(file)) {
                gson.toJson(existingDetails, writer);
                return true;
            }

        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<WeddingDetails> getWeddingDetailsByUserId(String userId) {
        List<WeddingDetails> allDetails = readExistingData();
        List<WeddingDetails> userDetails = new ArrayList<>();
        
        for (WeddingDetails detail : allDetails) {
            if (detail.getUserId().equals(userId)) {
                userDetails.add(detail);
            }
        }
        
        return userDetails;
    }

    private List<WeddingDetails> readExistingData() {
        List<WeddingDetails> details = new ArrayList<>();
        File file = new File(JSON_FILE_PATH);

        if (file.exists() && file.length() > 0) {
            try (Reader reader = new FileReader(file)) {
                Type listType = new TypeToken<ArrayList<WeddingDetails>>(){}.getType();
                List<WeddingDetails> loadedDetails = gson.fromJson(reader, listType);
                if (loadedDetails != null) {
                    details = loadedDetails;
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return details;
    }
}
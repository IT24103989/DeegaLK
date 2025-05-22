package com.WeddingPlanner.model;

import java.io.Serializable;

public class WeddingDetails implements Serializable {
    private String venue;
    private String date;
    private String time;
    private String userId;
    private String createdAt;
    private String buyerName;
    private String buyerEmail;
    private String buyerPhone;

    public WeddingDetails() {
        // Set default values using the provided timestamp and user login
        this.userId = "IT24103989";
        this.createdAt = "2025-05-21 16:58:39";
    }

    // Getters and Setters
    public String getVenue() {
        return venue;
    }

    public void setVenue(String venue) {
        this.venue = venue;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    public String getBuyerName() {
        return buyerName;
    }

    public void setBuyerName(String buyerName) {
        this.buyerName = buyerName;
    }

    public String getBuyerEmail() {
        return buyerEmail;
    }

    public void setBuyerEmail(String buyerEmail) {
        this.buyerEmail = buyerEmail;
    }

    public String getBuyerPhone() {
        return buyerPhone;
    }

    public void setBuyerPhone(String buyerPhone) {
        this.buyerPhone = buyerPhone;
    }
}
package com.WeddingPlanner.model;

public class Booking {
    private String bookingId;
    private String buyerUsername;
    private String vendorUsername;
    private String businessName;
    private String businessType;
    private String bookingDate;
    private String status;
    private String price;
    private String[] services;

    // Constructors
    public Booking() {}

    // Getters and Setters
    public String getBookingId() {
        return bookingId;
    }
    public void setBookingId(String bookingId) {
        this.bookingId = bookingId;
    }

    public String getBuyerUsername() {
        return buyerUsername;
    }
    public void setBuyerUsername(String buyerUsername) {
        this.buyerUsername = buyerUsername;
    }

    public String getVendorUsername() {
        return vendorUsername;
    }
    public void setVendorUsername(String vendorUsername) {
        this.vendorUsername = vendorUsername;
    }

    public String getBusinessName() {
        return businessName;
    }
    public void setBusinessName(String businessName) {
        this.businessName = businessName;
    }

    public String getBusinessType() {
        return businessType;
    }
    public void setBusinessType(String businessType) {
        this.businessType = businessType;
    }

    public String getBookingDate() {
        return bookingDate;
    }
    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public String getPrice() {
        return price;
    }
    public void setPrice(String price) {
        this.price = price;
    }

    public String[] getServices() {
        return services;
    }
    public void setServices(String[] services) {
        this.services = services;
    }

    private String id;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
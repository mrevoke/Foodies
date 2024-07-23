package com.connection;

public class User {
    private int id;
    private String name;
    private String email;
    private String phone;
    private String address;
    private String Role;
    
    // Getters and setters for user fields
    
    public int getId() {
        return id;
    }
    public String getRole() {
    	return Role;
    }
    public void setRole(String Role) {
    	this.Role=Role;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}


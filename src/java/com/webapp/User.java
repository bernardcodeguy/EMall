/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.webapp;

import java.io.Serializable;
import java.util.UUID;

/**
 *
 * @author Kornell
 */
public class User implements Serializable{
    
    private String id;
    private String username;
    private String fname;
    private String lname;
    private String email;
    private String password;
    private String gender;
    private String imageUrl;
    private  double virtualBalance;
    
    
    public User() {
        this.id = UUID.randomUUID().toString();
        
    }

    public User(String username, String fname, String lname, String email, String password,String gender, String imageUrl) {
        this.id = UUID.randomUUID().toString();
        this.username = username;
        this.fname = fname;
        this.lname = lname;
        this.email = email;
        this.password = password;
        this.gender = gender;
        this.imageUrl = imageUrl;
        this.virtualBalance = 100000;
    }

    public String getId() {
        return id;
    }

   

    
    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getFname() {
        return fname;
    }

    public void setFname(String fname) {
        this.fname = fname;
    }

    public String getLname() {
        return lname;
    }

    public void setLname(String lname) {
        this.lname = lname;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
    
    

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public double getVirtualBalance() {
        return virtualBalance;
    }

    public void setVirtualBalance(double virtualBalance) {
        this.virtualBalance = virtualBalance;
    }

    
    
    
    
    
}

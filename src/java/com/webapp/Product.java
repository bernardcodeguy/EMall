
package com.webapp;


import java.io.OutputStream;
import java.sql.Blob;

/**
 *
 * @author Kornell
 */
public class Product {
    
    private int id;
    private String pr_name;
    private String manufacturer;
    private double price;
    private int qty_in_stock;
    private String category;
    private Blob img;
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public Blob getImg() {
        return img;
    }

    public void setImg(Blob img) {
        this.img = img;
    }

    public String getPr_name() {
        return pr_name;
    }

    public void setPr_name(String pr_name) {
        this.pr_name = pr_name;
    }

    public String getManufacturer() {
        return manufacturer;
    }

    public void setManufacturer(String manufacturer) {
        this.manufacturer = manufacturer;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQty_in_stock() {
        return qty_in_stock;
    }

    public void setQty_in_stock(int qty_in_stock) {
        this.qty_in_stock = qty_in_stock;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

   
    
    

    
    
}

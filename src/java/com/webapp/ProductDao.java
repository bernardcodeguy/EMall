
package com.webapp;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Kornell
 */
public class ProductDao {
    private static String usernameDB = "root";
    private static String passwordDB = "1234";
    private static String urlPort = "localhost:3307";
    private static String databaseName = "emall";
    private static String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
    private static String dbDriver = "com.mysql.cj.jdbc.Driver";
    
    
    
     public  static Connection getConnection(){  
        Connection con=null;  
        try{  
            Class.forName(dbDriver);  
            con=DriverManager.getConnection(url,usernameDB,passwordDB);  
        }catch(Exception e){
            System.out.println(e);
        }  
        return con;  
    }
    
    
    public static List<Product> getRecords(int start,int total) throws SQLException{ 
        String sql = "SELECT * FROM product LIMIT "+(start-1)+","+total;
        
        List<Product> list = new ArrayList<>();  
        
        Connection con=getConnection();  
        PreparedStatement ps=con.prepareStatement(sql);
        ResultSet rs=ps.executeQuery();  
        
        while(rs.next()){            
            Product p=new Product();  
            p.setId(rs.getInt("id"));
            p.setPr_name(rs.getString("pr_name"));
            p.setManufacturer(rs.getString("manufacturer"));
            p.setPrice(rs.getDouble("price"));
            p.setQty_in_stock(rs.getInt("qty_in_stock"));
            p.setCategory(rs.getString("category"));
            p.setImg(rs.getBlob("img"));
            list.add(p);  
         }  
        
        
         con.close();
        
         return list;
    }
    
    
    public static List<Product> getRecordSearch(int start,int total,String keyword) throws SQLException{ 
        //String sql = "SELECT * FROM product LIMIT "+(start-1)+","+total;
        String sql = "SELECT * FROM product WHERE LOCATE(?, pr_name) > 0  OR LOCATE(?, category) > 0 LIMIT "+(start-1)+","+total;
        
        
        
        List<Product> list = new ArrayList<>();  
        
        Connection con=getConnection();  
        PreparedStatement ps=con.prepareStatement(sql);
        ps.setString(1, keyword);
        ps.setString(2, keyword);
        ResultSet rs=ps.executeQuery();  
        
        while(rs.next()){            
            Product p=new Product();  
            p.setId(rs.getInt("id"));
            p.setPr_name(rs.getString("pr_name"));
            p.setManufacturer(rs.getString("manufacturer"));
            p.setPrice(rs.getDouble("price"));
            p.setQty_in_stock(rs.getInt("qty_in_stock"));
            p.setCategory(rs.getString("category"));
            p.setImg(rs.getBlob("img"));
            list.add(p);  
         }  
        
        
         con.close();
        
         return list;
    }
    
}

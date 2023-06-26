package com.webapp;


import com.webapp.Cart;
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

public class CartDao {
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
     
    public static List<Cart> getRecords(String username) throws SQLException{ 
        String sql = "SELECT * FROM cart WHERE username=?";
        
        List<Cart> list = new ArrayList<>();  
        
        Connection con=getConnection();  
        PreparedStatement ps=con.prepareStatement(sql);
        ps.setString(1, username);
        ResultSet rs=ps.executeQuery();  
        
        while(rs.next()){            
            Cart c=new Cart();  
            c.setId(rs.getInt("id"));
            c.setPr_id(rs.getInt("pr_id"));
            c.setPr_name(rs.getString("pr_name"));
            c.setManufacturer(rs.getString("manufacturer"));
            c.setPrice(rs.getDouble("price"));
            list.add(c);  
         }  
        
        
         con.close();
        
         return list;
    }
    
}

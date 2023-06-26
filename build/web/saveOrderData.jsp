<%-- 
    Document   : saveOrderData.jsp
    Created on : Sep 8, 2022, 12:40:51 PM
    Author     : Kornell
--%>

<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.ObjectOutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.ObjectInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.webapp.User"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="com.webapp.Cart"%>
<%@ page import="java.sql.*" %>


<%!
    
    double totalAmount;
    String username = "";
    List<Cart> list = null;
    Map<Integer,Integer> check = null;
    
     File file = null;
     User user = null;
     double virtualBalance;
     
        
    
%>


<%
    
    username = request.getParameter("username");
    virtualBalance = Double.parseDouble(request.getParameter("vbalance"));
   totalAmount = Double.parseDouble(request.getParameter("total"));
    
    
    if(virtualBalance >= totalAmount ){
        double newBalance;
        final String usernameDB = "root";
        final String passwordDB = "1234";
        final String urlPort = "localhost:3307";
        final String databaseName = "emall";
        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        final String dbDriver = "com.mysql.cj.jdbc.Driver";
    
    
    
        file = new File(username+".obj");
        check = (Map<Integer,Integer>)session.getAttribute("check");    
        list = (List<Cart>) session.getAttribute("list");
    
        FileInputStream fileIn = new FileInputStream(file);
        ObjectInputStream objectIn = new ObjectInputStream(fileIn);
        Object obj = objectIn.readObject();               
        user = (User) obj;
        objectIn.close();
        
        
        
        newBalance = virtualBalance - totalAmount;
        
        for(Cart c: list){
           

            String sql = "INSERT INTO orders(pr_id,pr_name,manufacturer,price,username) VALUES(?,?,?,?,?)";
            Class.forName(dbDriver);
            Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, c.getPr_id());
            ps.setString(2, c.getPr_name());
            ps.setString(3, c.getManufacturer());
            ps.setDouble(4, c.getPrice());
            ps.setString(5, username);
            
            ps.executeUpdate();
            con.close();
     
        
        }
        
        for(Cart c: list){                
            String sql2 = "INSERT INTO order_history(pr_id,pr_name,manufacturer,price,username) VALUES(?,?,?,?,?)";
            Class.forName(dbDriver);
            Connection con2 = DriverManager.getConnection(url,usernameDB,passwordDB);
            PreparedStatement ps2 = con2.prepareStatement(sql2);

            ps2.setInt(1, c.getPr_id());
            ps2.setString(2, c.getPr_name());
            ps2.setString(3, c.getManufacturer());
            ps2.setDouble(4, c.getPrice());
            ps2.setString(5, username);
            ps2.executeUpdate();
            con2.close();
               
        }
        
        for(Map.Entry<Integer, Integer> pair : check.entrySet()){
        
            int qty_in_stock = pair.getValue() - 1;
        
            String sql3 = "UPDATE product SET qty_in_stock=? WHERE id=?";
            Class.forName(dbDriver);
            Connection con3 = DriverManager.getConnection(url,usernameDB,passwordDB);
            PreparedStatement ps3 = con3.prepareStatement(sql3);	
            ps3.setInt(1, qty_in_stock);
            ps3.setInt(2, pair.getKey());
            ps3.executeUpdate();
            con3.close();
     
        }
        
        
        String sql4 = "DELETE FROM cart WHERE username=?";
	Class.forName(dbDriver);
	Connection con4 = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps4 = con4.prepareStatement(sql4);	
	ps4.setString(1, username);
 	ps4.executeUpdate();
        con4.close();
        
        user.setVirtualBalance(newBalance);       
        FileOutputStream fileOut = new FileOutputStream(file);
        ObjectOutputStream objectOut = new ObjectOutputStream(fileOut);
        objectOut.writeObject(user);
        objectOut.close();
        
 
    }else{
        PrintWriter out1 = response.getWriter();
        out1.println("<script type=\"text/javascript\">");
        out1.println("alert('Insufficient Balance');");
        out1.println("location='cart.jsp';");
        out1.println("</script>");
    }
    
 
   
	
%>


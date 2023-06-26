<%-- 
    Document   : saveProductData.jsp
    Created on : Sep 9, 2022, 4:20:58 PM
    Author     : Kornell
--%>

<%@page import="java.io.PrintWriter"%>
<%@page import="java.io.InputStream"%>
<%@ page import="java.sql.*" %>


<%
	int edit_id = Integer.parseInt(request.getParameter("edit_id"));
	
	String pr_name = request.getParameter("pr_name");
	String manufacturer = request.getParameter("manufacturer");
	double price = Double.parseDouble(request.getParameter("price"));
	int qty_in_stock = Integer.parseInt(request.getParameter("qty_in_stock"));
        String category = request.getParameter("category");
        
        
        
        
        

	final String usernameDB = "root";
        final String passwordDB = "1234";
        final String urlPort = "localhost:3307";
        final String databaseName = "emall";
        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        final String dbDriver = "com.mysql.cj.jdbc.Driver";
	String sql = "UPDATE product SET pr_name=?, manufacturer=?, price=?, qty_in_stock=?, category=? WHERE id=?";
	Class.forName(dbDriver);
	Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps = con.prepareStatement(sql);
	
	ps.setString(1, pr_name);
	ps.setString(2, manufacturer);
	ps.setDouble(3, price);
	ps.setInt(4, qty_in_stock);
        ps.setString(5, category);
	ps.setInt(6, edit_id);	
	ps.executeUpdate();  

     
	
%>


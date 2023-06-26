<%-- 
    Document   : saveCreateProduct.jsp
    Created on : Sep 9, 2022, 7:15:11 PM
    Author     : Kornell
--%>


<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Connection"%>
<%
	
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
	String sql = "INSERT INTO product(pr_name,manufacturer,price,qty_in_stock,category) VALUES(?,?,?,?,?)";
	Class.forName(dbDriver);
	Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps = con.prepareStatement(sql);
	
	ps.setString(1, pr_name);
	ps.setString(2, manufacturer);
	ps.setDouble(3, price);
	ps.setInt(4, qty_in_stock);
        ps.setString(5, category);
	
	
	
	ps.executeUpdate();  
	
%>


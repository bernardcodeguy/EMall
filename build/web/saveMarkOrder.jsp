<%-- 
    Document   : saveMarkOrder.jsp
    Created on : Sep 9, 2022, 7:36:56 PM
    Author     : Kornell
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
	int order_id = Integer.parseInt(request.getParameter("order_id"));

	final String usernameDB = "root";
        final String passwordDB = "1234";
        final String urlPort = "localhost:3307";
        final String databaseName = "emall";
        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        final String dbDriver = "com.mysql.cj.jdbc.Driver";
	String sql = "INSERT INTO delivey_time(order_id) VALUES(?)";
	Class.forName(dbDriver);
	Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps = con.prepareStatement(sql);

	ps.setInt(1, order_id);
	
	ps.executeUpdate(); 



        String sql1 = "UPDATE orders SET is_delivered=1 WHERE id=?";
	Class.forName(dbDriver);
	Connection con1 = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps1 = con1.prepareStatement(sql1);
	
	ps1.setInt(1, order_id);	
	ps1.executeUpdate(); 
        con1.close();
        
        String sql2 = "UPDATE order_history SET is_delivered=1 WHERE id=?";
	Class.forName(dbDriver);
	Connection con2 = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps2 = con2.prepareStatement(sql2);
	
	ps2.setInt(1, order_id);	
	ps2.executeUpdate();
        con2.close();
	
%>

<%-- 
    Document   : saveDelProduct.jsp
    Created on : Sep 9, 2022, 6:56:19 PM
    Author     : Kornell
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%
	int del_id = Integer.parseInt(request.getParameter("del_id"));

	final String usernameDB = "root";
        final String passwordDB = "1234";
        final String urlPort = "localhost:3307";
        final String databaseName = "emall";
        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        final String dbDriver = "com.mysql.cj.jdbc.Driver";
	String sql = "DELETE FROM product WHERE id=?";
	Class.forName(dbDriver);
	Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps = con.prepareStatement(sql);

	ps.setInt(1, del_id);
	
	ps.executeUpdate(); 
	
%>

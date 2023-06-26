<%-- 
    Document   : saveDelCartData.jsp
    Created on : Sep 7, 2022, 6:10:53 PM
    Author     : Kornell
--%>

<%@ page import="java.sql.*" %>



<%
	String del_id = request.getParameter("del_id");
	
        String [] attribs = del_id.split(" ");
	
	int pr_id = Integer.parseInt(attribs[0]);
        String username = attribs[1];
	
	
        
	final String usernameDB = "root";
        final String passwordDB = "1234";
        final String urlPort = "localhost:3307";
        final String databaseName = "emall";
        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        final String dbDriver = "com.mysql.cj.jdbc.Driver";
        String sql = "DELETE FROM cart WHERE pr_id=? AND username=?";
        Class.forName(dbDriver);
	Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps = con.prepareStatement(sql);

	ps.setInt(1, pr_id);
        ps.setString(2, username);
	
	ps.executeUpdate();

%>



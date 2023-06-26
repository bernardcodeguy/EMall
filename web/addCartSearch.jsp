<%-- 
    Document   : addCartSearch
    Created on : Sep 9, 2022, 12:33:59 PM
    Author     : Kornell
--%>

<%@ page import="java.sql.*" %>


<%
	int pr_id = Integer.parseInt(request.getParameter("pr_id"));
	String pr_name = request.getParameter("pr_name");
	String manufacturer = request.getParameter("manufacturer");
        String username = request.getParameter("username");
        double price = Double.parseDouble(request.getParameter("price"));
        int pag = Integer.parseInt(request.getParameter("page"));       
	
	
	
	final String usernameDB = "root";
        final String passwordDB = "1234";
        final String urlPort = "localhost:3307";
        final String databaseName = "emall";
        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        final String dbDriver = "com.mysql.cj.jdbc.Driver";
        String sql = "INSERT INTO cart(pr_id,pr_name,manufacturer,price,username) SELECT * FROM (SELECT ? AS pr_id, ? AS pr_name, ? AS manufacturer, ? AS price,? AS username) AS new_value WHERE NOT EXISTS (SELECT pr_id FROM cart WHERE pr_id = ?) LIMIT 1;";
        Class.forName(dbDriver);
	Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
	PreparedStatement ps = con.prepareStatement(sql);
        
	ps.setInt(1, pr_id);
	ps.setString(2, pr_name);
        ps.setString(3, manufacturer);
        ps.setDouble(4, price);
        ps.setString(5, username);
        ps.setInt(6, pr_id);
        
 	ps.executeUpdate();

        
        response.sendRedirect("search.jsp?page="+pag);
        
       
%>

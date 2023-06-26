<%-- 
    Document   : updateImg.jsp
    Created on : Sep 9, 2022, 5:22:10 PM
    Author     : Kornell
--%>

<%@ page import="java.sql.*" %>

<%!
	int id;
	
        Blob img;
	
%>


<% 
	if(request.getParameterMap().containsKey("id"))
	{
	     
	    id = Integer.parseInt(request.getParameter("id")); 
	    
            final String usernameDB = "root";
            final String passwordDB = "1234";
            final String urlPort = "localhost:3307";
            final String databaseName = "emall";
            final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
            final String dbDriver = "com.mysql.cj.jdbc.Driver";
            String sql = "SELECT img FROM product WHERE id="+id;
            Class.forName(dbDriver);
            Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            rs.next();

            
            img = rs.getBlob("img");
	}
        

        
%>



<% if(img == null){ %>
<div class="con" style="width:300px; height:300px; margin-left:200px;">
        <a href="#" class="" id=""><img src="cover.png" alt="image not found" class="responsive-img circle" id="dp"></a>
</div>
<% }else{ %>
    <div class="con" style="width:300px; height:300px; margin-left:200px;">
        <a href="#" class="" id=""><img src="productimage?id=<%=id%>" alt="image not found" class="responsive-img circle" id="dp"></a>
</div>
<% } %>

     
        
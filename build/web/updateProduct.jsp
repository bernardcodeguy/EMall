<%-- 
    Document   : updateProduct.jsp
    Created on : Sep 9, 2022, 3:42:30 PM
    Author     : Kornell
--%>

<%@ page import="java.sql.*" %>

<%!
	int edit_id;
	String pr_name = "";
	String manufacturer = "";
	double price;
        String qty_in_stock = "";
        String category = "";
        Blob img;
	
%>


<% 
	if(request.getParameterMap().containsKey("edit_id"))
	{
	     
	    edit_id = Integer.parseInt(request.getParameter("edit_id")); 
	    
            final String usernameDB = "root";
            final String passwordDB = "1234";
            final String urlPort = "localhost:3307";
            final String databaseName = "emall";
            final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
            final String dbDriver = "com.mysql.cj.jdbc.Driver";
            String sql = "SELECT * FROM product WHERE id="+edit_id;
            Class.forName(dbDriver);
            Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);

            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(sql);
            rs.next();

            pr_name = rs.getString("pr_name");
            manufacturer = rs.getString("manufacturer");
            price = rs.getDouble("price");
            qty_in_stock = rs.getString("qty_in_stock");
            category = rs.getString("category");
            img = rs.getBlob("img");
	}
        

        
%>

<div class="col s12">
    <div class=input-field>		
            <input type="hidden" id="edit_id" name="edit_id" value="<%=edit_id%>">
    </div>
</div>

<% if(img == null){ %>
<div class="con" style="width:100px; height:100px; margin-left:300px;">
        <img src="cover.png" alt="image not found" class="responsive-img circle" id="dp">
</div>
<% }else{ %>
    <div class="con" style="width:100px; height:100px; margin-left:300px;">
        <img src="productimage?id=<%=edit_id%>" alt="image not found" class="responsive-img circle" >
</div>
<% } %>

<div class="col s12 m6 l6">
          <div class=input-field>
                  <label>Product Name</label><br>
                  <input type="text" id="pr_name" name="pr_name" value="<%= pr_name%>" required>
          </div>
      </div>
		
	<div class="col s12 m6 l6">
		<div class=input-field>
			<label>Manufacturer</label><br>
			<input type="text" id="manufacturer" name="manufacturer" value="<%= manufacturer%>" required>
			
		</div>
	</div>
	
	<div class="col s12 m6 l6">
		<div class=input-field>
			<label>Price (£)</label><br>
                        <input type="text" id="price" name="price" value="<%= price%>0" required>
		</div>
	</div>
		
	<div class="col s12 m6 l6">
		<div class=input-field>
			<label>Quantity In Stock</label><br>
			<input type="text" id="qty_in_stock" name="qty_in_stock" value="<%=qty_in_stock %>" required>
			
		</div>
	</div>
              
        <div class="col s12">
		<div class=input-field>
			<label>Category</label><br>
                        <input type="text" id="category" name="category" value="<%=category %>" required>
			
		</div>
	</div>
                        
        
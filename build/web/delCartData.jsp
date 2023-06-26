<%-- 
    Document   : delCartData.jsp
    Created on : Sep 7, 2022, 6:07:53 PM
    Author     : Kornell
--%>

<%@ page import="java.sql.*" %>

<%!
	String del_id = "";
	
%>


<% 
	if(request.getParameterMap().containsKey("del_id"))
	{	     
		del_id = request.getParameter("del_id"); 
		
	}


%>

	<input type="hidden" name="del_id" id="del_id"  value= "<%=del_id%>" />
                        
     <p>Are you sure you want to remove the item from cart?</p> 

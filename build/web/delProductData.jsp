<%-- 
    Document   : delProductData
    Created on : Sep 9, 2022, 6:52:51 PM
    Author     : Kornell
--%>


<%!
	int del_id = 0;
	
%>


<% 
	if(request.getParameterMap().containsKey("del_id"))
	{
	     
		del_id = Integer.parseInt(request.getParameter("del_id")); 

	}

	

%>

 <input type="hidden" name="del_id" id="del_id"  value= "<%=del_id%>" />
                        
 <p>Are you sure you want to delete this product?</p> 

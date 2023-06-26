<%-- 
    Document   : markOrderData.jsp
    Created on : Sep 9, 2022, 7:30:50 PM
    Author     : Kornell
--%>

<%!
	int order_id = 0;
	
%>


<% 
	if(request.getParameterMap().containsKey("order_id"))
	{
	     
		order_id = Integer.parseInt(request.getParameter("order_id")); 

	}

	

%>

 <input type="hidden" name="order_id" id="order_id"  value= "<%=order_id%>" />
                        
 <p>Are you sure you want to mark this order as delivered?</p>

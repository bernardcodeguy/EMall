<%-- 
    Document   : adminindex
    Created on : Sep 8, 2022, 4:43:08 PM
    Author     : Kornell
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! 
    String title = "Admin Panel";
%>

<%@ include file="header.jsp" %>



<div class="container" id="reg-container"> 
		 <div class="card grey lighten-4">
		       <div class="card-content">	       
		       	<div class="row center-align">
		       		<div class="col s12">
		       			<span class="card-title teal-text text-lighten-2">Admin Confirmation</span>
		       		</div>
		       	</div>	
		       		       	
		       	<form action="admin" method="post">
		       	<div class="row center-align">

		       			<div class="col s12">
		       				<div class=input-field>
		       					<i class="material-icons prefix">https</i>
		       					<input type="password" id="key" class="validate" name="key" data-length="10" required>
		       					<label for="key" data-error="max-length exceeded" data-success="" class="active">Admin Pin</label>
		       				</div>
		       			</div>
		       		
		       			<div class="col s12">
		       				<div class=input-field>	       					
		       					<input type="submit" class="btn blue lighten-1" value="Confirm">		       					
		       				</div>
		       			</div>
		       	</div>
		       			       	
		     </form>
		     
		     	<div class="row center-align">
		     		<p>Back to <a href="index.jsp">homepage</a></p>
		     	</div>
		     
		         	       	         
		       </div>
		     
		</div>	 
	 
	 </div>

<%@ include file="mid.jsp" %>

<script>
	
	$(document).ready(function(){
		M.updateTextFields();
	})
        

</script>


<%@ include file="footer.jsp" %>
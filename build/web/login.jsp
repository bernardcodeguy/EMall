<%-- 
    Document   : allogin
    Created on : Sep 3, 2022, 2:49:28 PM
    Author     : Kornell
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%! 
    String title = "Log In";
    String username = "";
%>

<%@ include file="header.jsp" %>

<div class="container" id="reg-container"> 
		 <div class="card grey lighten-4">
		       <div class="card-content">	       
		       	<div class="row center-align">
		       		<div class="col s12">
		       			<span class="card-title teal-text text-lighten-2">Log In</span>
		       		</div>
		       	</div>	
		       		       	
		       	<form action="login" method="post">
		       	<div class="row center-align">

		       			 <!-- Username -->
		       			
		       			<div class="col s12">
		       				<div class=input-field>
		       					<i class="material-icons prefix">person</i>
		       					<input type="text" id="username" class="validate" name="username" >
		       					<label for="username" class="active">Username</label>
		       				</div>
		       			</div>
		       			
		       			<!-- Password -->
		       			
		       			<div class="col s12">
		       				<div class=input-field>
		       					<i class="material-icons prefix">https</i>
		       					<input type="password" id="password" class="validate" name="password"  required>
		       					<label for="password" class="active">Password</label>
		       				</div>
		       			</div>
		       				       			
		       			
		       			<div class="col s12">
		       				<div class=input-field>	       					
		       					<input type="submit" class="btn blue lighten-1" value="Log in">		       					
		       				</div>
		       			</div>
		       	</div>
		       			       	
		     </form>
		     
		     	<div class="row center-align">
		     	
		     		<p>Not a member yet? Signup <a href="signup.jsp">here</a></p>
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
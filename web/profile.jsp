<%-- 
    Document   : profile
    Created on : Sep 9, 2022, 1:53:26 PM
    Author     : Kornell
--%>
<%@page import="java.io.ObjectInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.webapp.User"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! 
    String title = "Profile";
    String username = "";
    File file = null;
     User user = null;
     String currencyForm = "";
%>

<%@ include file="header.jsp" %>

<% 
    
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    
    if(session.getAttribute("username") == null){
        
        response.sendRedirect("index.jsp");
            
    }else{
        
        username = String.valueOf(session.getAttribute("username"));
        
        file = new File(username+".obj");
        
    
        FileInputStream fileIn = new FileInputStream(file);
        ObjectInputStream objectIn = new ObjectInputStream(fileIn);
        Object obj = objectIn.readObject();               
        user = (User) obj;
        objectIn.close();
        
        
	
	currencyForm = String.format("£ %,.2f", user.getVirtualBalance());
    }

%>


<header>
   
            
            
    <!-- Cart count queries -->
    <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/emall" user="root" password="1234"/>
    <sql:query var="rsc" dataSource="${db}">
    SELECT * FROM cart WHERE username=?
    <sql:param value = "${username}" />
    </sql:query>
    
    <!-- Cart count queries -->
    <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/emall" user="root" password="1234"/>
    <sql:query var="rsco" dataSource="${db}">
    SELECT * FROM order_history WHERE username=?
    <sql:param value = "${username}" />
    </sql:query>
    
     <!-- Cart count queries -->
    <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/emall" user="root" password="1234"/>
    <sql:query var="rscoo" dataSource="${db}">
    SELECT * FROM order_history WHERE username=? AND is_delivered < 1
    <sql:param value = "${username}" />
    </sql:query>
    
    <!-- Cart count queries -->
    <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/emall" user="root" password="1234"/>
    <sql:query var="rscooo" dataSource="${db}">
    SELECT * FROM order_history WHERE username=? AND is_delivered > 0
    <sql:param value = "${username}" />
    </sql:query>
    
    <!-- Navigation Bar -->	
	<div class="navbar">
 	<nav>
        <div class="nav-wrapper blue lighten-1">
        	<div class="container">
        	<a href="home.jsp?page=1" class="brand-logo">eMall</a>
            <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
            <ul class="right hide-on-med-and-down">
                <li><a href="home.jsp?page=1"><i class="material-icons left">home</i>Home</a></li>
                <li><a href="search.jsp?page=1"><i class="material-icons left">search</i>Search</a></li>
                <li><a href="order.jsp"><i class="material-icons left">history</i>Orders</a></li>                
                <li>
                    <a href="cart.jsp"><i class="material-icons left">shopping_cart</i>Cart
                        <print:choose>
                            <print:when test="${rsc.rowCount < 1}">
                                
                            </print:when>
                            <print:otherwise>
                                <span class="new badge grey">
                            <print:out value="${rsc.rowCount}"></print:out>
                                 </span>
                            </print:otherwise>                          
                        </print:choose>
                        
                    </a>
                </li>
                <li><a href="profile.jsp"><i class="material-icons left">person</i>Profile</a></li>
                <li><a href="logout"><i class="material-icons left">logout</i> Log out</a></li>
            </ul>
            <ul class="side-nav" id="mobile-demo">
                <li><a href="home.jsp?page=1">Home</a></li>
                <li><a href="search.jsp?page=1">Search</a></li>
                <li><a href="order.jsp">Orders</a></li>                
                <li>
                    <a href="cart.jsp">Cart
                        <print:choose>
                            <print:when test="${rsc.rowCount < 1}">                                
                            </print:when>
                            <print:otherwise>
                                <span class="new badge grey">
                            <print:out value="${rsc.rowCount}"></print:out>
                                 </span>
                            </print:otherwise>                          
                        </print:choose>
                    </a>
                </li>
                <li><a href="profile.jsp">Profile</a></li>
                <li><a href="logout">Log out</a></li>
            </ul>
        	
        	</div>
            
        </div>
    </nav>
     
    </div>  
    
</header>
<main>
    
  <div class="container">
            
            
            
            
		
		
		<div class="row " style="margin-top: 50px;">
			<div class="col s12">
			
				<div class="card-panel ">
					<div class="row">
                                        <div class="col s6">
                                        
                                                
                                        <div class="con" style="width:100px; height:100px">
                                                <a href="#" class="" id="upload-img"><img src="avi.png" alt="image not found" class="responsive-img circle" id="dp"></a>
                                        </div>


                                        </div>
                                        <div class="col s6" style="margin-top:10px;">
                                                <p style="font-weight:bold;font-size:1.3em">
                                                    <%= user.getFname() %> <%= user.getLname() %><br>
                                                <span style="font-weight:normal; font-size:0.7em">
                                                    <% if(user.getGender().equals("M")){ %>
                                                        
                                                        <print:out value="Male"></print:out><br> 
                                                    
                                                    <%}else if(user.getGender().equals("F")){ %>
                                                        <print:out value="Female"></print:out><br>
                                                    <%}else{%>
                                                        <print:out value="Other"></print:out><br>
                                                    <%}%>
                                                    
                                                </span>
                                                </p>									
                                        </div>
                                </div>
                                <br>
                                <br>
                                <hr>


                                <div class="row">
                                        <div class="col s4" style="font-weight:bold">
                                                Email Address:					
                                        </div>
                                        <div class="col s8">		
                                                <%= user.getEmail() %> <br>				
                                        </div>

                                </div>
                                <hr>
                                <div class="row">
                                        <div class="col s4" style="font-weight:bold">
                                                Username:					
                                        </div>
                                        <div class="col s8">		
                                                <%= user.getUsername() %> <br>				
                                        </div>

                                </div>
                                  <hr>
                                
                                <div class="row">
                                        <div class="col s4" style="font-weight:bold">
                                                Gender:					
                                        </div>
                                        <div class="col s8" >			
                                               <% if(user.getGender().equals("M")){ %>
                                                        
                                                    <print:out value="Male"></print:out><br> 

                                                <%}else if(user.getGender().equals("F")){ %>
                                                    <print:out value="Female"></print:out><br>
                                                <%}else{%>
                                                    <print:out value="Other"></print:out><br>
                                                <%}%> 				
                                        </div>
                                     <hr>
                                </div>
                                 <div class="row">
                                        <div class="col s4" style="font-weight:bold">
                                                Total Orders:					
                                        </div>
                                        <div class="col s8" >			
                                               
                                            <print:out value="${rsco.rowCount}"></print:out><br>
                                                				
                                        </div>
                                     <hr>
                                </div>
                                <div class="row">
                                        <div class="col s4" style="font-weight:bold">
                                                Pending Orders:					
                                        </div>
                                        <div class="col s8" >			
                                               
                                            <print:out value="${rscoo.rowCount}"></print:out><br>
                                                				
                                        </div>
                                     <hr>
                                </div>
                                 <div class="row">
                                        <div class="col s4" style="font-weight:bold">
                                                Delivered Orders:					
                                        </div>
                                        <div class="col s8" >			
                                               
                                            <print:out value="${rscooo.rowCount}"></print:out><br>
                                                				
                                        </div>
                                     <hr>
                                </div>
                                   <div class="row">
                                        <div class="col s4" style="font-weight:bold">
                                                Virtual Bank Balance:					
                                        </div>
                                        <div class="col s8" >			
                                               
                                            <%= currencyForm %> <br>
                                                				
                                        </div>
                                     <hr>
                                </div>
                        </div>

                </div>
                 
                 
			
	  </div>

	</div>  
  
</main>
<footer class="page-footer blue lighten-1">
          <div class="container">
            <div class="row">
              <div class="col l6 s12">
                <h5 class="white-text">eMall</h5>
                <p class="grey-text text-lighten-4">Online Shopping Mall</p>
              </div>
              <div class="col l4 offset-l2 s12">
                <h5 class="white-text">Contact Us</h5>
                <ul>
                  <li><a class="grey-text text-lighten-3" href="#!">kornell@gmail.com</a></li>
                  <li><a class="grey-text text-lighten-3" href="#!">+4478394847</a></li>
                  
                </ul>
              </div>
            </div>
          </div>
          <div class="footer-copyright">
            <div class="container">
            © 2022 Copyright Text
            <a class="grey-text text-lighten-4 right" href="#">More Links</a>
            </div>
          </div>
        </footer>

                                                        



<%@ include file="mid.jsp" %>

<script>
            $(document).ready(function(){
                $(".button-collapse").sideNav();
                
                   
            });
                    
</script>


<%@ include file="footer.jsp" %>




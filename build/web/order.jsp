<%-- 
    Document   : order.jsp
    Created on : Sep 8, 2022, 3:13:51 PM
    Author     : Kornell
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%! 
    String title = "Orders";
    String username = "";
    
%>

<%@ include file="header.jsp" %>

<% 
    
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    
    if(session.getAttribute("username") == null){
        
        response.sendRedirect("index.jsp");
            
    }else{
        
        username = String.valueOf(session.getAttribute("username"));
    }
    
    

%>

<header>
    
            
    
            
       <!-- Cart count queries -->
            <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/emall" user="root" password="1234"/>
	    <sql:query var="rsc" dataSource="${db}">
	    SELECT * FROM cart WHERE username=?
            <sql:param value = "${username}" />
	    </sql:query>   
    
    
  
            
    <!-- Order  queries -->
            <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/emall" user="root" password="1234"/>
	    <sql:query var="rsch" dataSource="${db}">
	    SELECT * FROM order_history WHERE username=? ORDER BY time_order DESC
            <sql:param value = "${username}" />
	    </sql:query> 
    
    
    
            
    
  <!-- Navigation Bar -->	
	<div class="navbar">
 	<nav>
        <div class="nav-wrapper blue lighten-1">
        	<div class="container">
        	<a href=""home.jsp?page=1" class="brand-logo">eMall</a>
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
                <li><a href="home.jsp">Categories</a></li>
                <li><a href="search.jsp?page=1">Search</a></li>             
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
 
    
    <div class="container" style="">
        
        <ul class="collapsible" style="height: 70vh;overflow-y: auto; scrollbar-width: auto;" onmouseover="this.style.overflow='auto'" onmouseout="this.style.overflow='hidden'">
            <li class="">
              <div class="collapsible-header active"><i class="material-icons">history</i>Order History</div>
              <div class="collapsible-body">
                  <print:choose>
                      <print:when test="${rsch.rowCount < 1}">
                            
                            <span>No recent order yet</span>
                          
                      </print:when>
                      <print:otherwise>
                          <ul class="collection">
                            <print:forEach items="${rsch.rows}" var="orderh">   
                              <li class="collection-item avatar black-text ">
                                  <!-- Order  queries -->
                                <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/emall" user="root" password="1234"/>
                                <sql:query var="rscimg" dataSource="${db}">
                                SELECT img FROM product WHERE id=?
                                <sql:param value = "${orderh.pr_id}" />
                                </sql:query>
                                
                                <print:choose>
                                    <print:when test="${rscimg.rowCount < 1}">
                                        <img src="cover.png" alt="" class="circle">
                                        
                                    </print:when>
                                    <print:otherwise>
                                        
                                            <img src="productimage?id=<print:out value="${orderh.pr_id}"></print:out>" alt="" class="circle">
                                            
                                        
                                    </print:otherwise>
                                </print:choose>
                                <span class="title">${orderh.pr_name}</span>
                                <p> ${orderh.manufacturer} (Manufacturer)<br>
                                    £${orderh.price}0 (Price)<br>
                                </p>
                                <p style="font-style: italic; font-size: 12px;"> 
                                   <print:set var="dateParts" value="${fx:split(orderh.time_order, '-')}" />   
                                    <print:set var="year" value="${dateParts[0]}" />
                                    <print:set var="month" value="${dateParts[1]}" />
                                    <print:set var="day" value="${dateParts[2]}" />

                                    <print:set var="dateParts2" value="${fx:split(day, 'T')}" />
                                    <print:set var="day1" value="${dateParts2[0]}" />
                                    <print:set var="time" value="${dateParts2[1]}" />
                                   <span style="font-style: italic; font-size: 12px;">Ordered on:</span>
                                   ${day1}/${month}/${year} @ ${time}
                                </p>
                                <print:choose>
                                    <print:when test="${orderh.is_delivered < 1}">
                                        
                                        <p class="red-text" style="font-style: italic; font-size: 12px;">  
                                            Pending Delivery
                                         </p>
                                    </print:when>
                                    <print:otherwise>
                                        <p class="green-text" style="font-style: italic; font-size: 12px;">  
                                            Delivered
                                            <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/emall" user="root" password="1234"/>
                                            <sql:query var="rscdate" dataSource="${db}">
                                            SELECT * FROM delivey_time WHERE order_id=?
                                            <sql:param value = "${orderh.id}" />
                                            </sql:query>
                                            <print:forEach items="${rscdate.rows}" var="orderdate">
                                                <print:set var="dateParts" value="${fx:split(orderdate.time_delivered, '-')}" />   
                                                <print:set var="year" value="${dateParts[0]}" />
                                                <print:set var="month" value="${dateParts[1]}" />
                                                <print:set var="day" value="${dateParts[2]}" />
                                                
                                                <print:set var="dateParts2" value="${fx:split(day, 'T')}" />
                                                <print:set var="day1" value="${dateParts2[0]}" />
                                                <print:set var="time" value="${dateParts2[1]}" />
                                                
                                            <span style="font-style: italic; font-size: 12px;"> on: ${day1}/${month}/${year} @ ${time}</span>
                                            </print:forEach>
                                         </p>
                                    </print:otherwise>
                                    
                                </print:choose>
                                
                                
                              </li>
                          </print:forEach>

                        </ul>
                          
                      </print:otherwise>      
                      
                      
                  </print:choose>
              </div>
            </li>
        </ul>
        
                
        
        
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
            
                $('.collapsible').collapsible();
              

//             $(document).on('click', '.download-btn', function(){
//                 
//                    var id = $(this).attr('id');
//
//                       $(".download-btn").attr("href", "order.mp3");
//                       $(".download-btn").attr("download");
//
//                        
//
//                        $.ajax({
//                        url: "deliverOrder.jsp",
//                        type: "POST",
//                        data:{id:id},
//                        success:function(data){   
//                            
//                            window.location.reload(true);
//                            
//                        }
//                    }); 
//            });


        });
        
                    
</script>

<%@ include file="footer.jsp" %>


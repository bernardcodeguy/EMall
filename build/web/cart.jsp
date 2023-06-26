<%-- 
    Document   : cart
    Created on : Sep 7, 2022, 5:49:55 PM
    Author     : Kornell
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@page import="com.webapp.Cart"%>
<%@page import="com.webapp.CartDao"%>

<%! 
    String title = "Cart";
    String username = "";
    List<Cart> list;
    
    Map<Integer,Integer> check;
    
    int counting;
%>

<%@ include file="header.jsp" %>

<% 
    
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    
    if(session.getAttribute("username") == null){
        
        response.sendRedirect("index.jsp");
            
    }else{
        
        username = String.valueOf(session.getAttribute("username"));
         
    }
    
    list=CartDao.getRecords(username);
    
    check= new HashMap<>();
%>



<header>
   
 
    
    <!-- Cart count queries -->
            <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/emall" user="root" password="1234"/>
	    <sql:query var="rsc" dataSource="${db}">
	    SELECT * FROM cart WHERE username=?
            <sql:param value = "${username}" />
	    </sql:query>
            
    
    <!-- Cart sum queries -->
            <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/emall" user="root" password="1234"/>
	    <sql:query var="rscsum" dataSource="${db}">
	    SELECT SUM(price) AS summ FROM cart WHERE username=?
            <sql:param value = "${username}" />
	    </sql:query>
            
         <print:forEach items="${rscsum.rows}" var="sum"> 
        <print:set var = "sum" scope = "session" value = "${sum.summ}"/>      
        </print:forEach>
            
            
    
  <!-- Navigation Bar -->	
	<div class="navbar">
 	<nav>
        <div class="nav-wrapper blue lighten-1">
        	<div class="container">
        	<a href="home.jsp" class="brand-logo">eMall</a>
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
        
        <div class="row">           
                <% if(list.isEmpty()){ %>
                        <div class="col s12">                       
                        <div class="card">
                        <div class="card-content ">
                          <span class="card-title center-align">Cart Empty!</span>                                        
                        </div>
                      </div>
                <% }else{ %>        
                  
                     <div class="col s12 m12 l8">
                     <% counting = 1; %>
                     <%  for(Cart c:list){  %>
                        
                        <div class="card">
                          <div class="card-content ">
                            <span class="card-title">Cart (<%= counting%>)</span>
                                 
                                <p class="center-align"><span style="font-weight: bold;">Product Name:</span> <%= c.getPr_name() %></p>
                                <p class="center-align"><span style="font-weight: bold;">Manufacturer:</span> <%= c.getManufacturer() %></p>
                                <p class="center-align"><span style="font-weight: bold;">Price: £</span> <%= c.getPrice() %>0</p>
                                
                                
                                <%                                   
                                    final String usernameDB = "root";
                                    final String passwordDB = "1234";
                                    final String urlPort = "localhost:3307";
                                    final String databaseName = "emall";
                                    final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
                                    final String dbDriver = "com.mysql.cj.jdbc.Driver";
                                    String sql = "SELECT qty_in_stock FROM product WHERE id=?";
                                    Class.forName(dbDriver);
                                    Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
                                    PreparedStatement ps = con.prepareStatement(sql);

                                    ps.setInt(1, c.getPr_id());
                                    
                                    ResultSet rs=ps.executeQuery();
                                    
                                    rs.next();
                                    
                                    check.put(c.getPr_id(), rs.getInt("qty_in_stock"));
                                    
                                    session.setAttribute("check",check);
                                %>
                                
<!--                                <p class="center-align"><span style="font-weight: bold;">In Stock:</span> <%= check.get(c.getPr_id()) %></p>-->
                          </div>
                          <div class="card-action">
                            <a href="#" class="btn red del-music" id="<%= c.getPr_id() %>">Delete</a>
                          </div>
                        </div>
                       <% counting = counting+1; %>
                       
                       <% session.setAttribute("list",list); %>
                      <% } %>
                      </div>
                      <div class="col s12 m12 l4">

                          <div class="card-panel center-align">
                              <p class="card-title" style="font-weight: bold;">Cart Summary</p>
                              <p class="" style="font-weight: bold";>Subtotal <span class="center-align" style="font-weight: normal"><fmt:formatNumber value="${sum}" type="currency" currencySymbol="£"></fmt:formatNumber></span></p>                                
                              <a href="#" class="btn pay blue lighten-1" id="${sum}">CHECKOUT(<fmt:formatNumber value="${sum}" type="currency" currencySymbol="£"></fmt:formatNumber>)</a>
                          </div>
                      </div>
                     
                <% } %>
            
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
                $('#modal1').modal({
		      dismissible: false, // Modal cannot be closed by clicking anywhere outside
		    });
                $('#modal3').modal({
		      dismissible: false, // Modal cannot be closed by clicking anywhere outside
		    });
                
                $(document).on('click', '.del-music', function(){
				
                    var del_id = $(this).attr('id')+" "+'<%= username%>';
                    
                    //alert(del_id);
                    
                    $.ajax({

                      url: "delCartData.jsp",
                      type: "POST",
                      data:{del_id:del_id},
                      success:function(data){
                           $("#del-creds").html(data);
                           $('#modal3').modal('open');
                      }


                    }); 
                          
				
                });
                
                $(document).on('click', '#del', function(){
        	

                        $.ajax({

                            url: "saveDelCartData.jsp",
                            type: "POST",
                            data:$("#del-edu_form").serialize(),
                            success:function(data){
                                $('#modal3').modal('close');
                                window.location.reload(true); 
                            }
                       }); 


                });
                
                $(document).on('click', '.pay', function(){
                    
                    var total = $(this).attr('id');
                     
                     
                    $.ajax({

                      url: "orderData.jsp",
                      type: "POST",
                      data:{total:total},
                      success:function(data){                          
                           $("#pay-creds").html(data);
                           $('#modal1').modal('open');
                      }
                   });
                     
                });
                
                $(document).on('click', '#buy', function(){
                        $.ajax({

                            url: "saveOrderData.jsp",
                            type: "POST",
                            data:$("#order_form").serialize(),
                            success:function(data){                               
                                $('#modal1').modal('close');
                                //alert(data);
                               window.location.reload(true); 
                            }
                       }); 
                });
                
                
                   
            });
                    
</script>







<%@ include file="footer.jsp" %>


<!-- Modal for Deleting Employee Education Credentials-->
    <div id="modal3" class="modal modal-fixed-footer" style="width: 30%; height:20%">
          <form method="POST" id="del-edu_form" action="#">
      <div class="modal-content" >
        <h4 class="center-align">Confirmation</h4>

          <div class="row center-align" id="del-creds">

          </div>

      </div>
      <div class="modal-footer">
        <a href="#" class="modal-close waves-effect waves-light btn-flat teal white-text">No</a>
        <a href="#" class="waves-effect waves-light btn-flat red white-text" id="del" id="del">Yes</a>
      </div>
      </form>
</div> 



<!-- Payment Modal-->
    <div id="modal1" class="modal modal-fixed-footer" style="width: 30%; height:40%">
          <form method="POST" id="order_form" action="#">
      <div class="modal-content" >
        <h4 class="center-align">Confirm Purchase</h4>

          <div class="row center-align" id="pay-creds">

          </div>

      </div>
      <div class="modal-footer">
        <a href="#" class="modal-close waves-effect waves-light btn-flat red white-text">Decline</a>
        <a href="#" class="waves-effect waves-light btn-flat  teal white-text" id="buy" >Buy</a>
      </div>
      </form>
</div>






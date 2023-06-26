<%-- 
    Document   : search
    Created on : Sep 8, 2022, 4:21:18 PM
    Author     : Kornell
--%>

<%@page import="com.webapp.ProductDao"%>
<%@page import="java.util.List"%>
<%@page import="com.webapp.Product"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%! 
    String title = "Search Product";
    String username = "";
    
    String keyword = "";
    int pageid;
    int total;
    List<Product> list;
    int count;
    int pages;
    
    int pageNumber;
%>

<%@ include file="header.jsp" %>

<% 
    
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    
    if(session.getAttribute("username") == null){
        
        
            
    }
        
        
        
        
        keyword = request.getParameter("keyword");
        pageContext.setAttribute("keyword", keyword);
        
        
        pageid = Integer.parseInt(request.getParameter("page"));  
        
        pageNumber = Integer.parseInt(request.getParameter("page"));  
        
        total=8;
        
        if(pageid==1){
        }else{  
            pageid=pageid-1;  
            pageid=pageid*total+1;  
        } 

        list=ProductDao.getRecordSearch(pageid,total,keyword);
    

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
	    SELECT * FROM order_history WHERE username=?
            <sql:param value = "${username}" />
	    </sql:query> 
    
    
    
            
    
 <% if(session.getAttribute("username") == null){ %>
        
        <!-- Navigation Bar -->	
	<div class="navbar">
 	<nav>
        <div class="nav-wrapper blue lighten-1">
        	<div class="container">
        	<a href=""home.jsp?page=1" class="brand-logo">eMall</a>
            <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
            <ul class="right hide-on-med-and-down">
                <li><a href="home.jsp?page=1"><i class="material-icons left">home</i>Home</a></li>
                <li><a href="login.jsp"><i class="material-icons left">login</i>Log In</a></li>
                <li><a href="signup.jsp"><i class="material-icons left">supervisor_account</i>Sign Up</a></li>
                <li><a href="adminindex.jsp"><i class="material-icons left">dashboard</i>Admin Panel</a></li>
                              
                
            </ul>
            <ul class="side-nav" id="mobile-demo">
                <li><a href="home.jsp?page=1">Home</a></li>
                <li><a href="login.jsp">Log In</a></li>
                <li><a href="signup.jsp">Sign Up</a></li>
                <li><a href="adminindex.jsp">Admin Panel</a></li>
                
            </ul>
        	
        	</div>
            
        </div>
    </nav>
     
    </div>
    
    <%}else{%>
    
    
    
    
            
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
  <%}%>  
    
</header>

<main>
    
            
   <div class="page-body" style="height: 80vh;">
    
    
    
    <div class="container" style="margin-top:20px;">
        <nav class="blue lighten-1">
        <div class="nav-wrapper">
            <form class="white-text" method="post" action="search.jsp?page=1">
            <div class="input-field">
              <input id="search" type="search" placeholder="Search music by artist or title" name="keyword" required>
              <label class="label-icon" for="search"><i class="material-icons">search</i></label>
              <i class="material-icons">close</i>
            </div>
          </form>
        </div>
      </nav>
    </div>
       
    <div class="container" >       
        <div class="row">
            <%  for(Product p:list){  %>
            
                <div class="col s6 m6 l3">                
                    <div class="card grey lighten-4">
                       <div class="card-image">
                           <% if(p.getImg() == null){ %>
                                <img src="cover.png" width="200" height="200">
                           <% }else{ %>
                                <img src="productimage?id=<%=p.getId()%>" width="200" height="200">
                           <% } %>
                       </div>
                       <div class="card-content">
                           <p><span style="font-weight: bold">Product Name: </span> <%= p.getPr_name() %></p>
                           <p><span style="font-weight: bold">Manufacturer: </span> <%= p.getManufacturer() %></p>
                           <p><span style="font-weight: bold">Price: £</span>  <%= p.getPrice() %>0</p>
                           <p><span style="font-weight: bold">Category: </span>  <%= p.getCategory() %></p>
                           
                           <% if(p.getQty_in_stock() < 10 && p.getQty_in_stock() > 0 ){%>
                            <p class="red-text"><span class="black-text" style="font-weight: bold">In Stock: </span> <%= p.getQty_in_stock() %> left</p>
                            <% }else if(p.getQty_in_stock() < 1){ %>
                            <p class="red-text"><span class="black-text" style="font-weight: bold"> </span> Out of stock!</p>
                           <% }else{ %>
                            <p class="green-text"><span class="black-text" style="font-weight: bold">In Stock: </span> <%= p.getQty_in_stock() %> left</p>
                           <% } %>
                           
                       </div>
                       <div class="card-action">
                           
                           <form   method="post" action="addCartSearch.jsp">
                               
                            <% if(p.getQty_in_stock() < 1 ){ %>
                            
                            <% }else if(session.getAttribute("username") == null){%>
                            
                            <% }else{%>
                            <input type="hidden" name="pr_id" id="pr_id" value="<%= p.getId() %>" 
                             class="form-control" >
                            <input type="hidden" name="pr_name" id="pr_name" value="<%= p.getPr_name() %>" 
                                 class="form-control" >
                            <input type="hidden" name="manufacturer" id="manufacturer" value="<%= p.getManufacturer() %>" 
                             class="form-control" >
                            <input type="hidden" name="price" id="price" value="<%= p.getPrice() %>" 
                             class="form-control" >
                            <input type="hidden" name="username" id="username" value="<%= username%>" 
                             class="form-control" >
                             <input type="hidden" name="page" id="page" value="<%= pageNumber %>" 
                             class="form-control" >
                            
                            
                            <button type="submit" class="btn blue lighten-1" id="join_meeting"><i class="material-icons">shopping_cart</i>  Add To Cart</button>
                            <% }%>
                        </form>

                       </div>
                     </div>               
                </div> 
            
            <% } %>
                 
            <% if(total >= count){%>
            
            <% }else{ %>
                
                <div class="col s12 center-align">
                 <ul class="pagination">
                 <% if(pageNumber-1 < 1){%>
                 <li class="disabled"><a href="#" ><i class="material-icons">chevron_left</i></a></li>
                 <% }else{ %>
                 <li class="waves-effect" id="1"><a href="home.jsp?page=<%= pageNumber-1%>" ><i class="material-icons">chevron_left</i></a></li>
                 <% } %>
                 
                <% for(int i=1; i<=pages; i++) {%>
                    
                 <li class="waves-effect" id="<%=i%>"><a href="home.jsp?page=<%=i%>" ><%=i%></a></li>   
                
                <% } %>
                
                <% if(pageNumber+1 > pages){%>
                 <li class="disabled"><a href="#"><i class="material-icons">chevron_right</i></a></li>
                 <% }else{ %>
                 <li class="waves-effect"><a href="search.jsp?page=<%= pageNumber+1%>"><i class="material-icons">chevron_right</i></a></li>
                 <% } %>
                 </ul>
               </div>
            
            
            <% } %>
                           
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
                
                
                var pageNo = "<%=pageNumber%>";
                
                
                
                    
                $('#'+pageNo).attr('class','waves-effect  grey lighten-2');
                    
                
                
//                $(document).on('click', '.add-to-cart', function(){
//				
//                    var musicid = $(this).attr('id');
//                    var userid = '${id}';
//                    $.ajax({
//                        url: "addCart.jsp",
//                        type: "POST",
//                        data:{musicid:musicid,userid:userid},
//                        success:function(data){
//                             window.location.reload(true);
//                        }
//
//
//                    }); 
//                          
//				
//                });
                   
            });
                    
</script>


<%@ include file="footer.jsp" %>


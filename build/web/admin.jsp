<%-- 
    Document   : admin
    Created on : Sep 9, 2022, 2:35:51 PM
    Author     : Kornell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%! 
    String title = "Admin Panel";
    String key = "";
    String newUserName = "";
%>

<%@ include file="header.jsp" %>
	
<%	
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		
	if(session.getAttribute("key") == null){
            response.sendRedirect("index.jsp");
	}else{
            
            key = String.valueOf(session.getAttribute("key"));
    }



	final String usernameDB = "root";
        final String passwordDB = "1234";
        final String urlPort = "localhost:3307";
        final String databaseName = "emall";
        final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
        final String dbDriver = "com.mysql.cj.jdbc.Driver";
	String sql = "SELECT SUM(price) FROM order_history WHERE is_delivered > 0";
	Class.forName(dbDriver);
	Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
	Statement ps = con.createStatement();
	ResultSet rs = ps.executeQuery(sql);
	rs.next();
	
	double sum = rs.getDouble(1);
	
	String currencyForm = String.format("£%,.2f", sum);
	
%>




<!-- Navigation Bar -->	
	<div class="navbar">
 	<nav>
        <div class="nav-wrapper blue lighten-1">
        	<div class="container">
        	<a href="admin.jsp" class="brand-logo">eMall</a>
            <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
            <ul class="right hide-on-med-and-down">
                <li><a href="#" class="add-product">Add New Product</a></li>
                <li><a href="adminlogout">Log out</a></li>
            </ul>
            <ul class="side-nav" id="mobile-demo">
                <li><a href="#" class="add-product">Add New Product</a></li>
                <li><a href="adminlogout">Logout</a></li>
            </ul>
        	
        	</div>
            
        </div>
    </nav>
    </div>


<div class="container">
    
      <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/emall" user="root" password="1234"/>
      <sql:query var="rowproduct" dataSource="${db}">
	    SELECT * FROM product  ORDER BY pr_name ASC
      </sql:query>
            
      <sql:query var="roworder" dataSource="${db}">
	    SELECT * FROM order_history
      </sql:query>
            
      <sql:query var="rowpen" dataSource="${db}">
	    SELECT * FROM order_history WHERE is_delivered < 1
      </sql:query>
            
            
            
       <sql:query var="rowcomplete" dataSource="${db}">
	    SELECT * FROM order_history WHERE is_delivered > 0
      </sql:query>
            
      <!-- Order History  queries -->
            <sql:setDataSource var="db" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost:3307/emall" user="root" password="1234"/>
	    <sql:query var="rsch" dataSource="${db}">
	    SELECT * FROM order_history
	    </sql:query> 
        
    <div class="row c-row">
        
         <div class="col s6 m6 l3 c-col">
            <div class="card-panel c-card">
                    <div class="row">
                            <div class="col s12">
                                <p class="center-align" style="font-size:0.9em">No. of Products</p>
                            </div>
                            <div class="col s12">
                                    <h4 class="center-align flow-text" style="font-weight: bold;"><print:out value="${rowproduct.rowCount}"></print:out></h4>
                            </div>
                    </div>   		
            </div> 
        </div>
        <div class="col s6 m6 l3 c-col">
            <div class="card-panel c-card">
                    <div class="row">
                            <div class="col s12">
                                <p class="center-align" style="font-size:0.9em">No. of Orders</p>
                            </div>
                            <div class="col s12">
                                    <h4 class="center-align flow-text" style="font-weight: bold;"><print:out value="${roworder.rowCount}"></print:out></h4>
                            
                                    <p class="center-align" style="font-style: italic; font-size: 12px;">                                   
                                   <span class="red-text" style="font-style: italic; font-size: 12px;">Pending:</span>
                                   (${rowpen.rowCount})
                                    </p>
                                    
                                    <p class="center-align" style="font-style: italic; font-size: 12px;">                                   
                                   <span class="green-text" style="font-style: italic; font-size: 12px;">Delivered:</span>
                                   (${rowcomplete.rowCount})
                                    </p>
                                    
                            </div>
                    </div>   		
            </div> 
        </div>
        <div class="col s6 m6 l3 c-col">
            <div class="card-panel c-card">
                    <div class="row">
                            <div class="col s12">
                                <p class="center-align" style="font-size:0.9em">Sales<br> (Cash)</p>
                            </div>
                            <div class="col s12">
                                    <h4 class="center-align flow-text" style="font-weight: bold;"> <%= currencyForm %></h4>
                            </div>
                    </div>   		
            </div> 
        </div>
        
        
        
    </div>
    <div class="row">
	    <div class="col s12">
	      <ul id="tabs-swipe-demo" class="tabs">
		  <li class="tab col s6"><a class="black-text" href="#test-swipe-2">All Products</a></li>
		  <li class="tab col s6"><a class="black-text" href="#test-swipe-3">All Orders</a></li>		    
		  </ul>
	    </div>
          
            <div id="test-swipe-2" class="col s12" style="height: 50vh;overflow-y: auto; scrollbar-width: auto;" onmouseover="this.style.overflow='auto'" onmouseout="this.style.overflow='hidden'">
	    
	    	<div class="card-panel">
	    		<table class="">
			        <thead>
			          <tr>
			          	  <th>#</th>
			              <th>Product Name</th>
			              <th>Manufacturer</th>
			              <th>Price(£)</th>
			              <th>Quantity In Stock</th>
                                      <th>Category</th>
                                      <th>Sales</th>
                                      <th>Action</th>
			          </tr>
			        </thead>
			        <tbody>
			        
			        	<print:set var="count_product" value="${1}" scope="session"/>								
	      				<print:forEach items="${rowproduct.rows}" var="product" >
	      					<tr>
	      						<td>
	      							<print:out value="${count_product}"></print:out>
	      						</td>
	      						<td>
	      							<print:out value="${product.pr_name} "></print:out>			
	      						</td>
	      						<td>
	      							<print:out value="${product.manufacturer}"></print:out>
	      						</td>
	      						<td>
	      							<print:out value="${product.price}"></print:out>0
	      							
	      						</td>
                                                        <td>
	      							<print:out value="${product.qty_in_stock}"></print:out>
	      							
	      						</td>
                                                        <td>
	      							<print:out value="${product.category}"></print:out>
	      							
	      						</td>
                                                        <sql:query var="rowsales" dataSource="${db}">
                                                            SELECT * FROM order_history WHERE is_delivered > 0 AND pr_id=?
                                                            <sql:param value = "${product.id}" />
                                                           
                                                      </sql:query>
                                                           
                                                        <td>
                                                            <print:out value="${rowsales.rowCount}"></print:out>

                                                        </td>
                                                         
	      						<td>
	      							<a class="btn-small btn-floating waves-effect waves-light blue lighten-1 view" id="${product.id}"><i class="material-icons">image</i></a>
	      							<a class="btn-small btn-floating waves-effect waves-light blue lighten-1 edit-product" id="${product.id}"><i class="material-icons">create</i></a>
	      							<a class="btn small btn-floating waves-effect waves-light red del_product" id="${product.id}"><i class="material-icons">delete</i></a>
	      						</td>
	      					</tr>
	      					<print:set var="count_product" value="${count_product + 1}" />
						</print:forEach>
			        </tbody>
	        	</table>
	    	</div>
	    </div>
            <div id="test-swipe-3" class="col s12" style="height: 50vh;overflow-y: auto; scrollbar-width: auto;" onmouseover="this.style.overflow='auto'" onmouseout="this.style.overflow='hidden'">
	    
	    	<div class="card-panel">
	    		<print:choose>
                      <print:when test="${rsch.rowCount < 1}">
                            
                            <span>No recent order yet</span>
                          
                      </print:when>
                      <print:otherwise>
                          <ul class="collection">
                            <print:forEach items="${rsch.rows}" var="orderh">   
                              <li class="collection-item avatar ">
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
                                    ${orderh.username} (Buyer)<br>
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
                                 <print:choose>
                                    <print:when test="${orderh.is_delivered < 1}">
                                             
                                        <a  class="secondary-content delivered-btn btn"  id="${orderh.id}">
                                            
                                            Mark as Delivered
                                        </a>
                                        
                                    </print:when>
                                    <print:otherwise>
                                        
                                    </print:otherwise>
                                    
                                </print:choose>
                                
                                       
                                    
                                
                              </li>
                          </print:forEach>

                        </ul>
                          
                      </print:otherwise>      
                      
                      
                  </print:choose>
	    	</div>
	    </div>
    </div>
</div>





<%@ include file="mid.jsp" %>

<script type="text/javascript">
	$(document).ready(function(){
            
                var id;
		$(".button-collapse").sideNav();
		
		$('#modal1').modal({
		      dismissible: false, // Modal cannot be closed by clicking anywhere outside
		    });
		$('#modal2').modal({
		      dismissible: false, // Modal cannot be closed by clicking anywhere outside
		    });
		$('#modal3').modal({
		      dismissible: false, // Modal cannot be closed by clicking anywhere outside
		    });
		$('#modal4').modal({
		      dismissible: false, // Modal cannot be closed by clicking anywhere outside
		    });
                
                $('#modal5').modal({
		      dismissible: false, // Modal cannot be closed by clicking anywhere outside
		    });
                $('#modal-img').modal();
		
		$(document).on('click','.view', function() {
			
			 id = $(this).attr('id');
		 
			   $.ajax({

		          url: "updateImg.jsp",
		          type: "POST",
		          data:{id:id},
		          success:function(data){
                                $('#mod-1').html(data);
                                $('#modal1').modal('open'); 
		          }
		     });  
	   });
		
	
		
        //Delete data
        $(document).on('click','.del_user', function() {


             var del_id = $(this).attr('id');
             
             
             
              $.ajax({

                  url: "delUserData.jsp",
                  type: "POST",
                  data:{del_id:del_id},
                  success:function(data){
                       $("#del-pro").html(data);
                       $('#modal2').modal('open');
                  }


             });  

        });
        
        $(document).on('click', '#del', function(){
        	

            $.ajax({

                url: "saveDelUser.jsp",
                type: "POST",
                data:$("#del-edu_form").serialize(),
                success:function(data){
               	  $('#modal2').modal('close');
		 window.location.reload(true); 
                }
           }); 
      });
      
      
      $(document).on('click', '.edit-product', function(){
          
          var edit_id = $(this).attr('id');

            $.ajax({

                url: "updateProduct.jsp",
                type: "POST",
                 data:{edit_id:edit_id},
                success:function(data){
                   $('#edit-creds').html(data);
		   $('#modal3').modal('open'); 

                }
           }); 
      });
      
      
      $(document).on('click', '#update-pro', function(){
                
                var price = $("#price").val();
                var qty_in_stock = $("#qty_in_stock").val();
                
                
                var regExp = /[a-zA-Z]/g;
        
                if(regExp.test(price) || regExp.test(qty_in_stock)){

                        alert("Input error (type mismatch in Price or Quantity In Stock)");

                }else{

                       $.ajax({
       
                       url: "saveProductData.jsp",
                       type: "POST",
                       data:$("#update-pro_form").serialize(),
                       success:function(data){
                              $('#modal3').modal('close'); 
                              window.location.reload(true);
                       }
                  });
                }
	});
        
        
        
      
      
      //Delete music data
        $(document).on('click','.del_product', function() {


             var del_id = $(this).attr('id');
             
             
             
              $.ajax({

                  url: "delProductData.jsp",
                  type: "POST",
                  data:{del_id:del_id},
                  success:function(data){
                       $("#del-pro").html(data);
                       $('#modal2').modal('open');
                  }


             });  

        });
        
        
        
        //Delete music data
        $(document).on('click', '#del', function(){
        	

            $.ajax({

                url: "saveDelProduct.jsp",
                type: "POST",
                data:$("#del-edu_form").serialize(),
                success:function(data){
               	  $('#modal2').modal('close');
		 window.location.reload(true); 
                }
           }); 
      });
        
        
        $(document).on('click', '.add-product', function(){
        	
                $('#modal5').modal('open'); 
            
      });
      
      $(document).on('click', '#create-product', function(){
          
                var price = $("#price1").val();
                var qty_in_stock = $("#qty_in_stock1").val();
                
                
                var regExp = /[a-zA-Z]/g;
        
                if(regExp.test(price) || regExp.test(qty_in_stock)){

                        alert("Input error (type mismatch in Price or Quantity In Stock)");

                }else{
                
                $.ajax({

                url: "saveCreateProduct.jsp",
                type: "POST",
                data:$("#create-music_form").serialize(),
                success:function(data){
                       $('#modal5').modal('close');
                       window.location.reload(true);
                }
           }); 
          }
        });
        
      $(document).on('click', '#upd-img', function(){
                
                $('#modal1').modal('close');
                
                
                
                $('<input>').attr({
                    type: 'hidden',
                    id: 'product_id',
                    name: 'id',
                    value:id
                }).appendTo('#img-div');
 		 $("#product_id").val(id);	
                
                $('#modal-img').modal('open');
				    
	});
        
        
        $(document).on('click', '.delivered-btn ', function(){
                
                var order_id = $(this).attr('id');
                
                $.ajax({

                  url: "markOrderData.jsp",
                  type: "POST",
                  data:{order_id:order_id},
                  success:function(data){
                       $("#del-pro").html(data);
                       $('#modal2').modal('open');
                  }


             });
				    
	});
        
        
        //Delete music data
        $(document).on('click', '#del', function(){
        	

            $.ajax({

                url: "saveMarkOrder.jsp",
                type: "POST",
                data:$("#del-edu_form").serialize(),
                success:function(data){
               	  $('#modal2').modal('close');
		 window.location.reload(true); 
                }
           }); 
      });
        
    
        
        
           
      
 	
	});
	

</script>


<%@ include file="footer.jsp" %>



<!-- Viewing Product Image-->
	  <div id="modal1" class="modal modal-fixed-footer" style="height:50%;width:40%; " >
	    <div class="modal-content" >
	      <h4 class="center-align">PRODUCT IMAGE</h4>
	      	<div class="row center-align" id="mod-1">  
	      	 
				      	
	      	</div>
	      
	    </div>
	    <div class="modal-footer">
              <a href="#" class="waves-effect waves-light btn blue lighten-1" id="upd-img">Update</a>  
	      <a href="" class="modal-close waves-effect waves-light btn-flat red-text">Close</a>
	    </div>
	  </div>

<!-- Modal for Prompting Admin-->
	  <div id="modal2" class="modal modal-fixed-footer" style="width: 30%; height:25%">
	  	<form method="POST" id="del-edu_form" action="#">
                
	    <div class="modal-content" >
	      <h4 class="center-align">Confirmation</h4>
	      
	      	<div class="row center-align" id="del-pro">
	      	
	      	</div>
	      
	    </div>
	    <div class="modal-footer">
	      <a href="#" class="modal-close waves-effect waves-light btn-flat blue lighten-1 white-text">No</a>
	      <a href="#" class="waves-effect waves-light btn-flat red white-text" id="del" id="del">Yes</a>
	    </div>
	    </form>
	  </div>



<!-- Modal for Editing  Credentials-->
    <div id="modal3" class="modal modal-fixed-footer" style="width: 40%; height: 65%;">
          
         
       <form action="#" method="post" id="update-pro_form" >
            <div class="modal-content" >
            <h4 class="center-align">Edit</h4>
              <div class="row center-align" id="edit-creds">

              </div>

            </div>
          <div class="modal-footer">
            <a href="#" class="modal-close waves-effect waves-light btn red">Close</a>
            <a href="#" class="waves-effect waves-light btn blue lighten-1" id="update-pro">Update</a>
          </div>
      </form>
    </div>


  


                
                
<!-- Modal for Adding  User Music-->
    <div id="modal5" class="modal modal-fixed-footer" style="width: 40%; height: 60%;">
        <form action="#" method="post" id="create-music_form" >       
      <div class="modal-content" >
        <h4 class="center-align">Add Product</h4>
          <div class="row center-align" id="edit-creds">
              
             
               
        <div class="col s12 m6 l6">
          <div class=input-field>
                  <label>Product Name</label><br>
                  <input type="text" id="pr_name" name="pr_name" required>
          </div>
      </div>
		
	<div class="col s12 m6 l6">
		<div class=input-field>
			<label>Manufacturer</label><br>
			<input type="text" id="manufacturer" name="manufacturer" required>
			
		</div>
	</div>
	
	<div class="col s12 m6 l6">
		<div class=input-field>
			<label>Price (£)</label><br>
			<input type="text" id="price1" name="price" required>
		</div>
	</div>
		
	<div class="col s12 m6 l6">
		<div class=input-field>
			<label>Quantity In Stock</label><br>
			<input type="text" id="qty_in_stock1" name="qty_in_stock" required>
			
		</div>
	</div>
              
        <div class="col s12">
		<div class=input-field>
			<label>Category</label><br>
			<input type="text" id="category" name="category" required>
			
		</div>
	</div>
              
       
	
          </div>

      </div>
      <div class="modal-footer">
        <a href="#" class="modal-close waves-effect waves-light btn red">Close</a>
        <a href="#" class="waves-effect waves-light btn blue lighten-1" id="create-product">Create</a>
      </div>
      </form>
    </div>


<!-- Modal for Adding Profile Photo-->
	  <div id="modal-img" class="modal modal-fixed-footer" style="height:40%; width:50%">
	  	<form action="productimage" method="post" enctype="multipart/form-data">
		    <div class="modal-content" >
		      <h4 class="center-align">UPDATE PRODUCT IMAGE</h4>
		      <p class="center-align red-text">Square Images are recommended for better display</p>
		      	<div class="row center-align" id="">  
		      	 
		      	<div class="col s12" id="img-div">
					<div class=input-field>		
<!--						<input type="hidden" id="product_id" name="id" value="">-->
					</div>
			     </div>   						 
					<div class="col s12">
						<div class = "file-field input-field" >
                                                    <div class = "btn blue lighten-1">
                                                       <span>Browse</span>
                                                       <input type = "file" name="img" id="img"/>
                                                    </div>                  
                                                    <div class = "file-path-wrapper">
                                                       <input class = "file-path validate" type = "text"
                                                          placeholder = "Upload file" name="img" id="img" required/>
                                                    </div>
                                             </div>   
					</div>  
					<div class="col s12">
				      <div class=input-field>	       					
				       	<input type="submit" class="btn blue lighten-1 " value="Save Changes">		       					
				     </div>  	
		      	</div>
		      
		    </div>
		    </div>
	    </form>
 	</div>
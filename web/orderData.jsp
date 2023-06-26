<%-- 
    Document   : orderData
    Created on : Sep 8, 2022, 11:32:49 AM
    Author     : Kornell
--%>

<%@page import="com.webapp.User"%>
<%@page import="java.io.ObjectInputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="com.webapp.Cart"%>
<%@ page import="java.sql.*" %>


<%!
    
    double totalAmount;
    String username = "";
    List<Cart> list = null;
    Map<Integer,Integer> check = null;
    
     File file = null;
     User user = null;
     String virtualBalance = "";
     
     double vBalance;
%>


<% 

    check = (Map<Integer,Integer>)session.getAttribute("check");    
    list = (List<Cart>) session.getAttribute("list");    
    totalAmount = Double.parseDouble(request.getParameter("total"));
    username = String.valueOf(session.getAttribute("username"));
    
    
    file = new File(username+".obj");
    
    FileInputStream fileIn = new FileInputStream(file);
    ObjectInputStream objectIn = new ObjectInputStream(fileIn);
    Object obj = objectIn.readObject();               
    user = (User) obj;
    objectIn.close();
    
    vBalance = user.getVirtualBalance();
    virtualBalance = String.format("%,.2f", user.getVirtualBalance());
    
    
%>


<input type="hidden" id="username" name="username" value="<%=username %>">


<input type="hidden" id="vbalance" name="vbalance" value="<%=vBalance %>">

<input type="hidden" id="total" name="total" value="<%=totalAmount %>">

<div class="col s12">
        <div class=input-field>
        <label for="card">Credit Card Balance</label><br>
        <input class="active" type="text"  id="card" name="card" value="£ <%= virtualBalance %>" readonly="">
        </div>
</div>

<div class="col s12">
        <div class=input-field>
                <label for="amount">Amount Deducted</label><br>
                <input type="text" id="amount" name="amount" value="    -(£ <%=totalAmount%>0)" readonly>
        </div>
</div>





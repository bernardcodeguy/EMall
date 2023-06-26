<%-- 
    Document   : index
    Created on : Sep 3, 2022, 12:57:20 PM
    Author     : Kornell
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! 
    String title = "Start Page";
%>

<%@ include file="header.jsp" %>




<% 

    response.sendRedirect("home.jsp?page=1");
%>

    

<%@ include file="mid.jsp" %>

<%@ include file="footer.jsp" %>

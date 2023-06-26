/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.webapp;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Bern Ard
 */
@WebServlet(name = "AlLogin", urlPatterns = {"/allogin"})
public class AlLogin extends HttpServlet {

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
	String password = request.getParameter("password");
        
        File file = new File(username+".obj");
        
        if(!file.exists()){
            PrintWriter out1 = response.getWriter();
            out1.println("<script type=\"text/javascript\">");
            out1.println("alert('Wrong username or password');");
            out1.println("location='allogin.jsp';");
            out1.println("</script>");
        }else{
            FileInputStream fileIn = new FileInputStream(file);
            ObjectInputStream objectIn = new ObjectInputStream(fileIn);
 
            try {
                Object obj = objectIn.readObject();
                
                User userRead = (User) obj;
                
                objectIn.close();
                
                Boolean match = BCrypt.checkpw(password, userRead.getPassword());
                
                if(match){
                    response.sendRedirect("home.jsp?page=1");
                    
                }else{
                    PrintWriter out1 = response.getWriter();
                    out1.println("<script type=\"text/javascript\">");
                    out1.println("alert('Wrong username or password');");
                    out1.println("location='allogin.jsp';");
                    out1.println("</script>");  
                }
                 
                
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(SignUp.class.getName()).log(Level.SEVERE, null, ex);
            } 
        }
        
    }

   

}

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.webapp;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
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
 * @author Kornel
 */
@WebServlet(name = "SignUp", urlPatterns = {"/signup"})
public class SignUp extends HttpServlet {

  

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        String username = request.getParameter("username");
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String plainPass1 = request.getParameter("passwd");
        String plainPass2 = request.getParameter("passwd2");
        String gender = request.getParameter("gender");
        
        String imageUrl = "";
        
        if(plainPass1.equals(plainPass2)) {
           String password = hashPassword(plainPass1); 
           
           User user = new User(username,fname,lname,email,password,gender,imageUrl);
           
           
           // String userDirectory = new File("signup.jsp").getAbsolutePath();
            //response.getWriter().println(userDirectory);
            
            File file = new File(username+".obj");
            
            if(!(file.exists())){
                FileOutputStream fileOut = new FileOutputStream(file);
                ObjectOutputStream objectOut = new ObjectOutputStream(fileOut);
                objectOut.writeObject(user);
                objectOut.close(); 
                
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                response.sendRedirect("allogin.jsp");
            }else{
                
                PrintWriter out1 = response.getWriter();
                out1.println("<script type=\"text/javascript\">");
                out1.println("alert('Username already exist');");
                out1.println("location='signup.jsp';");
                out1.println("</script>");
            }
            
      
            
          
       }else {
           
            PrintWriter out1 = response.getWriter();
            out1.println("<script type=\"text/javascript\">");
            out1.println("alert('Passwords does not match');");
            out1.println("location='register.jsp';");
            out1.println("</script>");
    }
        
        
    }
    
    private String hashPassword(String plainTextPassword){
		return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
	}
    
    

    

}

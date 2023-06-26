/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.webapp;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Bern Ard
 */
@WebServlet(name = "ProductImage", urlPatterns = {"/productimage"})
@MultipartConfig(maxFileSize=161772150)
public class ProductImage extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
                int id = Integer.parseInt(request.getParameter("id"));
                final String usernameDB = "root";
                final String passwordDB = "1234";
                final String urlPort = "localhost:3307";
                final String databaseName = "emall";
                final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
                final String dbDriver = "com.mysql.cj.jdbc.Driver";
                String sql = "SELECT img FROM product WHERE id=?";

                try {
                Class.forName(dbDriver);
                Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);

                PreparedStatement ps;
		  
		   ps = con.prepareStatement(sql);
		   ps.setInt(1, id);
		   
		   ResultSet rs1 = ps.executeQuery();
		   if(rs1.next()){
		    byte [] imageData = rs1.getBytes("img"); // extract byte data from the resultset..
		    OutputStream os = response.getOutputStream(); // output with the help of outputStream 
		             os.write(imageData);
		             os.flush();
		             os.close();
		   }
		  } catch (Exception e) {
		   // TODO Auto-generated catch block
		   e.printStackTrace();
		   response.getOutputStream().flush();
		   response.getOutputStream().close();
		  }
        
        
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
            int id = Integer.parseInt(request.getParameter("id"));
            
                response.getWriter().println(id);
	
		InputStream img = null ;
		
		
		
		Part part = request.getPart("img");

		if(!part.getContentType().contains("image")) {
                    PrintWriter out1 = response.getWriter();
                    out1.println("<script type=\"text/javascript\">");
                    out1.println("alert('Invalid image type');");
                    out1.println("location='admin.jsp';");
                    out1.println("</script>"); 
			
		}else {
			img = part.getInputStream();
			
			try {
				
                            final String usernameDB = "root";
                            final String passwordDB = "1234";
                            final String urlPort = "localhost:3307";
                            final String databaseName = "emall";
                            final String url = "jdbc:mysql://"+urlPort+"/"+databaseName;
                            final String dbDriver = "com.mysql.cj.jdbc.Driver";
                            Class.forName(dbDriver);
                            Connection con = DriverManager.getConnection(url,usernameDB,passwordDB);
                            String sql = "UPDATE product SET img=? WHERE id=? ";	
                            PreparedStatement ps;
                            
                            ps = con.prepareStatement(sql);
                            ps.setBlob(1, img);
                            ps.setInt(2, id);

                            ps.executeUpdate();
                      
                           response.sendRedirect("admin.jsp");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			
			
		}
        
    }

}

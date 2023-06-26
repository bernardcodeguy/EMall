
package com.webapp;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Kornell
 */
@WebServlet(name = "Admin", urlPatterns = {"/admin"})
public class Admin extends HttpServlet {

   

  
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String key = request.getParameter("key");
	
        String originalKey = "korPasia22";
		
        if(key.equals(originalKey)) {

                HttpSession session = request.getSession();
                session.setAttribute("key", key);
                response.sendRedirect("admin.jsp");


        }else {
                PrintWriter out = response.getWriter(); 
                out.println("<script type=\"text/javascript\">"); 
                out.println("alert('Wrong PIN!!');"); 
                out.println("location='adminindex.jsp';");
                out.println("</script>"); 

        }
    }

    
}

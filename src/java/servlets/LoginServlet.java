/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jasypt.util.text.AES256TextEncryptor;

/**
 *
 * @author ACER
 */
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = dao.DaoRetro.getUserByUsername(request.getParameter("username"));
        if (user != null) {
            
            AES256TextEncryptor decryptor = new AES256TextEncryptor();
            decryptor.setPassword(request.getServletContext().getInitParameter("encryptionPass"));
            
            if (decryptor.decrypt(user.getPassword()).equals(request.getParameter("password"))) {
                request.getSession().setAttribute("user", user);
                response.sendRedirect("index.jsp");
            } else {
                request.setAttribute("error", "Contraseña incorrecta");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "El usuario no existe");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}

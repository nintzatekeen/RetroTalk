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

/**
 *
 * @author ACER
 */
public class RegistryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("registro.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (dao.DaoRetro.isUserAvailable(request.getParameter("user"))) {
            if (request.getParameter("password").equals(request.getParameter("confirm"))) {
                if (request.getParameter("password").length()>=4) {
                    User user = new User();
                    user.setUsername(request.getParameter("username"));
                    user.setPassword(request.getParameter("password"));
                    user.setEmail(request.getParameter("email"));
                    dao.DaoRetro.insertUser(user);
                } else {
                    request.setAttribute("error", "LA CONTRASEÑA ES DEMASIADO PEQUEÑA");
                    request.getRequestDispatcher("registro.php").forward(request, response);
                }
            } else {
                request.setAttribute("error", "LA CONTRASEÑA NO COINCIDE");
                request.getRequestDispatcher("registro.php").forward(request, response);
            }
        }
        else {
            request.setAttribute("error", "USUARIO NO DISPONIBLE");
            request.getRequestDispatcher("registro.php").forward(request, response);
        }
    }

}
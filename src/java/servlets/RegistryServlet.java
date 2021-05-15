/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.User;
import dao.DaoRetro;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jasypt.util.text.AES256TextEncryptor;

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
        if (!request.getParameter("username").isEmpty()
                && !request.getParameter("password").isEmpty()
                && !request.getParameter("confirm").isEmpty()
                && !request.getParameter("email").isEmpty()) {
            if (dao.DaoRetro.isUserAvailable(request.getParameter("user"))) {
                if (request.getParameter("password").equals(request.getParameter("confirm"))) {
                    if (request.getParameter("password").length() >= 4) {
                        if (DaoRetro.getUserByUsername(request.getParameter("username")) == null) {
                            User user = new User();
                            user.setUsername(request.getParameter("username"));
                            System.out.println(request.getServletContext().getInitParameter("encryptionPass"));
                            AES256TextEncryptor encryptor = new AES256TextEncryptor();

                            encryptor.setPassword(request.getServletContext().getInitParameter("encryptionPass"));
                            user.setPassword(encryptor.encrypt(request.getParameter("password")));
                            user.setEmail(request.getParameter("email"));
                            user = dao.DaoRetro.insertUser(user);
                            request.getSession().setAttribute("user", user);
                            response.sendRedirect("index.jsp");
                        }  else {
                        request.setAttribute("error", "EL USUARIO YA EXISTE");
                        request.getRequestDispatcher("registro.jsp").forward(request, response);
                    }
                    } else {
                        request.setAttribute("error", "LA CONTRASEÑA ES DEMASIADO PEQUEÑA");
                        request.getRequestDispatcher("registro.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "LA CONTRASEÑA NO COINCIDE");
                    request.getRequestDispatcher("registro.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("error", "USUARIO NO DISPONIBLE");
                request.getRequestDispatcher("registro.jsp").forward(request, response);
            }
        } else {
            request.setAttribute("error", "NO DEBEN QUEDAR CAMPOS VACÍOS");
            request.getRequestDispatcher("registro.jsp").forward(request, response);
        }

    }

}

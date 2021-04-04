/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

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
public class CategoryRemoveServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String strCat = request.getParameter("category");
        try {
            Integer cat = Integer.parseInt(strCat);
            if (!dao.AdminDAO.removeCategory(cat)) {
                request.setAttribute("error", "No se pudo borrar la categoría");
                request.getRequestDispatcher(request.getHeader("referer")).forward(request, response);
            } else {
                response.sendRedirect("index.jsp");
            }
        } catch (NumberFormatException | NullPointerException e) {
            request.setAttribute("error", "No se pudo borrar la categoría");
                request.getRequestDispatcher(request.getHeader("referer")).forward(request, response);
        }
        
    }

}

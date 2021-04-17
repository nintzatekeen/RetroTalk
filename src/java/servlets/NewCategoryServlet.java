/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.Category;
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
public class NewCategoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("categoryId");
        String name = request.getParameter("categoryName");
        String desc = request.getParameter("categoryDescription");
        String icon = request.getParameter("categoryIcon");

        try {
            if (name.isEmpty()) {
                request.setAttribute("error", "El nombre no puede quedar vacío");
                request.getRequestDispatcher("createCategory.jsp").forward(request, response);
            } else {
                int id;
                try {
                    id = Integer.parseInt(idStr);
                } catch (NumberFormatException e) {
                    id = 0;
                }
                
                if (icon != null && icon.isEmpty())
                    icon = null;
                
                Category newCat = new Category(id, name, desc, icon);
                if (!dao.AdminDAO.createCategory(newCat)) {
                    request.setAttribute("error", "No se pudo crear la categoría");
                    request.getRequestDispatcher("createCategory.jsp").forward(request, response);
                } else {
                    response.sendRedirect("index.jsp");
                }

            }
        } catch (NullPointerException e) {
            request.setAttribute("error", "PARAMETROS ERRÓNEOS");
            request.getRequestDispatcher("createCategory.jsp").forward(request, response);
        }

    }

}

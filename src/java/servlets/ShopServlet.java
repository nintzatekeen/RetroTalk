package servlets;

import beans.Product;
import beans.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ShopServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        if (user != null) {
            ArrayList<Product> productsList = (ArrayList<Product>) dao.DaoTienda.getProducts();
            request.getSession().setAttribute("productsList", productsList);
            response.sendRedirect("shop.jsp");
        } else {
            response.sendRedirect("shop.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        ArrayList<Product> productsList = (ArrayList<Product>) dao.DaoTienda.getProducts();
        request.getSession().setAttribute("productsList", productsList);
        response.sendRedirect("shop.jsp");

    }

}

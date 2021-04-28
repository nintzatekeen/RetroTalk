package servlets;

import beans.PrivateMessage;
import beans.Product;
import beans.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NewPrivateMessageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Product> productsList = (ArrayList<Product>) request.getSession().getAttribute("productsList");

        int idProducto = Integer.parseInt(request.getParameter("idProducto"));
        Product product = null;
        for (Product p : productsList) {
            if (idProducto == p.getId()) {
                product = p;
            }
        }
        User user = (User) request.getSession().getAttribute("user");
        String msg = request.getParameter("msg");
        if (request.getParameter("oferta") != null) {
            msg += " --OFERTA: " + request.getParameter("oferta") + "€";
        }
        PrivateMessage privateMsg = new PrivateMessage();
        privateMsg.setContent(msg);
        privateMsg.setProduct(product);
        privateMsg.setUser(user);
        dao.DaoTienda.newPrivateMessage(privateMsg);

        response.sendRedirect("index.jsp");

    }

}

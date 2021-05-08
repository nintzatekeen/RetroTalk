/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.Product;
import beans.User;
import dao.DaoTienda;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Paths;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig
public class InsertProductServlet extends HttpServlet {

    private static final String productsPath = "images/productos/";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
            
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        Double price;
        try {
            price = Double.parseDouble(request.getParameter("price"));
        } catch (NullPointerException | NumberFormatException e) {
            price = null;
        }

        if ((title != null && !title.isEmpty())
                && (description != null && !description.isEmpty())
                && (price != null && price > 0)) {

            Product product = new Product();
            product.setUser(user);
            product.setTitle(title);
            product.setDescription(description);
            product.setPrice(price);

            int id = DaoTienda.insertProduct(product);

//            product = DaoTienda.getProductById(id);

            Part imgPart = request.getPart("img");

            String extension = utils.Utilities.getExtension(
                    Paths.get(imgPart.getSubmittedFileName()).getFileName().toString());

            String fileName = id + extension;

            String realPath = request.getServletContext().getRealPath(productsPath);

            String fileStr = realPath + File.separator + fileName;

            String imgStr = productsPath + id + extension;

            if (extension != null) {
                try (InputStream is = imgPart.getInputStream();
                        FileOutputStream fos = new FileOutputStream(fileStr)) {
                    ArrayList<Byte> bytes = new ArrayList<>();
                    int next = is.read();
                    while (next != -1) {
                        bytes.add((byte) next);
                        next = is.read();
                    }
                    byte[] img = new byte[bytes.size()];
                    for (int i = 0; i < img.length; i++) {
                        img[i] = bytes.get(i);
                    }
                    fos.write(img);
                    DaoTienda.updateProductImg(id, imgStr);
                } catch (IOException ex) {
                    System.err.println("Error al escribir la imagen: " + ex.getMessage());
                }
            }
            response.sendRedirect("product.jsp?id="+id);
        } else {
            request.setAttribute("error", "Los campos título, descripción y precio no pueden quedar vacíos");
            request.getRequestDispatcher("newProduct.jsp").forward(request, response);
        }
    }
}

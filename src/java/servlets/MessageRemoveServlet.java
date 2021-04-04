/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ACER
 */
public class MessageRemoveServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String[] idsStr = request.getParameterValues("messageId");
        List<Integer> ids = Arrays.stream(idsStr).map(str -> Integer.parseInt(str)).collect(Collectors.toList());
        
        System.out.println("LA LISTA DE IDS: "+ids);
        
        dao.AdminDAO.removeMessages(ids);
        
        response.sendRedirect(request.getHeader("referer"));
    }

}

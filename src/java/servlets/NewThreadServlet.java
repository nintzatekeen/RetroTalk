/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.ForumThread;
import beans.User;
import dao.DaoRetro;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NewThreadServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Integer categoryId;
        String threadTitle;
        String firstMsgContent;
        
        try {
            categoryId = Integer.parseInt(request.getParameter("category"));
            threadTitle = request.getParameter("title");
            firstMsgContent = request.getParameter("content");
            if (firstMsgContent.isEmpty() || threadTitle.isEmpty()) {
                request.setAttribute("error", "No pueden quedar campos vacíos");
                request.getRequestDispatcher("createThread.jsp?cat="+categoryId).forward(request, response);
            } else {
                ForumThread thread = DaoRetro.createNewThread(DaoRetro.getCategoryById(categoryId)
                , (User) request.getSession().getAttribute("user")
                , threadTitle
                , firstMsgContent);
                if (thread == null) {
                    request.setAttribute("error", "No se pudo crear el hilo");
                    request.getRequestDispatcher("createThread.jsp?cat"+categoryId).forward(request, response);
                } else
                    response.sendRedirect("thread.jsp?thread="+thread.getId());  
            }
            
        } catch (NullPointerException | NumberFormatException e) {
            System.err.println("ERROR al crear hilo: "+e.getMessage());
            response.sendRedirect("index.jsp");
        }
        
        
    }

}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.ForumThread;
import beans.Message;
import beans.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author dw2
 */
public class ServletMessage extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
        ForumThread thread = null;
        try {
            String strUser = request.getParameter("thread");
        Integer threadId = Integer.parseInt(strUser);
        thread = dao.DaoRetro.getThreadById(threadId);
        
        if (!request.getParameter("message").isEmpty()) {
            dao.DaoRetro.sendMessage(user, thread, request.getParameter("message"));
            response.sendRedirect("thread.jsp?thread="+thread.getId()+"&page="+dao.DaoRetro.getLastThreadPage(thread));
        }
        else {
            request.setAttribute("error", "El mensaje debe contener texto");
            request.getRequestDispatcher("thread.jsp?thread="+thread.getId()+"&page="+dao.DaoRetro.getLastThreadPage(thread));
        }
        
        } catch (NumberFormatException | NullPointerException e) {}
    }
}

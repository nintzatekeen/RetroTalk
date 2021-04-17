/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import beans.Category;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import org.apache.commons.dbcp2.BasicDataSource;

/**
 *
 * @author ACER
 */
public class AdminDAO {
    private static final BasicDataSource ds = new BasicDataSource();
    private static PreparedStatement psRemoveMessage;
    private static PreparedStatement psRemoveThread;
    private static PreparedStatement psSelectAffectedThreadMessage;
    private static PreparedStatement psRemoveCategory;
    private static PreparedStatement psSelectAffectedCategoryThread;
    private static PreparedStatement psRemoveUser;
    private static PreparedStatement psDeleteMessagesFromUser;
    private static PreparedStatement psDeleteThreadsFromUser;
    private static PreparedStatement psCreateCategory;

    static {
        //Para el driver nuevo
        ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
        ds.setUrl("jdbc:mysql://localhost/foro?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC");
        //para el driver de netbeans 8
//        ds.setDriverClassName("com.mysql.cj.jdbc.Driver");
//        ds.setUrl("jdbc:mysql://localhost/foro");

        ds.setUsername("root");
        ds.setPassword("");
        
        try {
            Connection cn = ds.getConnection();
            
            String sqlRemoveMessage = "delete from message where id = ?";
            String sqlRemoveThread = "delete from thread where id = ?";
            String sqlSelectAffectedThreadMessage = "select id from message where thread = ?";
            String sqlRemoveCategory = "delete from category where id = ?";
            String sqlSelectAffectedCategoryThread = "select id from thread where category = ?";
            String sqlRemoveUser = "delete from user where id = ?";
            String sqlDeleteMessagesFromUser = "delete from message where user = ?";
            String sqlDeleteThreadsFromUser = "delete from thread where user = ?";
            String sqlCreateCategory = "insert into category (id, name, description, icon) values (?,?,?,?)";
            
            psRemoveMessage = cn.prepareStatement(sqlRemoveMessage);
            psRemoveThread = cn.prepareStatement(sqlRemoveThread);
            psSelectAffectedThreadMessage = cn.prepareStatement(sqlSelectAffectedThreadMessage);
            psRemoveCategory = cn.prepareStatement(sqlRemoveCategory);
            psSelectAffectedCategoryThread = cn.prepareStatement(sqlSelectAffectedCategoryThread);
            psRemoveUser = cn.prepareStatement(sqlRemoveUser);
            psDeleteMessagesFromUser = cn.prepareStatement(sqlDeleteMessagesFromUser);
            psDeleteThreadsFromUser = cn.prepareStatement(sqlDeleteThreadsFromUser);
            psCreateCategory = cn.prepareStatement(sqlCreateCategory);
        } catch (SQLException ex) {
            System.err.println("Error al crear los preparedstatements en AdminDAO: " + ex.getMessage());
        }
    }
    
    
    public static boolean removeMessages (Integer... messageIds) {
        try {
            for (Integer id : messageIds) {
                psRemoveMessage.setInt(1, id);
                psRemoveMessage.executeUpdate();
            }
            return true;
        } catch (SQLException ex) {
            System.err.println("Error en removeMessages: " + ex.getMessage());
        }
        return false;
    }
    public static boolean removeMessages (Collection<Integer> messageIds) {
        return removeMessages(messageIds.toArray(new Integer[messageIds.size()]));
    }
    
    
    public static boolean removeThread (Integer threadId) {
        try {
            psSelectAffectedThreadMessage.setInt(1, threadId);
            ResultSet rs = psSelectAffectedThreadMessage.executeQuery();
            ArrayList<Integer> messageList = new ArrayList<>();
            while (rs.next()) {
                messageList.add(rs.getInt("id"));
            }
            if (!removeMessages(messageList))
                return false;   
            
            psRemoveThread.setInt(1, threadId);
            return psRemoveThread.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.err.println("Error en removeThreads: " + ex.getMessage());
        }
        return false;
    }
    
    public static boolean removeCategory (Integer categoryId) {
        try {
            psSelectAffectedCategoryThread.setInt(1, categoryId);
            ResultSet rs = psSelectAffectedCategoryThread.executeQuery();
            ArrayList<Integer> threadList = new ArrayList<>();
            while (rs.next()) {
                threadList.add(rs.getInt("id"));
            }
            
            threadList.forEach((threadId) -> {
                removeThread(threadId);
            });
            
            psRemoveCategory.setInt(1, categoryId);
            
            return psRemoveCategory.executeUpdate() > 0;
            
        } catch (SQLException ex) {
            System.err.println("Error en removeCategory: " + ex.getMessage());
        }
        return false;
    }
    
    private static int deleteMessagesFromUser (Integer userId) {
        try {
            psDeleteMessagesFromUser.setInt(1, userId);
            return psDeleteMessagesFromUser.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error en deleteMessagesFromUser: " + ex.getMessage());
        }
        return 0;
    }
    
    private static int deleteThreadsFromUser (Integer userId) {
        try {
            psDeleteThreadsFromUser.setInt(1, userId);
            return psDeleteThreadsFromUser.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error en deleteThreadsFromUser: " + ex.getMessage());
        }
        return 0;
    }
    
    private static boolean deleteUser (Integer userId) {
        try {
            psRemoveUser.setInt(1, userId);
            return psRemoveUser.executeUpdate() > 0;
        } catch (SQLException ex) {
            System.err.println("Error en deleteUser: " + ex.getMessage());
        }
        return false;
    }
    
    public static boolean removeUser (Integer userId) {
        deleteThreadsFromUser(userId);
        deleteMessagesFromUser(userId);
        return deleteUser(userId);
    }
    
    private static int getLastCategoryId () {
        String sql = "select max(id) as last from category";
        try (Connection cn = ds.getConnection();
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            if (rs.next())
                return rs.getInt("last");
        } catch (SQLException ex) {
            System.err.println("Error en getLastCategoryId: " + ex.getMessage());
        }
        return -1;
    }
    
    public static boolean createCategory (Category category) {
        try {
            if (category.getId() < 1 )
                category.setId(getLastCategoryId() + 1);
            
            psCreateCategory.setInt(1, category.getId());
            psCreateCategory.setString(2, category.getName());
            psCreateCategory.setString(3, category.getDescription());
            psCreateCategory.setString(4, category.getIcon());
            return psCreateCategory.executeUpdate() > 0;
        } catch (NullPointerException ex) {
            System.err.println("Categoría nula pasada como parámetro en createCategory: " + ex.getMessage());
        } catch (SQLException ex) {
            System.err.println("Error en createCategory: " + ex.getMessage());
        }
        return false;
    }
    
}

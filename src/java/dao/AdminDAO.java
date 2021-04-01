/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import org.apache.commons.dbcp2.BasicDataSource;

/**
 *
 * @author ACER
 */
public class AdminDAO {

    private static final BasicDataSource ds = new BasicDataSource();
    private static PreparedStatement psRemoveMessages;
    private static PreparedStatement psRemoveThreads;
    private static PreparedStatement psSelectAffectedThreadMessages;
    private static PreparedStatement psRemoveCategory;
    private static PreparedStatement psSelectAffectedCategoryThreads;

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
            
            String sqlRemoveMessages = "delete from message where id in (?)";
            String sqlRemoveThreads = "delete from thread where id in (?)";
            String sqlSelectAffectedThreadMessages = "select id from message where thread in (?)";
            String sqlRemoveCategory = "delete from category where id = ?";
            String sqlSelectAffectedCategoryThreads = "select id from thread where category = ?";
            
            psRemoveMessages = cn.prepareStatement(sqlRemoveMessages);
            psRemoveThreads = cn.prepareStatement(sqlRemoveThreads);
            psSelectAffectedThreadMessages = cn.prepareStatement(sqlSelectAffectedThreadMessages);
            psRemoveCategory = cn.prepareStatement(sqlRemoveCategory);
            psSelectAffectedCategoryThreads = cn.prepareCall(sqlSelectAffectedCategoryThreads);
        } catch (SQLException ex) {
            System.err.println("Error al crear los preparedstatements en AdminDAO: " + ex.getMessage());
        }
    }
    
    
    public static int removeMessages (Integer... messageIds) {
        try {
            psRemoveMessages.setArray(0,
                    ds.getConnection().createArrayOf("INTEGER", messageIds));
            return psRemoveMessages.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error en removeMessages: " + ex.getMessage());
        }
        return 0;
    }
    public static int removeMessages (Collection<Integer> messageIds) {
        return removeMessages(messageIds.toArray(new Integer[messageIds.size()]));
    }
    
    
    public static int removeThreads (Integer... threadIds) {
        try {
            Connection cn = ds.getConnection();
            psSelectAffectedThreadMessages.setArray(0, cn.createArrayOf("INTEGER", threadIds));
            ResultSet rs = psSelectAffectedThreadMessages.executeQuery();
            ArrayList<Integer> messageList = new ArrayList<>();
            while (rs.next()) {
                messageList.add(rs.getInt("id"));
            }
            if (removeMessages(messageList) < 1)
                return 0;   
            
            psRemoveThreads.setArray(0,
                    cn.createArrayOf("INTEGER", threadIds));
            return psRemoveThreads.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error en removeThreads: " + ex.getMessage());
        }
        return 0;
    }
    public static int removeThreads (Collection<Integer> threadIds) {
        return removeThreads(threadIds.toArray(new Integer[threadIds.size()]));
    }
    
    public static boolean removeCategory (Integer categoryId) {
        try {
            psSelectAffectedCategoryThreads.setInt(0, categoryId);
            ResultSet rs = psSelectAffectedCategoryThreads.executeQuery();
            ArrayList<Integer> threadList = new ArrayList<>();
            while (rs.next()) {
                threadList.add(rs.getInt("id"));
            }
            
            if (removeThreads(threadList) < 1)
                return false;
            
            psRemoveCategory.setInt(0, categoryId);
            
            return psRemoveCategory.executeUpdate() > 0;
            
        } catch (SQLException ex) {
            System.err.println("Error en removeCategory: " + ex.getMessage());
        }
        return false;
    }
    
    
    
}

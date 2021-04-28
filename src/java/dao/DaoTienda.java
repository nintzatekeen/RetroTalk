/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import beans.Category;
import beans.User;
import beans.ForumThread;
import beans.Message;
import beans.PrivateMessage;
import beans.Product;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;
import java.util.List;
import org.apache.commons.dbcp2.BasicDataSource;
import utils.Utilities;

/**
 *
 * @author ACER
 */
public class DaoTienda {

    private static final int MAX_RESULTS = 30;
    private static final BasicDataSource ds = new BasicDataSource();

    private static PreparedStatement psGetUserById;
    private static PreparedStatement psGetMessages;
    private static PreparedStatement psGetMessageById;
    private static PreparedStatement psSendMessage;
    private static PreparedStatement psUpdateUser;

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

            String sqlGetUserById = "select id, username, password, email, bio, avatar, date from user where id=?";
            String sqlGetMessages = "select id, content, user, thread, date, quote from message where thread = ? limit ?," + MAX_RESULTS;
            String sqlGetMessageById = "select id, content, user, thread, date, quote from message where id = ?";
            String sqlSendMessage = "insert into message (content, user, thread, date, quote) values (?,?,?,now(),?)";
            String sqlUpdateUser = "update user set avatar=?, bio=?, email=?, password=? where id=?";

            psGetUserById = cn.prepareStatement(sqlGetUserById);
            psGetMessages = cn.prepareStatement(sqlGetMessages);
            psGetMessageById = cn.prepareStatement(sqlGetMessageById);
            psSendMessage = cn.prepareStatement(sqlSendMessage);
            psUpdateUser = cn.prepareStatement(sqlUpdateUser);
        } catch (SQLException ex) {
            System.err.println("Error al crear los preparedstatements: " + ex.getMessage());
        }
    }

    public static List<Product> getProducts() {
        String sql = "select id, title, description, price, user, date, img from product";
        ArrayList<Product> list = new ArrayList<Product>();
        try (Connection cn = ds.getConnection();
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                User user = getUserById(rs.getInt("user"));
                Product product = new Product(rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("description"),
                        (float) rs.getDouble("price"),
                        user,
                        rs.getDate("date"),
                        rs.getString("img"));
                list.add(product);
            }
        } catch (SQLException ex) {
            System.err.println("Error en getCategories: " + ex.getMessage());
        }
        return list;
    }

    public static User getUserById(Integer id) {
        try {
            psGetUserById.setInt(1, id);
            ResultSet rs = psGetUserById.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setAvatar(rs.getString("avatar"));
                user.setBio(rs.getString("bio"));
                user.setDate(rs.getDate("date"));
                user.setEmail(rs.getString("email"));
                user.setId(rs.getInt("id"));
                user.setPassword(rs.getString("password"));
                user.setUsername(rs.getString("username"));
                return user;
            }
        } catch (SQLException ex) {
            System.err.println("Error en getUserById: " + ex.getMessage());
        }
        return null;
    }

    public static void newPrivateMessage(PrivateMessage msg) {
        String sql = "INSERT INTO `private_message`(`user`, `product`, `message`, `date`)"
                + " VALUES (" + msg.getUser().getId() + "," + msg.getProduct().getId() + ",'" + msg.getContent() + "',now())";
        try (Connection cn = ds.getConnection();
                Statement st = cn.createStatement()) {
            st.executeUpdate(sql);

        } catch (SQLException ex) {
            System.err.println("Error en newPrivateMessage: " + ex.getMessage());
        }
    }

//    public static Message getMessageById(Integer id) {
//        try {
//            psGetMessageById.setInt(1, id);
//            ResultSet rs = psGetMessageById.executeQuery();
//            if (rs.next()) {
//                return new Message(rs.getInt("id"),
//                        rs.getString("content"),
//                        getUserById(rs.getInt("user")),
//                        rs.getDate("date")); 
//            }
//        } catch (SQLException ex) {
//            System.err.println("Error en getMessageById: " + ex.getMessage());
//        }
//        return null;
//    }
//    public static Collection<Message> getMessages(Integer threadId, Integer page) {
//        try {
//            psGetMessages.setInt(1, threadId);
//            psGetMessages.setInt(2, page * MAX_RESULTS);
//            ResultSet rs = psGetMessages.executeQuery();
//            ArrayList<Message> list = new ArrayList<Message>();
//            while (rs.next()) {
//                Message msg = new Message(rs.getInt("id"),
//                        rs.getString("content"),
//                        getUserById(rs.getInt("user")),
//                        rs.getDate("date"),
//                        getThreadById(rs.getInt("thread")));
//                if (rs.getInt("quote") != 0) {
//                    Message quoted = getMessageById(rs.getInt("quote"));
//                }
//                list.add(msg);
//            }
//            if (!list.isEmpty()) {
//                return list;
//            }
//        } catch (SQLException ex) {
//            System.err.println("Error en getMessages: " + ex.getMessage());
//        }
//        return null;
//    }
//
//    public static boolean sendMessage(User user, ForumThread thread, String content) {
//        try {
//            psSendMessage.setString(1, content);
//            psSendMessage.setInt(2, user.getId());
//            psSendMessage.setInt(3, thread.getId());
//            psSendMessage.setNull(4, java.sql.Types.INTEGER);
//            return psSendMessage.executeUpdate() != 0;
//        } catch (SQLException ex) {
//            System.err.println("Error en sendMessage: " + ex.getMessage());
//        }
//        return false;
//    }
//
//    public static boolean updateUser(User user) {
//        try {
//            psUpdateUser.setString(1, user.getAvatar());
//            psUpdateUser.setString(2, user.getBio());
//            psUpdateUser.setString(3, user.getEmail());
//            psUpdateUser.setString(4, user.getPassword());
//            psUpdateUser.setInt(5, user.getId());
//            return psUpdateUser.executeUpdate() != 0;
//        } catch (SQLException ex) {
//            System.err.println("Error en updateUser: " + ex.getMessage());
//            return false;
//        }
//    }
}

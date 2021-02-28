/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import beans.Category;
import beans.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.dbcp2.BasicDataSource;

/**
 *
 * @author ACER
 */
public class DaoRetro {

    private static final BasicDataSource ds = new BasicDataSource();
    private static PreparedStatement psAvailableUser;
    private static PreparedStatement psInsertUser;
    private static PreparedStatement psGetUserByUsername;

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

            String sqlAvailableUser = "select id from user where username = ?";
            String sqlInsertUser = "insert into user (username, password, email, date) values (?,?,?,now())";
            String sqlGetUserByUsername = "select (id, username, password, email, bio, avatar, date) from user where username=?";
            psAvailableUser = cn.prepareStatement(sqlAvailableUser);
            psInsertUser = cn.prepareStatement(sqlInsertUser);
            psGetUserByUsername = cn.prepareStatement(sqlGetUserByUsername);
        } catch (SQLException ex) {
        }
    }

    public static List<Category> getCategories() {
        String sql = "select id, name, description from category";
        ArrayList<Category> list = new ArrayList<Category>();
        try (Connection cn = ds.getConnection();
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Category category = new Category(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"));
                list.add(category);
            }
        } catch (SQLException ex) {
            System.err.println("Error en getCategories: " + ex.getMessage());
        }
        return list;
    }

    public static boolean isUserAvailable(String user) {
        try {
            psAvailableUser.setString(1, user);
            ResultSet rs = psAvailableUser.executeQuery();
            boolean ret = !rs.next();
            rs.close();
            return ret;
        } catch (SQLException ex) {
            System.err.println("Error en isUserAvailable: " + ex.getMessage());
        }
        return false;
    }

    public static void insertUser(User user) {
        try {
            psInsertUser.setString(1, user.getUsername());
            psInsertUser.setString(2, user.getPassword());
            psInsertUser.setString(3, user.getEmail());
            psInsertUser.executeUpdate();
        } catch (SQLException ex) {
            System.err.println("Error en insertUser: " + ex.getMessage());
        }
    }

    public static User getUserByUsername(String username) {
        try {
            psGetUserByUsername.setString(1, username);
            ResultSet rs = psGetUserByUsername.executeQuery();
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
            System.err.println("Error en getUserByUsername: " + ex.getMessage());
        }
        return null;
    }
}

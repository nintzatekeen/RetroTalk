/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import beans.Category;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.dbcp2.BasicDataSource;

/**
 *
 * @author ACER
 */
public class DaoRetro {
    private static final BasicDataSource ds = new BasicDataSource();

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
        } catch (SQLException ex) {
        }
    }
    
    public static List<Category> getCategories () {
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
            System.err.println("Error en getCategories: "+ex.getMessage());
        }
        return list;
    }
}

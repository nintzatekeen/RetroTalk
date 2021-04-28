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
public class DaoRetro {
    private static final int MAX_RESULTS = 30;
    private static final BasicDataSource ds = new BasicDataSource();
    private static PreparedStatement psAvailableUser;
    private static PreparedStatement psInsertUser;
    private static PreparedStatement psGetUserByUsername;
    private static PreparedStatement psGetThreads;
    private static PreparedStatement psGetUserById;
    private static PreparedStatement psGetCategoryById;
    private static PreparedStatement psGetMessages;
    private static PreparedStatement psGetThreadById;
    private static PreparedStatement psGetMessageById;
    private static PreparedStatement psGetLastThreadPage;
    private static PreparedStatement psSendMessage;
    private static PreparedStatement psCreateThread;
    private static PreparedStatement psGetUserThreads;
    private static PreparedStatement psGetLastCategoryPage;
    private static PreparedStatement psGetLastUserThreadsPage;
    private static PreparedStatement psUpdateUser;
    private static PreparedStatement psSearchThreads;
    private static PreparedStatement psGetLastSearchThread;

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
            String sqlGetUserByUsername = "select id, username, password, email, bio, avatar, date from user where username=?";
            String sqlGetThreads = "select id, title, user, category from thread where category = ? order by id desc limit ?,"+MAX_RESULTS;
            String sqlGetUserById = "select id, username, password, email, bio, avatar, date from user where id=?";
            String sqlGetCategoryById = "select id, name, description, icon from category where id = ?";
            String sqlGetMessages = "select id, content, user, thread, date, quote from message where thread = ? limit ?,"+MAX_RESULTS;
            String sqlGetThreadById = "select id, title, user, category from thread where id = ?";
            String sqlGetMessageById = "select id, content, user, thread, date, quote from message where id = ?";
            String sqlGetLastThreadPage = "select count(*) as messages from message where thread = ?";
            String sqlSendMessage = "insert into message (content, user, thread, date, quote) values (?,?,?,now(),?)";
            String sqlCreateThread = "insert into thread (title, user, category) values (?, ?, ?)";
            String sqlGetUserThreads = "select id, title, user, category "
                    + "from thread where user = ? order by id desc limit ?,"+MAX_RESULTS;
            String sqlGetLastCategoryPage = "select count(*) as threads from thread where category = ?";
            String sqlGetLastUserThreadsPage = "select count(*) as threads from thread where user = ?";
            String sqlUpdateUser = "update user set avatar=?, bio=?, email=?, password=? where id=?";
            String sqlSearchThreads = "select id, title, user, category from thread where upper(title) like upper(?) order by id desc limit ?, "+MAX_RESULTS;
            String sqlGetLastSearchThread = "select count(*) as threads from thread where upper(title) like upper(?)";

            psAvailableUser = cn.prepareStatement(sqlAvailableUser);
            psInsertUser = cn.prepareStatement(sqlInsertUser);
            psGetUserByUsername = cn.prepareStatement(sqlGetUserByUsername);
            psGetThreads = cn.prepareStatement(sqlGetThreads);
            psGetUserById = cn.prepareStatement(sqlGetUserById);
            psGetCategoryById = cn.prepareStatement(sqlGetCategoryById);
            psGetMessages = cn.prepareStatement(sqlGetMessages);
            psGetThreadById = cn.prepareStatement(sqlGetThreadById);
            psGetMessageById = cn.prepareStatement(sqlGetMessageById);
            psGetLastThreadPage = cn.prepareStatement(sqlGetLastThreadPage);
            psSendMessage = cn.prepareStatement(sqlSendMessage);
            psCreateThread = cn.prepareStatement(sqlCreateThread, Statement.RETURN_GENERATED_KEYS);
            psGetUserThreads = cn.prepareStatement(sqlGetUserThreads);
            psGetLastCategoryPage = cn.prepareStatement(sqlGetLastCategoryPage);
            psGetLastUserThreadsPage = cn.prepareStatement(sqlGetLastUserThreadsPage);
            psUpdateUser = cn.prepareStatement(sqlUpdateUser);
            psSearchThreads = cn.prepareStatement(sqlSearchThreads);
            psGetLastSearchThread = cn.prepareStatement(sqlGetLastSearchThread);
        } catch (SQLException ex) {
            System.err.println("Error al crear los preparedstatements: " + ex.getMessage());
        }
    }

    public static List<Category> getCategories() {
        String sql = "select id, name, description, icon from category";
        ArrayList<Category> list = new ArrayList<Category>();
        try (Connection cn = ds.getConnection();
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Category category = new Category(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("icon"));
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

    public static Category getCategoryById(Integer id) {
        try {
            psGetCategoryById.setInt(1, id);
            ResultSet rs = psGetCategoryById.executeQuery();
            if (rs.next()) {
                return new Category(rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getString("icon"));
            }
        } catch (SQLException ex) {
            System.err.println("Error en getCategoryById: " + ex.getMessage());
        }
        return null;
    }

    public static ForumThread getThreadById(Integer id) {
        try {
            psGetThreadById.setInt(1, id);
            ResultSet rs = psGetThreadById.executeQuery();
            if (rs.next()) {
                return new ForumThread(rs.getInt("id"),
                        rs.getString("title"),
                        getUserById(rs.getInt("user")),
                        getCategoryById(rs.getInt("category")));
            }
        } catch (SQLException ex) {
            System.err.println("Error en getThreadById: " + ex.getMessage());
        }
        return null;
    }

    public static Collection<ForumThread> getThreads(Integer categoryId, Integer page) {
        ArrayList<ForumThread> list = new ArrayList<ForumThread>();
        try {
            Integer msgFrom = page * MAX_RESULTS;
            psGetThreads.setInt(1, categoryId);
            psGetThreads.setInt(2, msgFrom);
            ResultSet rs = psGetThreads.executeQuery();
            while (rs.next()) {
                ForumThread thread = new ForumThread(rs.getInt("id"),
                        rs.getString("title"),
                        getUserById(rs.getInt("user")),
                        getCategoryById(rs.getInt("category")));
                list.add(thread);
            }
            if (!list.isEmpty()) {
                return list;
            }
        } catch (SQLException ex) {
            System.err.println("Error en getThreads: " + ex.getMessage());
        }
        return null;
    }

    public static Message getMessageById(Integer id) {
        try {
            psGetMessageById.setInt(1, id);
            ResultSet rs = psGetMessageById.executeQuery();
            if (rs.next()) {
                return new Message(rs.getInt("id"),
                        rs.getString("content"),
                        getUserById(rs.getInt("user")),
                        rs.getDate("date"),
                        getThreadById(rs.getInt("thread")));
            }
        } catch (SQLException ex) {
            System.err.println("Error en getMessageById: " + ex.getMessage());
        }
        return null;
    }

    public static Collection<Message> getMessages(Integer threadId, Integer page) {
        try {
            psGetMessages.setInt(1, threadId);
            psGetMessages.setInt(2, page * MAX_RESULTS);
            ResultSet rs = psGetMessages.executeQuery();
            ArrayList<Message> list = new ArrayList<Message>();
            while (rs.next()) {
                Message msg = new Message(rs.getInt("id"),
                        rs.getString("content"),
                        getUserById(rs.getInt("user")),
                        rs.getDate("date"),
                        getThreadById(rs.getInt("thread")));
                if (rs.getInt("quote") != 0) {
                    Message quoted = getMessageById(rs.getInt("quote"));
                }
                list.add(msg);
            }
            if (!list.isEmpty()) {
                return list;
            }
        } catch (SQLException ex) {
            System.err.println("Error en getMessages: " + ex.getMessage());
        }
        return null;
    }

    public static int getLastThreadPage(ForumThread thread) {
        try {
            Integer id = thread.getId();
            psGetLastThreadPage.setInt(1, id);
            ResultSet rs = psGetLastThreadPage.executeQuery();
            if (rs.next()) {
                Integer page = rs.getInt("messages") / MAX_RESULTS;
                return page;
            }
        } catch (SQLException ex) {
            System.err.println("Error en getLastThreadPage: " + ex.getMessage());
        }
        return 0;
    }

    public static int getLastCategoryPage(int id) {
        try {
            psGetLastCategoryPage.setInt(1, id);
            ResultSet rs = psGetLastCategoryPage.executeQuery();
            if (rs.next()) {
                Integer page = rs.getInt("threads") / MAX_RESULTS;
                return page;
            }
        } catch (SQLException ex) {
            System.err.println("Error en getLastCategoryPage: " + ex.getMessage());
        }
        return 0;
    }

    public static int getLastUserThreadsPage(User user) {
        try {
            Integer id = user.getId();
            psGetLastUserThreadsPage.setInt(1, id);
            ResultSet rs = psGetLastUserThreadsPage.executeQuery();
            if (rs.next()) {
                Integer page = rs.getInt("threads") / MAX_RESULTS;
                return page;
            }
        } catch (SQLException ex) {
            System.err.println("Error en getLastUserThreadsPage: " + ex.getMessage());
        }
        return 0;
    }

    public static boolean sendMessage(User user, ForumThread thread, String content) {
        try {
            psSendMessage.setString(1, content);
            psSendMessage.setInt(2, user.getId());
            psSendMessage.setInt(3, thread.getId());
            psSendMessage.setNull(4, java.sql.Types.INTEGER);
            return psSendMessage.executeUpdate() != 0;
        } catch (SQLException ex) {
            System.err.println("Error en sendMessage: " + ex.getMessage());
        }
        return false;
    }

    public static ForumThread createNewThread(Category category, User user, String title, String content) {
        try {
            psCreateThread.setString(1, title);
            psCreateThread.setInt(2, user.getId());
            psCreateThread.setInt(3, category.getId());

            psCreateThread.execute();

            ResultSet rs = psCreateThread.getGeneratedKeys();
            if (rs.next()) {
                Integer threadId = rs.getInt(1);
                if (threadId != 0) {
                    if (sendMessage(
                            user,
                            getThreadById(threadId),
                            content)) {
                        return getThreadById(threadId);
                    } else {
                        return null;
                    }
                }
            } else {
                return null;
            }

        } catch (SQLException ex) {
            System.err.println("Error en createNewThread: " + ex.getMessage());
        }
        return null;
    }

    public static Collection<ForumThread> getUserThreads(Integer userId, Integer page) {
        ArrayList<ForumThread> list = new ArrayList<ForumThread>();
        try {
            Integer msgFrom = page * MAX_RESULTS;
            psGetUserThreads.setInt(1, userId);
            psGetUserThreads.setInt(2, msgFrom);
            ResultSet rs = psGetUserThreads.executeQuery();
            while (rs.next()) {
                ForumThread thread = new ForumThread(rs.getInt("id"),
                        rs.getString("title"),
                        getUserById(rs.getInt("user")),
                        getCategoryById(rs.getInt("category")));
                list.add(thread);
            }
            if (!list.isEmpty()) {
                return list;
            }
        } catch (SQLException ex) {
            System.err.println("Error en getUserThreads: " + ex.getMessage());
        }
        return null;
    }

    public static boolean updateUser(User user) {
        try {
            psUpdateUser.setString(1, user.getAvatar());
            psUpdateUser.setString(2, user.getBio());
            psUpdateUser.setString(3, user.getEmail());
            psUpdateUser.setString(4, user.getPassword());
            psUpdateUser.setInt(5, user.getId());
            return psUpdateUser.executeUpdate() != 0;
        } catch (SQLException ex) {
            System.err.println("Error en updateUser: " + ex.getMessage());
            return false;
        }
    }

    public static Message getLastThreadMessage(int threadId) {
        String sql = "select id from message m1"
                + " where thread = " + threadId + " and "
                + "(select max(id) from message m2 where thread = " + threadId + ")"
                + " = m1.id";
        try (Connection cn = ds.getConnection();
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            return getMessageById(rs.getInt("id"));
        } catch (SQLException ex) {
            System.err.println("Error en getLastThreadMessage: " + ex.getMessage());
            return null;
        }
    }

    public static int getMessageCountByThread(int threadId) {
        String sql = "select count(id) as messages from message where thread = " + threadId;
        try (Connection cn = ds.getConnection();
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sql)) {
            return rs.getInt("message");
        } catch (SQLException ex) {
            System.err.println("Error en getMessageCountByThread: " + ex.getMessage());
            return -1;
        }
    }

    public static Collection<ForumThread> searchThreads(String text, Integer page) {
        try {
            if (text != null && !text.isEmpty()) {
                text = Utilities.format4Like(text);
                page = page != null ? page : 0;

                psSearchThreads.setString(1, text);
                psSearchThreads.setInt(2, page);
                ResultSet rs = psSearchThreads.executeQuery();
                LinkedList<ForumThread> threads = new LinkedList<ForumThread>();
                while (rs.next()) {
                    threads.add(new ForumThread(rs.getInt("id"),
                             rs.getString("title"),
                             getUserById(rs.getInt("user")),
                             getCategoryById(rs.getInt("category"))));
                }
                return threads;
            }
        } catch (SQLException ex) {
            System.err.println("Error en searchThreads: " + ex.getMessage());
        }
        return null;
    }

    public static int getLastSearchThread(String text) {
        try {
            if (text != null && !text.isEmpty()) {
                psGetLastSearchThread.setString(1, Utilities.format4Like(text));
                ResultSet rs = psGetLastSearchThread.executeQuery();
                if (rs.next())
                    return rs.getInt("threads") / MAX_RESULTS;
            }
        } catch (SQLException ex) {
            System.err.println("Error en getLastSearchThreadsPage: " + ex.getMessage());
        }
        return 0;
    }
    
    public static Category getCategoryByThreadId(Integer threadId) {
        if (threadId != null && threadId > 0) {
            ForumThread thread = getThreadById(threadId);
            return thread != null ? thread.getCategory() : null;
        }
        return null;
    }
}

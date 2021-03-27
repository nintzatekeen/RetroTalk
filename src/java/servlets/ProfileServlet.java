/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlets;

import beans.User;
import dao.DaoRetro;
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
import org.jasypt.util.text.AES256TextEncryptor;

/**
 *
 * @author ACER
 */
@MultipartConfig
public class ProfileServlet extends HttpServlet {
    
    private static final String avatarPath = "avatars/";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");

        String oldPass = request.getParameter("oldPass");
        String newPass = request.getParameter("newPass");
        String newPassConfirm = request.getParameter("newPassConfirm");
        String email = request.getParameter("email");
        String bio = request.getParameter("bio");
        Part avatar = request.getPart("avatar");
        
        String realPath = request.getServletContext().getRealPath("avatars");

        if (!oldPass.isEmpty() || !newPass.isEmpty() || !newPassConfirm.isEmpty()) {
            if (oldPass.isEmpty() || newPass.isEmpty() || newPassConfirm.isEmpty()) {
                request.setAttribute("error", "No puede quedar ningún campo de contraseña vacío si se ha decidido cambiarla");
                request.getRequestDispatcher("editProfile.jsp").forward(request, response);
            } else {
                AES256TextEncryptor encryptor = new AES256TextEncryptor();
                encryptor.setPassword(request.getServletContext().getInitParameter("encryptionPass"));
                if (oldPass.equals(encryptor.decrypt(user.getPassword()))) {
                    if (newPass.equals(newPassConfirm)) {
                        if (updateOtherData(user, realPath, avatar, email, bio)) {
                            String newPassword = encryptor.encrypt(newPass);
                            user.setPassword(newPassword);
                            if (DaoRetro.updateUser(user)) {
                                response.sendRedirect("profile.jsp?user=" + user.getId());
                            } else {
                                request.getSession().setAttribute("user", DaoRetro.getUserById(user.getId()));
                                request.setAttribute("error", "No se pudo actualizar la info");
                                request.getRequestDispatcher("editProfile.jsp").forward(request, response);
                            }
                        }
                    } else {
                        request.setAttribute("error", "Las nuevas contraseñas no coinciden");
                        request.getRequestDispatcher("editProfile.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("error", "Ha introducido una contraseña antigua incorrecta");
                    request.getRequestDispatcher("editProfile.jsp").forward(request, response);
                }
            }
        } else {
            if (!updateOtherData(user, realPath, avatar, email, bio)) {
                request.setAttribute("error", "El emilio no debe quedar vacío");
                request.getRequestDispatcher("editProfile.jsp").forward(request, response);
            } else {
                updateOtherData(user, realPath, avatar, email, bio);
                if (DaoRetro.updateUser(user)) {
                    response.sendRedirect("profile.jsp?user=" + user.getId());
                } else {
                    request.getSession().setAttribute("user", DaoRetro.getUserById(user.getId()));
                    request.setAttribute("error", "No se pudo actualizar la info");
                    request.getRequestDispatcher("editProfile.jsp").forward(request, response);
                }
            }
        }

    }

    private static boolean updateOtherData(User user, String realPath, Part avatar, String email, String bio) {
        if (email.isEmpty()) {
            return false;
        } else {
            if (avatar != null) {
                String extension = getExtension(
                        Paths.get(avatar.getSubmittedFileName()).getFileName().toString());
                
                String fileStr = realPath;
                
                if (realPath.split("/").length > realPath.split("\\\\").length)
                    fileStr += "/";
                else
                    fileStr += "\\";

                fileStr += user.getUsername() + extension;
                String imgStr = avatarPath + user.getUsername() + extension;
                if (extension != null) {
                    try (InputStream is = avatar.getInputStream();
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
                        user.setAvatar(imgStr);
                    } catch (IOException ex) {
                        System.err.println("Error al escribir la imagen: "+ex.getMessage());
                    }

                }
            }
            user.setBio(bio);
            user.setEmail(email);
            return true;
        }
    }

    private static String getExtension(String fileName) {
        if (fileName == null) {
            return null;
        } else if (fileName.lastIndexOf(".") < 0) {
            return null;
        } else {
            return fileName.substring(fileName.lastIndexOf("."));
        }

    }
}

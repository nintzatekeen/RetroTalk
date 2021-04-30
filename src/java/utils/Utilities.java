/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package utils;

import beans.Message;
import beans.User;
import dao.DaoRetro;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 *
 * @author ACER
 */
public class Utilities {

    public static final Pattern imgPattern = Pattern.compile("\\[img\\](?<link>.*?)\\[/img\\]", Pattern.CASE_INSENSITIVE);
    public static final Pattern quotePattern = Pattern.compile("\\[quote\\](?<id>\\d*)\\[/quote\\]", Pattern.CASE_INSENSITIVE);

    public static boolean checkAdmin(User user) {
        User admin = dao.DaoRetro.getUserByUsername("admin");
        return admin.equals(user);
    }

    private static String replaceImages(String originalMessage) {
        String msg = originalMessage;
        Matcher matcher = imgPattern.matcher(msg);
        while (matcher.find()) {
            try {
                String link = matcher.group("link");
                int start = msg.indexOf(matcher.group());
                int end = start + matcher.group().length() - 1;
                String aux = msg.substring(0, start);
                if (aux.length() > 0) {
                    aux += "<br/>";
                }
                aux += "<img style='max-height:250px;max-width:250px' src='" + link + "'><br/>";
                aux += msg.substring(end + 1, msg.length());
                msg = aux;
            } catch (Exception e) {
            }
        }
        return msg;
    }

    private static String replaceQuotes(String originalMessage) {
        String msg = originalMessage;

        Matcher matcher = quotePattern.matcher(msg);

        while (matcher.find()) {
            try {
                String msgId = matcher.group("id");
                Integer id = Integer.parseInt(msgId);
                Message message = DaoRetro.getMessageById(id);
                String text = message.getContent();
                text = text.replaceAll("\\[quote\\].*?\\[\\/quote\\]", "");
                text = text.replaceAll("\\[QUOTE\\].*?\\[\\/QUOTE\\]", "");
                text = replaceImages(text);

                int start = msg.indexOf(matcher.group());
                int end = start + matcher.group().length() - 1;
                String aux = msg.substring(0, start);
                aux += "<br/>Cita de " + message.getUser().getUsername() + "<br/><span class='quote'>" + text + "</span><br/>";
                aux += msg.substring(end + 1, msg.length());
                msg = aux;
            } catch (Exception e) {
            }
        }
        return msg;
    }

    public static String formatMsgOutput(String originalMessage) {
        String msg = originalMessage;
        msg = replaceImages(msg);
        msg = replaceQuotes(msg);

        return msg;
    }

    public static String format4Like(String text) {
        return "%" + text
                .replaceAll("\\[", "[[]")
                .replaceAll("\\]", "[]]")
                .replaceAll("%", "[%]") + "%";
    }

    public static String getExtension(String fileName) {
        if (fileName == null) {
            return null;
        } else if (fileName.lastIndexOf(".") < 0) {
            return null;
        } else {
            return fileName.substring(fileName.lastIndexOf("."));
        }

    }
}

package com.ems.util;

import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailUtil {
    
    private static final String FROM_EMAIL = "abhisekkhatua772@gmail.com";
    private static final String FROM_NAME = "WorkSphere";
    private static final String PASSWORD = "grgz urvf oufr rmhp";
    private static final String HOST = "smtp.gmail.com";
    private static final String PORT = "587";

    public static boolean sendEmail(String toEmail, String subject, String message) {
        try {
            Properties props = new Properties();
            props.put("mail.smtp.host", HOST);
            props.put("mail.smtp.port", PORT);
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.trust", "*");
            props.put("mail.smtp.ssl.protocols", "TLSv1.2");
            
            Session session = Session.getInstance(props, new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(FROM_EMAIL, PASSWORD.replaceAll("\\s+", ""));
                }
            });
            
            
            Message mailMessage = new MimeMessage(session);
            
            mailMessage.setFrom(new InternetAddress(FROM_EMAIL, FROM_NAME));
            mailMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            mailMessage.setSubject(subject);
            
            mailMessage.setContent(message, "text/html; charset=utf-8");
            
            Transport.send(mailMessage);
            System.out.println("✅ EMAIL SENT SUCCESSFULLY!");
            return true;
            
        } catch (Exception e) {
            System.err.println("❌ EMAIL SENDING FAILED: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
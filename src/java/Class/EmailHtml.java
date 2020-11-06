/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Class;

import java.util.Date;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.swing.JOptionPane;

/**
 *
 * @author Dinidu Lochana
 */
public class EmailHtml {

    private static String u;
    private static String p;

    public static void Send(String mail, final String From, final String Pass, String To, String Subject, String Body) {
        try {
            Properties props = new Properties();
            // props.put("mail.smtp.host", "smtp.mail.yahoo.com"); // for gmail use smtp.gmail.com
            props.put("mail.smtp.host", mail);
            props.put("mail.smtp.auth", "true");
            props.put("mail.debug", "true");
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.port", "465");
            props.put("mail.smtp.socketFactory.port", "465");
            props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            props.put("mail.smtp.socketFactory.fallback", "false");

            Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(From, Pass);
                }
            });

            mailSession.setDebug(true); // Enable the debug mode

            Message msg = new MimeMessage(mailSession);

            //--[ Set the FROM, TO, DATE and SUBJECT fields
            msg.setFrom(new InternetAddress(From));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(To));
            msg.setSentDate(new Date());
            msg.setSubject(Subject);
            //--[ Create the body of the mail
            msg.setText(Body);

//            MimeBodyPart messagebodypart = new MimeBodyPart();
//            messagebodypart = new MimeBodyPart();
//            messagebodypart.setFileName(Body);
//            msg.
            //--[ Ask the Transport class to send our mail message
            Transport.send(msg);

        } catch (Exception E) {
            System.out.println(E + "");
        }
    }

    public static void htmlcontent(String to, String from, String pass, String html, String subject) {
        u = from;
        p = pass;
        Properties props = new Properties();
        //type gmail="smtp.gmail.com" Ymail = "smtp.mail.yahoo.com"
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.auth", "true");
        props.put("mail.debug", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.port", "465");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.socketFactory.fallback", "false");

        Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {

                return new PasswordAuthentication(u, new String(p));
            }
        });

        mailSession.setDebug(true);
        try {
            // Create a default MimeMessage object.
            MimeMessage message = new MimeMessage(mailSession);

            // Set From: header field of the header.
            message.setFrom(new InternetAddress(from));

            // Set To: header field of the header.
            message.addRecipient(Message.RecipientType.TO,
                    new InternetAddress(to));

            // Set Subject: header field
            message.setSubject(subject);

            // Send the actual HTML message, as big as you like
            message.setContent(html,
                    "text/html");

            // Send message
            Transport.send(message);
            System.out.println("Sent message successfully....");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}

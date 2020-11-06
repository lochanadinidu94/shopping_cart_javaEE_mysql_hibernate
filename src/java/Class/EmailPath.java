/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Class;

import com.sun.mail.smtp.SMTPTransport;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.swing.JOptionPane;

/**
 *
 * @author Dinidu Lochana
 */
public class EmailPath {

    public static void SendMail(String uba, String mokakda, String mama, String password, String body) throws javax.mail.MessagingException {
        try {

            String[] guy = {uba};                           //labanna
            String fnm = mokakda;                           //attatching file path............
            String from = mama;                             //ywanna
            String pass = password;                         //password
            String Subject = body;                          //body aka
            String host = "smtp.gmail.com";

            Properties prop = new Properties();
            prop = System.getProperties();
            prop.put("mail.smtp.starttls.enable", "true");
            prop.put("mail.smtp.host", host);
            prop.put("mail.smtp.socketFactory.port", 465);
            prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
            prop.put("mail.smtp.user", from);
            prop.put("mail.smtp.password", pass);
            prop.put("mail.smtp.port", 465);
            prop.put("mail.smtp.auth", "true");

            Session ses = Session.getDefaultInstance(prop, null);
            Message mm = new MimeMessage(ses);
            mm.setFrom(new InternetAddress(from));
            InternetAddress[] ias = new InternetAddress[guy.length];

            for (int i = 0; i < guy.length; i++) {
                ias[i] = new InternetAddress(guy[i]);
            }

            for (int i = 0; i < ias.length; i++) {
                mm.addRecipients(Message.RecipientType.TO, ias);
            }

            mm.setSubject("DR:PC Software Solution");

            MimeBodyPart mbp = new MimeBodyPart();

            //Multipart mp = new MimeMultipart();

            MimeBodyPart messagebodypart = new MimeBodyPart();
            messagebodypart = new MimeBodyPart();
            //javax.activation.DataSource source = new FileDataSource(fnm);
            //messagebodypart.setDataHandler(new DataHandler(source));
            
            messagebodypart.setFileName(body);
            //mp.addBodyPart(messagebodypart);
            //mm.setContent(mp);

            SMTPTransport tran = (SMTPTransport) ses.getTransport("smtp");

            //////////////////////////////////
            //System.out.println(messagebodypart);
            //System.out.println("Ok 1");
            //System.out.println(body);
            tran.connect(host, 465, from, pass);
            //System.out.println("1");
            tran.sendMessage(mm, mm.getAllRecipients());
            //System.out.println("Ok");
            tran.close();
            //////////////////////////////////

        } catch (Exception ex) {
            System.out.println(ex + "");
        }

    }

}

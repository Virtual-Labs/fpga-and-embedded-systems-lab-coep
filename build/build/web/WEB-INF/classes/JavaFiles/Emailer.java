/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package JavaFiles;

import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Emailer {

    public void sendEmail(
            String aFromEmailAddr, String aToEmailAddr,
            String aSubject, String aBody) {
        try {
            Properties props = new Properties();
            //props.put("mail.smtp.host", "mail.atpune.in");  
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.debug", "true");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");
            //props.put("mail.smtp.localhost", "atpune.in");  

            Session s = Session.getInstance(props, null);
            s.setDebug(true);

            MimeMessage message = new MimeMessage(s);

            InternetAddress from = new InternetAddress(aFromEmailAddr, "Virtual Lab COEP admin");
            InternetAddress to = new InternetAddress(aToEmailAddr);

            message.setSentDate(new Date());
            message.setFrom(from);
            message.addRecipient(Message.RecipientType.TO, to);

            message.setSubject(aSubject);
            message.setContent(aBody, "text/html");

            Transport tr = s.getTransport("smtp");
            //tr.connect("mail.atpune.in", "admin@atpune.in", "admin123");  
            tr.connect("smtp.gmail.com", "coepinstrumentationdepartmenT@gmail.com", "COEPINSTRU");
            message.saveChanges();
            tr.sendMessage(message, message.getAllRecipients());
            tr.close();
        } catch (AddressException ex) {
            Logger.getLogger(Emailer.class.getName()).log(Level.SEVERE, null, ex);
        } catch (MessagingException ex) {
            Logger.getLogger(Emailer.class.getName()).log(Level.SEVERE, null, ex);
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(Emailer.class.getName()).log(Level.SEVERE, null, ex);
        }



    }
}
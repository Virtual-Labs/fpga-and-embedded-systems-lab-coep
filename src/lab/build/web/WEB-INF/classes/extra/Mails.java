/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package extra;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

/**
 *
 * @author root
 */
public class Mails {
   public void sendMail(String subject, String mail){
               
		
		//String username = "embeddedfpgavlab";
		//String password = "fpgapranav";
 
		Properties props = new Properties();
		props.put("mail.smtp.host", "smtp.gmail.com");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class",
				"javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");
 
		Session session = Session.getDefaultInstance(props,
			new javax.mail.Authenticator() {
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication("embeddedfpgavlab","fpgapranav");
				}
			});
		
 
		try {
 
			Message message = new MimeMessage(session);
			
			message.setRecipients(Message.RecipientType.TO,
					InternetAddress.parse("dns.instru@coep.ac.in"));
			message.setSubject(subject);
			message.setText(mail);
 
			Transport.send(message);
 
			System.out.println("Done");
 
		} catch (MessagingException e) {
			throw new RuntimeException(e);
		}


   } 
}

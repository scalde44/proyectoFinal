/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UsuarioBEANS;

import java.io.File;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Session;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Transport;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.InternetAddress;
import javax.swing.JOptionPane;

/**
 *
 * @author Windows
 */
public class MailSender {

//declaración de nuestras variables
//correo electrónico que se utilizara para enviar los mail
    private String Username = "meetingoffice4@gmail.com";
//contraseña de correo electrónico
    private String PassWord = "Scalderon4";
//mensaje
    String Mensage = "";
//destino de mail
    String To = "";
//asunto a tratar
    String Subject = "";
  
  
//métodos para obtener o cambiar información de nuestras variables

    public void mensaje(String mensaje) {
        this.Mensage = mensaje;
    }

    public void para(String para) {
        this.To = para;
    }

    public void asunto(String asunto) {
        this.Subject = asunto;
    }

// este método autentifica el usuario y contraseña y enviar el mail a el destinatario

    public void SendMail() {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(Username, PassWord);
            }
        });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(Username));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(To));
            message.setSubject(Subject);
            message.setText(Mensage);

            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
    }
}

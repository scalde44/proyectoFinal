/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import UsuarioBEANS.MailSender;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import Utils.ConexionBD;
import java.sql.*;
import javax.servlet.http.HttpSession;
import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @author steve
 */
@WebServlet(name = "ServletLogin", urlPatterns = {"/ServletLogin"})
public class ServletLogin extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        MailSender ms=new MailSender();
        String correo = request.getParameter("txtCorreo");
        Connection cnx = ConexionBD.getConexion();
        String contrasenaTemporal=String.valueOf((int)100000000*Math.random());
        String contrasenaEncriptada = DigestUtils.md5Hex(contrasenaTemporal);
        try {
            PreparedStatement sta = cnx.prepareStatement("select * from usuarios where correo=?");
            sta.setString(1, correo);
            ResultSet rs = sta.executeQuery();
            if (rs.next()) {
                PreparedStatement sta1=cnx.prepareStatement("update usuarios set contrasena=? where correo=?");
                sta1.setString(1, contrasenaEncriptada);
                sta1.setString(2, correo);
                sta1.executeUpdate();
                ms.para(correo);
                ms.asunto("Recuperacion de la contraseña");
                ms.mensaje("Meeting Office:\n Usuario:"+rs.getString("nombre")+"\n Correo:"+correo+"\n Contraseña:"+contrasenaTemporal);
                ms.SendMail();
                request.setAttribute("msg", "Correo de recuperacion enviado");
                request.getRequestDispatcher("Login.jsp").forward(request, response);
            }else{
               request.setAttribute("msg", "Compruebe el correo o la contraseña");
                request.getRequestDispatcher("recuperarContrasena.jsp").forward(request, response); 
            }
        } catch (SQLException ex) {
            request.setAttribute("msg", ex);
                request.getRequestDispatcher("recuperarContrasena.jsp").forward(request, response);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    //Metodo Post
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
        String correo = request.getParameter("txtCorreo");
        String contrasena = request.getParameter("txtContra");
        String contrasenaEncriptada = DigestUtils.md5Hex(contrasena);
        Connection cnx = ConexionBD.getConexion();
        try {
            PreparedStatement sta = cnx.prepareStatement("select * from usuarios where correo=? and contrasena=?");
            sta.setString(1, correo);
            sta.setString(2, contrasenaEncriptada);

            ResultSet rs = sta.executeQuery();

            PreparedStatement sta1 = cnx.prepareStatement("select * from administradores where correo=? and contrasena=?");
            sta1.setString(1, correo);
            sta1.setString(2, contrasenaEncriptada);

            ResultSet rs1 = sta1.executeQuery();

            if (rs1.next()) {
                HttpSession sesionOkk = request.getSession();
                sesionOkk.setAttribute("administrador", correo);
                request.getRequestDispatcher("principal.jsp").forward(request, response);

            }
            if (rs.next()) {
                HttpSession sesionOk = request.getSession();
                sesionOk.setAttribute("usuario", correo);
                request.getRequestDispatcher("principalReuniones.jsp").forward(request, response);
                
            } else {
                request.setAttribute("msg", "Compruebe el correo o la contraseña");
                request.getRequestDispatcher("Login.jsp").forward(request, response);

            }
        } catch (Exception e) {
            System.err.println(e);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

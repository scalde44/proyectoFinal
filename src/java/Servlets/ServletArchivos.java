/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import UsuarioBEANS.Archivo;
import Utils.ConexionBD;
import java.awt.Desktop;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Hashtable;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javazoom.upload.MultipartFormDataRequest;
import javazoom.upload.UploadBean;
import javazoom.upload.UploadException;
import javazoom.upload.UploadFile;

/**
 *
 * @author steve
 */
@WebServlet(name = "ServletArchivos", urlPatterns = {"/ServletArchivos"})
@MultipartConfig
public class ServletArchivos extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try {
            Connection cn = ConexionBD.getConexion();
            String accion1 = request.getParameter("accion1");
            if (accion1.equalsIgnoreCase("abrir")) {
                String nombre = request.getParameter("nombre");

                try {

                    File objetofile = new File("C:\\Users\\steve\\OneDrive\\Escritorio\\Archivos\\" + nombre);
                    Desktop.getDesktop().open(objetofile);

                } catch (IOException ex) {

                    System.out.println(ex);

                }
                request.setAttribute("msg1", "Archivo abierto");
                request.getRequestDispatcher("listaArchivos.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("msg1", e.getMessage());
            request.getRequestDispatcher("buscarArchivo.jsp").forward(request, response);

        }
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            Connection cn = ConexionBD.getConexion();
            MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
            UploadBean upBean;
            File crearArchivo;
            String accion = mrequest.getParameter("accion");
            String nombreArchivo;
            String tipoArchivo;
            String tamanoArchivo;
            String direccion = "C:\\Users\\steve\\OneDrive\\Escritorio\\Archivos\\";

            if (accion.equalsIgnoreCase("subir")) {

                Hashtable files = mrequest.getFiles();
                if (!files.isEmpty()) {
                    UploadFile file = (UploadFile) files.get("archivoSubido");
                    upBean = new UploadBean();
                    upBean.setFolderstore(direccion);
                    nombreArchivo = file.getFileName();
                    tipoArchivo = file.getContentType();
                    long tamano = file.getFileSize() / 1024;
                    tamanoArchivo = Long.toString(tamano) + " KB";
                    crearArchivo = new File(direccion + nombreArchivo);
                    String n = nombreArchivo.substring(0, nombreArchivo.lastIndexOf('.'));
                    upBean.store(mrequest, "archivoSubido");

                    request.setAttribute("msg1", "El archivo: " + nombreArchivo + " ha sido subido exitosamente");
                    request.getRequestDispatcher("subirArchivo.jsp").forward(request, response);

                }

            }
        } catch (UploadException ex) {
            request.setAttribute("msg1", "Archivo no encontrado");
            request.getRequestDispatcher("buscarArchivo.jsp").forward(request, response);

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

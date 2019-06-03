/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import Utils.ConexionBDReunion;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperRunManager;

/**
 *
 * @author steve
 */
@WebServlet(name = "ServletActas", urlPatterns = {"/ServletActas"})
public class ServletActas extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ServletActas</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServletActas at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        String salida;
        String accion = request.getParameter("accion");
        String idR = request.getParameter("idR");
        int idd = Integer.parseInt(idR);
        if (accion.equalsIgnoreCase("generarActa")) {
            try {

                String ruta = "/WEB-INF/actas/reporteReunion.jasper";
                File acta = new File(request.getRealPath(ruta));
                HashMap hm = null;

                hm = new HashMap();

                hm.put("idR", idR);

                ServletOutputStream servletOutputStream = response.getOutputStream();

                byte[] bytes = null;

                Connection cnxr = ConexionBDReunion.getConexion();

                try {

                    bytes = JasperRunManager.runReportToPdf(acta.getPath(), hm, cnxr);
                    response.setContentType("application/pdf");
                    response.setContentLength(bytes.length);
                    servletOutputStream.write(bytes, 0, bytes.length);
                    servletOutputStream.flush();
                    servletOutputStream.close();
                    PreparedStatement staEl = cnxr.prepareStatement("update reunion set estadoReunion=? where ID_Reunion=?");
                    staEl.setString(1, "Finalizada");
                    staEl.setInt(2, idd);
                    staEl.executeUpdate();
                } catch (JRException e) {
                    StringWriter stringWriter = new StringWriter();
                    PrintWriter printWriter = new PrintWriter(stringWriter);
                    e.printStackTrace(printWriter);
                    response.setContentType("text/plain");
                    response.getOutputStream().print(stringWriter.toString());
                }

            } catch (Exception e) {
                request.setAttribute("msg", e);
                request.getRequestDispatcher("principalReuniones.jsp").forward(request, response);
            }
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
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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

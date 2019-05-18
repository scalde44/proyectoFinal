/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import UsuarioBEANS.MailSender;
import UsuarioBEANS.Reuniones;
import Utils.ConexionBD;
import Utils.ConexionBDReunion;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigInteger;
import java.sql.Connection;
import java.util.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.activation.MimetypesFileTypeMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javazoom.upload.UploadBean;
import javazoom.upload.UploadFile;
import org.apache.poi.xwpf.usermodel.ParagraphAlignment;
import org.apache.poi.xwpf.usermodel.UnderlinePatterns;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;

/**
 *
 * @author steve
 */
@WebServlet(name = "ServletReunion", urlPatterns = {"/ServletReunion"})
public class ServletReunion extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    MailSender ms = new MailSender();

    // Acta
    private XWPFDocument document = new XWPFDocument();

    public int generarActa(int idReunion, String nombreReunion, String asis[], String lugar, String objetivos, String fecha, String hora, String comentarios) {
        int salida = 0;
        String direccion = "C:\\Users\\steve\\OneDrive\\Escritorio\\Archivos\\";

        try {
            File ruta = new File(direccion + nombreReunion + ".docx");
            OutputStream output = new FileOutputStream(ruta);

            XWPFParagraph paragraphTitulo = document.createParagraph();
            XWPFRun runTitulo = paragraphTitulo.createRun();
            paragraphTitulo.setAlignment(ParagraphAlignment.CENTER);
            runTitulo.setBold(true);
            runTitulo.setFontSize(14);
            runTitulo.setUnderline(UnderlinePatterns.WORDS);
            runTitulo.setText(nombreReunion);
            runTitulo.setColor("2f66f2");
            runTitulo.addBreak();
            XWPFParagraph paragraph = document.createParagraph();
            XWPFRun run = paragraph.createRun();

            for (int i = 0; i < asis.length; i++) {
                XWPFParagraph paragraphLista = document.createParagraph();
                XWPFRun runLista = paragraphLista.createRun();
                runLista.setText(asis[i]);
                paragraphLista.setNumID(BigInteger.ONE);
                runLista.addBreak();
            }
            run.setText("Id " + idReunion);
            run.addBreak();
            run.setText("Lugar " + lugar);
            run.addBreak();
            run.setText("Fecha " + fecha);
            run.addBreak();
            run.setText("Hora " + hora);
            run.addBreak();
            document.write(output);
            output.close();
            try {
                MimetypesFileTypeMap mimeTypesMap = new MimetypesFileTypeMap();
                String mimeType = mimeTypesMap.getContentType(direccion + nombreReunion + ".docx");
                mimeType = mimeTypesMap.getContentType(ruta);
                long tamano = ruta.length() / 1024;
                String tamanoArchivo = Long.toString(tamano) + " KB";
                Connection cn = ConexionBD.getConexion();
                PreparedStatement sta = cn.prepareStatement("insert into archivo(nombreArchivo,direccionArchivo,tipoArchivo,tamanoArchivo)"
                        + "values(?,?,?,?)");
                sta.setString(1, nombreReunion + ".docx");
                sta.setString(2, ruta.getAbsolutePath());
                sta.setString(3, mimeType);
                sta.setString(4, tamanoArchivo);
                sta.executeUpdate();
            } catch (SQLException ex) {
            }
            try {
                Connection cn = ConexionBD.getConexion();
                PreparedStatement sta1 = cn.prepareStatement("select * from archivo where nombreArchivo=?");
                sta1.setString(1, nombreReunion + ".docx");
                ResultSet rs = sta1.executeQuery();
                if (rs.next()) {
                    salida = Integer.parseInt(rs.getString(1));
                }
            } catch (SQLException ex) {
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return salida;
    }
//

    public ResultSet mostrarLugar(int id) throws SQLException {
        Connection cnxr = ConexionBD.getConexion();

        PreparedStatement sta = cnxr.prepareStatement("select * from lugar where ID_Lugar=?");
        sta.setInt(1, id);
        ResultSet rs = sta.executeQuery();
        return rs;

    }

    public ResultSet mostrarUsuario(String correo) throws SQLException {
        Connection cnxr = ConexionBD.getConexion();

        PreparedStatement sta = cnxr.prepareStatement("select * from usuarios where correo=?");
        sta.setString(1, correo);
        ResultSet rs = sta.executeQuery();
        return rs;

    }

    public ResultSet mostrar() throws SQLException {
        Connection cnxr = ConexionBD.getConexion();

        PreparedStatement sta = cnxr.prepareStatement("select * from lugar");
        ResultSet rs = sta.executeQuery();
        return rs;

    }

    public ResultSet mostrarDatosReunion(int idReunion) throws SQLException {
        Connection cnxr = ConexionBD.getConexion();

        PreparedStatement sta = cnxr.prepareStatement("select * from reunion where ID_Reunion=?");
        sta.setInt(1, idReunion);
        ResultSet rs = sta.executeQuery();
        return rs;

    }

    public ResultSet mostrarDatosReunion2(int idUser) throws SQLException {
        Connection cnxr = ConexionBD.getConexion();

        PreparedStatement sta = cnxr.prepareStatement("select * from participantes where ID_Usuario=?");
        sta.setInt(1, idUser);
        ResultSet rs = sta.executeQuery();
        return rs;

    }

    public ResultSet mostrarIDname() throws SQLException {
        Connection cnxr = ConexionBD.getConexion();
        PreparedStatement sta = cnxr.prepareStatement("select * from usuarios");
        ResultSet rs = sta.executeQuery();
        return rs;

    }

    public ResultSet participantesEstaReunion(int reunion, int usuario) throws SQLException {
        Connection cnxr = ConexionBD.getConexion();
        PreparedStatement sta = cnxr.prepareStatement("select * from participantes where ID_Reunion=? and ID_Usuario=?");
        sta.setInt(1, reunion);
        sta.setInt(2, usuario);
        ResultSet rs = sta.executeQuery();
        return rs;

    }

    public ResultSet emailVinculados(int usuario) throws SQLException {
        Connection cnxr = ConexionBD.getConexion();
        PreparedStatement sta = cnxr.prepareStatement("select * from usuarios where ID_Usuario=?");
        sta.setInt(1, usuario);
        ResultSet rs = sta.executeQuery();
        return rs;

    }
    // Parse fecha

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String accion = request.getParameter("accion");
        String usu = request.getParameter("usuario");
        Connection cnxr = ConexionBDReunion.getConexion();
        if (accion.equals("listar")) {
            try {
                PreparedStatement sta = cnxr.prepareStatement("select * from reunion where coordinadorReunion=?");
                sta.setString(1, usu);
                ResultSet rs = sta.executeQuery();

                ArrayList<Reuniones> lista = new ArrayList<Reuniones>();
                while (rs.next()) {
                    Reuniones r = new Reuniones(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getDate(6), rs.getTime(7), rs.getString(8));
                    lista.add(r);
                }
                request.setAttribute("lista", lista);
                request.getRequestDispatcher("listaReuniones.jsp").forward(request, response);
            } catch (Exception e) {
            }

        } else if (accion.equals("crear")) {
            String coordinador = request.getParameter("usuario");
            int idLugar = Integer.parseInt(request.getParameter("txtLugar"));
            String nombre = request.getParameter("txtNombreReunion");
            String objetivos = request.getParameter("txtAsunto");
            String fechaString = request.getParameter("txtFecha");
            String horaString = request.getParameter("txtHora");
            String estado = "Activa";
            //  Castear Fecha
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            Date parsed = format.parse(fechaString);
            java.sql.Date fecha = new java.sql.Date(parsed.getTime());
            //  Castear Hora
            DateFormat formatter = new SimpleDateFormat("HH:mm");
            java.sql.Time hora = new java.sql.Time(formatter.parse(horaString).getTime());
            //
            PreparedStatement sta1 = cnxr.prepareStatement("select * from reunion where fechaReunion=? and horaReunion=?");
            sta1.setDate(1, fecha);
            sta1.setTime(2, hora);
            ResultSet rss = sta1.executeQuery();
            if (rss.next()) {
                request.setAttribute("msg", "Reunion ya creada a esa hora y en esa fecha");
                request.getRequestDispatcher("nuevaReunion.jsp").forward(request, response);
            } else {
                try {

                    PreparedStatement sta = cnxr.prepareStatement("insert into reunion"
                            + "(coordinadorReunion,nombreReunion,ID_Lugar,objetivosReunion,fechaReunion,horaReunion,estadoReunion)values(?,?,?,?,?,?,?)");
                    sta.setString(1, coordinador);
                    sta.setString(2, nombre);
                    sta.setInt(3, idLugar);
                    sta.setString(4, objetivos);
                    sta.setDate(5, fecha);
                    sta.setTime(6, hora);
                    sta.setString(7, estado);
                    sta.executeUpdate();
                    request.getRequestDispatcher("principalReuniones.jsp").forward(request, response);
                } catch (Exception e) {
                    request.setAttribute("msg", e);
                    request.getRequestDispatcher("nuevaReunion.jsp").forward(request, response);
                }

            }
        } else if (accion.equalsIgnoreCase("desactivarReunion")) {
            String coordinador = request.getParameter("usuario");
            int idReunion = Integer.parseInt(request.getParameter("idReunion"));
            String estado = "Inactiva";
            try {
                PreparedStatement staEl = cnxr.prepareStatement("update reunion set estadoReunion=? where ID_Reunion=?");
                staEl.setString(1, estado);
                staEl.setInt(2, idReunion);
                staEl.executeUpdate();
                request.getRequestDispatcher("ServletReunion?accion=listar&usuario=" + coordinador + "").forward(request, response);
            } catch (Exception e) {
            }
        } else if (accion.equalsIgnoreCase("activarReunion")) {
            String coordinador = request.getParameter("usuario");
            int idReunion = Integer.parseInt(request.getParameter("idReunion"));
            String estado = "Activa";
            try {
                PreparedStatement staEl = cnxr.prepareStatement("update reunion set estadoReunion=? where ID_Reunion=?");
                staEl.setString(1, estado);
                staEl.setInt(2, idReunion);
                staEl.executeUpdate();
                request.getRequestDispatcher("ServletReunion?accion=listar&usuario=" + coordinador + "").forward(request, response);
            } catch (Exception e) {
            }
        } else if (accion.equalsIgnoreCase("vincularParticipante")) {

            int idReunion = Integer.parseInt(request.getParameter("idReunion"));
            int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
            String correo = request.getParameter("correo");
            String coordinador = request.getParameter("coordinador");
            String invitado = request.getParameter("usuario");
            String nomReunion = request.getParameter("nombreR");
            String lugarR = request.getParameter("lugarR");
            String fechaR = request.getParameter("fecha");
            String horaR = request.getParameter("hora");
            String objetivosR = request.getParameter("objetivos");
            PreparedStatement sta = cnxr.prepareStatement("select * from participantes where ID_Reunion=? and ID_Usuario=?");
            sta.setInt(1, idReunion);
            sta.setInt(2, idUsuario);
            ResultSet rs = sta.executeQuery();

            if (rs.next()) {
                request.setAttribute("msg", "Usuario Ya vinculado");
                request.getRequestDispatcher("participantes.jsp?idReunion=" + idReunion + "&nombre=" + nomReunion + "&lugar=" + lugarR + "&fecha=" + fechaR + "&hora=" + horaR + "&objetivos=" + objetivosR).forward(request, response);
            } else {
                try {
                    PreparedStatement staEl = cnxr.prepareStatement("insert into participantes(ID_Reunion,ID_Usuario)"
                            + "values(?,?)");
                    staEl.setInt(1, idReunion);
                    staEl.setInt(2, idUsuario);
                    staEl.executeUpdate();
                    ms.para(correo);
                    ms.asunto("Invitacion Reunion por " + coordinador);
                    ms.mensaje("Invitado: " + invitado + "\n Reunion: " + nomReunion + "\n Lugar: " + lugarR + "\n Fecha: " + fechaR + "\n Hora: " + horaR + "\n Objetivos: " + objetivosR);
                    ms.SendMail();
                    request.setAttribute("msg", "Usuario vinculado");
                    request.getRequestDispatcher("participantes.jsp?idReunion=" + idReunion + "&nombre=" + nomReunion + "&lugar=" + lugarR + "&fecha=" + fechaR + "&hora=" + horaR + "&objetivos=" + objetivosR).forward(request, response);
                } catch (Exception e) {
                    request.setAttribute("msg", e);
                    request.getRequestDispatcher("participantes.jsp?idReunion=" + idReunion).forward(request, response);

                }
            }
        } else if (accion.equalsIgnoreCase("desvincularParticipante")) {
            int idReunion = Integer.parseInt(request.getParameter("idReunion"));
            int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
            String correo = request.getParameter("correo");
            String coordinador = request.getParameter("coordinador");
            String invitado = request.getParameter("usuario");
            String nomReunion = request.getParameter("nombreR");
            String lugarR = request.getParameter("lugarR");
            String fechaR = request.getParameter("fecha");
            String horaR = request.getParameter("hora");
            String objetivosR = request.getParameter("objetivos");
            PreparedStatement sta = cnxr.prepareStatement("select * from participantes where ID_Reunion=? and ID_Usuario=?");
            sta.setInt(1, idReunion);
            sta.setInt(2, idUsuario);
            ResultSet rs = sta.executeQuery();
            if (rs.next()) {
                try {
                    PreparedStatement staEl = cnxr.prepareStatement("delete from participantes where ID_Reunion=? and ID_Usuario=?");
                    staEl.setInt(1, idReunion);
                    staEl.setInt(2, idUsuario);
                    staEl.executeUpdate();
                    request.setAttribute("msg", "Usuario desvinculado");
                    request.getRequestDispatcher("participantes.jsp?idReunion=" + idReunion + "&nombre=" + nomReunion + "&lugar=" + lugarR + "&fecha=" + fechaR + "&hora=" + horaR + "&objetivos=" + objetivosR).forward(request, response);

                } catch (Exception e) {
                }
            } else {
                request.setAttribute("msg", "Usuario No vinculado todavia");
                request.getRequestDispatcher("participantes.jsp?idReunion=" + idReunion + "&nombre=" + nomReunion + "&lugar=" + lugarR + "&fecha=" + fechaR + "&hora=" + horaR + "&objetivos=" + objetivosR).forward(request, response);
            }
        } else if (accion.equalsIgnoreCase("generarActa")) {
            try {
                int idReunion = Integer.parseInt(request.getParameter("idR"));
                String asistentes[] = request.getParameterValues("asistentes");
                String comentarios = request.getParameter("txtComentariosReunion");
                PreparedStatement sta = cnxr.prepareStatement("select * from reunion where ID_Reunion=?");
                sta.setInt(1, idReunion);
                ResultSet rs = sta.executeQuery();
                if (rs.next()) {

                    int idd = generarActa(idReunion, rs.getString("nombreReunion"), asistentes,
                            "Lugar", rs.getString("objetivosReunion"), rs.getString("fechaReunion"), rs.getString("horaReunion"), comentarios);
                    for (int i = 0; i < asistentes.length; i++) {
                        PreparedStatement sta1 = cnxr.prepareStatement("insert into palabrasClaves (palabraClave,ID_Archivo) values (?,?)");
                        sta1.setString(1, asistentes[i]);
                        sta1.setInt(2, idd);
                        sta1.executeUpdate();

                    }

                }
                PreparedStatement staEl = cnxr.prepareStatement("update reunion set estadoReunion=? where ID_Reunion=?");
                staEl.setString(1, "Inactiva");
                staEl.setInt(2, idReunion);
                staEl.executeUpdate();
                request.setAttribute("msg", "Acta generada");
                request.getRequestDispatcher("principalReuniones.jsp").forward(request, response);

            } catch (Exception e) {
                request.setAttribute("msg", e);
                request.getRequestDispatcher("principalReuniones.jsp").forward(request, response);
            }
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

        try {
            processRequest(request, response);

        } catch (ParseException ex) {
            Logger.getLogger(ServletReunion.class
                    .getName()).log(Level.SEVERE, null, ex);

        } catch (SQLException ex) {
            Logger.getLogger(ServletReunion.class
                    .getName()).log(Level.SEVERE, null, ex);
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

        try {
            processRequest(request, response);

        } catch (ParseException ex) {
            Logger.getLogger(ServletReunion.class
                    .getName()).log(Level.SEVERE, null, ex);

        } catch (SQLException ex) {
            Logger.getLogger(ServletReunion.class
                    .getName()).log(Level.SEVERE, null, ex);
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

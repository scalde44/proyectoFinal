 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Servlets;

import UsuarioBEANS.Administrador;
import UsuarioBEANS.Usuario;
import Utils.ConexionBD;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.codec.digest.DigestUtils;

/**
 *
 * @author steve
 */
@WebServlet(name = "ServletMantenimiento", urlPatterns = {"/ServletMantenimiento"})
public class ServletMantenimiento extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param correo
     * @return 
     * @throws java.sql.SQLException
     */
    public ResultSet mostrarUsuario(String correo) throws SQLException {
        Connection cnxr = ConexionBD.getConexion();
        PreparedStatement sta = cnxr.prepareStatement("select * from usuarios where correo=?");
        sta.setString(1, correo);
        ResultSet rs = sta.executeQuery();
        return rs;

    }
    public ResultSet mostrarAdmin(String correo) throws SQLException {
        Connection cnxr = ConexionBD.getConexion();
        PreparedStatement sta = cnxr.prepareStatement("select * from administradores where correo=?");
        sta.setString(1, correo);
        ResultSet rs = sta.executeQuery();
        return rs;

    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String accion = request.getParameter("accion");
        Connection cnx = ConexionBD.getConexion();

        if (accion.equals("listar")) {
            try {
                PreparedStatement sta = cnx.prepareStatement("select * from usuarios");
                ResultSet rs = sta.executeQuery();

                ArrayList<Usuario> lista = new ArrayList<Usuario>();
                while (rs.next()) {
                    Usuario u = new Usuario(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
                    lista.add(u);
                }
                request.setAttribute("lista", lista);
                request.getRequestDispatcher("listado.jsp").forward(request, response);
            } catch (Exception e) {
            }

        } else if (accion.equals("listarAdmin")) {
            try {
                PreparedStatement sta = cnx.prepareStatement("select * from administradores");
                ResultSet rs = sta.executeQuery();

                ArrayList<Administrador> lista = new ArrayList<Administrador>();
                while (rs.next()) {
                    Administrador a = new Administrador(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
                    lista.add(a);
                }
                request.setAttribute("lista", lista);
                request.getRequestDispatcher("listadoAdmin.jsp").forward(request, response);
            } catch (Exception e) {
            }

        } else if (accion.equals("consultar")) {
            String nombre = request.getParameter("txtNombre");
            try {
                PreparedStatement sta = cnx.prepareStatement("select * from usuarios where nombre=?");
                sta.setString(1, nombre);
                ResultSet rs = sta.executeQuery();

                ArrayList<Usuario> lista = new ArrayList<Usuario>();
                while (rs.next()) {
                    Usuario u = new Usuario(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
                    lista.add(u);
                }
                request.setAttribute("lista", lista);
                request.getRequestDispatcher("listado.jsp").forward(request, response);
            } catch (Exception e) {
            }
        } else if (accion.equals("consultarAdmin")) {
            String correo = request.getParameter("txtCorreo");
            try {
                PreparedStatement sta = cnx.prepareStatement("select * from administradores where correo=?");
                sta.setString(1, correo);
                ResultSet rs = sta.executeQuery();

                ArrayList<Administrador> lista = new ArrayList<Administrador>();
                while (rs.next()) {
                    Administrador a = new Administrador(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5));
                    lista.add(a);
                }
                request.setAttribute("lista", lista);
                request.getRequestDispatcher("listadoAdmin.jsp").forward(request, response);
            } catch (Exception e) {
            }
        } else if (accion.equalsIgnoreCase("desactivar")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String estado = "Inactivo";
            try {
                PreparedStatement staEl = cnx.prepareStatement("update usuarios set estado=? where ID_Usuario=?");
                staEl.setString(1, estado);
                staEl.setInt(2, id);
                staEl.executeUpdate();
                request.getRequestDispatcher("ServletMantenimiento?accion=listar").forward(request, response);
            } catch (Exception e) {
            }
        } else if (accion.equalsIgnoreCase("activar")) {
            int id = Integer.parseInt(request.getParameter("id"));
            String estado = "Activo";
            try {
                PreparedStatement staEl = cnx.prepareStatement("update usuarios set estado=? where ID_Usuario=?");
                staEl.setString(1, estado);
                staEl.setInt(2, id);
                staEl.executeUpdate();
                request.getRequestDispatcher("ServletMantenimiento?accion=listar").forward(request, response);
            } catch (Exception e) {
            }
        } else if (accion.equalsIgnoreCase("desactivarAdmin")) {
            String correo = request.getParameter("correo");
            String estado = "Inactivo";
            try {
                PreparedStatement staEl = cnx.prepareStatement("update administradores set estado=? where correo=?");
                staEl.setString(1, estado);
                staEl.setString(2, correo);
                staEl.executeUpdate();
                request.getRequestDispatcher("ServletMantenimiento?accion=listarAdmin").forward(request, response);
            } catch (Exception e) {
            }
        } else if (accion.equalsIgnoreCase("activarAdmin")) {
            String correo = request.getParameter("correo");
            String estado = "Activo";
            try {
                PreparedStatement staEl = cnx.prepareStatement("update administradores set estado=? where correo=?");
                staEl.setString(1, estado);
                staEl.setString(2, correo);
                staEl.executeUpdate();
                request.getRequestDispatcher("ServletMantenimiento?accion=listarAdmin").forward(request, response);
            } catch (Exception e) {
            }
        } else if (accion.equals("insertar")) {
            
            String nombre = request.getParameter("txtNombre");
            String correo = request.getParameter("txtCorreo");
            String contrasena = request.getParameter("txtContrasena");
            String contrasena1 = request.getParameter("txtContrasena1");
            String seguridad = request.getParameter("seguridad");
            ResultSet rss=mostrarUsuario(correo);
            ResultSet rss2=mostrarAdmin(correo);
            if(rss.next()||rss2.next()){
                
                request.setAttribute("msg", "El correo ya esta registrado");
                request.getRequestDispatcher("nuevo.jsp").forward(request, response);
            }else{
            if (seguridad.equalsIgnoreCase("BUENA") || seguridad.equalsIgnoreCase("EXCELENTE")) {
                if (contrasena.equals(contrasena1)) {
                    String contrasenaEncriptada = DigestUtils.md5Hex(contrasena);
                    try {

                        String estado = "Activo";

                        PreparedStatement sta = cnx.prepareStatement("insert into usuarios(nombre,correo,contrasena,estado) values(?,?,?,?)");

                        sta.setString(1, nombre);
                        sta.setString(2, correo);
                        sta.setString(3, contrasenaEncriptada);
                        sta.setString(4, estado);
                        sta.executeUpdate();
                        request.setAttribute("msg", "El usuario ha sido registrado con éxito");
                        request.getRequestDispatcher("principal.jsp").forward(request, response);
                    } catch (Exception e) {
                        request.setAttribute("msg", e);
                        request.getRequestDispatcher("nuevo.jsp").forward(request, response);
                    }

                } else {
                    request.setAttribute("msg", "Las contraseñas no coinciden");
                    request.getRequestDispatcher("nuevo.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("msg", "El nivel de las contraseñas es malo");
                request.getRequestDispatcher("nuevo.jsp").forward(request, response);
            }
        }
        } else if (accion.equals("insertarAdmin")) {
            String nombre = request.getParameter("txtNombre");
            String correo = request.getParameter("txtCorreo");
            String contrasena = request.getParameter("txtContrasena");
            String contrasena1 = request.getParameter("txtContrasena1");
            String seguridad = request.getParameter("seguridad");
            String estado = "Activo";
            ResultSet rss=mostrarUsuario(correo);
            ResultSet rss2=mostrarAdmin(correo);
            if(rss.next()||rss2.next()){
                
                request.setAttribute("msg", "El correo ya esta registrado");
                request.getRequestDispatcher("nuevo.jsp").forward(request, response);
            }else{
            if (seguridad.equalsIgnoreCase("BUENA") || seguridad.equalsIgnoreCase("EXCELENTE")) {
                if (contrasena.equals(contrasena1)) {
                    String contrasenaEncriptada = DigestUtils.md5Hex(contrasena);
                    try {

                        PreparedStatement sta = cnx.prepareStatement("insert into administradores(nombre,correo,contrasena,estado) values(?,?,?,?)");
                        sta.setString(1, nombre);
                        sta.setString(2, correo);
                        sta.setString(3, contrasenaEncriptada);
                        sta.setString(4, estado);

                        sta.executeUpdate();
                        request.setAttribute("msg", "El administrador ha sido registrado con éxito");
                        request.getRequestDispatcher("principal.jsp").forward(request, response);
                    } catch (Exception e) {
                        request.setAttribute("msg", e);
                        request.getRequestDispatcher("nuevoAdmin.jsp").forward(request, response);
                    }

                } else {
                    request.setAttribute("msg", "Las contraseñas no coinciden");
                    request.getRequestDispatcher("nuevoAdmin.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("msg", "El nivel de las contraseñas es malo");
                request.getRequestDispatcher("nuevo.jsp").forward(request, response);
            }
        }}
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
        } catch (SQLException ex) {
            Logger.getLogger(ServletMantenimiento.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException ex) {
            Logger.getLogger(ServletMantenimiento.class.getName()).log(Level.SEVERE, null, ex);
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

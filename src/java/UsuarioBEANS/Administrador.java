/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UsuarioBEANS;

/**
 *
 * @author steve
 */
public class Administrador {
    private int ID_Administrador;
    private String nombre,correo,contrasena,estado;

    public Administrador(int ID_Administrador, String nombre, String correo, String contrasena, String estado) {
        this.ID_Administrador = ID_Administrador;
        this.nombre = nombre;
        this.correo = correo;
        this.contrasena = contrasena;
        this.estado = estado;
    }

    public int getID_Administrador() {
        return ID_Administrador;
    }

    public void setID_Administrador(int ID_Administrador) {
        this.ID_Administrador = ID_Administrador;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

   
    
}

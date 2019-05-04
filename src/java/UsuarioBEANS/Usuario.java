package UsuarioBEANS;

public class Usuario {
    private int ID_Usuario;
    private String nombre,correo,contrasena,estado;
    //------------------------------------------

    public Usuario(int ID_Usuario, String nombre, String correo, String contrasena, String estado) {
        this.ID_Usuario = ID_Usuario;
        this.nombre = nombre;
        this.correo = correo;
        this.contrasena = contrasena;
        this.estado = estado;
    }

    public int getID_Usuario() {
        return ID_Usuario;
    }

    public void setID_Usuario(int ID_Usuario) {
        this.ID_Usuario = ID_Usuario;
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

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
public class Archivo {
    private int ID_Archivo;
    private String nombreArchivo,direccionArchivo,tipoArchivo,tamanoArchivo;

    public Archivo(int ID_Archivo, String nombreArchivo, String direccionArchivo, String tipoArchivo, String tamanoArchivo) {
        this.ID_Archivo = ID_Archivo;
        this.nombreArchivo = nombreArchivo;
        this.direccionArchivo = direccionArchivo;
        this.tipoArchivo = tipoArchivo;
        this.tamanoArchivo = tamanoArchivo;
    }

    public int getID_Archivo() {
        return ID_Archivo;
    }

    public void setID_Archivo(int ID_Archivo) {
        this.ID_Archivo = ID_Archivo;
    }

    public String getNombreArchivo() {
        return nombreArchivo;
    }

    public void setNombreArchivo(String nombreArchivo) {
        this.nombreArchivo = nombreArchivo;
    }

    public String getDireccionArchivo() {
        return direccionArchivo;
    }

    public void setDireccionArchivo(String direccionArchivo) {
        this.direccionArchivo = direccionArchivo;
    }

    public String getTipoArchivo() {
        return tipoArchivo;
    }

    public void setTipoArchivo(String tipoArchivo) {
        this.tipoArchivo = tipoArchivo;
    }

    public String getTamanoArchivo() {
        return tamanoArchivo;
    }

    public void setTamanoArchivo(String tamanoArchivo) {
        this.tamanoArchivo = tamanoArchivo;
    }
    
}

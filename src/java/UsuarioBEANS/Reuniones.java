/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UsuarioBEANS;

import java.sql.Date;
import java.sql.Time;

/**
 *
 * @author steve
 */
public class Reuniones {
     private int ID_Reunion;
     private String coordinadorReunion,nombreReunion;
     private int ID_Lugar;
     private String objetivosReunion;
     private Date fechaReunion;
     private Time horaReunion;
     private String estado;

    public Reuniones(int ID_Reunion, String coordinadorReunion, String nombreReunion, int ID_Lugar, String objetivosReunion, Date fechaReunion, Time horaReunion, String estado) {
        this.ID_Reunion = ID_Reunion;
        this.coordinadorReunion = coordinadorReunion;
        this.nombreReunion = nombreReunion;
        this.ID_Lugar = ID_Lugar;
        this.objetivosReunion = objetivosReunion;
        this.fechaReunion = fechaReunion;
        this.horaReunion = horaReunion;
        this.estado = estado;
    }

    public int getID_Reunion() {
        return ID_Reunion;
    }

    public void setID_Reunion(int ID_Reunion) {
        this.ID_Reunion = ID_Reunion;
    }

    public String getCoordinadorReunion() {
        return coordinadorReunion;
    }

    public void setCoordinadorReunion(String coordinadorReunion) {
        this.coordinadorReunion = coordinadorReunion;
    }

    public String getNombreReunion() {
        return nombreReunion;
    }

    public void setNombreReunion(String nombreReunion) {
        this.nombreReunion = nombreReunion;
    }

    public int getID_Lugar() {
        return ID_Lugar;
    }

    public void setID_Lugar(int ID_Lugar) {
        this.ID_Lugar = ID_Lugar;
    }

    public String getObjetivosReunion() {
        return objetivosReunion;
    }

    public void setObjetivosReunion(String objetivosReunion) {
        this.objetivosReunion = objetivosReunion;
    }

    public Date getFechaReunion() {
        return fechaReunion;
    }

    public void setFechaReunion(Date fechaReunion) {
        this.fechaReunion = fechaReunion;
    }

    public Time getHoraReunion() {
        return horaReunion;
    }

    public void setHoraReunion(Time horaReunion) {
        this.horaReunion = horaReunion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    

     
}

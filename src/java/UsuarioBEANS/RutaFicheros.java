/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package UsuarioBEANS;

import java.io.File;

/**
 *
 * @author steve
 */
public class RutaFicheros {

    public RutaFicheros() {
    }
     public File[] listar() {
        String sDirectorio = "C:\\Users\\steve\\OneDrive\\Escritorio\\Archivos";
        File f = new File(sDirectorio);
        File[] ficheros = null;
        if (f.exists()) {
            ficheros = f.listFiles();
        }
        return ficheros;
    }
    
}

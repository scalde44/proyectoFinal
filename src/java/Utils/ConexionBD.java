
package Utils;
import java.sql.*;

public class ConexionBD {
    public static Connection getConexion() {
        Connection con = null;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost/listas?user=root&password=");
            System.out.println("Conexion exitosa");
        } catch (Exception e) {
            System.out.println("Error: "+e);
        }
        return con;

    }
    
}

package datos;
import java.sql.*;

public class Conexion {
    private Statement St; 
    private String driver;
    private String user;
    private String pwd;
    private String cadena;
    private Connection con;

    public Conexion() {
        this.driver ="org.postgresql.Driver";
        this.user="postgres";
        this.pwd="1234";
        this.cadena="jdbc:postgresql://localhost:5432/bd_pesebre";
        this.con=this.crearConexion();	
    }

    Connection crearConexion() {
        try {
            Class.forName("org.postgresql.Driver");
            con = DriverManager.getConnection(cadena, user, pwd);
            System.out.println("✅ Conexión establecida con PostgreSQL");
            return con;
        } catch (Exception e) {
            System.out.println("❌ No se pudo establecer la conexión con la base de datos.");
            e.printStackTrace();
            return null;
        }
    }

    public Connection getConexion() { 
        return this.con; 
    }

    public String Ejecutar(String sql) {
        String result="";
        try {
            St=getConexion().createStatement();
            if (St.execute(sql)) {
                result="Operación realizada con exito";
            } else {
                result="Se ha producido un error";
            }
        } catch(Exception ex) {
            result += ex.getMessage();
        }
        return result;
    }

    public ResultSet Consulta(String sql) {
        ResultSet reg=null;
        try {
            St=getConexion().createStatement();
            reg=St.executeQuery(sql);
        } catch(Exception ee) {
            System.out.println("Error en consulta: " + ee.getMessage());
        }
        return reg;
    }

    String getDriver() { return this.driver; }
    String getUser() { return this.user; }
    String getPwd() { return this.pwd; }
    String getCadena() { return this.cadena; }
}

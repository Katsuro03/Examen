package seguridad;

import java.sql.*;
import datos.Conexion;

public class Usuario {
    private int id;
    private int perfil;  // 1=admin, 2=alumno, 3=invitado
    private String nombre;
    private String correo;
    private String clave;
    
    public Usuario() {}
    
    public Usuario(int perfil, String nombre, String correo, String clave) {
        this.perfil = perfil;
        this.nombre = nombre;
        this.correo = correo;
        this.clave = clave;
    }
    
    // ========== MÉTODOS CRUD ==========
    
    // 1. Autenticar usuario
    public static Usuario autenticar(String correo, String clave) {
        String sql = "SELECT * FROM usuarios WHERE correo = '" + correo + "' AND clave = '" + clave + "'";
        Usuario usuario = null;
        
        try {
            Conexion conexion = new Conexion();
            ResultSet rs = conexion.Consulta(sql);
            
            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setPerfil(rs.getInt("perfil"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setClave(rs.getString("clave"));
            }
            
        } catch (SQLException e) {
            System.out.println("Error al autenticar usuario: " + e.getMessage());
        }
        return usuario;
    }
    
    // 2. Registrar nuevo usuario (solo admin puede registrar alumnos)
    public String registrarUsuario() {
        // Validar formato de correo según perfil
        if (this.perfil == 2 && !this.correo.endsWith("@est.ups.edu.ec")) {
            return "ERROR: Los alumnos deben usar correo institucional (@est.ups.edu.ec)";
        }
        
        // Verificar si el correo ya existe
        String verificarSql = "SELECT COUNT(*) FROM usuarios WHERE correo = '" + this.correo + "'";
        try {
            Conexion conexion = new Conexion();
            ResultSet rs = conexion.Consulta(verificarSql);
            if (rs.next() && rs.getInt(1) > 0) {
                return "ERROR: El correo ya está registrado";
            }
        } catch (SQLException e) {
            return "ERROR: " + e.getMessage();
        }
        
        // Insertar nuevo usuario
        String sql = "INSERT INTO usuarios (perfil, nombre, correo, clave) VALUES (" +
                    this.perfil + ", '" + this.nombre + "', '" + 
                    this.correo + "', '" + this.clave + "')";
        
        Conexion conexion = new Conexion();
        return conexion.Ejecutar(sql);
    }
    
    // 3. Obtener todos los usuarios (solo admin)
    public static java.util.List<Usuario> obtenerTodos() {
        java.util.List<Usuario> usuarios = new java.util.ArrayList<>();
        String sql = "SELECT * FROM usuarios ORDER BY perfil, nombre";
        
        try {
            Conexion conexion = new Conexion();
            ResultSet rs = conexion.Consulta(sql);
            
            while (rs.next()) {
                Usuario usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setPerfil(rs.getInt("perfil"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setClave(rs.getString("clave"));
                usuarios.add(usuario);
            }
            
        } catch (SQLException e) {
            System.out.println("Error al obtener usuarios: " + e.getMessage());
        }
        return usuarios;
    }
    
    // 4. Actualizar usuario
    public String actualizarUsuario() {
        // Validar formato de correo para alumnos
        if (this.perfil == 2 && !this.correo.endsWith("@est.ups.edu.ec")) {
            return "ERROR: Los alumnos deben usar correo institucional";
        }
        
        String sql = "UPDATE usuarios SET " +
                    "perfil = " + this.perfil + ", " +
                    "nombre = '" + this.nombre + "', " +
                    "correo = '" + this.correo + "', " +
                    "clave = '" + this.clave + "' " +
                    "WHERE id = " + this.id;
        
        Conexion conexion = new Conexion();
        return conexion.Ejecutar(sql);
    }
    
    // 5. Eliminar usuario
    public static String eliminarUsuario(int id) {
        String sql = "DELETE FROM usuarios WHERE id = " + id;
        
        Conexion conexion = new Conexion();
        return conexion.Ejecutar(sql);
    }
    
    // 6. Obtener usuario por ID
    public static Usuario obtenerPorId(int id) {
        String sql = "SELECT * FROM usuarios WHERE id = " + id;
        Usuario usuario = null;
        
        try {
            Conexion conexion = new Conexion();
            ResultSet rs = conexion.Consulta(sql);
            
            if (rs.next()) {
                usuario = new Usuario();
                usuario.setId(rs.getInt("id"));
                usuario.setPerfil(rs.getInt("perfil"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setCorreo(rs.getString("correo"));
                usuario.setClave(rs.getString("clave"));
            }
            
        } catch (SQLException e) {
            System.out.println("Error al obtener usuario: " + e.getMessage());
        }
        return usuario;
    }
    
    // 7. Método para verificar permisos
    public boolean tieneAcceso(String seccion) {
        switch (this.perfil) {
            case 1: // Admin: acceso a todo
                return true;
                
            case 2: // Alumno: acceso a galeria, juego, calendario
                return seccion.equals("galeria") || 
                       seccion.equals("juego") || 
                       seccion.equals("calendario");
                       
            case 3: // Invitado: acceso a galeria, juego, calendario
                return seccion.equals("galeria") || 
                       seccion.equals("juego") || 
                       seccion.equals("calendario");
                       
            default:
                return false;
        }
    }
    
    // 8. Método para obtener nombre del perfil
    public String getNombrePerfil() {
        switch (this.perfil) {
            case 1: return "Administrador";
            case 2: return "Alumno UPS";
            case 3: return "Invitado";
            default: return "Desconocido";
        }
    }
    
    // ========== GETTERS Y SETTERS ==========
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getPerfil() { return perfil; }
    public void setPerfil(int perfil) { this.perfil = perfil; }
    
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    
    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }
    
    public String getClave() { return clave; }
    public void setClave(String clave) { this.clave = clave; }
    
 // Método para verificar si el usuario tiene acceso a una página
    public boolean puedeAcceder(String pagina) {
        // El index siempre es público
        if (pagina.equals("index")) {
            return true;
        }
        
        switch (this.perfil) {
            case 1: // Admin: acceso a todo
                return true;
                
            case 2: // Alumno: acceso a juego, galeria, calendario
            case 3: // Invitado: acceso a juego, galeria, calendario
                return pagina.equals("juego") || 
                       pagina.equals("galeria") || 
                       pagina.equals("calendario");
                       
            default:
                return false;
        }
    }
}
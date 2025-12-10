package seguridad;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import datos.Conexion;

public class Calendario {
    private int dia;
    private String frase;
    private String modelo3dUrl;
    private String audioUrl;
    private String imagenUrl;
    private String villancicoNombre;
    private Date fechaVisible;
    
    // Constructor vacío
    public Calendario() {}
    
    // Constructor con parámetros
    public Calendario(int dia, String frase, String modelo3dUrl, String audioUrl, 
                     String imagenUrl, String villancicoNombre, Date fechaVisible) {
        this.dia = dia;
        this.frase = frase;
        this.modelo3dUrl = modelo3dUrl;
        this.audioUrl = audioUrl;
        this.imagenUrl = imagenUrl;
        this.villancicoNombre = villancicoNombre;
        this.fechaVisible = fechaVisible;
    }
    
    // ========== MÉTODOS CRUD ==========
    
    // 1. Obtener todos los días del calendario
    public static List<Calendario> obtenerTodosLosDias() {
        List<Calendario> dias = new ArrayList<>();
        String sql = "SELECT * FROM calendario_adviento ORDER BY dia";
        
        try {
            Conexion conexion = new Conexion();
            ResultSet rs = conexion.Consulta(sql);
            
            while (rs.next()) {
                Calendario dia = new Calendario();
                dia.setDia(rs.getInt("dia"));
                dia.setFrase(rs.getString("frase"));
                dia.setModelo3dUrl(rs.getString("modelo_3d_url"));
                dia.setAudioUrl(rs.getString("audio_url"));
                dia.setImagenUrl(rs.getString("imagen_url"));
                dia.setVillancicoNombre(rs.getString("villancico_nombre"));
                dia.setFechaVisible(rs.getDate("fecha_visible"));
                dias.add(dia);
            }
            
        } catch (SQLException e) {
            System.out.println("Error al obtener días del calendario: " + e.getMessage());
        }
        return dias;
    }
    
    // 2. Obtener un día específico
    public static Calendario obtenerDia(int numeroDia) {
        String sql = "SELECT * FROM calendario_adviento WHERE dia = " + numeroDia;
        Calendario dia = null;
        
        try {
            Conexion conexion = new Conexion();
            ResultSet rs = conexion.Consulta(sql);
            
            if (rs.next()) {
                dia = new Calendario();
                dia.setDia(rs.getInt("dia"));
                dia.setFrase(rs.getString("frase"));
                dia.setModelo3dUrl(rs.getString("modelo_3d_url"));
                dia.setAudioUrl(rs.getString("audio_url"));
                dia.setImagenUrl(rs.getString("imagen_url"));
                dia.setVillancicoNombre(rs.getString("villancico_nombre"));
                dia.setFechaVisible(rs.getDate("fecha_visible"));
            }
            
        } catch (SQLException e) {
            System.out.println("Error al obtener día " + numeroDia + ": " + e.getMessage());
        }
        return dia;
    }
    
    // 3. Insertar nuevo día
    public String insertarDia() {
        String sql = "INSERT INTO calendario_adviento (dia, frase, modelo_3d_url, audio_url, imagen_url, villancico_nombre, fecha_visible) " +
                    "VALUES (" + this.dia + ", '" + this.frase + "', '" + this.modelo3dUrl + "', '" + 
                    this.audioUrl + "', '" + this.imagenUrl + "', '" + this.villancicoNombre + "', '" + 
                    new java.sql.Date(this.fechaVisible.getTime()) + "')";
        
        Conexion conexion = new Conexion();
        return conexion.Ejecutar(sql);
    }
    
    // 4. Actualizar día existente
    public String actualizarDia() {
        String sql = "UPDATE calendario_adviento SET " +
                    "frase = '" + this.frase + "', " +
                    "modelo_3d_url = '" + this.modelo3dUrl + "', " +
                    "audio_url = '" + this.audioUrl + "', " +
                    "imagen_url = '" + this.imagenUrl + "', " +
                    "villancico_nombre = '" + this.villancicoNombre + "', " +
                    "fecha_visible = '" + new java.sql.Date(this.fechaVisible.getTime()) + "' " +
                    "WHERE dia = " + this.dia;
        
        Conexion conexion = new Conexion();
        return conexion.Ejecutar(sql);
    }
    
    // 5. Eliminar día
    public static String eliminarDia(int numeroDia) {
        String sql = "DELETE FROM calendario_adviento WHERE dia = " + numeroDia;
        
        Conexion conexion = new Conexion();
        return conexion.Ejecutar(sql);
    }
    
    // 6. Verificar si un día está disponible (fecha actual o pasada)
    public boolean estaDisponible() {
        java.util.Date hoy = new java.util.Date();
        return this.fechaVisible.before(hoy) || this.fechaVisible.equals(hoy);
    }
    
    // 7. Obtener días disponibles (hasta la fecha actual)
    public static List<Calendario> obtenerDiasDisponibles() {
        List<Calendario> diasDisponibles = new ArrayList<>();
        String sql = "SELECT * FROM calendario_adviento WHERE fecha_visible <= CURRENT_DATE ORDER BY dia";
        
        try {
            Conexion conexion = new Conexion();
            ResultSet rs = conexion.Consulta(sql);
            
            while (rs.next()) {
                Calendario dia = new Calendario();
                dia.setDia(rs.getInt("dia"));
                dia.setFrase(rs.getString("frase"));
                dia.setModelo3dUrl(rs.getString("modelo_3d_url"));
                dia.setAudioUrl(rs.getString("audio_url"));
                dia.setImagenUrl(rs.getString("imagen_url"));
                dia.setVillancicoNombre(rs.getString("villancico_nombre"));
                dia.setFechaVisible(rs.getDate("fecha_visible"));
                diasDisponibles.add(dia);
            }
            
        } catch (SQLException e) {
            System.out.println("Error al obtener días disponibles: " + e.getMessage());
        }
        return diasDisponibles;
    }
    
    // ========== GETTERS Y SETTERS ==========
    
    public int getDia() { return dia; }
    public void setDia(int dia) { this.dia = dia; }
    
    public String getFrase() { return frase; }
    public void setFrase(String frase) { this.frase = frase; }
    
    public String getModelo3dUrl() { return modelo3dUrl; }
    public void setModelo3dUrl(String modelo3dUrl) { this.modelo3dUrl = modelo3dUrl; }
    
    public String getAudioUrl() { return audioUrl; }
    public void setAudioUrl(String audioUrl) { this.audioUrl = audioUrl; }
    
    public String getImagenUrl() { return imagenUrl; }
    public void setImagenUrl(String imagenUrl) { this.imagenUrl = imagenUrl; }
    
    public String getVillancicoNombre() { return villancicoNombre; }
    public void setVillancicoNombre(String villancicoNombre) { this.villancicoNombre = villancicoNombre; }
    
    public Date getFechaVisible() { return fechaVisible; }
    public void setFechaVisible(Date fechaVisible) { this.fechaVisible = fechaVisible; }
    
    // ========== MÉTODO toString ==========
    @Override
    public String toString() {
        return "Calendario{" +
                "dia=" + dia +
                ", frase='" + frase + '\'' +
                ", modelo3dUrl='" + modelo3dUrl + '\'' +
                ", audioUrl='" + audioUrl + '\'' +
                ", imagenUrl='" + imagenUrl + '\'' +
                ", villancicoNombre='" + villancicoNombre + '\'' +
                ", fechaVisible=" + fechaVisible +
                '}';
    }
 // Método para obtener estadísticas del calendario
    public static Map<String, Integer> obtenerEstadisticas() {
        Map<String, Integer> stats = new HashMap<>();
        stats.put("total", 0);
        stats.put("disponibles", 0);
        stats.put("bloqueados", 0);
        
        String sql = "SELECT " +
                    "COUNT(*) as total, " +
                    "COUNT(CASE WHEN fecha_visible <= CURRENT_DATE THEN 1 END) as disponibles, " +
                    "COUNT(CASE WHEN fecha_visible > CURRENT_DATE THEN 1 END) as bloqueados " +
                    "FROM calendario_adviento";
        
        try {
            Conexion conexion = new Conexion();
            ResultSet rs = conexion.Consulta(sql);
            
            if (rs.next()) {
                stats.put("total", rs.getInt("total"));
                stats.put("disponibles", rs.getInt("disponibles"));
                stats.put("bloqueados", rs.getInt("bloqueados"));
            }
            
        } catch (SQLException e) {
            System.out.println("Error al obtener estadísticas: " + e.getMessage());
        }
        
        return stats;
    }
 // Agrega este método a tu clase Calendario.java
    public static String actualizarFecha(int dia, Date nuevaFecha) {
        String sql = "UPDATE calendario_adviento SET fecha_visible = '" + 
                    new java.sql.Date(nuevaFecha.getTime()) + "' WHERE dia = " + dia;
        
        Conexion conexion = new Conexion();
        return conexion.Ejecutar(sql);
    }
}
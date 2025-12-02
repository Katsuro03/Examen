package seguridad;

import java.sql.Timestamp;

public class Bitacora {

    private int id;
    private String tabla;
    private String operacion;
    private String valorAnterior;
    private String valorNuevo;
    private Timestamp fecha;
    private String usuario;
    private String esquema;

    // Constructor vacío (importante para frameworks)
    public Bitacora() {}

    // Constructor completo
    public Bitacora(int id, String tabla, String operacion, String valorAnterior,
                    String valorNuevo, Timestamp fecha, String usuario, String esquema) {
        this.id = id;
        this.tabla = tabla;
        this.operacion = operacion;
        this.valorAnterior = valorAnterior;
        this.valorNuevo = valorNuevo;
        this.fecha = fecha;
        this.usuario = usuario;
        this.esquema = esquema;
    }

    // ====== GETTERS ======
    public int getId() { return id; }
    public String getTabla() { return tabla; }
    public String getOperacion() { return operacion; }
    public String getValorAnterior() { return valorAnterior; }
    public String getValorNuevo() { return valorNuevo; }
    public Timestamp getFecha() { return fecha; }
    public String getUsuario() { return usuario; }
    public String getEsquema() { return esquema; }

    // ====== SETTERS ======
    public void setId(int id) { this.id = id; }
    public void setTabla(String tabla) { this.tabla = tabla; }
    public void setOperacion(String operacion) { this.operacion = operacion; }
    public void setValorAnterior(String valorAnterior) { this.valorAnterior = valorAnterior; }
    public void setValorNuevo(String valorNuevo) { this.valorNuevo = valorNuevo; }
    public void setFecha(Timestamp fecha) { this.fecha = fecha; }
    public void setUsuario(String usuario) { this.usuario = usuario; }
    public void setEsquema(String esquema) { this.esquema = esquema; }
}

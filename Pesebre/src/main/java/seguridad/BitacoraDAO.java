package seguridad;

import datos.Conexion;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BitacoraDAO {

    public List<Bitacora> listar() {
        List<Bitacora> lista = new ArrayList<>();

        String sql = "SELECT id_aud, tabla_aud, operacion_aud, valoranterior_aud, " +
                "valornuevo_aud, fecha_aud, usuario_aud, esquema_aud " +
                "FROM auditoria.tb_auditoria ORDER BY fecha_aud DESC";

        try (Connection con = new Conexion().getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Bitacora b = new Bitacora();

                b.setId(rs.getInt("id_aud"));
                b.setTabla(rs.getString("tabla_aud"));
                b.setOperacion(rs.getString("operacion_aud"));
                b.setValorAnterior(rs.getString("valoranterior_aud"));
                b.setValorNuevo(rs.getString("valornuevo_aud"));
                b.setFecha(rs.getTimestamp("fecha_aud"));
                b.setUsuario(rs.getString("usuario_aud"));
                b.setEsquema(rs.getString("esquema_aud"));

                lista.add(b);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return lista;
    }
}

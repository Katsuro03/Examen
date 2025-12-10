<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="datos.Conexion, java.util.Date, java.text.SimpleDateFormat" %>
<%
    String accion = request.getParameter("accion");
    Conexion conexion = new Conexion();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    
    try {
        if ("desbloquear_rango".equals(accion)) {
            int inicio = Integer.parseInt(request.getParameter("inicio"));
            int fin = Integer.parseInt(request.getParameter("fin"));
            
            String sql = "UPDATE calendario_adviento SET fecha_visible = '2024-01-01' " +
                        "WHERE dia BETWEEN " + inicio + " AND " + fin;
            conexion.Ejecutar(sql);
            
            response.sendRedirect("admin_calendario.jsp?mensaje=Días " + inicio + "-" + fin + " desbloqueados&tipo=success");
            
        } else if ("desbloquear_hoy".equals(accion)) {
            Date hoy = new Date();
            String sql = "UPDATE calendario_adviento SET fecha_visible = '" + 
                        sdf.format(hoy) + "' WHERE fecha_visible > '" + sdf.format(hoy) + "'";
            conexion.Ejecutar(sql);
            
            response.sendRedirect("admin_calendario.jsp?mensaje=Días desbloqueados hasta hoy&tipo=success");
        }
        
    } catch (Exception e) {
        response.sendRedirect("admin_calendario.jsp?mensaje=Error: " + e.getMessage() + "&tipo=danger");
    }
%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="seguridad.Usuario, seguridad.Bitacora, java.util.List" %>
<%@ page import="seguridad.BitacoraDAO" %>
<%@ page import="seguridad.Bitacora" %>


<%
    // Verificación de sesión y rol
    Usuario usuario = (Usuario) session.getAttribute("usuario_obj");
    if (usuario == null || usuario.getPerfil() != 1) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Bitácora del Sistema</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/estilos.css">
</head>

<body>

    <!-- ============ HEADER ============ -->
    <header>
        <img src="imagenes/ups.png" class="logo">
        <h1 class="header-title">Panel de Administración</h1>
        <h2 class="header-subtitle">Bitácora del Sistema</h2>
    </header>

    <div class="main-container">

        <!-- ============ SIDEBAR ============ -->
        <div class="sidebar">

            <div class="user-section">
                <div class="welcome-msg">👋 Administrador, <%= usuario.getNombre() %></div>

                <form action="cerrarSesion.jsp" method="post">
                    <button type="submit" class="logout-btn">Cerrar Sesión</button>
                </form>
            </div>

            <div class="sidebar-section">
                <h4>Navegación</h4>
                <ul class="sidebar-links">
                    <li><a href="index.jsp"><i class="fas fa-home"></i> Inicio</a></li>
                    <li><a href="admin_usuarios.jsp"><i class="fas fa-users-cog"></i> Administrar Usuarios</a></li>
                    <li><a href="admin_bitacora.jsp" class="active"><i class="fas fa-book"></i> Bitácora del Sistema</a></li>
                </ul>
            </div>

        </div>

        <!-- ============ CONTENIDO PRINCIPAL ============ -->
        <div class="content">

            <section class="main-section">
                <h3>Registro de Actividades</h3>
                <p>Consulta todas las operaciones realizadas por los usuarios.</p>

                <%
                    String msg = (String) session.getAttribute("mensaje");
                    if (msg != null) {
                %>

                <div class="alert alert-info"><%= msg %></div>

                <%
                        session.removeAttribute("mensaje");
                    }
                %>

<!-- En lugar de solo la tabla, envuélvela así: -->
<div class="table-responsive">
    <table class="table table-hover table-bordered align-middle tabla-bitacora">
        <thead class="table-dark text-center">
            <tr>
                <th>ID</th>
                <th>Tabla Afectada</th>
                <th>Acción Realizada</th>
                <th>Valor Afectado</th>
                <th>Fecha</th>
                <th>Usuario</th>
            </tr>
        </thead>
        <tbody>
            <%
                BitacoraDAO dao = new BitacoraDAO();
                List<Bitacora> lista = dao.listar();
    
                for (Bitacora b : lista) {
                    String accionFull = "";
                    String estilo = "";
                    String icono = "";
    
                    String oper = (b.getOperacion() != null) ? b.getOperacion() : "";
    
                    switch (oper) {
                        case "I":
                            accionFull = "INSERT";
                            icono = "<i class='fas fa-plus-circle'></i>";
                            estilo = "style='color:green;font-weight:bold;'";
                            break;
                        case "U":
                            accionFull = "UPDATE";
                            icono = "<i class='fas fa-pen'></i>";
                            estilo = "style='color:blue;font-weight:bold;'";
                            break;
                        case "D":
                            accionFull = "DELETE";
                            icono = "<i class='fas fa-trash'></i>";
                            estilo = "style='color:red;font-weight:bold;'";
                            break;
                        default:
                            accionFull = "SIN DEFINIR";
                            icono = "<i class='fas fa-exclamation-triangle'></i>";
                            estilo = "style='color:gray;font-weight:bold;'";
                    }
            %>
            <tr class="text-center">
                <td><%= b.getId() %></td>
                <td><%= b.getTabla() %></td>
                <td <%= estilo %>>
                    <%= icono %> <span style="margin-left:6px;"><%= accionFull %></span>
                </td>
                <!-- Aquí mostramos valor nuevo si existe, sino el anterior -->
                <td>
                    <%= (b.getValorNuevo() != null && !b.getValorNuevo().isEmpty())
                            ? b.getValorNuevo()
                            : b.getValorAnterior() %>
                </td>
                <td><%= b.getFecha() %></td>
                <td><%= b.getUsuario() %></td>
            </tr>
            <% } %>
        </tbody>
    </table>
</div>


            </section>

        </div>

    </div>

    <!-- ============ FOOTER ============ -->
    <footer>
        <p>&copy; 2025 Universidad Politécnica Salesiana - Panel Administrador</p>
    </footer>

</body>
</html>

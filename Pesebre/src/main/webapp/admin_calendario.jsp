<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="seguridad.Usuario, seguridad.Calendario, java.util.List, java.sql.*, datos.Conexion, java.text.SimpleDateFormat, java.util.Date" %>

<%
    // Validar sesión
    Usuario usuario = (Usuario) session.getAttribute("usuario_obj");
    if (usuario == null || usuario.getPerfil() != 1) {
        response.sendRedirect("login.jsp");
        return;
    }

    String mensaje = null;
    String tipoMensaje = "info";
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdfDisplay = new SimpleDateFormat("dd/MM/yyyy");

    // Procesar Acciones del Calendario
    if ("POST".equals(request.getMethod())) {
        String accion = request.getParameter("accion");

        try {
            Conexion conexion = new Conexion();

            if ("desbloquear".equals(accion)) {
                conexion.Ejecutar("UPDATE calendario_adviento SET fecha_visible = '2024-01-01'");
                mensaje = "Todos los días han sido desbloqueados";
                tipoMensaje = "success";

            } else if ("restaurar".equals(accion)) {

                String sql = "UPDATE calendario_adviento SET fecha_visible = CASE dia ";

                for (int d = 1; d <= 24; d++) {
                    sql += "WHEN " + d + " THEN STR_TO_DATE('2025-12-" + (d < 10 ? "0" + d : d) + "', '%Y-%m-%d') ";
                }

                sql += "END";

                conexion.Ejecutar(sql);
                mensaje = "Fechas restauradas correctamente";
                tipoMensaje = "info";
            } else if ("test".equals(accion)) {
                conexion.Ejecutar("UPDATE calendario_adviento SET fecha_visible = '2024-01-01' WHERE dia <= 5");
                mensaje = "Modo prueba activado (5 días desbloqueados)";
                tipoMensaje = "warning";

            } else if ("actualizar_individual".equals(accion)) {

                String diaParam = request.getParameter("dia");
                String fechaParam = request.getParameter("fecha");

                if (diaParam != null && fechaParam != null) {

                    int dia = Integer.parseInt(diaParam);
                    Date f = sdf.parse(fechaParam);

                    conexion.Ejecutar("UPDATE calendario_adviento SET fecha_visible = '" +
                                        new java.sql.Date(f.getTime()) + "' WHERE dia = " + dia);

                    mensaje = "Día " + dia + " actualizado correctamente";
                    tipoMensaje = "success";
                }
            }

        } catch (Exception ex) {
            mensaje = "Error: " + ex.getMessage();
            tipoMensaje = "danger";
        }
    }

    // ➤ Obtener días
    List<Calendario> dias = Calendario.obtenerTodosLosDias();
%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Administrar Calendario</title>

    <!-- Boostrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Iconos -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Calendario visual -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

    <!-- CSS personalizado -->
    <link rel="stylesheet" href="css/estilos.css" type="text/css">
</head>

<body>

    <!-- ============ HEADER (MISMO QUE admin_usuarios.jsp) ============ -->
    <header>
        <img src="imagenes/ups.png" class="logo">
        <h1 class="header-title">Panel de Administración</h1>
        <h2 class="header-subtitle">Gestión de Calendario</h2>

        <a href="admin_usuarios.jsp" class="btn btn-warning">
            <i class="fas fa-users"></i> Gestionar Usuarios
        </a>
    </header>

    <div class="main-container">

        <!-- ============ MENU LATERAL (MISMO FORMATO) ============ -->
        <div class="sidebar">

            <div class="user-section">
                <div class="welcome-msg">
                    👋 Bienvenido Administrador, <%= usuario.getNombre() %>
                </div>

                <form action="cerrarSesion.jsp" method="post">
                    <button class="logout-btn">Cerrar Sesión</button>
                </form>
            </div>

            <div class="sidebar-section">
                <h4>Navegación</h4>
                <ul class="sidebar-links">
                    <li><a href="index.jsp"><i class="fas fa-home"></i> Inicio</a></li>
                    <li><a href="admin_usuarios.jsp"><i class="fas fa-users-cog"></i> Administrar Usuarios</a></li>
                    <li><a href="admin_calendario.jsp" class="active"><i class="fas fa-calendar-alt"></i> Administrar Calendario</a></li>
                    <li><a href="admin_bitacora.jsp"><i class="fas fa-book"></i> Bitácora</a></li>
                </ul>
            </div>

        </div>

        <!-- ============ CONTENIDO PRINCIPAL ============ -->
        <div class="content">
            <section class="main-section">

                <h2>Administración del Calendario de Adviento</h2>
                <p>Control total sobre los días disponibles</p>

                <% if (mensaje != null) { %>
                    <div class="alert alert-<%=tipoMensaje%>"><%=mensaje%></div>
                <% } %>

                <!-- BOTONES MASIVOS -->
                <div class="mb-4">
                    <form method="post">
                        <input type="hidden" name="accion" value="desbloquear">
                        <button class="btn btn-success"><i class="fas fa-unlock"></i> Desbloquear Todos</button>
                    </form>

                    <br>

                    <form method="post">
                        <input type="hidden" name="accion" value="restaurar">
                        <button class="btn btn-warning"><i class="fas fa-clock-rotate-left"></i> Restaurar Fechas</button>
                    </form>

                    <br>

                    <form method="post">
                        <input type="hidden" name="accion" value="test">
                        <button class="btn btn-info"><i class="fas fa-vial"></i> Activar Modo Test</button>
                    </form>
                </div>

                <hr>

                <!-- LISTA VISUAL DE DÍAS -->
                <div class="row">
                <% for(Calendario d : dias) { %>
                    <div class="col-md-3">
                        <div class="card p-3 text-center <%= d.estaDisponible() ? "bg-success-subtle" : "bg-warning-subtle" %>">

                            <h2>Día <%= d.getDia() %></h2>
                            <h5>
                                Fecha Visible:
                                <%= sdfDisplay.format(d.getFechaVisible()) %>
                            </h5>

                            <!-- Botón editar modal -->
                            <button class="btn btn-primary mt-2"
                                    data-bs-toggle="modal"
                                    data-bs-target="#modalEditar"
                                    onclick="document.getElementById('diaEditar').value='<%= d.getDia() %>'">
                                <i class="fas fa-edit"></i> Editar
                            </button>

                        </div>
                    </div>
                <% } %>
                </div>

            </section>
        </div>
    </div>

    <!-- MODAL PARA EDITAR UN DÍA -->
    <div class="modal fade" id="modalEditar">
        <div class="modal-dialog">
            <form method="post">
                <div class="modal-content">

                    <div class="modal-header bg-primary text-white">
                        <h5 class="modal-title">Actualizar Fecha del Día</h5>
                        <button data-bs-dismiss="modal" class="btn-close"></button>
                    </div>

                    <div class="modal-body">

                        <input type="hidden" name="accion" value="actualizar_individual">

                        <label>Día:</label>
                        <input type="number" id="diaEditar" name="dia"
                               class="form-control" required readonly>

                        <label>Fecha:</label>
                        <input type="date" name="fecha"
                               class="form-control" required>

                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-success">Guardar</button>
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancelar</button>
                    </div>

                </div>
            </form>
        </div>
    </div>

    <!-- FOOTER -->
    <footer>
        <p>&copy; 2025 Universidad Politécnica Salesiana - Panel Administrador</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>

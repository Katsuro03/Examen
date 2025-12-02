<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="seguridad.Usuario, java.util.List" %>

<%
    // Verificar que el usuario sea administrador
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
    <title>Administrar Usuarios</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/estilos.css" type="text/css">
</head>

<body>

    <!-- ============ HEADER ============ -->
    <header>
        <img src="imagenes/ups.png" alt="Logo Universidad Politécnica Salesiana" class="logo">
        <h1 class="header-title">Panel de Administración</h1>
        <h2 class="header-subtitle">Gestión de Usuarios</h2>
    </header>

    <div class="main-container">

        <!-- ============ MENÚ LATERAL ============ -->
        <div class="sidebar">

            <!-- Usuario logueado -->
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
                    <li><a href="admin_usuarios.jsp" class="active"><i class="fas fa-users-cog"></i> Administrar Usuarios</a></li>
                    <li><a href="admin_bitacora.jsp"><i class="fas fa-book"></i> Bitácora del Sistema</a></li>
                    
                </ul>
            </div>
        </div>

        <!-- ============ CONTENIDO PRINCIPAL ============ -->
        <div class="content">
            <section class="main-section">

                <h3>Administrar Usuarios</h3>
                <p>Gestiona todos los usuarios registrados en el sistema.</p>

                <div class="row">
				<%
    String msg = (String) session.getAttribute("mensaje");
    if (msg != null) {
%>
    <div class="alert alert-info"><%= msg %></div>
<%
        session.removeAttribute("mensaje");
    }
%>

                    <!-- TABLA DE USUARIOS -->
                    <div class="col-md-8">
                        <table class="table table-bordered table-hover">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre</th>
                                    <th>Correo</th>
                                    <th>Perfil</th>
                                    <th>Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    List<Usuario> usuarios = Usuario.obtenerTodos();
                                    for (Usuario u : usuarios) {
                                %>
                                <tr>
                                    <td><%= u.getId() %></td>
                                    <td><%= u.getNombre() %></td>
                                    <td><%= u.getCorreo() %></td>
                                    <td><%= u.getNombrePerfil() %></td>
                                    <td>
                                       <a href="editar_usuario.jsp?id=<%= u.getId() %>" class="btn btn-sm btn-warning">Editar</a>
									   <a href="eliminar_usuario.jsp?id=<%= u.getId() %>" class="btn btn-sm btn-danger"
   										onclick="return confirm('¿Seguro que deseas eliminar este usuario?');">
  										 Eliminar
										</a>

                                    </td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>

                    <!-- FORMULARIO CREAR USUARIO -->
                    <div class="col-md-4">
                        <h4>Crear Nuevo Usuario</h4>
                        
                        <form method="post" action="crear_usuario.jsp">
                            <div class="mb-3">
                                <label>Nombre</label>
                                <input type="text" name="nombre" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label>Correo</label>
                                <input type="email" name="correo" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label>Contraseña</label>
                                <input type="password" name="clave" class="form-control" required>
                            </div>

                            <div class="mb-3">
                                <label>Perfil</label>
                                <select name="perfil" class="form-control" required>
                                    <option value="1">Administrador</option>
                                    <option value="2">Alumno (@est.ups.edu.ec)</option>
                                    <option value="3">Invitado</option>
                                </select>
                            </div>

                            <button type="submit" class="btn btn-success w-100">Crear Usuario</button>
                        </form>
                    </div>
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

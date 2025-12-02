<%@ page import="seguridad.Usuario" %>
<%
    // Validar solo administradores
    Usuario admin = (Usuario) session.getAttribute("usuario_obj");
    if (admin == null || admin.getPerfil() != 1) {
        response.sendRedirect("login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    Usuario u = Usuario.obtenerPorId(id);

    if (u == null) {
        out.println("<h3>Error: Usuario no encontrado</h3>");
        return;
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Editar Usuario</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            background: #f2f4f7;
        }

        .topbar {
            width: 100%;
            background: #003366;
            padding: 15px;
            color: white;
            font-size: 22px;
            font-weight: bold;
        }

        .container {
            width: 450px;
            margin: 40px auto;
            background: white;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 0 10px rgba(0,0,0,0.15);
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #003366;
        }

        label {
            font-weight: bold;
            margin-top: 10px;
            display: block;
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 8px;
            border: 1px solid #bbb;
            font-size: 15px;
        }

        .btn {
            padding: 10px 18px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            margin-top: 15px;
        }

        .btn-success {
            background: #28a745;
            color: white;
            width: 100%;
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
            display: block;
            text-align: center;
            margin-top: 10px;
            padding: 10px;
            border-radius: 8px;
            text-decoration: none;
        }

        .btn-success:hover {
            background: #1f8a39;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }
    </style>

</head>
<body>

<div class="topbar">
    Panel de Administración
</div>

<div class="container">
    <h2>Editar Usuario</h2>

    <form action="actualizar_usuario.jsp" method="post">
        <input type="hidden" name="id" value="<%= u.getId() %>">

        <label>Nombre</label>
        <input type="text" name="nombre" value="<%= u.getNombre() %>" required>

        <label>Correo</label>
        <input type="email" name="correo" value="<%= u.getCorreo() %>" required>

        <label>Clave</label>
        <input type="text" name="clave" value="<%= u.getClave() %>" required>

        <label>Perfil</label>
        <select name="perfil">
            <option value="1" <%= u.getPerfil()==1?"selected":"" %>>Administrador</option>
            <option value="2" <%= u.getPerfil()==2?"selected":"" %>>Alumno</option>
            <option value="3" <%= u.getPerfil()==3?"selected":"" %>>Invitado</option>
        </select>

        <button type="submit" class="btn btn-success">Guardar Cambios</button>

        <a href="admin_usuarios.jsp" class="btn-secondary">Cancelar</a>
    </form>
</div>

</body>
</html>

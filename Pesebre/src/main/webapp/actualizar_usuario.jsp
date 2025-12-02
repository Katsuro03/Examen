<%@ page import="seguridad.Usuario" %>

<%
    Usuario admin = (Usuario) session.getAttribute("usuario_obj");
    if (admin == null || admin.getPerfil() != 1) {
        response.sendRedirect("login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));
    String nombre = request.getParameter("nombre");
    String correo = request.getParameter("correo");
    String clave = request.getParameter("clave");
    int perfil = Integer.parseInt(request.getParameter("perfil"));

    Usuario u = Usuario.obtenerPorId(id);
    if (u != null) {
        u.setNombre(nombre);
        u.setCorreo(correo);
        u.setClave(clave);
        u.setPerfil(perfil);

        String resultado = u.actualizarUsuario();

        session.setAttribute("mensaje", resultado.equals("OK") ? 
            "Usuario actualizado correctamente" : resultado);
    }

    response.sendRedirect("admin_usuarios.jsp");
%>

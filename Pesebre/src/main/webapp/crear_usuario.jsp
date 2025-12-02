<%@ page import="seguridad.Usuario" %>

<%
    // Validar solo administradores
    Usuario admin = (Usuario) session.getAttribute("usuario_obj");
    if (admin == null || admin.getPerfil() != 1) {
        response.sendRedirect("login.jsp");
        return;
    }

    String nombre = request.getParameter("nombre");
    String correo = request.getParameter("correo");
    String clave = request.getParameter("clave");
    int perfil = Integer.parseInt(request.getParameter("perfil"));

    Usuario nuevo = new Usuario(perfil, nombre, correo, clave);
    String resultado = nuevo.registrarUsuario();

    session.setAttribute("mensaje", 
        (resultado.equals("OK") ? "Usuario creado exitosamente" : resultado)
    );

    response.sendRedirect("admin_usuarios.jsp");
%>

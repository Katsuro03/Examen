<%@ page import="seguridad.Usuario" %>
<%
    Usuario admin = (Usuario) session.getAttribute("usuario_obj");
    if (admin == null || admin.getPerfil() != 1) {
        response.sendRedirect("login.jsp");
        return;
    }

    int id = Integer.parseInt(request.getParameter("id"));

    String resultado = Usuario.eliminarUsuario(id);

    session.setAttribute("mensaje", resultado.equals("OK") ? 
        "Usuario eliminado correctamente" : resultado);

    response.sendRedirect("admin_usuarios.jsp");
%>

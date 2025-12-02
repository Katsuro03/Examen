<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidar la sesión
    session.invalidate();
    
    // Redirigir a la página principal
    response.sendRedirect("index.jsp");
%>
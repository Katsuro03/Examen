<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="seguridad.Usuario" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Login - Pesebre Universitario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        body {
            background: linear-gradient(135deg, #1e3c72, #2a5298);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Arial', sans-serif;
        }
        
        .login-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 400px;
            padding: 40px;
        }
        
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .login-logo {
            width: 80px;
            height: auto;
            margin-bottom: 15px;
        }
        
        .login-title {
            color: #1e3c72;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .login-subtitle {
            color: #7f8c8d;
            font-size: 0.9em;
        }
        
        .form-control {
            border-radius: 10px;
            padding: 12px 15px;
            margin-bottom: 20px;
            border: 2px solid #e9ecef;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: #1e3c72;
            box-shadow: 0 0 0 0.2rem rgba(30, 60, 114, 0.25);
        }
        
        .btn-login {
            background: linear-gradient(45deg, #d4af37, #ffd700);
            border: none;
            color: #1e3c72;
            font-weight: bold;
            padding: 12px;
            border-radius: 25px;
            width: 100%;
            transition: all 0.3s;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
        }
        
        .alert {
            border-radius: 10px;
            margin-bottom: 20px;
        }
        
        .perfil-selector {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .perfil-option {
            flex: 1;
            text-align: center;
            padding: 10px;
            border: 2px solid #e9ecef;
            border-radius: 10px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .perfil-option:hover {
            border-color: #1e3c72;
        }
        
        .perfil-option.active {
            border-color: #d4af37;
            background: rgba(212, 175, 55, 0.1);
        }
        
        .perfil-icon {
            font-size: 1.5em;
            margin-bottom: 5px;
            display: block;
        }
        
        .login-footer {
            text-align: center;
            margin-top: 20px;
            color: #7f8c8d;
            font-size: 0.9em;
        }
        
        .login-footer a {
            color: #1e3c72;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <img src="imagenes/ups.png" alt="UPS" class="login-logo">
            <h3 class="login-title">Pesebre Universitario</h3>
            <p class="login-subtitle">Universidad Politécnica Salesiana</p>
        </div>
        
        <%
            // Procesar login si se envió el formulario
            if ("POST".equals(request.getMethod())) {
                String correo = request.getParameter("correo");
                String clave = request.getParameter("clave");
                
                Usuario usuario = Usuario.autenticar(correo, clave);
                
                if (usuario != null) {
                    // Guardar usuario en sesión
                    session.setAttribute("usuario", usuario.getNombre());
                    session.setAttribute("usuario_obj", usuario);
                    session.setAttribute("perfil", usuario.getPerfil());
                    
                    // Redirigir según perfil
                    switch (usuario.getPerfil()) {
                        case 1: // Admin
                            response.sendRedirect("admin_usuarios.jsp");
                            break;
                        case 2: // Alumno
                        case 3: // Invitado
                            response.sendRedirect("index.jsp");
                            break;
                        default:
                            response.sendRedirect("index.jsp");
                    }
                } else {
        %>
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle"></i>
                        Correo o contraseña incorrectos
                    </div>
        <%
                }
            }
        %>
        
        <form method="POST" action="login.jsp">
            <div class="mb-3">
                <label for="correo" class="form-label">
                    <i class="fas fa-envelope"></i> Correo electrónico
                </label>
                <input type="email" class="form-control" id="correo" name="correo" 
                       placeholder="ejemplo@est.ups.edu.ec" required>
            </div>
            
            <div class="mb-3">
                <label for="clave" class="form-label">
                    <i class="fas fa-lock"></i> Contraseña
                </label>
                <input type="password" class="form-control" id="clave" name="clave" 
                       placeholder="Ingresa tu contraseña" required>
            </div>
            
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="remember">
                <label class="form-check-label" for="remember">Recordarme</label>
            </div>
            
            <button type="submit" class="btn btn-login">
                <i class="fas fa-sign-in-alt"></i> Iniciar Sesión
            </button>
        </form>
        
        <div class="login-footer">
            <p>¿No tienes cuenta? <a href="registro.jsp">Regístrate aquí</a></p>

        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Mostrar/ocultar contraseña
        document.getElementById('clave').addEventListener('focus', function() {
            const toggleBtn = document.createElement('button');
            toggleBtn.type = 'button';
            toggleBtn.className = 'btn btn-sm btn-outline-secondary position-absolute';
            toggleBtn.style.right = '10px';
            toggleBtn.style.top = '50%';
            toggleBtn.style.transform = 'translateY(-50%)';
            toggleBtn.innerHTML = '<i class="fas fa-eye"></i>';
            
            this.parentElement.style.position = 'relative';
            this.parentElement.appendChild(toggleBtn);
            
            toggleBtn.addEventListener('click', function() {
                const input = document.getElementById('clave');
                if (input.type === 'password') {
                    input.type = 'text';
                    this.innerHTML = '<i class="fas fa-eye-slash"></i>';
                } else {
                    input.type = 'password';
                    this.innerHTML = '<i class="fas fa-eye"></i>';
                }
            });
        });
    </script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="seguridad.Usuario" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro - Pesebre Universitario</title>
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
        
        .register-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            width: 100%;
            max-width: 500px;
            padding: 40px;
        }
        
        .register-header {
            text-align: center;
            margin-bottom: 30px;
        }
        
        .register-logo {
            width: 80px;
            height: auto;
            margin-bottom: 15px;
        }
        
        .register-title {
            color: #1e3c72;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .register-subtitle {
            color: #7f8c8d;
            font-size: 0.9em;
        }
        
        .form-control {
            border-radius: 10px;
            padding: 12px 15px;
            margin-bottom: 15px;
            border: 2px solid #e9ecef;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: #1e3c72;
            box-shadow: 0 0 0 0.2rem rgba(30, 60, 114, 0.25);
        }
        
        .btn-register {
            background: linear-gradient(45deg, #d4af37, #ffd700);
            border: none;
            color: #1e3c72;
            font-weight: bold;
            padding: 12px;
            border-radius: 25px;
            width: 100%;
            transition: all 0.3s;
            margin-top: 10px;
        }
        
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
        }
        
        .alert {
            border-radius: 10px;
            margin-bottom: 20px;
        }
        
        .account-type {
            margin-bottom: 20px;
        }
        
        .account-option {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 10px;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .account-option:hover {
            border-color: #1e3c72;
            background: rgba(30, 60, 114, 0.05);
        }
        
        .account-option.selected {
            border-color: #d4af37;
            background: rgba(212, 175, 55, 0.1);
        }
        
        .account-icon {
            font-size: 1.5em;
            color: #1e3c72;
            margin-right: 10px;
        }
        
        .account-title {
            font-weight: bold;
            color: #2c3e50;
        }
        
        .account-description {
            font-size: 0.85em;
            color: #7f8c8d;
            margin-top: 5px;
        }
        
        .register-footer {
            text-align: center;
            margin-top: 20px;
            color: #7f8c8d;
            font-size: 0.9em;
        }
        
        .register-footer a {
            color: #1e3c72;
            text-decoration: none;
            font-weight: bold;
        }
        
        .form-check {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <img src="imagenes/ups.png" alt="UPS" class="register-logo">
            <h3 class="register-title">Crear Cuenta</h3>
            <p class="register-subtitle">Pesebre Universitario - Universidad Politécnica Salesiana</p>
        </div>
        
        <%
            // Procesar registro si se envió el formulario
            if ("POST".equals(request.getMethod())) {
                String nombre = request.getParameter("nombre");
                String correo = request.getParameter("correo");
                String clave = request.getParameter("clave");
                String confirmarClave = request.getParameter("confirmarClave");
                String perfilStr = request.getParameter("perfil");
                
                // Validaciones básicas
                String error = null;
                
                if (nombre == null || nombre.trim().isEmpty()) {
                    error = "El nombre es requerido";
                } else if (correo == null || correo.trim().isEmpty()) {
                    error = "El correo es requerido";
                } else if (clave == null || clave.trim().isEmpty()) {
                    error = "La contraseña es requerida";
                } else if (!clave.equals(confirmarClave)) {
                    error = "Las contraseñas no coinciden";
                } else if (perfilStr == null) {
                    error = "Debes seleccionar un tipo de cuenta";
                }
                
                if (error == null) {
                    int perfil = Integer.parseInt(perfilStr);
                    
                    // Validar correo institucional para alumnos
                    if (perfil == 2 && !correo.endsWith("@est.ups.edu.ec")) {
                        error = "Los alumnos deben usar correo institucional (@est.ups.edu.ec)";
                    }
                    
                    if (error == null) {
                        Usuario nuevoUsuario = new Usuario(perfil, nombre, correo, clave);
                        String resultado = nuevoUsuario.registrarUsuario();
                        
                        if (resultado.startsWith("ERROR")) {
                            error = resultado.substring(7); // Quitar "ERROR: "
                        } else {
                            // Autenticar automáticamente al usuario
                            Usuario usuario = Usuario.autenticar(correo, clave);
                            if (usuario != null) {
                                session.setAttribute("usuario", usuario.getNombre());
                                session.setAttribute("usuario_obj", usuario);
                                session.setAttribute("perfil", usuario.getPerfil());
                                response.sendRedirect("index.jsp");
                                return;
                            } else {
                                error = "Error al iniciar sesión automáticamente";
                            }
                        }
                    }
                }
                
                if (error != null) {
        %>
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle"></i>
                        <%= error %>
                    </div>
        <%
                }
            }
        %>
        
        <form method="POST" action="registro.jsp" id="registroForm">
            <div class="mb-3">
                <label for="nombre" class="form-label">
                    <i class="fas fa-user"></i> Nombre completo
                </label>
                <input type="text" class="form-control" id="nombre" name="nombre" 
                       placeholder="Ej: Juan Pérez" required>
            </div>
            
            <div class="mb-3">
                <label for="correo" class="form-label">
                    <i class="fas fa-envelope"></i> Correo electrónico
                </label>
                <input type="email" class="form-control" id="correo" name="correo" 
                       placeholder="ejemplo@est.ups.edu.ec o tu@correo.com" required>
            </div>
            
            <div class="mb-3">
                <label for="clave" class="form-label">
                    <i class="fas fa-lock"></i> Contraseña
                </label>
                <input type="password" class="form-control" id="clave" name="clave" 
                       placeholder="Mínimo 6 caracteres" required minlength="6">
            </div>
            
            <div class="mb-3">
                <label for="confirmarClave" class="form-label">
                    <i class="fas fa-lock"></i> Confirmar contraseña
                </label>
                <input type="password" class="form-control" id="confirmarClave" name="confirmarClave" 
                       placeholder="Repite tu contraseña" required minlength="6">
            </div>
            
            <div class="account-type">
                <label class="form-label">
                    <i class="fas fa-user-tag"></i> Tipo de cuenta
                </label>
                
                <div class="account-option" onclick="seleccionarPerfil(2)">
                    <div>
                        <i class="fas fa-graduation-cap account-icon"></i>
                        <span class="account-title">Alumno UPS</span>
                    </div>
                    <p class="account-description">
                        Requiere correo @est.ups.edu.ec<br>
                        Acceso completo a todas las funcionalidades
                    </p>
                    <input type="radio" name="perfil" value="2" style="display: none;">
                </div>
                
                <div class="account-option" onclick="seleccionarPerfil(3)">
                    <div>
                        <i class="fas fa-user-friends account-icon"></i>
                        <span class="account-title">Invitado</span>
                    </div>
                    <p class="account-description">
                        Cualquier correo válido<br>
                        Acceso básico a las funcionalidades
                    </p>
                    <input type="radio" name="perfil" value="3" style="display: none;">
                </div>
            </div>
            
            <div class="mb-3 form-check">
                <input type="checkbox" class="form-check-input" id="terminos" required>
                <label class="form-check-label" for="terminos">
                    Acepto los <a href="#" data-bs-toggle="modal" data-bs-target="#modalTerminos">términos y condiciones</a>
                </label>
            </div>
            
            <button type="submit" class="btn btn-register">
                <i class="fas fa-user-plus"></i> Crear Cuenta
            </button>
        </form>
        
        <div class="register-footer">
            <p>¿Ya tienes cuenta? <a href="login.jsp">Inicia sesión aquí</a></p>
        </div>
    </div>
    
    <!-- Modal Términos y Condiciones -->
    <div class="modal fade" id="modalTerminos">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Términos y Condiciones</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <h6>Condiciones de Uso</h6>
                    <p>1. Los alumnos deben utilizar su correo institucional @est.ups.edu.ec</p>
                    <p>2. Los invitados pueden utilizar cualquier correo válido</p>
                    <p>3. La información proporcionada será utilizada únicamente para el acceso al sistema</p>
                    <p>4. Se prohíbe el uso indebido de las funcionalidades</p>
                    <p>5. La Universidad Politécnica Salesiana se reserva el derecho de administrar las cuentas</p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Seleccionar tipo de cuenta
        function seleccionarPerfil(perfil) {
            // Remover selección anterior
            document.querySelectorAll('.account-option').forEach(option => {
                option.classList.remove('selected');
            });
            
            // Agregar selección actual
            event.currentTarget.classList.add('selected');
            
            // Establecer valor del radio button
            document.querySelectorAll('input[name="perfil"]').forEach(radio => {
                radio.checked = (radio.value == perfil);
            });
        }
        
        // Validar contraseñas
        document.getElementById('registroForm').addEventListener('submit', function(e) {
            const clave = document.getElementById('clave').value;
            const confirmarClave = document.getElementById('confirmarClave').value;
            const perfilSeleccionado = document.querySelector('input[name="perfil"]:checked');
            const correo = document.getElementById('correo').value;
            
            // Validar contraseñas
            if (clave !== confirmarClave) {
                e.preventDefault();
                alert('Las contraseñas no coinciden');
                return;
            }
            
            // Validar selección de perfil
            if (!perfilSeleccionado) {
                e.preventDefault();
                alert('Debes seleccionar un tipo de cuenta');
                return;
            }
            
            // Validar correo institucional para alumnos
            if (perfilSeleccionado.value == '2' && !correo.endsWith('@est.ups.edu.ec')) {
                e.preventDefault();
                alert('Los alumnos deben usar correo institucional (@est.ups.edu.ec)');
                return;
            }
        });
        
        // Mostrar/ocultar contraseña
        document.getElementById('clave').addEventListener('focus', function() {
            agregarBotonOjo(this.id);
        });
        
        document.getElementById('confirmarClave').addEventListener('focus', function() {
            agregarBotonOjo(this.id);
        });
        
        function agregarBotonOjo(inputId) {
            const input = document.getElementById(inputId);
            const parent = input.parentElement;
            
            // Verificar si ya existe el botón
            if (parent.querySelector('.btn-ver-clave')) return;
            
            const toggleBtn = document.createElement('button');
            toggleBtn.type = 'button';
            toggleBtn.className = 'btn btn-sm btn-outline-secondary btn-ver-clave';
            toggleBtn.innerHTML = '<i class="fas fa-eye"></i>';
            
            parent.style.position = 'relative';
            toggleBtn.style.position = 'absolute';
            toggleBtn.style.right = '10px';
            toggleBtn.style.top = '50%';
            toggleBtn.style.transform = 'translateY(-50%)';
            
            parent.appendChild(toggleBtn);
            
            toggleBtn.addEventListener('click', function() {
                if (input.type === 'password') {
                    input.type = 'text';
                    this.innerHTML = '<i class="fas fa-eye-slash"></i>';
                } else {
                    input.type = 'password';
                    this.innerHTML = '<i class="fas fa-eye"></i>';
                }
            });
        }
    </script>
</body>
</html>
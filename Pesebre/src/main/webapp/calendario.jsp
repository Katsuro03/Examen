<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="seguridad.Calendario, java.util.List" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Calendario de Adviento - Pesebre Universitario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/estilos.css" type="text/css">
    
    <style>
        .calendario-section {
            padding: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .calendario-title {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 10px;
            font-weight: bold;
        }
        
        .calendario-subtitle {
            text-align: center;
            color: #7f8c8d;
            margin-bottom: 30px;
            font-size: 1.1em;
        }
        
        .calendario-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
            gap: 20px;
            padding: 20px;
        }
        
        .dia-calendario {
            background: linear-gradient(135deg, #d4af37, #ffd700);
            border-radius: 15px;
            padding: 20px;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            min-height: 180px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            border: 3px solid transparent;
        }
        
        .dia-calendario.disponible:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            border-color: #1e3c72;
        }
        
        .dia-calendario.bloqueado {
            background: linear-gradient(135deg, #95a5a6, #bdc3c7);
            cursor: not-allowed;
        }
        
        .dia-calendario.abierto {
            min-height: 300px;
            justify-content: flex-start;
        }
        
        .numero {
            font-size: 2.5em;
            font-weight: bold;
            color: #1e3c72;
            margin-bottom: 10px;
        }
        
        .sorpresa {
            display: none;
            text-align: center;
            width: 100%;
        }
        
        .dia-calendario.abierto .sorpresa {
            display: block;
            animation: aparecer 0.5s ease;
        }
        
        @keyframes aparecer {
            0% { opacity: 0; transform: translateY(10px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        
        .imagen-dia {
            max-width: 100px;
            max-height: 100px;
            margin: 10px auto;
            border-radius: 10px;
            border: 2px solid #1e3c72;
        }
        
        .frase {
            font-size: 0.9em;
            color: #2c3e50;
            margin: 10px 0;
            font-style: italic;
            line-height: 1.4;
        }
        
        .btn-ver-3d {
            background: #1e3c72;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 20px;
            margin: 5px 0;
            cursor: pointer;
            transition: all 0.3s ease;
            font-size: 0.9em;
            width: 100%;
        }
        
        .btn-ver-3d:hover {
            background: #2a5298;
            transform: scale(1.05);
        }
        
        .audio-container {
            margin: 10px 0;
            width: 100%;
        }
        
        .villancico-nombre {
            font-size: 0.8em;
            color: #1e3c72;
            margin-bottom: 5px;
            font-weight: bold;
        }
        
        .audio-navidad {
            width: 100%;
            margin: 5px 0;
            border-radius: 10px;
        }
        
        .bloqueado-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.8);
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            border-radius: 15px;
            padding: 10px;
        }
        
        .bloqueado-overlay i {
            font-size: 2em;
            margin-bottom: 10px;
        }
        
        .no-datos, .error-datos {
            grid-column: 1 / -1;
            text-align: center;
            padding: 40px;
            background: #f8f9fa;
            border-radius: 15px;
            color: #6c757d;
            margin: 20px 0;
        }
        
        .nav-buttons {
            margin: 20px 0;
            text-align: center;
        }
        
        .nav-buttons a {
            margin: 0 10px;
            text-decoration: none;
        }
        
        /* Estilos para el modal 3D */
        #modal3D .modal-dialog {
            max-width: 800px;
            height: 80vh;
        }
        
        #visor-3d {
            width: 100%;
            height: 500px;
            border-radius: 10px;
        }
        
        .modal-header {
            background: linear-gradient(45deg, #d4af37, #ffd700);
            color: #1e3c72;
        }
        
        @media (max-width: 768px) {
            .calendario-grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
                gap: 15px;
                padding: 10px;
            }
            
            .dia-calendario {
                min-height: 150px;
                padding: 15px;
            }
            
            .numero {
                font-size: 2em;
            }
            
            #modal3D .modal-dialog {
                max-width: 95%;
                height: 60vh;
            }
            
            #visor-3d {
                height: 400px;
            }
        }
        
        @media (max-width: 480px) {
            .calendario-grid {
                grid-template-columns: repeat(3, 1fr);
                gap: 10px;
            }
            
            .dia-calendario {
                min-height: 120px;
                padding: 10px;
            }
            
            .numero {
                font-size: 1.8em;
            }
        }
    </style>
</head>

<body>
<%@ page import="seguridad.Usuario" %>
<%
    // Verificar si hay usuario en sesión
    Usuario usuario = (Usuario) session.getAttribute("usuario_obj");
    
    // Si no hay usuario, redirigir al login
    if (usuario == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // Verificar acceso según el perfil
    String paginaActual = request.getServletPath().replace(".jsp", "").replace("/", "");
    
    // Definir qué páginas pueden acceder cada perfil
    boolean tieneAcceso = false;
    
    switch(usuario.getPerfil()) {
        case 1: // Admin - acceso a todo
            tieneAcceso = true;
            break;
            
        case 2: // Alumno - acceso a juego, galeria, calendario
        case 3: // Invitado - acceso a juego, galeria, calendario
            if (paginaActual.equals("juego") || 
                paginaActual.equals("galeria") || 
                paginaActual.equals("calendario") ||
                paginaActual.equals("index")) {
                tieneAcceso = true;
            }
            break;
    }
    
    if (!tieneAcceso) {
        response.sendRedirect("index.jsp");
        return;
    }
%>
    <!-- HEADER IDÉNTICO AL INDEX -->
    <header>
        <img src="imagenes/ups.png" alt="Logo Universidad Politécnica Salesiana" class="logo">
        <h1 class="header-title">Pesebre Universitario</h1>
        <h2 class="header-subtitle">Universidad Politécnica Salesiana</h2>
    </header>

    <!-- BOTONES DE NAVEGACIÓN -->
    <div class="main-container">
        <div class="content">
            <section class="calendario-section">
                <h1 class="calendario-title">🎄 Calendario de Adviento 2025 🎄</h1>
                <p class="calendario-subtitle">Descubre una sorpresa cada día hasta Navidad</p>
                
                <div class="calendario-grid">
                    <%
                        try {
                            List<Calendario> dias = Calendario.obtenerTodosLosDias();
                            
                            if (dias != null && !dias.isEmpty()) {
                                
                                for (Calendario dia : dias) {
                                    boolean disponible = dia.estaDisponible();
                    %>
                    <div class="dia-calendario <%= disponible ? "disponible" : "bloqueado" %>" 
                         data-dia="<%= dia.getDia() %>">
                        <div class="numero"><%= dia.getDia() %></div>
                        <div class="sorpresa">
                            <!-- Imagen 2D -->
                            <% if (dia.getImagenUrl() != null && !dia.getImagenUrl().isEmpty()) { %>
                                <img src="<%= dia.getImagenUrl() %>" alt="Día <%= dia.getDia() %>" 
                                     class="imagen-dia" 
                                     onerror="this.src='imagenes/pesebre.png'">
                            <% } %>
                            
                            <!-- Frase del día -->
                            <p class="frase"><%= dia.getFrase() %></p>
                            
                            <!-- Botón para modelo 3D -->
                            <% if (dia.getModelo3dUrl() != null && !dia.getModelo3dUrl().isEmpty()) { %>
                                <button class="btn-ver-3d" 
                                        onclick="mostrarModelo3D('<%= dia.getModelo3dUrl() %>', <%= dia.getDia() %>)">
                                    <i class="fas fa-cube"></i> Ver Modelo 3D
                                </button>
                            <% } %>
                            
                            <!-- Audio del villancico -->
                            <% if (dia.getAudioUrl() != null && !dia.getAudioUrl().isEmpty()) { %>
                                <div class="audio-container">
                                    <p class="villancico-nombre">
                                        <strong>
                                            <%= dia.getVillancicoNombre() != null ? dia.getVillancicoNombre() : "Villancico" %>
                                        </strong>
                                    </p>
                                    <audio controls class="audio-navidad">
                                        <source src="<%= dia.getAudioUrl() %>" type="audio/mpeg">
                                        Tu navegador no soporta el elemento de audio.
                                    </audio>
                                </div>
                            <% } %>
                        </div>
                        
                        <!-- Overlay para días bloqueados -->
                        <% if (!disponible) { %>
                            <div class="bloqueado-overlay">
                                <i class="fas fa-lock"></i>
                                <p>Disponible el <%= new java.text.SimpleDateFormat("dd/MM").format(dia.getFechaVisible()) %></p>
                            </div>
                        <% } %>
                    </div>
                    <%         }
                            } else { %>
                    <div class="no-datos">
                        <h4><i class="fas fa-calendar-times"></i> No hay datos disponibles</h4>
                        <p>El calendario de adviento aún no está configurado.</p>
                        <p>Por favor, verifica que la tabla 'calendario_adviento' tenga datos.</p>
                    </div>
                    <%     }
                        } catch (Exception e) { %>
                    <div class="error-datos">
                        <h4><i class="fas fa-exclamation-triangle"></i> Error al cargar el calendario</h4>
                        <p><%= e.getMessage() %></p>
                        <p>Detalles técnicos en la consola del servidor.</p>
                    </div>
                    <% } %>
                </div>
                
                <!-- Información del calendario -->
                <div class="alert alert-info mt-4 text-center">
                    <h5><i class="fas fa-info-circle"></i> ¿Cómo funciona?</h5>
                    <p>• Haz clic en los números para abrir la sorpresa del día</p>
                    <p>• Los días bloqueados (<i class="fas fa-lock"></i>) se desbloquearán en su fecha correspondiente</p>
                    <p>• Cada día tiene un modelo 3D único y un villancico especial</p>
                </div>
            </section>
        </div>
    </div>

    <!-- Modal para modelos 3D -->
    <div class="modal fade" id="modal3D" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-cube"></i> Modelo 3D - Día <span id="dia-modal"></span>
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body text-center">
                    <model-viewer id="visor-3d" 
                                 auto-rotate 
                                 camera-controls 
                                 camera-orbit="0deg 75deg 105%"
                                 style="width: 100%; height: 500px;"
                                 alt="Modelo 3D del día">
                        <div slot="progress-bar"></div>
                    </model-viewer>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        <i class="fas fa-times"></i> Cerrar
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- FOOTER IDÉNTICO AL INDEX -->
    <footer>
        <p>&copy; 2025 Universidad Politécnica Salesiana - Pesebre Universitario</p>
    </footer>

    <script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>
    <script>
        // Función para mostrar modelo 3D
        function mostrarModelo3D(modeloUrl, dia) {
            console.log("Cargando modelo 3D:", modeloUrl, "para día:", dia);
            const visor = document.getElementById('visor-3d');
            visor.src = modeloUrl;
            document.getElementById('dia-modal').textContent = dia;
            
            // Mostrar loading mientras carga
            visor.addEventListener('load', () => {
                console.log("Modelo 3D cargado correctamente");
            });
            
            visor.addEventListener('error', () => {
                console.error("Error al cargar el modelo 3D:", modeloUrl);
                alert("El modelo 3D no está disponible en este momento.");
            });
            
            const modal = new bootstrap.Modal(document.getElementById('modal3D'));
            modal.show();
            
            // Evitar propagación del clic
            event.stopPropagation();
        }

        // Manejar clics en los días disponibles
        document.querySelectorAll('.dia-calendario.disponible').forEach(dia => {
            dia.addEventListener('click', function(e) {
                // Evitar que se abra si se hace clic en el botón de 3D o audio
                if (!e.target.closest('.btn-ver-3d') && 
                    !e.target.closest('.audio-navidad') &&
                    !e.target.closest('.bloqueado-overlay')) {
                    this.classList.toggle('abierto');
                }
            });
        });

        // Manejar clics en los días bloqueados
        document.querySelectorAll('.dia-calendario.bloqueado').forEach(dia => {
            dia.addEventListener('click', function(e) {
                if (!e.target.closest('.bloqueado-overlay')) {
                    const numeroDia = this.getAttribute('data-dia');
                    alert('¡Todavía no es el día ' + numeroDia + '! Vuelve en su fecha correspondiente.');
                }
            });
        });

        // Manejo de errores en imágenes
        document.addEventListener('DOMContentLoaded', function() {
            document.querySelectorAll('.imagen-dia').forEach(img => {
                img.addEventListener('error', function() {
                    this.src = 'imagenes/pesebre.png';
                    this.alt = 'Imagen no disponible';
                });
            });
        });
    </script>
</body>
</html>
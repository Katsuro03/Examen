<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Galería - Pesebre Universitario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="css/estilos.css" type="text/css">
    
    <style>
        .galeria-section {
            padding: 20px;
        }
        
        .galeria-title {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 30px;
            font-weight: bold;
        }
        
        .personajes-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 25px;
            padding: 20px;
        }
        
        .personaje-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            overflow: hidden;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border: 1px solid #e9ecef;
        }
        
        .personaje-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.15);
        }
        
        .personaje-img {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-bottom: 3px solid #d4af37;
        }
        
        .personaje-info {
            padding: 20px;
        }
        
        .personaje-info h3 {
            color: #2c3e50;
            margin-bottom: 10px;
            font-weight: bold;
        }
        
        .personaje-info p {
            color: #666;
            line-height: 1.6;
            margin-bottom: 15px;
        }
        
        .btn-3d {
            background: linear-gradient(45deg, #d4af37, #ffd700);
            border: none;
            color: #1e3c72;
            padding: 10px 20px;
            border-radius: 25px;
            font-weight: bold;
            transition: all 0.3s ease;
            width: 100%;
        }
        
        .btn-3d:hover {
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
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
        #visor3D .modal-dialog {
            max-width: 90%;
            height: 80vh;
        }
        
        #modelo-3d {
            width: 100%;
            height: 70vh;
            background: #f8f9fa;
            border-radius: 10px;
        }
        
        .modal-header {
            background: linear-gradient(45deg, #d4af37, #ffd700);
            color: #1e3c72;
        }
        
        @media (max-width: 768px) {
            .personajes-grid {
                grid-template-columns: 1fr;
                padding: 10px;
            }
            
            #visor3D .modal-dialog {
                max-width: 95%;
                height: 60vh;
            }
            
            #modelo-3d {
                height: 50vh;
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
        <!-- CONTENIDO PRINCIPAL DE LA GALERÍA -->
        <div class="content">
            <section class="galeria-section">
                <h1 class="galeria-title">Personajes del Pesebre</h1>
                
                <div class="personajes-grid">
                    <!-- Jesús -->
                    <div class="personaje-card">
                        <img src="imagenes/jesus.png" alt="Jesús Niño" class="personaje-img">
                        <div class="personaje-info">
                            <h3>Jesús Niño</h3>
                            <p>El Salvador, hijo de Dios, que nació en Belén para salvar a la humanidad. Su nacimiento marca el comienzo de la era cristiana y representa la esperanza para el mundo.</p>
                            <button class="btn-3d" data-modelo="modelos/jesus.glb">
                                <i class="fas fa-cube"></i> Ver en 3D
                            </button>
                        </div>
                    </div>
                    
                    <!-- María -->
                    <div class="personaje-card">
                        <img src="imagenes/maria.png" alt="Virgen María" class="personaje-img">
                        <div class="personaje-info">
                            <h3>Virgen María</h3>
                            <p>Madre de Jesús, mujer de gran fe y humildad que aceptó la voluntad de Dios. Es ejemplo de amor maternal y entrega incondicional en la historia de la salvación.</p>
                            <button class="btn-3d" data-modelo="modelos/maria.glb">
                                <i class="fas fa-cube"></i> Ver en 3D
                            </button>
                        </div>
                    </div>
                    
                    <!-- José -->
                    <div class="personaje-card">
                        <img src="imagenes/jose.png" alt="San José" class="personaje-img">
                        <div class="personaje-info">
                            <h3>San José</h3>
                            <p>Padre adoptivo de Jesús, hombre justo y protector de la Sagrada Familia. Representa la fortaleza silenciosa y la dedicación familiar en el plan divino.</p>
                            <button class="btn-3d" data-modelo="modelos/jose.glb">
                                <i class="fas fa-cube"></i> Ver en 3D
                            </button>
                        </div>
                    </div>
                    
                    <!-- Reyes Magos -->
                    <div class="personaje-card">
                        <img src="imagenes/reyes.png" alt="Reyes Magos" class="personaje-img">
                        <div class="personaje-info">
                            <h3>Reyes Magos</h3>
                            <p>Melchor, Gaspar y Baltasar, sabios que siguieron la estrella para adorar al Niño Jesús. Simbolizan la búsqueda de la verdad y la adoración de todas las naciones.</p>
                            <button class="btn-3d" data-modelo="modelos/reyes.glb">
                                <i class="fas fa-cube"></i> Ver en 3D
                            </button>
                        </div>
                    </div>
                    
                    <!-- Pastores -->
                    <div class="personaje-card">
                        <img src="imagenes/pastores.png" alt="Pastores" class="personaje-img">
                        <div class="personaje-info">
                            <h3>Pastores</h3>
                            <p>Hombres humildes que fueron los primeros en visitar al Niño Jesús guiados por ángeles. Representan la sencillez y la apertura a los mensajes divinos.</p>
                            <button class="btn-3d" data-modelo="modelos/pastores.glb">
                                <i class="fas fa-cube"></i> Ver en 3D
                            </button>
                        </div>
                    </div>
                    
                    <!-- Animales -->
                    <div class="personaje-card">
                        <img src="imagenes/animales.png" alt="Animales del Pesebre" class="personaje-img">
                        <div class="personaje-info">
                            <h3>Animales del Pesebre</h3>
                            <p>El buey y el burro que acompañaron el nacimiento de Jesús, proporcionando calor y compañía en el humilde pesebre de Belén.</p>
                            <button class="btn-3d" data-modelo="modelos/animales.glb">
                                <i class="fas fa-cube"></i> Ver en 3D
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Visor 3D Modal -->
                <div class="modal fade" id="visor3D">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title">
                                    <i class="fas fa-cube"></i> Modelo 3D - <span id="nombre-personaje">Personaje</span>
                                </h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <model-viewer id="modelo-3d" auto-rotate camera-controls></model-viewer>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>

    <!-- FOOTER IDÉNTICO AL INDEX -->
    <footer>
        <p>&copy; 2025 Universidad Politécnica Salesiana - Pesebre Universitario</p>
    </footer>

    <script type="module" src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"></script>
    <script>
        document.querySelectorAll('.btn-3d').forEach(button => {
            button.addEventListener('click', function() {
                const modelo = this.getAttribute('data-modelo');
                const nombrePersonaje = this.closest('.personaje-card').querySelector('h3').textContent;
                
                document.getElementById('modelo-3d').src = modelo;
                document.getElementById('nombre-personaje').textContent = nombrePersonaje;
                
                new bootstrap.Modal(document.getElementById('visor3D')).show();
            });
        });

        // Manejo de errores en imágenes
        document.querySelectorAll('.personaje-img').forEach(img => {
            img.addEventListener('error', function() {
                this.src = 'imagenes/pesebre.png';
                this.alt = 'Imagen no disponible';
            });
        });
    </script>
</body>
</html>